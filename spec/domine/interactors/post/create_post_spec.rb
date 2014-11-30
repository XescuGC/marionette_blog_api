require 'spec_helper'

describe Interactors::CreatePost do
  subject { Interactors::CreatePost }

  context 'must create a valid Post' do
    let(:request) { {post: attributes_for(:post)} }
    it {
      before_count = PostRepository.all.count
      response = subject.new(request).exec

      expect(response[:post]).to include(:id)
      expect(PostRepository.all.count).to be(before_count + 1)
    }
  end

  describe 'must be invalid' do
    context 'if the Post is invalid' do
      let(:request) { {post: attributes_for(:post, title: nil)} }
      it {
        response = subject.new(request).exec

        expect(response).to include(:errors)
        errors = response[:errors].first
        expect(errors[:code]).to eq(101)
        expect(errors[:field]).to eq(:title)
        expect(errors[:resource]).to eq('Post')
      }
    end
  end
end
