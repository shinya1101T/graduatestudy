# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    def authenticate_admin
    @current_user = User.find_by(id: session[:user_id])
    if @current_user == nil || @current_user.role != "admin"
      flash[:notice] ="管理者ではありません"
      redirect_to("/posts/index") 
    end
  end
      # TODO Add authentication logic here.
    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
