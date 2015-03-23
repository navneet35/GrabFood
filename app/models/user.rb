class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum status: [:active, :inactive]
  devise :omniauthable, :omniauth_providers => [:google,:facebook]
  # devise :omniauthable, :omniauth_providers => [:facebook]
  # attr_accessible :email, :password, :password_confirmation, :remember_me,:name
  has_many :user_role_maps, :class_name => "UserRoleMap", :primary_key => :id, :foreign_key => "user_id"
  has_many :roles, :through => :user_role_maps
  def self.current_user= user
    Thread.current[:current_user]= user
  end

  def self.current_user
    Thread.current[:current_user]
  end


  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(provider: data["provider"], uid: data["uid"],email: data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data["name"],
                           email: data["email"],
                           name: data["name"],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end
end
