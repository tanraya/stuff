require 'attachment_thumbnails_job'

class Attachment < ActiveRecord::Base
  include Rails.application.routes.url_helpers
=begin
  ALLOWED_MIME_TYPES = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
  ALLOWED_EXTENSIONS = [:jpeg, :jpg, :png, :JPEG, :JPG, :PNG]
=end
  belongs_to      :attachable, :polymorphic => true
  image_accessor  :attach
  attr_accessible :attach, :attachable_id, :attachable_type
=begin
  validates :attach, :presence => true, :on => :create
  validates :attach, :length => { :maximum => 10.megabytes }

  # Dragonfly custom validators for image
  # see: github.com/markevans/dragonfly
  validates_property :format,    :of => :attach, :in => ALLOWED_EXTENSIONS
  validates_property :mime_type, :of => :attach, :in => ALLOWED_MIME_TYPES
  validates_property :width,     :of => :attach, :in => (50..5000)
  validates_property :height,    :of => :attach, :in => (50..5000)
=end
  default_scope order(:updated_at)

  after_save do
    Delayed::Job.enqueue AttachmentThumbnailsJob.new(id)
  end

  def to_jq_upload
    {
      :name          => attach.name,
      :size          => attach.size,
      :url           => attach.thumb('600x460#').url,
      :thumbnail_url => attach.thumb('80x80#').url,
      :delete_url    => attachment_path(:id => id),
      :delete_type   => :DELETE,
      :attachment_id => id
    }
  end
end