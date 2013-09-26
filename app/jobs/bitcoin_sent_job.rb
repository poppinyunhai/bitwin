class BitcoinSentJob
  @queue = :bitcoin_sent_job

  def self.perform()
  	RESQUE_LOGGER.info "bitcoin synchronize  sent transactions start "
    Operation.btc_synchronize!("sent")
    RESQUE_LOGGER.info "bitcoin synchronize sent transactions end"
  end
end


