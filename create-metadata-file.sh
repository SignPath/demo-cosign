#!/bin/bash

echo "Install cosign"
curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-amd64"
sudo mv cosign-linux-amd64 /usr/local/bin/cosign
sudo chmod +x /usr/local/bin/cosign

echo "Extracting the repository digest identifier for the given FQN"
export IMAGE_DIGEST=`docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE_FQN:$IMAGE_TAG"`

echo "Generating a metadata file to be signed from identifier: $IMAGE_DIGEST"
cosign generate $IMAGE_DIGEST > payload.json

echo "Store image digest for later step"
echo "IMAGE_DIGEST=$IMAGE_DIGEST" >> $GITHUB_ENV