class Upload < ActiveRecord::Base
  has_many :attachments,
    :as => :attachable,
    :dependent => :destroy

  attr_accessible :title
  validates :title, :presence => true
end
