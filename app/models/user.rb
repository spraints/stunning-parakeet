class User < ActiveRecord::Base
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
end
