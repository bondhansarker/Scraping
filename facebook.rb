require "mechanize"

def facebook

  url = "https://x.facebook.com/"

  agent = Mechanize.new {|agent| agent.user_agent_alias = "Mac Safari"}

  html = agent.get(url)

  form = html.forms.first

  form['email'] = 'user_name'
  form['pass'] = 'password'

  page = form.submit

  link = page.link_with(:dom_class => "_54k8 _56bs _26vk _56b_ _56bw _56bt") #don't save login data

  page = link.click

  link = page.link_with(:dom_class => "_4kk6") #for going to my profile

  page = link.click 

  link = page.link_with(:dom_class => "_15kq _77li") #found the post

  page = link.click 

  100.times {
    form = page.form_with(:id => 'comment_form_100001964235456_3936856359723133')
    form['comment_text'] = "textarea_values"
    submit = form.button_with(:value => 'Post')
    form.click_button(submit)
  }
  
  puts succeed

end

facebook