require 'spec_helper'

describe PostDecorator do
  subject { PostDecorator }
  describe 'must correctly decorate a Post' do
    let(:response) { Helpers::Factories::Post.new_created_request }
    context 'single Post' do
      it {
        decorated = subject.decorate_response(response)

        tags = response[:post][:tags].map{|t| t[:name]}
        expect(decorated).to eq({
          id:         response[:post][:id],
          title:      response[:post][:title],
          preface:    response[:post][:preface],
          body:       response[:post][:body],
          tags:       tags,
          created_at: response[:post][:created_at].iso8601,
        })
      }
    end
    context 'array of Post' do
      let!(:post1) { Helpers::Factories::Post.new_created_request }
      let!(:post2) { Helpers::Factories::Post.new_created_request }
      context 'single Post' do
        it {
          posts = Interactors::ListPost.new.exec
          decorated = subject.decorate_response(posts)

          expect(decorated.count).to eq(2)
          dec1 = decorated.first
          dec2 = decorated.last

          tags1 = post2[:post][:tags].map{|t| t[:name]}
          expect(dec1).to eq({
            id:         post2[:post][:id],
            title:      post2[:post][:title],
            preface:    post2[:post][:preface],
            body:       post2[:post][:body],
            tags:       tags1,
            created_at: post2[:post][:created_at].iso8601,
          })
          tags2 = post1[:post][:tags].map{|t| t[:name]}
          expect(dec2).to eq({
            id:         post1[:post][:id],
            title:      post1[:post][:title],
            preface:    post1[:post][:preface],
            body:       post1[:post][:body],
            tags:       tags2,
            created_at: post1[:post][:created_at].iso8601,
          })
        }
      end
      context 'with no content' do
        let!(:request) { Helpers::Factories::Post.new_created_request }
        it {
          response = Interactors::DeletePost.new(request).exec
          decorated = subject.decorate_response(response)

          expect(decorated).to be_nil
        }
      end
    end
    context 'if there are some errors' do
      let(:request) { Helpers::Factories::Post.new_request }
      it {
        request[:post][:title] = nil
        response = Interactors::CreatePost.new(request).exec
        decorate = subject.decorate_response(response)
        expect(decorate).to eq({
          message: 'Check validation errors',
          errors: [
            {
              resource: 'Post',
              field:    :title,
              code:     101
            }
          ]
        })
      }
    end
  end
end
