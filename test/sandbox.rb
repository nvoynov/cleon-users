require "digest/sha2"

module CryptoProvider

end

def hash_password(password, salt)
  digestor = Digest::SHA256.new
  input = digestor.digest(salt + password)

  1000.times.inject(input) do |reply|
    digestor.digest(reply)
  end
end

pp hash_password("abcdefgh", "sfafsaffsf")
