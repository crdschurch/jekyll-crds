require 'spec_helper'

RSpec.describe Jekyll::Crds do
  before do
    @url = 'https://www.youtube.com/watch?v=DP1TOQ2G0Ks'
    @video = {
      'contentful_id' => '12345',
      'source_url' => @url
    }
    @obj = EmbeddableVideo.new(@video)
  end

  it "should parse video url" do
    expect(EmbeddableVideo.parse_video_url(@url)[:id]).to eq('DP1TOQ2G0Ks')
    expect(EmbeddableVideo.parse_video_url('https://www.youtube.com/embed/DP1TOQ2G0Ks')[:id]).to eq('DP1TOQ2G0Ks')
    expect(EmbeddableVideo.parse_video_url('https://www.youtube.com/v/DP1TOQ2G0Ks')[:id]).to eq('DP1TOQ2G0Ks')
    expect(EmbeddableVideo.parse_video_url('https://vimeo.com/348733803')[:id]).to eq('348733803')
  end

  it "should parse video provider" do
    expect(EmbeddableVideo.parse_video_url('https://www.youtube.com/embed/DP1TOQ2G0Ks')[:provider]).to eq('youtube')
    expect(EmbeddableVideo.parse_video_url('https://vimeo.com/348733803')[:provider]).to eq('vimeo')
  end

  it "should return ERB template" do
    expect(@obj.tpl.class.name).to eq('ERB')
  end

  it "should override the to_s method" do
    expect(@obj.to_s).to include('https://www.youtube.com/embed/DP1TOQ2G0Ks')
    expect(@obj.to_s).to be_a(String)
  end
end
