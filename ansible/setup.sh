:
export TAG=`date +%s`
docker build -t influitive/ansible . \
 && docker tag influitive/ansible:latest influitive/ansible:${TAG} \
 && docker push influitive/ansible:${TAG} \
 && docker push influitive/ansible:latest 
