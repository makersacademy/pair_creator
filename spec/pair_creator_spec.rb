require 'pair_creator'
describe PairCreator do

  let(:subject){described_class.call('june')}
  let(:students){['Andy', 'Bob', 'Tony']}
  let(:historic){[['Andy', 'Bob']]}

  before do
    allow(File).to receive(:write)
    allow(YAML).to receive(:load_file).and_return students
    allow(subject).to receive(:historic_pairs).and_return historic
  end

  it 'a new pair to be generated' do
    expect(subject.generate_new_pairs).to eq [['Andy', 'Tony']]
  end
end