shared_examples_for 'Presence Validation' do
  it 'must be invalid' do
    expect(model.valid?).to be_falsey
  end
  context 'must have a presence error' do
    it {
      model.valid?
      errors.each do |error|
        expect(model.errors.added?(field.to_sym, error.to_sym)).to be_truthy
      end
    }
  end
end
