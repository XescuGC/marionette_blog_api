require 'spec_helper'

describe Interactors::ListPost do
  subject { Interactors::ListPost }

  describe 'must return all posts' do
    context 'if no post' do
      it {
        response = subject.new.exec

        expect(response[:posts].count).to eq(0)
      }
    end
    context 'if one post' do
      let!(:request) { Helpers::Factories::Post.new_created_request }
      it {
        response = subject.new.exec

        expect(response[:posts].count).to eq(1)
      }
    end
    context 'if more than one post should return them in order of creation (-1)' do
      let!(:request) { Helpers::Factories::Post.new_created_request }
      let!(:request2) { Helpers::Factories::Post.new_created_request }
      let!(:request3) { Helpers::Factories::Post.new_created_request }
      it {
        response = subject.new.exec

        expect(response[:posts].count).to eq(3)
        expect(response[:posts][0][:id]).to eq(request3[:post][:id])
        expect(response[:posts][1][:id]).to eq(request2[:post][:id])
        expect(response[:posts][2][:id]).to eq(request[:post][:id])
      }
    end
    context 'if a tag filter is specified must return only the posts with the Tag with the creation order (-1)' do
      let(:tag1)      { attributes_for(:tag, name: 'surf') }
      let(:tag2)      { attributes_for(:tag, name: 'eat') }
      let(:tag3)      { attributes_for(:tag, name: 'paly') }
      let!(:request)  { Helpers::Factories::Post.new_created_request(tags: [tag1[:name], tag2[:name]]) }
      let!(:request2) { Helpers::Factories::Post.new_created_request(tags: [tag1[:name], tag3[:name]]) }
      let!(:request3) { Helpers::Factories::Post.new_created_request(tags: [tag3[:name]]) }
      it {
        response = subject.new({filter: {tag: tag1[:name]}}).exec

        expect(response[:posts].count).to eq(2)
        expect(response[:posts][0][:id]).to eq(request2[:post][:id])
        expect(response[:posts][1][:id]).to eq(request[:post][:id])
      }
      it {
        response = subject.new({filter: {tag: tag2[:name]}}).exec

        expect(response[:posts].count).to eq(1)
        expect(response[:posts][0][:id]).to eq(request[:post][:id])
      }
      it {
        response = subject.new({filter: {tag: tag3[:name]}}).exec

        expect(response[:posts].count).to eq(2)
        expect(response[:posts][0][:id]).to eq(request3[:post][:id])
        expect(response[:posts][1][:id]).to eq(request2[:post][:id])
      }
    end
  end
end
