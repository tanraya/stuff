class Attachment < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  #ALLOWED_MIME_TYPES = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  #ALLOWED_EXTENSIONS = [:jpeg, :jpg, :png, :JPEG, :JPG, :PNG]

  belongs_to      :attachable, :polymorphic => true
  image_accessor  :attach
  attr_accessible :attach, :attachable_id, :attachable_type

  #validates :image, :presence => true, :on => :create
  #validates :image, :length => { :maximum => 6.megabytes }

  # Dragonfly custom validators for image
  # see: github.com/markevans/dragonfly
  #validates_property :format,    :of => :image, :in => ALLOWED_EXTENSIONS
  #validates_property :mime_type, :of => :image, :in => ALLOWED_MIME_TYPES
  #validates_property :width,     :of => :image, :in => (50..3000)
  #validates_property :height,    :of => :image, :in => (50..3000)

  default_scope order(:updated_at)

  def to_jq_upload
    {
      :name          => attach.name,
      :size          => attach.size,
      :url           => attach.url,
      :thumbnail_url => attach.thumb('80x80#').url,
      :delete_url    => attachment_path(:id => id),
      :delete_type   => :DELETE,
      :attachment_id => id
    }
  end
end