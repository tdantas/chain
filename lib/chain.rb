class Chain

  class EndOfChain
    def perform(ctx);end
  end


  def initialize(*middlewares)
    @middlewares      = Array.new(middlewares)
    @last_middleware  = @middlewares.pop  || EndOfChain
  end

  def <<(middleware)
    @middlewares.push middleware
  end

  def run(ctx = {})
    to_app.perform(ctx)
  end

  private

  def to_app
    @middlewares.reverse.reduce(@last_middleware.new) do |app, middleware|
      middleware.new(app)
    end
  end

end
