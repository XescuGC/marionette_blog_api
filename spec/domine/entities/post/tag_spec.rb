require 'spec_helper'

describe Tag do
  context 'must respond to the following attributes' do
    it {
      [:name].each do |att|
        expect(subject).to respond_to(att)
      end
    }
  end
end
