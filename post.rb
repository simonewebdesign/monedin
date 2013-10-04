require 'net/http'

# Basic GET request
# uri = URI('http://simonewebdesign.it/blog/')
# puts Net::HTTP.get(uri) # => String


# POST params
#isJsEnabled=true&source_app=&session_key=MY%40MAILADDRESS.COM&session_password=MY_PASSWORD
#&signin=Sign+In&session_redirect=&csrfToken=ajax%3A9104694997583838774&sourceAlias=0_7r5yezRXCiA_H0CRD8sf6DhOjTKUNps5xGTqeX8EEoi

uri = URI('https://www.linkedin.com/uas/login-submit')
params = {
  'isJsEnabled'       => 'true', 
  'source_app'        => '',
  'session_key'       => '',
  'session_password'  => '',
  'signin'            => 'Sign+In',
  'session_redirect'  => '',
  'csrfToken'         => 'ajax%3A9104694997583838774',
  'sourceAlias'       => '0_7r5yezRXCiA_H0CRD8sf6DhOjTKUNps5xGTqeX8EEoi'
}
res = Net::HTTP.post_form(uri, params)

puts 'Response completed.'
puts "Response code: #{res.code}"

if res.code == '302'

  # debugging
  puts "Location: #{res['location']}"
  #puts "Header: "
  #res.each_header do |header_name, header_value|
  #  puts "#{header_name} : #{header_value}"
  #end

  # get cookies
  # all_cookies = res.get_fields('set-cookie')

  #cookies_array = Array.new
  #all_cookies.each { |cookie|
  #    cookies_array.push(cookie.split('; ')[0])
  #}
  #cookies = cookies_array.join('; ')
  #puts "INSPECTING COOKiES"
  #puts all_cookies.inspect

# Request Headers

#GET /nhome/ HTTP/1.1
#Host: www.linkedin.com
#Connection: keep-alive
#Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
#User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/30.0.1599.66 Safari/537.36
#DNT: 1
#Referer: http://www.linkedin.com/
#Accept-Encoding: gzip,deflate,sdch
#Accept-Language: en-US,en;q=0.8
#Cookie: bcookie="v=2&6dd8cdf7-01e8-4232-81df-69a9c5cbaef0"; visit="v=1&G"; __qca=P0-251899317-1363701986042; X-LI-IDC=C4; __utma=23068709.1573120424.1380897853.1380897853.1380897853.1; __utmb=23068709.2.10.1380897853; __utmc=23068709; __utmz=23068709.1380897853.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); __utmv=23068709.guest; L1e=5744e48f; JSESSIONID="ajax:4525093924544860256"; li_at=AQEBARGGRmAAAAGvAAABQYPt5J8AAAFBhFvBnwwYqNAmLEADgTrMOMHPJ4uYNXkml7fGumFZ0usau0ZO_3710wzPgxKtvxEctAq0fW32RD4p9cymvnWdKt9BNJA-2nXJxTjriBTfxwx-_xRCVqooww; lang="v=2&lang=en-us"

  # 2nd request
  uri2 = "http://www.linkedin.com/nhome/"  # URI(res['location'])
  params2 = {
    'Cookie' => res['set-cookie']
  }
  res2 = Net::HTTP.get(uri2, params2)

  File.open("home.html", "w") { |io|
    io.write res2
  }
else
  puts "Not 302, aborting."
end
puts "Finish."

#puts res.body won't work because is a 302 Found & Redirect (or Moved Temporarily).

# 200 OK: The request is fulfilled.
# 301 Move Permanently: The resource requested for has been permanently moved to a
#     new location. The URL of the new location is given in the response header
#     called Location. The client should issue a new request to the new location. 
#     Application should update all references to this new location.
# 302 Found & Redirect (or Move Temporarily): Same as 301, but the new location is
#     temporarily in nature. The client should issue a new request, but 
#     applications need not update the references.

#homeUri = URI('http://www.linkedin.com/nhome/')
#homeBody = Net::HTTP.get(homeUri)

#File.open("home.html", "w") { |io|
#  io.write homeBody
#}
