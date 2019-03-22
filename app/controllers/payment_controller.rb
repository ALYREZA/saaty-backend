require 'net/https'
require 'json'
class PaymentController < ApplicationController
  def callback
    puts "salam"
  end

  def makeRequestToIdPay(orderId, email,plan)
    begin
      url = URI.parse('https://api.idpay.ir/v1.1/payment')
      req = Net::HTTP::Post.new(url.to_s)
      req['Content-Type'] = "application/json"
      req['X-API-KEY'] = "2a7be493-32b0-4543-81a6-4fab56760d28"
      req['X-SANDBOX'] = 1
      payload = {
        "order_id": orderId,
        "amount": choosePlan(plan),
        "mail": email,
        "callback": "https://postb.in/gnWQkCzb"
      }

      req.body = payload.to_json
      http = Net::HTTP.new(url.host, url.port)
      if url.scheme =='https'
        http.use_ssl = true
      end
      res = http.start do |sending|
        sending.verify_mode = OpenSSL::SSL::VERIFY_NONE
        sending.request(req)
      end
      return res.body;
    rescue => e
      return "failed #{e}"
    end
  end
  def choosePlan(plan)
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

end
