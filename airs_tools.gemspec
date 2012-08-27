# -*- encoding: utf-8 -*-
require File.expand_path('../lib/airs_tools/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Masakuni Kato"]
  gem.email         = ["kato@airs.co.jp"]
  gem.description   = %q{This is a little command line tools in AIRS, inc.}
  gem.summary       = %q{AIRS command line tools}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "airs_tools"
  gem.require_paths = ["lib"]
  gem.version       = AirsTools::VERSION
  
  gem.add_dependency 'thor'
  gem.add_dependency 'grit'
  gem.add_dependency 'jira-ruby'
end
