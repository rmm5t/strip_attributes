# More info at https://github.com/guard/guard#readme

directories %w(lib test)

guard :minitest, bundler: true do
  watch(%r{^lib/(.+)\.rb$})  { "test" }
  watch(%r{^test/(.+)\.rb$}) { "test" }
end
