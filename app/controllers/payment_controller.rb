require 'net/https'
require 'json'
require 'uri'
require 'jwt'


class PaymentController < ApplicationController
  Hmac_secret = "@LYR3ZA$$"
  IdPayUrl = "https://api.idpay.ir/v1.1/"
  CustomHeader = {
    'Content-Type': "application/json",
    'X-API-KEY': "2a7be493-32b0-4543-81a6-4fab56760d28",
    'X-SANDBOX': 1
  }
  def callback
    begin
      decodeToken = URI.decode(params[:token])
      decoded_token = JWT.decode decodeToken, Hmac_secret, true, { algorithm: 'HS256' }
      status = params[:status].to_i
      track_id = params[:track_id].to_i
      id = params[:id]
      order_id = params[:order_id]
      amount = params[:amount].to_i
      card_no = params[:card_no]
      payment_date = Time.zone.now
      checkStatus(status, order_id, id)
      pay = Payment.find_by!(order_id: order_id, payment_id: id)
      pay.track_id = track_id
      pay.card_no = card_no
      pay.payment_date = payment_date
      render json: pay if pay.save!
    rescue JWT::ExpiredSignature
      render json: {"error-code": 400, "message": "token expired"}, status: 404
    rescue JWT::ImmatureSignature
      render json: {"error-code": 401, "message": "Immature Signature"}, status: 404
    rescue JWT::DecodeError
      render json: {"error-code": 402, "message": "Decode Error"}, status: 404
    end
  end

  def makeRequestToIdPay(orderId, name,email, plan)
    exp = Time.now.to_i + 10 * 60
    payAttention = { data: email, exp: exp }
    token = JWT.encode payAttention, Hmac_secret, 'HS256'
    encodeToken = URI.encode(token)
    fullUrl = paymentCallback_path(encodeToken)
    payload = {
      "order_id": orderId.to_s,
      "amount": priceOfPlan(plan),
      "mail": email,
      "name": name,
      "callback": fullUrl
    }
    paymentResponse = sendPostRequest("payment",payload)
    render json: {"error-code": nil, message: "successfully created"}, status: 201
  end


  def checkStatus(status,orderId, payment_id)
    if status === 10
      makeVerifyRequestToIdPay(orderId, payment_id)
    end
  end


  def makeVerifyRequestToIdPay(orderId, payment_id)
    payload = {
      "order_id": orderId.to_s,
      "id": payment_id.to_s,
    }
    verifyResponse = sendPostRequest("payment/verify",payload)
    saveIdPayResponse(verifyResponse[:data])
  end


  def saveIdPayResponse(data)
    paymentRes = JSON.parse(data)
    id = paymentRes['id']
    orderId = paymentRes['order_id']
    status = paymentRes['status'].to_i
    verified_at = Time.zone.now
    pay = Payment.find_by!(order_id: orderId, payment_id: id)
    pay.status = status
    pay.verified_at = verified_at
    getPlan = converPrice2Plan(pay.amount)
    if(pay.save!)
      addDate = dateOfPlan(getPlan)
      chargeUserAccount(pay.user, getPlan, addDate )
      return {status: status}
    else
      return {status: 404}
    end
  end

  def priceOfPlan(plan)
    what = case plan
    when 1
      70000
    when 2
      120000
    when 3
      840000
    when 4
      1440000
    end

    return what
  end

  def converPrice2Plan(price)
    what = case price
    when 70000
      1
    when 120000
      2
    when 840000
      3
    when 1440000
      4
    end
    return what
  end
  def dateOfPlan(plan)
    what = case plan
    when 1
      1.month
    when 2
      1.month
    when 3
      12.month
    when 4
      12.month
    end

    return what
  end


  private 

  def sendPostRequest(uri, payload)
    begin
      url = URI.parse("#{IdPayUrl}/#{uri}")
      req = Net::HTTP::Post.new(url.to_s)
      CustomHeader.each do |key, value|
        req[key] = value
      end
      req.body = payload.to_json
      http = Net::HTTP.new(url.host, url.port)
      if url.scheme =='https'
        http.use_ssl = true
      end
      res = http.start do |sending|
        sending.verify_mode = OpenSSL::SSL::VERIFY_NONE
        sending.request(req)
      end
      return {data: res.body, status: res.status }
    rescue => e 
      return "failed #{e}"
    end

  end

  def chargeUserAccount(user, newPlan, newDate)
    newUser = user
    newUser.plan = newPlan
    if user.expired_at
      if user.expired_at > Time.zone.now
        newUser.expired_at = user.expired_at + newDate
      else
        newUser.expired_at = Time.zone.now + newDate
      end
    else
      newUser.expired_at = Time.zone.now + newDate
    end
    newUser.save! 
  end

end
