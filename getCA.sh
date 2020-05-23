IPAURL="ENTER IPA URL"
IPANAME="ca.ipa"

curl -s "$IPAURL" --output "$IPANAME"

unzip -q "$IPANAME"
codesign -d --extract-certificates Payload/*.app
openssl x509 -inform DER -in codesign0 -out codesign0.pem
openssl x509 -inform DER -in codesign1 -out codesign1.pem
openssl x509 -inform DER -in codesign2 -out codesign2.pem
cat codesign1.pem codesign2.pem > cachain.pem

rm codesign0
rm codesign0.pem
rm codesign1
rm codesign1.pem
rm codesign2
rm codesign2.pem
rm -rf "Payload"