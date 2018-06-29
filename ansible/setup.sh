:
. .env
export TAG=`date +%s`
docker build -t ${DOCKER_REPO}/ansible . \
 && docker tag ${DOCKER_REPO}/ansible influitive/ansible:${TAG} \
 && docker push ${DOCKER_REPO}/ansible:${TAG} \
 && docker push ${DOCKER_REPO}/ansible:latest
