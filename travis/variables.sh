#!/usr/bin/env bash

RELEASETYPE=''

#null definition
export NULL='none'

#internal DokerImage name
export LOCAL_DOCKERIMAGE='eoepca/eoepca-build-cpp'


#eoepca repository
export EOEPCA_REPOSITORY='eoepca'

#eoepca name
export EOEPCA_IMAGE="eoepca-build-cpp"

#get branch name
TRAVIS_BRANCH="${TRAVIS_BRANCH:-develop}"

#change name for branch feature ex feature/EOEPCA-38 change in  feature_EOEPCA_38
echo ${TRAVIS_BRANCH} | grep '/'
if [ $? -eq 0 ]
then
	TRAVIS_BRANCH=$(echo ${TRAVIS_BRANCH}| sed -e 's@/@_@g')
	TRAVIS_BRANCH=$(echo ${TRAVIS_BRANCH}| sed -e 's@-@_@g')
fi
export TRAVIS_BRANCH

#simple anchor
if [ "${TRAVIS_BRANCH}" == 'master' ]
then
  RELEASETYPE='release_'
	echo 'Branch selected: master '
fi

#simple anchor
if [ "${TRAVIS_BRANCH}" == 'develop' ]
then
  RELEASETYPE='develop_'
	echo 'Branch selected: develop' 
fi

#new definitions
export TRAVIS_BUILD_NUMBER="${TRAVIS_BUILD_NUMBER:-0}"
export buildTag=${RELEASETYPE}${TRAVIS_BRANCH}_${TRAVIS_BUILD_NUMBER}
export BUILD_IMAGE="${BUILD_IMAGE:-${NULL}}"
export BUILD_IMAGE_PUSH="${BUILD_IMAGE_PUSH:-${NULL}}"

