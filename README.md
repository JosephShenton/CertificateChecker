# CertificateChecker
This is the certificate check written for Ignition. 

I have provided old certificates as an example.

# Installation

In Terminal

```
cd /path/to/revokeCheckerFolder/
chmod a+x check.sh
chmod a+x getCA.sh
chmod a+x readCerts.sh
chmod a+x request.sh
chmod a+x revokeChecker.sh
```

# Usage

### Check all Certificates

In terminal run 

```
./revokeChecker.sh
```

### Check Individual Certificate

> Please Note, for this the password must be the p12 name.

In terminal run 

```
./check.sh "/path/to/password.p12"
```