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

p c.uid

