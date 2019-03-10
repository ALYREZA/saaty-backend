module Mutations
    class EndRecord < BaseMutation
        argument :record_uuid, String, required: true
        argument :stop, String, required: false

        type Types::SaatType

        def resolve(record_uuid: nil, stop: nil)
            if stop
                stoppedTime =  Chronic.parse(stop.to_s, :context => :past, :now => Time.zone.now)
            else
                stoppedTime =  Chronic.parse("this second", :context => :past, :now => Time.zone.now)
            end
            record = Saat.find_by!(uuid: record_uuid, user: context[:current_user])
            start_time = Time.parse(record.start.to_s)
            end_time = Time.parse(stoppedTime.to_s)
            duration_seconds = end_time - start_time
            if duration_seconds <= 0
                return GraphQL::ExecutionError.new("seconds could not be negative")
            end
            if duration_seconds > 0 && record.end == nil
                duration_hours = duration_seconds / 3600
                record.duration = duration_hours
                record.end = stoppedTime
                record.save!
            else
                record
            end
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("#{e.record.errors.full_messages.join(', ')}")

        end 
    end
end