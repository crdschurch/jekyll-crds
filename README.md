# Jekyll::Crds

## What is this?

Jekyll::Crds is a handy set of reusable utilities for Crossroad's Jekyll projects. Running this command today does two main things:

1. Configure and expose environment vars to the `site` object within Jekyll.
2. Builds a cached (\_includes) version of the shared header and shared footer.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-crds'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-crds

## Usage

Add `bundle exec jekyll crds` to your build process or use it one-off via command line.

## License

The gem is available as open source under the terms of the [BSD-3 License](https://opensource.org/licenses/BSD-3-Clause).
