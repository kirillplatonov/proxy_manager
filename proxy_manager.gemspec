$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "proxy_manager"
  s.version     = '0.0.8'
  s.authors     = ["Kirill Platonov"]
  s.licenses    = ['MIT']
  s.email       = ["platonov.kd@gmail.com"]
  s.homepage    = "https://github.com/bloodyhistory/proxy_manager"
  s.summary     = "Ruby proxy manager for easy usage proxy in parser/web bots."
  s.description = <<-DESCRIPTION
    This gem is for easy usage proxy in your parsers/web-bots. It will manage
    your proxy list and check availability.
  DESCRIPTION

  s.files       = `git ls-files`.split("\n") - %w[.gitignore .travis.yml]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'net-ping', '~> 1.7', '>= 1.7.2'

  s.add_development_dependency 'turn', '~> 0.9', '>= 0.9.7'
  s.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.1'
  s.add_development_dependency 'guard-rspec', '~> 4.2', '>= 4.2.8'
  s.add_development_dependency 'growl', '~> 1.0', '>= 1.0.3'
  s.add_development_dependency 'fuubar', '~> 1.3', '>= 1.3.2'
  s.add_development_dependency 'yard', '~> 0.8', '>= 0.8.7.4'
end
