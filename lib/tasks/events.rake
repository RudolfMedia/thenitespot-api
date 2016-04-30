task :destroy_expired_events => :environment do

    Event.where("expiration_date < ?", Date.today).each do |event|
    	event.destroy
    end

end
