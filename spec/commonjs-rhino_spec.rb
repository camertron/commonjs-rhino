# encoding: UTF-8

require 'spec_helper'

describe CommonjsRhino do
  let(:rhino) { CommonjsRhino }
  let(:privileged_uris) { [File.expand_path('../', __FILE__)] }

  describe '#create_context' do
    it 'returns a context object' do
      rhino.create_context(privileged_uris).tap do |context|
        expect(context).to respond_to(:eval)
        expect(context).to respond_to(:eval_file)
      end
    end
  end
end
