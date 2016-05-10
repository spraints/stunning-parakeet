require_relative "lib/app"
root=File.join("..", App.root)

require "dotenv"
Dotenv.load File.join(root, ".env")

require "omniauth-github"
use OmniAuth::Builder do
  github_hostname = ENV["GITHUB_HOSTNAME"] || "github.com"
  github_protocol = ENV["GITHUB_PROTOCOL"] || "https"

  options = {:scope => "repo,write:repo_hook"}
  if github_hostname != "github.com"
    options[:client_options] = {
      :site => "#{github_protocol}://#{github_hostname}/api/v3",
      :authorize_url => "#{github_protocol}://#{github_hostname}/login/oauth/authorize",
      :authorize_url => "#{github_protocol}://#{github_hostname}/login/oauth/access_token",
    }
  end

  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"], options
end

run App

# vim:ft=ruby
