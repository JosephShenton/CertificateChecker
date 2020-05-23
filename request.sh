filename=$1
password=$2
openssl pkcs12 -in ${filename} -clcerts -nokeys -passin pass:${password} -out ${filename}.crt &> /dev/null
openssl x509 -in ${filename}.crt -out ${filename}.pem &> /dev/null

certificate=$(openssl x509 -in ${filename}.pem -noout -nameopt -oneline -subject | sed 's/.*O=\(.*\)\/C/\1/' | sed 's/=.*//')

# openssl ocsp -issuer cachain.pem -cert ${filename}.pem -url `openssl x509 -in ${filename}.pem -noout -ocsp_uri` -CAfile cachain.pem -header 'host' 'ocsp.apple.com' | grep "${filename}.pem: revoked" &> /dev/null
openssl ocsp -issuer cachain.pem -cert ${filename}.pem -url `openssl x509 -in ${filename}.pem -noout -ocsp_uri` -CAfile cachain.pem -header 'host' 'ocsp.apple.com' &> $(pwd)/cmdout.txt

cat $(pwd)/cmdout.txt | fgrep -v "OK" | grep "${filename}.pem: revoked" &> /dev/null
if [ $? == 0 ]; then
    # printf "\nChecking if $certificate is revoked";
    RED='\033[1;31m'
    NC='\033[0m' # No Color
    # printf "$certificate is revoked.\n\n";
    echo -e "$certificate is revoked."
    # printf "\n";
  else 
    # printf "\nChecking if $certificate is revoked";
    GREEN='\033[1;32m'
    NC='\033[0m' # No Color
    # printf "$certificate is revoked.\n\n";
    echo -e "$certificate is signed."
    # printf "\n";
fi

# printf "\n";

rm ${filename}.crt
rm ${filename}.pem