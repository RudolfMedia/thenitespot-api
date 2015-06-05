class ApplicationController < ActionController::API


protected

  def valid_sort?
    %w(eat drink attend).include? params[:sort]  	
  end

end
