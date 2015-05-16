$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mixed_number_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mixed_number_rails"
  s.version     = MixedNumberRails::VERSION
  s.authors     = ["tpadjen"]
  s.email       = ["tpadjen@gmail.com"]
  s.homepage    = "https://github.com/tpadjen/mixed_number_rails"
  s.summary     = "Store mixed numbers in an ActiveRecord model seamlessly with built-in validation."
  # s.description = "TODO: Description of MixedNumberRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.10"
  s.add_dependency "mixed_number"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
