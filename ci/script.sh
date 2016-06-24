#!/bin/bash
set -e -x
# run the tests!
if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    mkdir -p $HOME/build/urschrei/convertbng/wheelhouse
    docker pull $DOCKER_IMAGE
    docker run --rm -v `pwd`:/io $DOCKER_IMAGE $PRE_CMD /io/ci/build_wheel.sh
    # clean up numpy
    sudo rm wheelhouse/numpy-1.11.0-cp27-cp27mu-manylinux1_x86_64.whl
fi

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    python setup.py nosetests
    pip wheel . -w wheelhouse
    mkdir to_test
    cd to_test
    pip install convertbng --no-index wheelhouse
    nosetests convertbng
fi
