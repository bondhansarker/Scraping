require "mechanize"

def both

  #Mechanize

  url = "https://www.gov.uk/"

  fp = File.new("myfile.txt", "w")

  agent = Mechanize.new {|agent| agent.user_agent_alias = "Mac Safari"}

  html = agent.get(url)

  form = html.forms.first

  form['q'] = 'passport'

  page = form.submit

  fp.write("Mechanize Search Results\n\n")

  page.search('#js-results li a').each do |element|
    fp.write(element.text.strip + "\n")
  end


  #Nokogiri

  page_url =  page.uri

  html = agent.get(page_url).body

  html_doc = Nokogiri::HTML(html)

  fp.write("\n\nNokogiri Search Results\n\n")

  html_doc.css('#js-results li a').each do |element|
    fp.write(element.text.strip + "\n")
  end

  puts "both done"

end

both