every 1.day, at: '12:01 am' do
  rake "destroy_expired_events"
end

every 1.day at: '3:00 am' do 
  rake "destroy_expired_specials"
end