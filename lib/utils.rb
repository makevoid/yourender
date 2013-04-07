module Utils
  def redcloth(view)
    textile = File.read "#{PATH}/textile/#{view}.textile"
    RedCloth.new(textile).to_html
  end
end

UPCASED_WORDS = %w(aws ami osx)

class String
  def humanize
    str = self.gsub(/_/, " ")
    str[0].upcase + str[1..-1]
  end
end