module Disposer
  def with(connection)
    begin
      yield(connection)
    ensure
      connection.dispose
    end
  end
end