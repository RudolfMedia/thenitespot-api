class TimeoutRecovery 

	def initialize(app)
		@app = app
	end

	class Error < StandardError; end

	def call(env)
		@app.call(env)
	  rescue Rack::Timeout::Error => e
	  	ApplicationController.action(:handle_timeout).call(env)
		#raise Error, "Original Error: #{e.class.inspect}, #{e.message.inspect}, #{e.backtrace.inspect}"
	end

end