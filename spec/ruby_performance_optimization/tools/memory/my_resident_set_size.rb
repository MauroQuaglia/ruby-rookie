def my_resident_set_size(title, gc_enable: true)
  GC.enable if gc_enable # Così è come deve girare sempre.
  GC.disable if !gc_enable # Solo per avere una idea di quando il processo occuperebbe in memoria.

  memory_before = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  yield
  memory_after = `ps -o rss= -p #{Process.pid}`.to_i / 1024

  puts "#{title} - memory used: #{memory_after - memory_before} MB"
end
