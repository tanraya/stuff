class UploadsController < ApplicationController
  before_filter :clone_and_cleanup_params, :only => %w(create update)
  def index
    @uploads = Upload.all
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def new
    @upload = Upload.new
  end

  def edit
    @upload = Upload.find(params[:id])
  end

  def create
    @upload = Upload.new(params[:upload])

    respond_to do |format|
      if @upload.save
        bind_attachment_to(@upload)
        format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
        format.json { render json: @upload, status: :created, location: @upload }
      else
        format.html { render action: "new" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @upload = Upload.find(params[:id])

    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        bind_attachment_to(@upload)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
  end

private

  def bind_attachment_to(model)
    return if @attrs.nil?
    
    @attrs.each do |i, x|
      attachment = Attachment.find(x[:attachment_id]) rescue nil      
      attachment.update_attributes(
        :attachable_id   => model.id,
        :attachable_type => model.class.name
      ) if attachment
    end
  end

  def clone_and_cleanup_params
    return unless params[:upload].has_key?(:attachments_attributes)

    @attrs = params[:upload][:attachments_attributes].dup
    params[:upload].delete(:attachments_attributes)
    params.delete(:attachment)
  end

end
