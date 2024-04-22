#!/bin/bash

echo "Encode the signature using base64 for cosign"
cat signed-metadata/payload.json.sig | base64 > payload.json.base64.sig

echo "Upload the signature to the registry"
cosign attach signature --payload payload.json --signature payload.json.base64.sig $IMAGE_DIGEST
