every 1.day, at: '9:00 pm' do
  runner DailyDigestJob.perform_now
end