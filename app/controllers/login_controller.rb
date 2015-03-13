class LoginController < UserController
  # before_action :ifLogin, except: [:login]

  def ifLogin
    user = getLoggedInUserDetails
    if(user.present?)
      return true
    end
    render template: 'login/_register'
  end

  def login
     user = getLoggedInUserDetails
     if(user.present?)
       redirect_to :controller => 'home', :action => 'index'
     elsif(params[:commit]=="Login" && params[:email].present? && params[:pass].present?)
        params[:pass] = Digest::MD5.hexdigest(params[:pass])
        user = User.where("email = ? and password = ?", params[:email], params[:pass]).all

        if(user.present?)
         setLoginUserDetails(params[:email])
         flash[:success] = "Signed in successfully"
         redirect_to :controller => 'home', :action => 'index'
        else
          @message = "Incorrect username or password"
          render :action => 'login'
        end
     end


  end

  def register
    if(params[:commit]=="Register")
      user = User.find_by_email(params[:email])
      if(user.blank? && params[:email].present? && params[:pass].present? && params[:name].present?)
        create(params)
        setLoginUserDetails(params[:email])
        redirect_to :controller => 'home', :action => 'index'
      else
        @message = "Username already exists."
        render :action => 'register'
      end
    end
  end

  def logout
    user = getLoggedInUserDetails
    if(user.present?)
      deleteUserSession
    end

    redirect_to :controller => 'home' , :action => 'index'
  end

  def lostPassword
    if(params[:email].present?)
      if(User.find_by_email(params[:email]))
        @message = "A password reset link has been sent to your email. Please check."
      else
        @message = "Account not found. Please register."
        render :action => 'register'
      end
    end
  end

end
