module JsonHelper
  def json_response
    @json_response ||= JSON.parse(last_response.body)
  end
end
