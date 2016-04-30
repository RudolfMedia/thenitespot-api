every 1.day, at: '12:01 am' do
  rake "destroy_expired_events"
end