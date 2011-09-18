set :output, "/var/log/whenever.log"

every 1.hour do
  runner "TagSubscription.process_all"
end

if environment == "production"
  every 1.hour do
    runner "AmazonBackup.execute"
  end
  
  every 1.week do
    runner "UserPasswordResetNonce.prune!"
  end
end
