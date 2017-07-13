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

c = Mifare::Classic.new(r, uid, sak)

card = c.uid.join

p card

# response = Unirest.post "/participants", 
#                         headers:{ "Accept" => "application/json" }, 
#                         parameters:{ :identifier_key => card }

# response.code # Status code
# response.headers # Response headers
# response.body # Parsed body
# response.raw_body # Unparsed body
