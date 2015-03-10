class LoginController < UserController
  before_action :ifLogin, except: [:login]

  def ifLogin
    user = getLoggedInUserDetails;
    if(user.present?)
      return true;
    end
    render template: 'login/login';
  end

  def login
     user = getLoggedInUserDetails;
     if(user.present?)
     else(params[:commit]=="sign in")
       setLoginUserDetails
     end

     redirect_to :controller => 'home', :action => 'index'

  end

  def logout
    user = getLoggedInUserDetails;
    if(user.present?)
      deleteUserSession;
    else
    end

    redirect_to :controller => 'home' , :action => 'index';
  end
end
