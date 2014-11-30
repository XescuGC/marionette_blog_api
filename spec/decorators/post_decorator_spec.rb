require 'spec_helper'

describe PostDecorator do
  subject { PostDecorator }
  context 'must correctly decorate a Post' do
    let(:response) { Helpers::Factories::Post.new_created_request }
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
end
