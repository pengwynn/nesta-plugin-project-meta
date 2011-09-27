require 'api_cache'
require 'octokit'
require 'gems'
require 'hashie'

module Nesta
  module Plugin
    module ProjectMeta
      def self.github_meta(page)
        github_repo = page.metadata('github_repo')
        return nil if github_repo.nil?

        APICache.get("github-#{github_repo}", :fail => nil) do
          Octokit.repo(github_repo)
        end
      end

      def self.rubygems_meta(page)
        gem_name = page.metadata('gem')
        return nil if gem_name.nil?

        APICache.get("gem-#{gem_name}", :fail => nil) do
          Hashie::Mash.new(Gems.info(gem_name))
        end
      end

      module Helpers
        def github_meta(page)
          ProjectMeta.github_meta(page)
        end

        def link_to_github_watchers(page)
          metadata = github_meta(page)
          if metadata
            watchers_url = metadata.url + "/watchers"
            %Q{<a href="#{watchers_url}">#{metadata.watchers}</a>}
          end
        end

        def link_to_github_forks(page)
          metadata = github_meta(page)
          if metadata
            forks_url = metadata.url + "/network"
            %Q{<a href="#{forks_url}">#{metadata.forks}</a>}
          end
        end
      end
    end
  end

  class App
    helpers Nesta::Plugin::ProjectMeta::Helpers
  end
end
