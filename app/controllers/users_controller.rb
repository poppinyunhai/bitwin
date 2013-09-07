class UsersController < ApplicationController

  def info_edit
  end

  def info_update
  	Attachment.create(:attachmentable => current_user, :attachment => params[:attachment]) if params[:attachment]
  	redirect_to root_path
  end
end
