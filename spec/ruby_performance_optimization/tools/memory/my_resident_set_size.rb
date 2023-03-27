def my_resident_set_size(title)
  GC.enable

  memory_before = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  yield
  memory_after = `ps -o rss= -p #{Process.pid}`.to_i / 1024

  puts "#{title} - memory used: #{memory_after - memory_before} MB"
end
