require 'spec_helper'

RSpec.describe Jekyll::Crds::EnvGenerator do
  
  before do
    @site = JekyllHelper.scaffold(
      base_path: File.expand_path('./spec/dummy'),
      collections_dir: File.expand_path('./spec/dummy/collections'),
      collections: %w(podcasts episodes)
    )
    @generator = Jekyll::Placeholders::Generator.new
  end
end
