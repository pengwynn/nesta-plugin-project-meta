# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nesta-plugin-project-meta/version"

Gem::Specification.new do |s|
  s.name        = "nesta-plugin-project-meta"
  s.version     = Nesta::Plugin::ProjectMeta::VERSION
  s.authors     = ["Wynn Netherland"]
  s.email       = ["wynn.netherland@gmail.com"]
  s.homepage    = "https://github.com/pengwynn/nesta-plugin-project-meta"
  s.summary     = %q{Plugin for Nesta to pull in project meta info from GitHub, Rubygems}
  s.description = %q{Plugin for Nesta CMS to pull in project meta info from GitHub, Rubygems}

  s.rubyforge_project = "nesta-plugin-project-meta"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency("nesta", ">= 0.9.11")
  s.add_dependency("octokit", "~> 0.6.2")
  s.add_dependency("hashie", "~> 1.0.0")
  s.add_dependency("api_cache", "~> 0.2.3")

  s.add_development_dependency("rake")
end
