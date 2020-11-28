module Forms
  class Photo
    include ActiveModel::Model
    attr_accessor :title, :image
  end
end
