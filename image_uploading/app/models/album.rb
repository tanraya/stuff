# https://github.com/blueimp/jQuery-File-Upload/wiki/Rails-setup-for-V6
class Album < ActiveRecord::Base
  has_many   :photos, :dependent => :destroy
  belongs_to :cover, :class_name => 'Photo', :foreign_key => :cover_id

  validates :title, :presence => true, :uniqueness => true
  attr_accessible :title, :cover_id, :photos_attributes

  accepts_nested_attributes_for :photos,
    :reject_if     => lambda { |x| !x[:image_attributes] },
    :allow_destroy => true

  # Set album cover
  after_save do
    if cover.nil? && photos.any?
      update_attribute(:cover_id, photos.first.id)
    end
  end
end
