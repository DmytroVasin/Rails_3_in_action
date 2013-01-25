class Ticket < ActiveRecord::Base
  attr_accessible :description, :title, :asset, :user
  attr_accessible :assets_attributes

  searcher do
    label :tag, :from => :tags, :field => :name
    label :state, :from => :state, :field => "name"
  end

  paginates_per 5

  belongs_to :project
  belongs_to :user
  belongs_to :state
  
  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets, allow_destroy: true

  has_many :comments

  has_and_belongs_to_many :tags
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  def self.for(user)
    user.admin? ? Project : Project.readable_by(user)
  end


  def tag!(tags)
    tags = tags.split(" ").map do |tag|
      Tag.find_or_create_by_name(tag)
    end
    
    self.tags = self.tags | tags
    # sef ссылается ticket вроде
  end

end
