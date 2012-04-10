class Photo < ActiveRecord::Base
  belongs_to :album
  has_one :image, :as => :imageable, :dependent => :destroy

  attr_accessible :title, :image_attributes

  accepts_nested_attributes_for :image,
    :reject_if     => lambda { |x| x[:image].blank? },
    :allow_destroy => true
end
