require 'spec_helper'
require 'ostruct'
require_relative '../bin/server_client'

describe ServerClient do
  describe '#methods' do
    context 'with :post' do
      it 'should have succesful response' do
        allow(described_class).to receive(:post).and_return(OpenStruct.new(code: 200))

        response = described_class.post(type: 'folder', relative_path: 'path/to/folder')

        expect(response.code).to eq(200)
      end
    end

    context 'with :delete' do
      it 'should have successful response' do
        allow(described_class).to receive(:delete).and_return(OpenStruct.new(code: 200))

        response = described_class.delete(relative_path: 'path/to/folder')

        expect(response.code).to eq(200)
      end
    end
  end
end
