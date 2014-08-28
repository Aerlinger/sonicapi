require 'spec_helper'

describe "A simple spec" do
  let(:api) { SonicApi.authenticate('asdf') }

  it "is true" do
    SonicApi.access_key.should eq('asdf')
  end
end
