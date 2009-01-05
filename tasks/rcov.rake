desc "Run RCov"
task :rcov do
  run_coverage Dir["test/**/*_test.rb"]
end

def run_coverage(files)
  rm_f "coverage"
  rm_f "coverage.data"
  if files.length == 0
    puts "No files were specified for testing"
    return
  end
  files = files.join(" ")
  if PLATFORM =~ /darwin/
    exclude = '--exclude "gems/"'
  else
    exclude = '--exclude "rubygems"'
  end
  rcov = "rcov -Ilib:test --sort coverage --text-report #{exclude} --no-validator-links"
  cmd = "#{rcov} #{files}"
  puts cmd
  sh cmd
end
