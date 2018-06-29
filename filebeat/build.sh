:
IMAGE=$(basename ${PWD})
DOCKER_REPO=influitive
TAG=`date +%s`

docker build -t ${DOCKER_REPO}/${IMAGE} . \
 && docker tag ${DOCKER_REPO}/${IMAGE} influitive/${IMAGE}:${TAG} \
 && docker push ${DOCKER_REPO}/${IMAGE}:${TAG} \
 && docker push ${DOCKER_REPO}/${IMAGE}:latest 
