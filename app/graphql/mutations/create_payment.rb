require 'json'
module Mutations
    class CreatePayment < BaseMutation
        null true
        argument :plan, Int, required: true


        
        field :payment, Types::PaymentType, null: false
        field :url, String, null: false
        def resolve(plan = nil)
            pay = PaymentController.new
            orderId = UUIDTools::UUID.random_create
            email = context[:current_user].email
            name = context[:current_user].name
            respon = pay.makeRequestToIdPay(orderId, name, email, plan[:plan])
        
            paymentId = JSON.parse(respon[:data])['id']
            paymentLink = JSON.parse(respon[:data])['link']
            payment = Payment.create!(
                order_id: orderId.to_s,
                user: context[:current_user],
                payment_id: paymentId,
                amount: pay.priceOfPlan(plan[:plan])
            )
            return {payment: payment, url: paymentLink}
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end

    end
end