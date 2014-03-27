[![Build Status](https://travis-ci.org/tdantas/chain.svg?branch=master)](https://travis-ci.org/tdantas/chain)
[![Coverage Status](https://coveralls.io/repos/tdantas/chain/badge.png)](https://coveralls.io/r/tdantas/chain)

# Chain

 Create middleware chains like Rack.

## Installation

Add this line to your application's Gemfile:

    gem 'chain'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chain

## Usage

**Middlewares** must implement an initialize that will receive the chain and respond_to perform with arity one.

**Application** ( the last node in the chain ) must initialize with arity zero and implement perform.  


````

  class Middleware
    def initialize(chain)
      @chain = chain
    end

    def perform(ctx)
      @chain.perform(ctx)
    end
  end

  class Application
    def initialize
      # do whatever setup
    end

    def perform(context)
      ...
    end
  end

  chain = Chain.new(Middleware, Application)
  context = {}
  chain.run(context)

````

  


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
