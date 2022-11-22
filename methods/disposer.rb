module Disposer

  def with(connection)
    result = ''
    begin
      result = yield(connection)
      connection.dispose
    rescue
      connection.dispose
    end
    result
  end
end