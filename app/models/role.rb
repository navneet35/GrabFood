class Role < ActiveRecord::Base
  # has_ancestry
  # attr_accessible :created_by, :name, :updated_by , :ancestry, :is_manager

  has_many :user_role_maps, :class_name => "UserRoleMap"
  has_many :users, :class_name => "User", :through => :user_role_maps
  belongs_to :creator, class_name: 'User', foreign_key: :created_by, primary_key: 'id'
  belongs_to :last_updated_by, class_name: 'User', foreign_key: :updated_by, primary_key: 'id'

  validates_presence_of :name

end
