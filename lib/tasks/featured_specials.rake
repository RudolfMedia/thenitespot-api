task :destroy_expired_specials => :environment do

    FeaturedSpecial.expired.each do |spl|
    	spl.destroy
    end

end
