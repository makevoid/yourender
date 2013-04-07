class Pass
  PASSWORDS = File.read "#{PATH}/config/passwords.txt"

  def self.passwords
    PASSWORDS.split
  end

  def self.word
    passwords.shuffle.first
  end

  def self.gen
    num = rand(11..99)
    "#{word}#{num}#{word}"
  end
end