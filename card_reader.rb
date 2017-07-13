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

response = Unirest.post "Carloss-MBP:3000/participants", 
                        headers:{ "Accept" => "application/json" }, 
                        parameters:{ :identifier_key => card }

p response.code # Status code
p response.headers # Response headers
p response.body # Parsed body
p response.raw_body # Unparsed body
