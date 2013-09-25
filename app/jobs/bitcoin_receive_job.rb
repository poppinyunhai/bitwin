class BitcoinReceiveJob
  @queue = :bitcoin_receive_job

  def self.perform()
  	RESQUE_LOGGER.info "bitcoin synchronize  receive transactions start "
    Lockfile.lock(:synchronize_transactions) do
      Operation.synchronize_transactions!({:currency => 'btc', :type => "receive"})
    end
    RESQUE_LOGGER.info "bitcoin synchronize receive transactions end"
  end
end


