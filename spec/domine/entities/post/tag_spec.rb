require 'spec_helper'

describe Tag do
  context 'must respond to the following attributes' do
    it {
      [:name].each do |att|
        expect(subject).to respond_to(att)
      end
    }
  end
  describe 'must have the following validation' do
    context 'Name' do
      it_should_behave_like 'Presence Validation' do
        let(:model)   { build(:tag, name: nil) }
        let(:field)   { :name }
        let(:errors)  { [:blank] }
      end
    end
  end
end
