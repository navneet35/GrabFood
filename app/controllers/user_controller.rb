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

  def setLoginUserDetails
    session[:state] = true;
    session[:email] = "navneetnsit09@gmail.com";
    session[:roleId] = 1;
    session[:userId] = 1;
    getLoggedInUserDetails
  end

  def getLoggedInUserDetails
    user = nil;
    if(session.present? && session[:state])
      user  = UserController.new;
      user.email = session[:email];
      user.roleId = session[:roleId];
      user.userId = session[:userId];
    end
    return user;
  end

  def deleteUserSession
     session[:state] = session[:email] = session[:roleId] = session[:userId] = nil;
  end

end
