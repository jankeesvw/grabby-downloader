require 'open-uri'

class Grabby
	def initialize
		Dir.mkdir("grabs") unless Dir.exist?("grabs")
		for letter in "dddd".."zzzz" do
			unless File.file?("grabs/#{letter}.png")
				begin
					uri = URI.parse("http://grab.by/#{letter}")
					open uri do |f|
						FileUtils.mv(f.path, "grabs/#{letter}.png")
					end  
					puts "[x] saved #{letter}"
				rescue
					puts "[ ] no file found with the name #{letter}"
				end  
				
				# break after 1000 MB
				if File.new("grabs").size.to_f / 1024 > 100
					break
				end
			else
				puts "[ ] already saved #{letter}"
			end # file exists
		end
	end
end

Grabby.new
