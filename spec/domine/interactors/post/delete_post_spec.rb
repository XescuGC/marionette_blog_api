require 'spec_helper'

describe Interactors::DeletePost do
  subject { Interactors::DeletePost }
  context 'must delete the Post' do
    let!(:request) { Helpers::Factories::Post.new_created_request }
    it {
      before_count = PostRepository.all.count
      response = subject.new(request).exec

      expect(response).to be_nil
      expect(PostRepository.all.count).to eq(before_count-1)
    }
  end
  describe 'must be invalid' do
    context 'if the Post is not found' do
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
