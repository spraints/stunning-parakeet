Rails.application.config.middleware.use OmniAuth::Builder do
  github_hostname = ENV["GITHUB_HOSTNAME"] || "github.com"
  github_protocol = ENV["GITHUB_PROTOCOL"] || "https"

  options = {:scope => "repo,write:repo_hook"}
  if github_hostname != "github.com"
    options[:client_options] = {
      :site => "#{github_protocol}://#{github_hostname}/api/v3",
      :authorize_url => "#{github_protocol}://#{github_hostname}/login/oauth/authorize",
      :token_url => "#{github_protocol}://#{github_hostname}/login/oauth/access_token",
    }
  end

  provider :github, ENV["GITHUB_KEY"], ENV["GITHUB_SECRET"], options
end
