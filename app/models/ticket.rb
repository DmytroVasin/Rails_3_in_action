class Ticket < ActiveRecord::Base
  attr_accessible :description, :title, :asset
  attr_accessible :assets_attributes

  belongs_to :project
  belongs_to :user
  
  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets, allow_destroy: true

  has_many :comments
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  def self.for(user)
    user.admin? ? Project : Project.readable_by(user)
  end
end
