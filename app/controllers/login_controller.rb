class LoginController < UserController
  before_action :ifLogin, except: [:login]

  def index

  end

  def ifLogin
    user = getLoggedInUserDetails();
    if(user.present?)
      return true;
    end
      redirect_to :controller => 'home', :action => 'login'
  end

  def login
     user = getLoggedInUserDetails();
     if(user.present?)
       redirect_to :controller => 'home', :action => 'index'
     end
       render action: :index
  end

  def logout
    user = getLoggedInUserDetails();
    if(user.present?)
      session[:state] = session[:email] = session[:roleId] = session[:userId] = null;
      redirect_to :controller => 'home' , :action => 'index';
    else
      redirect_to :action => 'login';
    end


  end
end
