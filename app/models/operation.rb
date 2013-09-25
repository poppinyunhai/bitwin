class Operation < ActiveRecord::Base

  belongs_to :user

  validates :txid,  presence: true, uniqueness: true

  before_save :synchronize_account

  def self.btc_synchronize!(type='receive')
    if type == 'receive'
      User.all.each do |user|
        transactions = Bitcoin::Client.instance.list_transactions('btc' + user.id.to_s)
        # transactions = Bitcoin::Client.instance.list_transactions()
        transactions = transactions.select do |tx|
          ["receive", "generated"].include? tx["category"]
        end

        transactions.each do |tx|
          o = Operation.where( :txid => tx["txid"], :user_id => user.id ).first
          if o 
            o.update_attribute(:confirmations, tx["confirmations"]) if o.status == OperationStatus::UN_CONFIRMED
          else
            Operation.transaction do 
              o = Operation.new
              o.user = user
              o.category = OperationCategory::RECEIVE 
              o.status = OperationStatus::UN_CONFIRMED
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
    else
      un_confirmed_sent_opreations = Operation.where(:category => OperationCategory::SENT, 
                        :status => OperationStatus::UN_CONFIRMED )
      un_confirmed_sent_opreations.each do |uo|
        next unless uo.txid
        tx = Bitcoin::Client.instance.gettransaction(uo.txid)
        if tx['confirmations'].to_i > 0
          Operation.transaction do 
            uo.confirmations = tx['confirmations']
            uo.blockhash = tx['blockhash']
            uo.blocktime = tx['blocktime']
            uo.timereceived = tx['timereceived']
            uo.status = OperationStatus::CONFIRMED
            uo.save!
          end
        end
      end
    end
  end

  def self.btc_translate(user,address,amount)
    if Bitcoin::Client.instance.get_balance >= amount.abs
      Operation.transaction do
        o = Operation.new
          o.user = user
          o.category = OperationCategory::SENT 
          o.status = OperationStatus::UN_CONFIRMED
          o.amount = amount
          o.confirmations = 0
          o.blocktime = Time.now
          o.txid = Bitcoin::Client.instance.send_to_address(address, amount.abs)
          o.currency_str = 'btc'
          o.save! 
          CoinAccount.transaction do 
            btc_account = user.btc_account
            btc_account.amount -= amount
            btc_account.save!
          end
      end
    else
      RESQUE_LOGGER.error("System Lack Bitcoin")
      raise RuntimeError.new("System Lack Bitcoin")
    end
  end

  protected

  def synchronize_account
    CoinAccount.transaction do 
      if self.currency_str == 'btc' && self.confirmations > 0 && self.status == OperationStatus::UN_CONFIRMED && self.category == OperationCategory::RECEIVE 
        self.status = OperationStatus::CONFIRMED
        btc_account = self.user.btc_account
        btc_account.amount += self.amount
        btc_account.save!
      end
    end
  end
end
