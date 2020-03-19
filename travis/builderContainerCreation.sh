#!/usr/bin/env bash

# fail fast settings from https://dougrichardson.org/2018/08/03/fail-fast-bash-scripting.html
set -euov pipefail

source travis/variables.sh

BUILDIMAGE="Build"
if [ "${BUILD_IMAGE}" != "${NULL}" ] #is defined a public DockerImageCompiler
then
	docker pull ${BUILD_IMAGE}
	if [ $? -ne 0 ] #pull failed, build my DockerImageCompiler
	then
		BUILDIMAGE="Build"
	else
		BUILDIMAGE="${NULL}"
		docker tag ${BUILD_IMAGE} ${LOCAL_DOCKERIMAGE}
	fi
fi

# the Image must be buildt
if [ ${BUILDIMAGE} != "${NULL}" ]
then
	docker build --rm --no-cache -t ${LOCAL_DOCKERIMAGE} .
fi

# check if the Image must be push
if [ "${BUILD_IMAGE_PUSH}" != "${NULL}" ]
then
	echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
	docker tag ${LOCAL_DOCKERIMAGE} ${DOCKER_USERNAME}/${EOEPCA_IMAGE}:$buildTag
	docker push ${DOCKER_USERNAME}/${EOEPCA_IMAGE}:$buildTag
fi

