require 'net/http'
http = Net::HTTP

uri = URI('https://www.wuphf.io/api/v1/recipients')
response = http.get(uri)

puts "response:"
puts response
# {"errors":["Authorized users only."]}



# uri      = URI('https://www.wuphf.io/api/v1/auth/sign_in')
# email    = 'jerry@example.com'
# password = 'password'

# res = http.post_form(uri, 'email' => email, 'password' => password)

# # Headers
# res['Set-Cookie']            # => String
# res.get_fields('set-cookie') # => Array
# res.to_hash['set-cookie']    # => Array
# puts "Headers: #{res.to_hash.inspect}"

# # Status
# puts res.code       # => '200'
# puts res.message    # => 'OK'
# puts res.class.name # => 'HTTPOK'

# # Body
# puts res.body
