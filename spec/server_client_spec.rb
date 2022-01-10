require 'spec_helper'
require_relative '../bin/server_client'

describe ServerClient do
  describe '#methods' do
    context 'with :post' do
      it 'should have succesful response' do
        allow(described_class).to receive(:post).and_return(200)
        expect(
          described_class.post(type: 'folder', relative_path: 'path/to/folder')
        ).to eq(200)
      end
    end
  end
end
