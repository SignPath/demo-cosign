echo "Extracting the repository digest identifier for the given FQN"
export IMAGE_DIGEST=`docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE_FQN:$IMAGE_TAG"`

echo "Generating a metadata file to be signed from identifier: $IMAGE_DIGEST"
cosign generate $IMAGE_DIGEST > payload.json

echo "Store image digest for later step"
echo "IMAGE_DIGEST=$IMAGE_DIGEST" >> $GITHUB_ENV