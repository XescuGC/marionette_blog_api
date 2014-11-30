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
    context 'if more than one post' do
      let!(:request) { Helpers::Factories::Post.new_created_request }
      let!(:request2) { Helpers::Factories::Post.new_created_request }
      let!(:request3) { Helpers::Factories::Post.new_created_request }
      it {
        response = subject.new.exec

        expect(response[:posts].count).to eq(3)
      }
    end
  end
end
