require_relative "lib/locked_gate/version"

Gem::Specification.new do |spec|
  spec.name        = 'locked_gate'
  spec.version     = LockedGate::VERSION
  spec.authors     = ['Daniel Moreto']
  spec.email       = ['dfmoreto@gmail.com']
  spec.homepage    = 'https://github.com/dfmoreto/locked_gate'
  spec.summary     = 'JWT authentication'
  spec.description = 'Gem to perform JWT authentication including token validation and expiration check and generate a User resource with logged user'
  spec.license = 'MIT'
  spec.required_ruby_version = '> 3.0.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/dfmoreto/locked_gate'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 7.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
