module Nesta
  module Plugin
    module Project::Meta
      module Helpers
        # If your plugin needs any helper methods, add them here...
      end
    end
  end

  class App
    helpers Nesta::Plugin::Project::Meta::Helpers
  end

  class Page
    def github_meta
      github_repo = self.metadata('github_repo')
      return nil if github_repo.nil?

      APICache.get("github-#{github_repo}") do
        Octokit.repo(github_repo)
      end
    end

    def rubygems_meta
      gem_name = self.metadata('gem')
      return nil if gem_name.nil?


      APICache.get("gem-#{gem_name}") do
        Hashie::Mash.new(Gems.info(gem_name))
      end
    end
  end
end
