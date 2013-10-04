require 'net/http'

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
  # GET
  uri2 = URI(res['location'])

  file = File.stat 'cached_response.html'
  req2 = Net::HTTP::Get.new(uri2)
  req2['E-Sticazzi'] = "fava"

  res2 = Net::HTTP.start(uri.hostname, uri.port) { |http|
    http.request(req2)
  }

  open 'cached_response', 'w' do |io|
    io.write res2.body
  end if res2.is_a?(Net::HTTPSuccess)

end
