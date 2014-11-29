require 'spec_helper'

describe Post do
  context 'must respond to the following attributes' do
    it {
      [:title, :body, :created_at, :updated_at, :tags, :id, :preface].each do |att|
        expect(subject).to respond_to(att)
      end
    }
  end
  describe 'must have the following validations' do
    [:title, :created_at, :updated_at, :body, :preface].each do |att|
      context "#{att}" do
        it_should_behave_like 'Presence Validation' do
          let(:model)   { build(:post).tap{ |model| model.send("#{att.to_sym}=", nil)} }
          let(:field)   { att.to_sym }
          let(:errors)  { [:blank] }
        end
      end
    end
  end
end
