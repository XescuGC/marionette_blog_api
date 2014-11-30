require 'spec_helper'

describe Interactors::UpdatePost do
  subject { Interactors::UpdatePost }

  context 'must update a valid Post' do
    let(:request) { Helpers::Factories::Post.new_created_request }
    it {
      new_title = (0...8).map { (65 + rand(26)).chr }.join
      request[:post][:title] = new_title
      before_count = PostRepository.all.count
      response = subject.new(request).exec

      expect(response[:post][:id]).to eq(request[:post][:id])
      expect(response[:post][:title]).to eq(new_title)
      expect(PostRepository.all.count).to eq(before_count)
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
    context 'if the Post is invalid' do
      let(:request) { Helpers::Factories::Post.new_created_request }
      it {
        request[:post][:title] = nil
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
