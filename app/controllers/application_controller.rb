class ApplicationController < ActionController::API

  rescue_from ActionController::ParameterMissing, with: :missing_parameter

protected

  def valid_sort?
    %w(eat drink attend).include? params[:sort]  	
  end

  def ll_params
    params.require(:ll).split(',')
  end

  def missing_parameter(exception)
    render json: { errors: { exception.param => 'parameter is required' } }, status: 422 and return 
  end

end
