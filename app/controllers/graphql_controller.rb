class GraphqlController < ApplicationController
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      session: session,
      current_user: current_user,
    }
    result = SaatySchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  private

  def current_user

    if Rails.env.development?
      return unless session[:token]
      rsa_private = File.read("./config/master.key")
      begin
        decoded_token = JWT.decode session[:token], rsa_private, true, { algorithm: 'HS256' }
        user_id = decoded_token[0]["data"].to_i
        return User.find_by id: user_id
      rescue JWT::ImmatureSignature => e
        return e
      end
    else
      return unless request.headers["Authorization"]
      rsa_private = File.read("./config/master.key")
      begin
        decoded_token = JWT.decode bearer_token.to_s, rsa_private, true, { algorithm: 'HS256' }
        user_id = decoded_token[0]["data"].to_i
        return User.find_by id: user_id
      rescue => e
        return {error: e}
      end
    end
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers["Authorization"]
    return header.gsub(pattern, '') if header && header.match(pattern)
  end
  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")
    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500
  end
end
