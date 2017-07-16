class AttachmentsController < ApplicationController
  before_action :find_attachment, only: [:destroy]

  respond_to :js

  def destroy
    respond_with @attachment.destroy
    authorize @attachment
  end

  private

  def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end