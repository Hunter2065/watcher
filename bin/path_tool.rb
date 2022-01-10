require 'pathname'

class PathTool
  def initialize(parent_folder_path:, absolute_path:)
    @absolute_path = absolute_path
    @parent_folder_path = parent_folder_path

    @path_name = Pathname.new(absolute_path)
  end

  def type
    @path_name.ftype
  end

  def relative_path
    parent_folder_name = Pathname.new(@parent_folder_path).basename.to_s
    relative_path_in_parent = @path_name.relative_path_from(@parent_folder_path).to_s

    [parent_folder_name, relative_path_in_parent].join('/')
  end
end
