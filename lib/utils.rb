module Utils
  def redcloth(view)
    textile = File.read "#{PATH}/textile/#{view}.textile"
    RedCloth.new(textile).to_html
  end
end