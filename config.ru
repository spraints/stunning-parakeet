require_relative "lib/app"
root=File.join("..", App.root)

require "dotenv"
Dotenv.load File.join(root, ".env")

require "omniauth-github"
use OmniAuth::Builder do
  github_hostname = ENV["GITHUB_HOSTNAME"] || "github.com"
  github_protocol = ENV["GITHUB_PROTOCOL"] || "https"
  if github_hostname == "github.com"
    provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"]
  else
    provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"],
      :client_options => {
        :site => "#{github_protocol}://#{github_hostname}/api/v3",
        :authorize_url => "#{github_protocol}://#{github_hostname}/login/oauth/authorize",
        :authorize_url => "#{github_protocol}://#{github_hostname}/login/oauth/access_token",
      }

run App

# vim:ft=ruby
