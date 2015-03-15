class ActiveRecord::Base
  # db_magic :slave => "ops_slave_#{Rails.env}",  :force_slave_reads => false
  before_save :set_updated_by
  before_create :set_created_by
  before_update :set_updated_by

  def set_updated_by
    user=User.current_user.present? ? User.current_user: User.find_by_email('system@infibeam.net')
    self.updated_by = user.id if self.has_attribute?(:updated_by)
  end

  def set_created_by
    user=User.current_user.present? ? User.current_user: User.find_by_email('system@infibeam.net')
    self.created_by = user.id if self.has_attribute?(:created_by)
  end

  def print_me
    puts self.to_yaml
  end

end