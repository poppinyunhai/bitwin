class BitcoinReceiveJob
  @queue = :bitcoin_receive_job

  def self.perform()
  	RESQUE_LOGGER.info "bitcoin synchronize  receive transactions start "
  	Operation.btc_synchronize!("receive")
  	RESQUE_LOGGER.info "bitcoin synchronize receive transactions end"
  end
end


