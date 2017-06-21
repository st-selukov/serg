shared_examples_for  'Attachable' do

  it { should have_many(:attachments).dependent(:destroy) }
  it { should accept_nested_attributes_for :attachments }

  describe 'check attacments' do
    it "return true if #{parent.name.underscore.pluralize}  not have attachment" do
      expect(parent.not_have_attachment(parent: ['file'])).to be true
    end
  end
end
