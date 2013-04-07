path = File.expand_path "../../", __FILE__

screens = Dir.glob("#{path}/screenshots_src/*")
screens.sort_by!{ |screen| File.mtime screen }
screens.each_with_index do |screen, idx|
  name = File.basename screen

  cmd = "cd #{path}/screenshots_src; mv \"#{name}\" #{idx+1}.png"
  puts "executing: #{cmd}"
  `#{cmd}`
end