class AttachmentThumbnailsJob < Struct.new(:attachment_id)

  def perform
    attachment = Attachment.find(attachment_id)
    #attachment.large_image  = photo.image.thumb('450x')
    attachment.medium_image  = attachment.attach.thumb('600x460#')
    attachment.save
  end

  def success(job)
    puts ">>> Successful finished job: #{job.id}"
  end

  def failure(job)
    puts ">>> Job #{job.id} failed to resize image"
  end

end