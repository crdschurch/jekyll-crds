require 'spec_helper'

RSpec.describe Jekyll::Crds::Client do
  
  before do
    @client = Jekyll::Crds::Client.new
    
    VCR.use_cassette 'ss' do
      @content_blocks = @client.send(:content_blocks)
    end
  end

  it "should return content blocks from Silverstripe" do
      expect(@content_blocks).not_to be_empty
  end

  it "should select content blocks by title" do
    expect(@client.select('sharedGlobalHeader')).to_not be nil
    expect(@client.select('footer')).to_not be nil
  end

end
