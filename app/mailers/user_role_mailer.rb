class UserRoleMailer < ApplicationMailer
 
  def notify_user(current_user,user_role)
  	@admin_user = current_user
    @user = user_role.user
    @spot = user_role.spot
    mail(to: @user.email, subject: 'You have been added to a Nitespot Business user group')
  end

end
