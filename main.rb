require 'anemone'
require 'optparse'
require 'ostruct'

options = OpenStruct.new
options.relative = false

begin
  # make sure that the last option is a URL we can crawl
  root = URI(ARGV.last)
rescue
  puts <<-INFO
Usage:
anemone url-list [options] <url>
Synopsis:
Crawls a site starting at the given URL, and outputs the URL of each page
in the domain as they are encountered.

Options:
-r, --relative Output relative URLs (rather than absolute)
INFO
  exit(0)
end

# parse command-line options
opts = OptionParser.new
opts.on('-r', '--relative') { options.relative = true }
opts.parse!(ARGV)

number = 0
info = ''
log = File.open("log.txt", 'w')
log.write("Crawl started: " + Time.new.to_s + "\n")

Anemone.crawl(root, :discard_page_bodies => true) do |anemone|
  
  anemone.on_every_page do |page|
    if options.relative
      puts "fetching #{page.url.path}..."
    else
      puts page.url
    end

    if (page.code == 200)
      # get page contents
      content = page.url.path + "\n\n" + page.body
      # create a new file and put the contents there
      File.new("#{number}.html", 'w').write(content)
      number = number + 1
      # log informations      
      log.write("#{page.url.path} >> #{number}.html\n")      
    else
      # not a valid page
      log.write("WARNING: Response #{page.code} on #{page.url.path}\n")
    end
  end

end

log.write("Crawl finished: : " + Time.new.to_s + "\n\n\n")
puts "finished!"
