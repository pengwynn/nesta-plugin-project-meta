require 'api_cache'
require 'octokit'
require 'gems'
require 'hashie'

module Nesta
  module Plugin
    module ProjectMeta
      module Helpers
        def link_to_github_watchers(page)
          if page.github_meta
            watchers_url = page.github_meta.url + "/watchers"
            %Q{<a href="#{watchers_url}">#{page.github_meta.watchers}</a>}
          end
        end

        def link_to_github_forks(page)
          if page.github_meta
            forks_url = page.github_meta.url + "/network"
            %Q{<a href="#{forks_url}">#{page.github_meta.forks}</a>}
          end
        end
      end
    end
  end

  class App
    helpers Nesta::Plugin::ProjectMeta::Helpers
  end

  class Page
    def github_meta
      github_repo = self.metadata('github_repo')
      return nil if github_repo.nil?

      APICache.get("github-#{github_repo}", :fail => nil) do
        Octokit.repo(github_repo)
      end
    end

    def rubygems_meta
      gem_name = self.metadata('gem')
      return nil if gem_name.nil?


      APICache.get("gem-#{gem_name}", :fail => nil) do
        Hashie::Mash.new(Gems.info(gem_name))
      end
    end
  end
end
