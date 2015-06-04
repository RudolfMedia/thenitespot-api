class ApiVersion

  def initialize(opts)
    @version, @default = opts[:version], opts[:default]
  end

  def matches?(request)
   @default || check_headers(request.headers)
  end

private

  def check_headers(headers)
    headers['Accept'].present? && headers['Accept'].include?("application/vnd.thenitespot.v#{@version}")
  end

end