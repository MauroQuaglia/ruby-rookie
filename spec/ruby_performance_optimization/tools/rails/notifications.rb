# https://dev.to/hugodias/using-rails-secret-weapon-activesupportnotifications-12d3
# https://edgeguides.rubyonrails.org/active_support_instrumentation.html per vedere tutti i vari subscribe del tipo "sql.active_record"

# config/initializers/events.rb
ActiveSupport::Notifications.subscribe("sql.active_record") do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)
  Rails.logger.info("SQL-INSPECTOR: #{event.name}")
end