class BitcoinJob
  @queue = :bitcoin_job

  def self.perform()
  	RESQUE_LOGGER.info "bitcoin synchronize_transactions start "
    Lockfile.lock(:synchronize_transactions) do
      Operation.synchronize_transactions!('btc')
    end
    RESQUE_LOGGER.info "bitcoin synchronize_transactions end"
  end
end
