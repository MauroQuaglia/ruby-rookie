# rails middleware -> per vedere la lista di tutti i middleware
# config.middleware.insert_before(0, GCDisabler)
# config.middleware.insert_after(GCDisabler, Rack::RubyProf, path: 'tmp/profile')

class GCDisabler
  def initialize(app)
    @app = app
  end

  def call(env)
    GC.start

    GC.disable
    response = @app.call(env)
    GC.enable

    response
  end
end