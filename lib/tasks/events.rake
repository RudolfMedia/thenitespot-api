task :destroy_expired_events => :environment do

    Event.expired.each do |event|
    	event.destroy
    end

end
