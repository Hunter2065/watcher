require 'spec_helper'
require_relative '../bin/path_tool'

# I need :type, :relative_path
describe PathTool do
  let(:path_tool) { described_class.new(parent_folder_path: 'root/path/to', absolute_path: 'root/path/to/folder') }

  describe '#methods' do
    # use :ftype
    context 'with :type' do
      it 'should return the element\'s type' do
        allow_any_instance_of(Pathname).to receive(:ftype).and_return('directory')

        expect(path_tool.type).to eq('directory')
      end
    end

    # use :relative_path_from and name for join by '/' it with relative path 'cause first method remove the parent folder name
    context 'with :relative_path option' do
      it 'should return element\'s the relative_path' do
        expect(path_tool.relative_path).to eq('to/folder')
      end
    end
  end
end
