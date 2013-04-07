`mkdir -p renameds`

screens = Dir.glob("./*")
screens.sort_by!{ |screen| File.basename(screen).to_i }

screens.each_with_index do |screen, idx|
  name = File.basename(screen).to_i

  `mv #{screen} ./renameds/#{name}.png`
end