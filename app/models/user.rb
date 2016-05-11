class User < ActiveRecord::Base
  def repositories
    octokit.repositories.map { |api_repo| ApiRepository.new(api_repo) }
  end

  def auth_token=(token)
    if token.nil?
      self.protected_auth_token = nil
    else
      self.protected_auth_token = crypt.encrypt_and_sign(token)
    end
  end

  def auth_token
    protected_auth_token && crypt.decrypt_and_verify(protected_auth_token)
  end

  private

  def crypt
    ActiveSupport::MessageEncryptor.new(ENV["TOKEN_SECRET"] || "a"*1024)
  end

  def octokit
    @octokit ||=
      begin
        faraday = Faraday::RackBuilder.new do |builder|
          builder.use Faraday::HttpCache
          builder.use Octokit::Response::RaiseError
          builder.adapter Faraday.default_adapter
        end
        Octokit::Client.new :access_token => auth_token, :middleware => faraday
      end
  end
end
