require 'mfrc522'
require 'securerandom'
require 'unirest'

r = MFRC522.new


begin
  r.picc_request(MFRC522::PICC_REQA)
  uid, sak = r.picc_select
rescue CommunicationError => e
  abort "Error communicating PICC: #{e.message}"
end

card = Mifare::Classic.new(r, uid, sak)

card.read

# response = Unirest.post "http://httpbin.org/post", 
#                         headers:{ "Accept" => "application/json" }, 
#                         parameters:{ :age => 23, :foo => "bar" }

# response.code # Status code
# response.headers # Response headers
# response.body # Parsed body
# response.raw_body # Unparsed body
