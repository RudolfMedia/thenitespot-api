class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  
  rescue_from ActionController::ParameterMissing, with: :missing_parameter
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

protected

  def valid_sort?
    %w(eat drink attend).include? params[:sort]  	
  end

  def radius
    params[:r] || 3
  end

  def ll_params
    params.require(:ll).split(',')
  end

  def missing_parameter(exception)
    render json: { errors: { exception.param => 'parameter is required' } }, status: 422 and return 
  end
  
  def record_not_found
    render json: { errors: "Oops!, can't find what you're looking for..." } , status: 404 and return
  end 

  def invalid_foreign_key(exception)
    render json: { errors: 'Foreign key violation' }, status: 422 and return 
  end

  def user_not_authorized
    render json: { errors: 'You are not authorized to perform this action.' }, status: 422 and return
  end

end
