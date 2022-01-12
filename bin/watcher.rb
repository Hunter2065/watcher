require 'filewatcher'
require 'byebug'
require_relative 'path_tool'
require_relative 'server_client'

class Watcher
  def initialize(watching_directory_path)
    @watching_directory_path = watching_directory_path

    @filewatcher = Filewatcher.new([@watching_directory_path], every: true)
  end

  def start_directory_monitoring
    @filewatcher.watch do |path_to_object, event|
      path_tool = PathTool.new(parent_folder_path: @watching_directory_path, absolute_path: path_to_object)
      relative_path = path_tool.relative_path

      puts "#{event}: #{path_to_object}"

      case event
      when :created
        type = path_tool.type.upcase

        response = ServerClient.post(
          {
            type: type,
            relative_path: relative_path,
            attachment: (File.new(path_to_object) if type == 'FILE')
          }.compact
        )
        
        puts "response status is #{response.code}"
      when :deleted
        response = ServerClient.delete(relative_path: relative_path)

        puts "response status is #{response.code}"
      end
    end
  end
end
