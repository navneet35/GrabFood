class HomeController < LoginController

  def index
    printf "Hi this is index method";
  end

  def login
    if(ifLogin user)
      redirect_to :controller => 'home', :action => 'index'
    else
      redirect_to :controller => 'login', :action => 'index'
    end
  end

end
