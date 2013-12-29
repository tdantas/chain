require 'spec_helper'

describe Chain do
  

  APP = Class.new do
      
      def perform(ctx)
        ctx[:mid] = true
        'final_app_return_value'
      end

  end

  ADD_VALUE = Class.new do 
    
    def initialize(next_node)
      @next_node = next_node
    end

    def perform(ctx)
      ctx[:value] = "new_value_added #{ctx[:before_add]}"
      @next_node.perform(ctx)
    end

  end

  BEFORE_ADD_VALUE = Class.new do 

    def initialize(next_node)
      @next_node = next_node
    end

    def perform(ctx)
      ctx[:before_add] = ctx[:id]
      @next_node.perform(ctx)
    end

  end

  UPPERCASE_RESPONSE = Class.new do 

    def initialize(next_node)
      @next_node = next_node
    end

    def perform(ctx)
      response = @next_node.perform(ctx)
      response.upcase
    end

  end

  it 'accepts no chain nodes' do
    chain = Chain.new
    expect { chain.run }.to_not raise_error
  end 

  context 'zero middlewares, one chain node' do 

    it 'when there is only one in the chain, there is no need to initialize with chain' do
      chain = Chain.new(APP)
      expect { chain.run }.to_not raise_error
    end

  end


  context '#run' do 

    it 'accepts "context object" that will be shared among all chain' do 
      
      chain = Chain.new(BEFORE_ADD_VALUE, ADD_VALUE, APP)
      
      ctx = {}
      ctx[:id] = 100

      response = chain.run(ctx)
      
      expect(response).to eql('final_app_return_value')
      expect(ctx[:value]).to eql('new_value_added 100')
    
    end

    it 'permits middleware changes the app returned value' do 
      chain = Chain.new(UPPERCASE_RESPONSE, APP)
      response = chain.run
      expect(response).to eql('FINAL_APP_RETURN_VALUE')
    end

  end
end