class State < ActiveRecord::Base
  attr_accessible :background, :color, :name

  has_many :tickets
  has_many :comments

  def to_s
    name
  end
end
