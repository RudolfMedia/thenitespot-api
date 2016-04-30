class RedirectMailInterceptor

  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "rowlandrudolf@comcast.net"
  end
  
end