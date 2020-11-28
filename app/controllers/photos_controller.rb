class PhotosController < ApplicationController

  include WholeErrorMessage
  include MyTweetAppAuthentication

  skip_before_action :require_sign_in, only: [:download, :show_image]

  def index
    @photos = current_user.photos.order(created_at: :desc)
  end

  def new
    @form = Forms::Photo.new
  end

  def create
    # TODO: refactor this fat controller.
    @form = ::Forms::Photo.new(params.require(:forms_photo).permit(:title, :image))
    image_path = @form.image ? "data/#{SecureRandom.uuid}#{File.extname(@form.image.original_filename)}" : nil
    photo = current_user.photos.build(title: @form.title, image_path: image_path)
    if photo.save
      File.binwrite(photo.image_abs_path, @form.image.read)
      redirect_to controller: :photos, action: :index and return
    else
      photo.errors.full_messages.each do |msg|
        add_whole_error_message msg
      end
    end
    render action: :new
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
    @current_photo ||= current_user.photos.where(id: params[:photo_id]).first
  end

  def current_photo_public
    Photo.find(params[:photo_id])
  end

end
