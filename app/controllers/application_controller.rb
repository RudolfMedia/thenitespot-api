class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  rescue_from ActionController::ParameterMissing, with: :missing_parameter
  rescue_from ActiveRecord::RecordNotFound, with: :not_found 
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ThenitespotApi::EnsureAdminError, with: :ensure_admin_exists

  def not_found
    render json: { errors: "Oops!, can't find what you're looking for..." } , status: 404 and return
  end 

  def handle_timeout
    render json: { error: 'Request Timeout' }, status: 503 and return
  end
  
protected

  def valid_sort?
    %w(eat drink attend).include? params[:sort]  	
  end

  def location
    if params[:location] &&  params[:location] =~ /^(\-?\d+(\.\d+)?),\s*(\-?\d+(\.\d+)?)$/
      params[:location].split(',')
    elsif request.try(:location)
      [ request.location.latitude, request.location.longitude ]
    else
      nil
    end
  end
  
  def radius
    params[:r] && params[:r].to_i.between?(1,5) ? params[:r].to_i : 1
  end

  def missing_parameter(exception)
    render json: { errors: { exception.param => 'parameter is required' } }, status: 422 and return 
  end

  def invalid_foreign_key(exception)
    render json: { errors: 'Foreign key violation' }, status: 422 and return 
  end

  def user_not_authorized
    render json: { errors: 'You are not authorized to perform this action.' }, status: 401 and return
  end

  def ensure_admin_exists
   render json: { errors: 'Must have alteast one administrative user.' }, status: 422 and return 
  end

end
