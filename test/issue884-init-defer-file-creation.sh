#!/usr/bin/env bash

. $(dirname "${BASH_SOURCE[0]}")/common.sh

TMPDIR=${CURR_DIR}tmppack
echo $TMPDIR

mkdir ${TMPDIR}
cd ${TMPDIR}

# kill dub init during interactive mode
${DUB} init <(while :; do sleep 1; done) &
kill $!

# ensure that no files are left behind
NFILES_PLUS_ONE=`ls -la | wc -l`

cd ${CURR_DIR}
rm -r ${TMPDIR}

# ignore sum + "." + ".."
if [ ${NFILES_PLUS_ONE} -gt 3 ]; then
    die $LINENO 'Aborted dub init left spurious files around.'
fi
