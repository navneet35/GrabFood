class User < ActiveRecord::Base
  enum status: [:active, :inactive]
end
