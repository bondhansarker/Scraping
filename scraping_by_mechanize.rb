require 'mechanize'

mechanize = Mechanize.new

#GO to a link and extract data

page = mechanize.get('http://weblog.rubyonrails.org/')

puts page.at('article header h2').text.strip

#Go to a link and do action and get new url

page = mechanize.get('http://en.wikipedia.org/wiki/Main_Page')

link = page.link_with(text: 'Random article')

page = link.click

puts page.uri

#GO to a link and fill up a search form and get search data

page = mechanize.get('https://www.gov.uk/')

form = page.forms.first

form['q'] = 'passport'

page = form.submit

page.search('#js-results li a').each do |element|
  puts element.text.strip
end