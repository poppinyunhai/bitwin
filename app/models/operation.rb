class Operation < ActiveRecord::Base

  belongs_to :user

  validates :txid,  presence: true, uniqueness: true

  before_save :synchronize_account

  def self.synchronize_transactions!(type='btc')
    if type == 'btc'
      btc_synchronize!
    end
  end


  def self.btc_synchronize!
    User.all.each do |user|
      # transactions = Bitcoin::Client.instance.list_transactions('btc' + user.id.to_s)
      transactions = Bitcoin::Client.instance.list_transactions()
      transactions = transactions.select do |tx|
        ["receive", "generated"].include? tx["category"]
      end

      transactions.each do |tx|
        o = Operation.where( :txid => tx["txid"], :user_id => user.id ).first
        if o 
          o.update_attribute(:confirmations, tx["confirmations"]) if o.status == OperationStatus::NEW
        else
          Operation.transaction do 
            o = Operation.new
            o.user = user
            o.category = (tx["category"]=='receive' ? OperationCategory::RECEIVE : OperationCategory::GENERATED)
            o.amount = tx['amount']
            o.confirmations = tx['confirmations']
            o.blockhash = tx['blockhash']
            o.blocktime = tx['blocktime']
            o.timereceived = tx['timereceived']
            o.txid = tx['txid']
            o.currency_str = 'btc'
            o.save!
          end
        end
      end
    end
  end

  protected

  def synchronize_account
    CoinAccount.transaction do 
      if self.currency_str =='btc' && self.confirmations > 1 && self.status != OperationStatus::OVER_TIME
        self.status = OperationStatus::OVER_TIME
        btc_account = self.user.btc_account
        btc_account.amount += self.amount
        btc_account.save!
      end
    end
  end
end
