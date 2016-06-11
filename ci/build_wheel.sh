#!/bin/bash
set -e -x
# Install a system package required by our library
yum install -y atlas-devel

# Compile wheels
/opt/python/cp27-cp27m/bin/pip install -r /io/dev-requirements.txt
# /opt/python/cp27-cp27m/bin/pip wheel /io/ -w wheelhouse/
cd io && /opt/python/cp27-cp27m/bin/python setup.py bdist_wheel
ls io
ls io/dist
# cp io/dist/* io/wheelhouse

# Bundle external shared libraries into the wheels
for whl in io/wheelhouse/*.whl; do
    auditwheel show $whl
    # auditwheel repair $whl -w /io/wheelhouse/
    # mkdir -p /io/wheelhouse
    # cp $whl /io/wheelhouse/
done

# Install packages and test
# for PYBIN in /opt/python/*/bin/; do
# /opt/python/cp27-cp27m/bin/pip install convertbng --no-index -f wheelhouse
# (cd $HOME; /opt/python/cp27-cp27m/bin/nosetests convertbng)
# done
