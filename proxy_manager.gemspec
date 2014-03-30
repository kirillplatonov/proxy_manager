$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "proxy_manager"
  s.version     = '0.0.2'
  s.authors     = ["Kirill Platonov"]
  s.email       = ["platonov.kd@gmail.com"]
  s.homepage    = "https://github.com/bloodyhistory/proxy_manager"
  s.summary     = "Ruby proxy manager. Gem for easy usage proxy in parser/web bots."
  s.description = <<-DESCRIPTION
    This gem is for easy usage proxy in your parsers/web-bots. It will manage your proxy
    list and check availability.
  DESCRIPTION

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc", ".rspec"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'net-ping'

  s.add_development_dependency 'turn'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'growl'
  s.add_development_dependency 'fuubar'
end
