require 'spec_helper'

describe Interactors::ShowPost do
  subject { Interactors::ShowPost }

  context 'must show the same Post' do
    let(:request) { Helpers::Factories::Post.new_created_request }
    it {
      response = subject.new(request).exec

      expect(response[:post][:id]).to eq(request[:post][:id])
    }
  end
  describe 'must be invalid' do
    context 'if the Post was not found' do
      let(:request) { Helpers::Factories::Post.new_created_request }
      it {
        request[:post][:id] = 123
        response = subject.new(request).exec

        expect(response).to include(:errors)
        errors = response[:errors].first
        expect(errors[:code]).to eq(105)
        expect(errors[:field]).to be_nil
        expect(errors[:resource]).to eq('Post')
      }
    end
  end
end
