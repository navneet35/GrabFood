class UserController < ApplicationController
  attr_accessor :state, :email, :roleId, :userId
  ACTIVE = 'active';
  INACTIVE = 'inactive';
  def new
     return User.new
  end

  def create
     if(empty(User.find_by_email(params[:user_email])))
        user = User.new;
        user.email = params[:user_email];
        user.first_name = params[:first_name];
        user.last_name = params[:last_name];
        user.password = params[:password];
        user.save;
     end
  end

  def update
     user = User.find_by_email(params[:user_email]);
     if(!empty(user))
       user.first_name = params[:first_name];
       user.last_name = params[:last_name];
       user.password = params[:password];
       user.save;
     end
  end

  def destroy
    user = User.find_by_email(params[:user_email]);
    if(!empty(user))
      user.status = INACTIVE;
      user.save;
    end
  end

  def getLoggedInUserDetails
    user = User.new;
    if(session.present? && session[:state])
      user.email = session[:email];
      user.roleId = session[:roleId];
      user.userId = session[:userId];
    end
    return user;
  end
end
