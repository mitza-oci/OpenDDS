#!/bin/bash
export MATRIX_NAME=$1
aws s3 cp s3://com.ociweb.opendds/$TRAVIS_BRANCH/$MATRIX_NAME/build.tar.gz .
tar zxf build.tar.gz
cd build
ctest -j 6
ret=$?
# replace the dot in $TRAVIS_JOB_NUMBER with slash
TRAVIS_BUILD_JOB_DIR=${TRAVIS_JOB_NUMBER/./\/}
$TRAVIS_BUILD_DIR/ctestlog2json.py --generated_url_prefix=http://com.ociweb.opendds.s3-website-us-east-1.amazonaws.com/tests/${TTRAVIS_BUILD_JOB_DIR} \
  --outdir=travis_tests/${TRAVIS_BUILD_JOB_DIR}
aws s3 sync travis_tests/${TRAVIS_BUILD_NUMBER} s3://com.ociweb.opendds/tests/${TRAVIS_BUILD_NUMBER}
aws s3 sync s3://com.ociweb.opendds/tests/${TRAVIS_BUILD_NUMBER} travis_tests/${TRAVIS_BUILD_NUMBER} --exclude "*.txt"

NUM_TEST_STAGES=`grep 'stage: test' $TRAVIS_BUILD_DIR/.travis.yml | wc -l`
NUM_TESTS_JSON_FILES=`find travis_tests/${TRAVIS_BUILD_NUMBER} -name "tests.json" | wc -l`

if [ $NUM_TEST_STAGES == ${NUM_TESTS_JSON_FILES} ]; then
  text=`echo "["; find travis_tests/${TRAVIS_BUILD_NUMBER} -name "tests.json" -exec cat {} \; | paste -sd "," - ; echo "]"`
  echo $text > travis_tests/${TRAVIS_BUILD_NUMBER}/report.json
  aws s3 cp travis_tests/${TRAVIS_BUILD_NUMBER}/report.json s3://com.ociweb.opendds/tests/${TRAVIS_BUILD_NUMBER}/report.json
fi

exit $ret