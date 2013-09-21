class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  acts_as_google_authenticated :method => :user_name_with_label
  
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :login_historys

  validates :username,  presence: true, uniqueness: true

  has_many :images, -> { where image: true  }, :as => :attachmentable, class_name: 'Attachment'

  has_many :account_operations, dependent: :destroy
  has_one :btc_operation, -> { where currency: Currency.find_by_code('btc') }, class_name: 'AccountOperation'

  has_one :answer, dependent: :destroy
  has_one :question,  :through => :answer, :source => :question

  def avatar
  	self.images.last.try(:attachment).try(:url) || "/uploads/attachment/default/user.png"
  end

  def trade_password=(new_password)
    @trade_password = BCrypt::Password.create(new_password)
    self.trade_hash = @trade_password
  end

  def trade_password
     @trade_password ||= BCrypt::Password.new(trade_hash)
  end

  def user_name_with_label
    "#{self.username}@snowball.io"
  end

end
