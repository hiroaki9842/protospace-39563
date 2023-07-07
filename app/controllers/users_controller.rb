class UsersController < ApplicationController
  def show
    @users = User.find(params[:id])
    @prototypes = current_user.prototypes
  end
end
