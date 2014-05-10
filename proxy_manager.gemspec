$:.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "proxy_manager"
  s.version     = '1.0.0'
  s.authors     = ["Kirill Platonov"]
  s.licenses    = ['MIT']
  s.email       = ["platonov.kd@gmail.com"]
  s.homepage    = "https://github.com/bloodyhistory/proxy_manager"
  s.summary     = "This is gem for easy usage proxy in your parsers/web-bots."
  s.description = <<-DESCRIPTION
    This is gem for easy usage proxy in your parsers/web-bots.
    It will manage your proxy list and check availability if you need it.
  DESCRIPTION

  s.files       = `git ls-files`.split("\n") - %w[.gitignore .travis.yml]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency 'turn', '~> 0.9', '>= 0.9.7'
  s.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.1'
  s.add_development_dependency 'guard-rspec', '~> 4.2', '>= 4.2.8'
  s.add_development_dependency 'growl', '~> 1.0', '>= 1.0.3'
  s.add_development_dependency 'fuubar', '~> 1.3', '>= 1.3.2'
  s.add_development_dependency 'yard', '~> 0.8', '>= 0.8.7.4'
end
