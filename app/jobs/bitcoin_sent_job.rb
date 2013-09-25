class BitcoinSentJob
  @queue = :bitcoin_sent_job

  def self.perform()
  	RESQUE_LOGGER.info "bitcoin synchronize  sent transactions start "
    Lockfile.lock(:synchronize_transactions) do
      Operation.synchronize_transactions!({:currency => 'btc', :type => "sent"})
    end
    RESQUE_LOGGER.info "bitcoin synchronize sent transactions end"
  end
end


