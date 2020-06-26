require 'nokogiri'
require 'httparty'
require 'byebug'

def job

  url = "https://dd313e8456be.ngrok.io/"
  unparsed_page = HTTParty.get(url)
  page = Nokogiri::HTML(unparsed_page)

  #get data from a div and get img url in 2 ways
  src1 = page.css("div.images").children.css("img").attribute("src").value()
  src2 = page.css("div.images > img")[0]['src']
  puts src1, src2

  lists = page.css("div.attr > ul > li") #This carries the collection of li tags

  #We can iterate the this array or by these value we can make another array
  lists.each do |li|
    puts li.text
  end

  #Get data from a div and make a hash

  keys = page.css("span.left")
  values = page.css("span.right")

  target = {}
  keys.each_with_index {|key, index|
    hashkey = key.text
    target[hashkey] = values[index].text
  }

  puts target

  byebug

end

job