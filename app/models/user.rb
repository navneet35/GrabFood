class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum status: [:active, :inactive]
  # attr_accessible :email, :password, :password_confirmation, :remember_me,:name
  has_many :user_role_maps, :class_name => "UserRoleMap", :primary_key => :id, :foreign_key => "user_id"
  has_many :roles, :through => :user_role_maps
  def self.current_user= user
    Thread.current[:current_user]= user
  end

  def self.current_user
    Thread.current[:current_user]
  end
end
