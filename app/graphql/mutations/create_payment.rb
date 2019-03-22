require 'json'
module Mutations
    class CreatePayment < BaseMutation
        argument :plan, Int, required: true
        type Types::PaymentType

        def resolve(plan = nil)
            pay = PaymentController.new
            orderId = UUIDTools::UUID.random_create
            email = context[:current_user].email
            thr = Thread.new { pay.makeRequestToIdPay(orderId, email, plan) }
            response = thr.join
            res_json = response.to_json
            Payment.create!(
                order_id: orderId,
                user: context[:current_user],
                payment_id: res_json.id,
                amount: pay.choosePlan(plan)
            )
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")
        end

    end
end