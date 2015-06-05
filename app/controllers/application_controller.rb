class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found 
  rescue_from ActionController::ParameterMissing, with: :missing_parameter

protected

  def valid_sort?
    %w(eat drink attend).include? params[:sort]  	
  end

  def ll_params
    params.require(:ll).split(',')
  end

  def record_not_found
    render json: { errors: "Oops!, can't find what you're looking for..." } , status: 404 and return
  end 

  def missing_parameter(exception)
    render json: { errors: { exception.param => 'parameter is required' } }, status: 422 and return 
  end

end
