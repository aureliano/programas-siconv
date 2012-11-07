require 'spec_helper'

describe "Programa Model" do
  let(:programa) { Programa.new }
  it 'can be created' do
    programa.should_not be_nil
  end
end
