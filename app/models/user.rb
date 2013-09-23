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

  has_many :coin_accounts, dependent: :destroy
  has_one :btc_account, -> { where currency: Currency.find_by_code('btc') }, class_name: 'CoinAccount'

  has_many :blank_accounts
  has_one :cny_account, -> { where blank_currency: BlankCurrency.find_by_code('cny') }, class_name: 'BlankAccount'
  
  has_many :operations
  has_many :bic_operations,  -> { where type: 'btc' }, class_name: 'Operation'
  
  has_one :answer, dependent: :destroy
  has_one :question,  :through => :answer, :source => :question



  after_create :create_account_and_blank_operations

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



  protected

  def create_account_and_blank_operations
    Currency.all.each do |currency|
      ao = CoinAccount.new
      ao.currency = currency
      ao.user = self
      if Rails.env.development?
        ao.address = "1D5CPeiFzLH29bxt3KtRrg1vDddDq7ybSr"
      else
        ao.address = Bitcoin::Client.instance.getnewaddress(currency.code+self.id.to_s)
      end
      ao.save!
    end

    BlankCurrency.all.each do |bc|
      bo = BlankAccount.new
      bo.user = self
      bo.blank_currency = bc
      bo.save!
    end
  end
end
