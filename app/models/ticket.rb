class Ticket < ActiveRecord::Base
  attr_accessible :description, :title, :asset

  belongs_to :project
  belongs_to :user
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  has_attached_file :asset,
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"

  def self.for(user)
    user.admin? ? Project : Project.readable_by(user)
  end
end
