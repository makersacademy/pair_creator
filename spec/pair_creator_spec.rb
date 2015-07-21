require 'pair_creator'
describe PairCreator do

  let(:subject){described_class.call('june')}
  let(:students){['Bob', 'Andy', 'Tony']}

  before do
    allow(File).to receive(:write).and_return true
    allow(YAML).to receive(:load_file).and_return students
  end

  it '' do
    subject
  end
end