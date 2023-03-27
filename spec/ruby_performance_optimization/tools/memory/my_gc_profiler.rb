def my_gc_profiler
  GC.enable

  GC::Profiler.enable
  yield
  GC::Profiler.report.inspect
  GC::Profiler.disable
end
