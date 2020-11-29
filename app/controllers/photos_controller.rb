class PhotosController < ApplicationController

  include WholeErrorMessage
  include MyTweetAppAuthentication

  skip_before_action :require_sign_in, only: [:download, :show_image]

  def index
    @photos = current_user.photos.recently_created
  end

  def new
    @form = Forms::Photo.new
  end

  def create
    @form = ::Forms::Photo.new(params.require(:forms_photo).permit(:title, :image))
    Photo.create_by_uploaded_file(
      user: current_user,
      photo_title: @form.title,
      uploaded_file: @form.image,
      when_succeeded: lambda {
        redirect_to controller: :photos, action: :index
      },
      when_failed: lambda { |errors|
        errors.full_messages.each { |msg| add_whole_error_message msg }
        render action: :new
      }
    )
  end

  def download
    send_file current_photo_public.image_abs_path, disposition: 'attachment'
  end

  def show_image
    @photo = current_photo_public
    render layout: false
  end

  private

  def current_photo
    @current_photo ||= current_user.find_my_photo_by(id: params[:photo_id])
  end

  def current_photo_public
    Photo.find(params[:photo_id])
  end

end
