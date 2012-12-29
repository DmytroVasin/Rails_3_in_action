class Comment < ActiveRecord::Base
  attr_accessible :text, :ticket_id, :user_id

  belongs_to :user
  belongs_to :ticket # ???

  validates :text, :presence => true
end
