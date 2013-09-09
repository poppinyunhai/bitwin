class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  acts_as_google_authenticated
  
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :confirmable

  has_many :login_historys

  validates :username,  presence: true

  has_many :images, -> { where image: true  }, :as => :attachmentable, class_name: 'Attachment'



  def avatar
  	self.images.last.try(:attachment).try(:url) || "/uploads/attachment/default/user.png"
  end
end
