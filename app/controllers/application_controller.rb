class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :wrap_in_transaction
  before_filter :clear_thread_context
  before_filter :set_thread_context
  after_filter :store_location

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def wrap_in_transaction
    begin
      ActiveRecord::Base.transaction do
        yield
      end
    # rescue ActiveRecord::RecordNotFound => e
    #   message="Your query fetched no results. "
    #   flash.now[:error]= message
    #   @error = message
    #   log_error e
    #   render '/home/index'
    # rescue ActiveRecord::RecordNotUnique => e
    #   message="Duplicate Data entered! "
    #   flash.now[:error] = message
    #   @error = message
    #   log_error e
    #   render '/home/index'
    # rescue ActiveRecord::ActiveRecordError => e
    #   message="Record Not Found : "
    #   flash.now[:error]= message
    #   @error = message
    #   log_error e
    #   render '/home/index'
    # rescue NoMethodError => e
    #   message="Attempt to access a page that does not exist."
    #   flash.now[:error]= message
    #   @error = message
    #   log_error e
    #   render '/home/index'
    # rescue ActionView::Template::Error => e
    #   message="Some error occurred while loading the page."
    #   flash.now[:error]= message
    #   @error = message
    #   log_error e
    #   render '/home/index'
    # # rescue StateMachine::InvalidTransition => e
    # #   message="Record already modified by some user. kindly refresh."
    # #   flash.now[:error]= message
    # #   @error = message
    # #   log_error e
    # #   render '/home/index'
    rescue Exception => e
      message = "Technical Error! "
      @error = message
      flash.now[:error] = message + e.to_s
      log_error e
      render '/home/index'
    end
  end

  def clear_thread_context
    Thread.current[:current_user] = nil
  end

  def set_thread_context
    return if ['confirmations', 'sessions', 'registrations', 'passwords'].include? self.controller_name

    if user_signed_in?
      User.current_user= current_user
    end

  end


  def log_error e
    logger.error "Error" + e.message
    e.backtrace.each do |line|
      logger.error line
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end



end
