module Forms
  class Session
    include ActiveModel::Model
    attr_accessor :username, :password

    validates :username, presence: true
    validates :password, presence: true
  end
end
