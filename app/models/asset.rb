class Asset < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :asset

  belongs_to :ticket

  has_attached_file :asset,
                    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
                    :url => "/system/:attachment/:id/:style/:filename"
end
