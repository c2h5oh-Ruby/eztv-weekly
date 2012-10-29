#!/usr/bin/ ruby

require 'rubygems'
require 'open-uri'
require 'nokogiri'

def argv_check()
	if (ARGV.length > 1) 
		abort("You can only use one argument! \n")
	else 
		if (ARGV[0] != nil)
			arg = ARGV[0]
		else
			arg =''
		end
	end
end

def set_node(counter)
	url = "http://eztv.it/page_" + counter.to_s
	begin
		node = Nokogiri::HTML(open(url)).xpath('//tr[@class]')
	rescue Errno::ECONNRESET => e
  		abort("Couldn't get #{url}: #{e}")
	rescue OpenURI::HTTPError => e
  		abort("Couldn't get #{url}: #{e}")
	rescue SocketError => e
		abort("Got socket error: #{e}")
	end
end

def node_checker(f, title, date)
	title2 =  f.css('a[title]').text 
	age = f.css('td.forum_thread_post').last.text #ile dni temu
	if (age.include? ">")
		abort("\nDone!")
	end
	if (title2.downcase.include? title.downcase) then
		print "\n------------------------------------------\n"
		print "Title: " + title2 + "\n"
		print "Magnet link: " + f.css('a.magnet').attribute('href') + "\n"
		print date
	end	
end

def page_browser(title, counter)
	date = ''
	node = set_node(counter)
	node.each do |f|
		if (f.attribute('class').text.eql? "forum_space_border") then 
			date = f.css('td').text.strip!
			else
			node_checker(f, title, date)
		end
	end
	counter = Integer(counter)
	counter += 1
end

counter = 0

while(true) do
	counter = page_browser(argv_check(), counter)
end

