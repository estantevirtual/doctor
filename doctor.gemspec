# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doctor/version'

Gem::Specification.new do |spec|
  spec.name          = 'doctor'
  spec.version       = Doctor::VERSION
  spec.authors       = ['uaiHebert']
  spec.email         = ['holiveira@estantevirtual.com.br']

  spec.summary       = %q{This project will analyse the databases, urls, etc statuses}
  spec.description   = %q{With this project you will able to analyse your external resources status. You will be able to configure wich database connection to check or all the http urls}
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    fail 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  # spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w(lib app)
  spec.test_files = Dir['spec/**/*']

  spec.add_dependency 'railties', '>= 3.1', '<= 5.0.2'
  spec.add_dependency 'sys-filesystem', '1.1.5'
  spec.add_dependency 'codeclimate-test-reporter', '0.4.8'
  spec.add_dependency 'net-telnet', '0.1.1'

  spec.add_development_dependency 'rake', '10.5.0'
  spec.add_development_dependency 'rails', '4.2.5'
  spec.add_development_dependency 'console', '0.5'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'sqlite3'
end
