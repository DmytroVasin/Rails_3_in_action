class Permission < ActiveRecord::Base
  attr_accessible :action, :thing_id, :thing_type, :user_id

  belongs_to :user
end
