class Project < ActiveRecord::Base
  attr_accessible :name


  validates :name, :presence => true, :uniqueness => true

  has_many :tickets, dependent: :destroy
  has_many :permissions, :as => :thing


  # this line say to us that: current user can watch only that post, what created by himself (permission table!)
  scope :readable_by, lambda { |user| joins(:permissions).where(permissions: { action: "view", user_id: user.id } )}

  def self.for(user)
    user.admin? ? Project : Project.readable_by(user)
  end

end
