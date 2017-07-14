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

p r 

p sak

# Unirest.post "Carloss-MBP:3000/participants",
#                         headers:{ "Accept" => "application/json" },
#                         parameters:{ :identifier_key => card }

# Unirest.post "mymac:3000/participants",
#                         headers:{ "Accept" => "application/json" },
#                         parameters:{ :identifier_key => card }