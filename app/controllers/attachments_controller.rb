class AttachmentsController < ApplicationController
  before_action :find_attachment, only: [:destroy]

  respond_to :js

  def destroy
    authorize @attachment
    respond_with @attachment.destroy
  end

  private

  def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end