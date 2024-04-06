echo "Loading the x509 certificate from SignPath"
curl -o cert.cer -L -H "Authorization: Bearer $SIGNPATH_API_TOKEN" \
  https://app.signpath.io/Api/v1-pre/$SIGNPATH_ORGANIZATION_ID/SigningRequests/$SIGNING_REQUEST_ID/X509Certificate

echo "Extracing the public key for verification"
openssl x509 -pubkey -noout -in cert.cer -inform DER > pubkey.pem

echo "Verifying the image"
cosign verify --insecure-ignore-tlog=true --key pubkey.pem $IMAGE_DIGEST