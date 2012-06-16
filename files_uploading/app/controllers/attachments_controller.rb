class AttachmentsController < ApplicationController
  respond_to :json

  def index
    @attachments = Attachment.all
    render :json => @attachments.collect { |p| p.to_jq_upload }
  end

  def attachable
    @attachments = Attachment.find_all_by_attachable_type_and_attachable_id(
      params[:attachable_type].classify,
      params[:attachable_id],
    )

    render :json => @attachments.collect { |p| p.to_jq_upload }
  end

  def create
    @attachment = Attachment.new(params[:attachment])

    if @attachment.save
      respond_with do |format|
        format.json do
          render :json => [ @attachment.to_jq_upload ]   
        end
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def update
    raise params.to_json
    @attachment = Attachment.find(params[:attachment])

    if @attachment.save
      respond_with do |format|
        format.json do
          render :json => [ @attachment.to_jq_upload ]   
        end
      end
    else
      render :json => [{:error => "custom_failure"}], :status => 304
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    render :json => true
  end
end