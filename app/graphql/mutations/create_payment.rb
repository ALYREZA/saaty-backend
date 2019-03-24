require 'json'
module Mutations
    class CreatePayment < BaseMutation
        argument :plan, Int, required: true
        type Types::PaymentType

        def resolve(plan = nil)
            pay = PaymentController.new
            orderId = UUIDTools::UUID.random_create
            email = context[:current_user].email
            name = context[:current_user].name
            respon = pay.makeRequestToIdPay(orderId, name, email, plan[:plan])
        
            paymentId = JSON.parse(respon)['id']
            Payment.create!(
                order_id: orderId.to_s,
                user: context[:current_user],
                payment_id: paymentId,
                amount: pay.priceOfPlan(plan[:plan])
            )
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end

    end
end