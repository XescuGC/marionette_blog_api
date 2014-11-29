require 'spec_helper'

describe Post do
  context 'must respond to the following attributes' do
    it {
      [:title, :body, :created_at, :updated_at, :tags, :id, :preface].each do |att|
        expect(subject).to respond_to(att)
      end
    }
  end
end
