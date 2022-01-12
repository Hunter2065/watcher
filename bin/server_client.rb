require 'rest-client'

class ServerClient
  SERVER_URI = 'http://127.0.0.1'.freeze

  def self.post(type:, relative_path:, attachment: nil)
    RestClient.post(
      {
        "#{SERVER_URI}/api/v1/virtual_drives",
        type: type,
        relative_path: relative_path,
        attachment: (attachment if type == 'FILE')
      }.compact
    )
  end
end
