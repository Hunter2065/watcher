require 'spec_helper'
require 'byebug'
require "ostruct"
require_relative '../bin/watcher'

describe Watcher do
  let(:watcher) { described_class.new('root/path/to/parent') }

  describe '#methods' do
    context 'with :start_directory_monitoring' do
      it 'should be successful for DIRECTORY' do
        # triggered event :create
        expect_any_instance_of(Filewatcher).to receive(:watch).and_yield('root/path/to/parent/new_folder', :created)

        # by path getted details
        expect_any_instance_of(PathTool).to receive(:type).and_return('directory')

        # send to server
        expect(ServerClient).to receive(:post).with(
          type: 'DIRECTORY',
          relative_path: 'parent/new_folder'
        ).and_return(OpenStruct.new(code: 200))

        watcher.start_directory_monitoring
      end

      it 'should be successful for FILE' do
        # triggered event :create
        expect_any_instance_of(Filewatcher).to receive(:watch).and_yield('root/path/to/parent/file.txt', :created)

        # by path getted details
        expect_any_instance_of(PathTool).to receive(:type).and_return('file')

        # send to server
        allow(File).to receive(:new).and_return('file.txt')
        expect(ServerClient).to receive(:post).with(
          type: 'FILE',
          relative_path: 'parent/file.txt',
          attachment: 'file.txt'
        ).and_return(OpenStruct.new(code: 200))

        watcher.start_directory_monitoring
      end
    end
  end
end
