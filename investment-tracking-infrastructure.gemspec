Gem::Specification.new do |s|
  s.name            = 'investment-tracking-infrastructure'
  s.version         = '0.0.1'
  s.platform        = Gem::Platform::RUBY
  s.summary         = 'Infrastructure for investment tracking app.'
  s.description     = 'This is to be plugged into delivery mechanisms for the investment tracking app.'
  s.email           = 'thiago.rdp@gmail.com'
  s.authors         = ['Thiago Rodrigues de Paula']
  s.homepage        = 'https://github.com/thiagorp/investment-tracking-infrastructure'
  s.license         = 'MIT'

  s.files           = `git ls-files`.split("\n")
  s.test_files      = `git ls-files -- test/*`.split("\n")
  s.require_paths   = ['lib']
  s.required_ruby_version = '>= 2.3.0'

  s.add_dependency('pg', '~>0.18')
  s.add_dependency('sequel', '~>4.30')

  s.add_development_dependency('rake', '~>10.5')
  s.add_development_dependency('timecop', '~>0.8')
  s.add_development_dependency('minitest', '~> 5.8')
end
