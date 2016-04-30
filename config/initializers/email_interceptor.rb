#if %w( development ).include?(Rails.env)
  ActionMailer::Base.register_interceptor(RedirectMailInterceptor)
#end
