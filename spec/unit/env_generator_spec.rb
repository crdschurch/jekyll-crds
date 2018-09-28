require 'spec_helper'

RSpec.describe Jekyll::Crds::EnvGenerator do

  before do
    @site = JekyllHelper.scaffold(
      base_path: File.expand_path('./spec/dummy'),
      collections_dir: File.expand_path('./spec/dummy/collections'),
      collections: %w(pages)
    )

    ENV['DEPLOY_URL'] = 'http://example.com'
    ENV['IMGIX_SRC'] = 'contentful_url'
    ENV['IMGIX_DOMAIN'] = 'imgix_url'
    ENV["STREAMSPOT_ID"] = "abcdefg12345"
    ENV["STREAMSPOT_API_KEY"] = "my_extra_awesome_key"

    @gen = Jekyll::Crds::Env.new(@site)
  end

  it 'should set the site url' do
    expect(@site.config['url']).to eq('http://example.com')
  end

  it 'should set the Jekyll env' do
    expect(@site.config['jekyll_env']).to eq('development')
  end

  it 'should have the correct default img url' do
    expect(@site.config['default_image']).to eq('//imgix_url/default-image.jpg')
  end

  it 'should set the gateway endpoint' do
    expect(@site.config['gateway_server_endpoint']).to eq('https://gatewayint.crossroads.net/gateway/')
  end

  it 'should configure the shared header endpoints' do
    expect(@site.config['shared_header']).not_to be(nil)
    expect(@site.config['shared_header']['img']).to eq('https://int.crossroads.net/proxy/gateway/api/image/profile/')
  end

  it 'should set imgix envs' do
    expect(@site.config['imgix'][:find]).to eq('contentful_url')
    expect(@site.config['imgix'][:replace]).to eq('imgix_url')
  end

  it 'should expose a constant for environments' do
    expect(@gen.envs).to be_truthy
    expect(@gen.envs.dig(:development)).to eq('int')
    expect(@gen.envs.dig(:int)).to eq('int')
    expect(@gen.envs.dig(:demo)).to eq('demo')
    expect(@gen.envs.dig(:production)).to eq('www')
  end

  it 'should return the correct env prefix' do
    @site.config['jekyll_env'] = 'development'
    expect(@gen.send(:env_prefix)).to eq('int')
    @site.config['jekyll_env'] = 'production'
    expect(@gen.send(:env_prefix)).to eq('www')
  end

  it 'should return the correct Streamspot envs' do
    @gen.send(:configure_streamspot_credentials)
    expect(@site.config['streamspotId']).to eq('abcdefg12345')
    expect(@site.config['streamspotKey']).to eq('my_extra_awesome_key')
  end

end
