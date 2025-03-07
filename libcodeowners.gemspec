# frozen_string_literal: true

require_relative 'lib/libcodeowners/version'

Gem::Specification.new do |spec|
  spec.name = 'libcodeowners'
  spec.version = Libcodeowners::VERSION
  spec.authors = ['Perry Hertler']
  spec.email = ['perry.hertler@gusto.com']

  spec.summary = 'A ruby library wrapping codeowners-rs.'
  spec.description = 'Provides a mechanism for ruby applications to use codeowners-rs.'
  spec.homepage = 'https://github.com/gusto/libcodeowners'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0'
  spec.required_rubygems_version = '>= 3.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rubyatscale/libcodeowners'
  spec.metadata['changelog_uri'] = 'https://github.com/rubyatscale/libcodeowners/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.extensions = ['ext/libcodeowners/Cargo.toml']

  spec.add_dependency 'code_teams', '~> 1.0'
  spec.add_dependency 'sorbet-runtime', '>= 0.5.11249'
  spec.add_development_dependency 'debug'
  spec.add_development_dependency 'railties'
  spec.add_development_dependency 'rake-compiler'
  spec.add_development_dependency 'rb_sys', '~> 0.9.63'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'sorbet'
  spec.add_development_dependency 'tapioca'
end
