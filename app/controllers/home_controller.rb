class HomeController < ApplicationController
  before_action :forbid_login_user,{only: [:top]}
  before_action :set_current_user

  def top
  end
  def about
  end
end
