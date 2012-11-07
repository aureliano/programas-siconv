require 'spec_helper'

describe "Concedente Model" do
  let(:concedente) { Concedente.new }
  it 'can be created' do
    concedente.should_not be_nil
  end
end
