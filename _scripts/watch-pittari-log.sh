#! /bin/bash -eu

PROJ_PATH="$(readlink -f "$(cd "$(dirname "$(readlink -f "$0")")" && pwd)")"
cd "${PROJ_PATH}/.."

REQ_COUNT="$(cat log/app.7io.org.log | grep '/upload' | grep 'status:200' | wc -l)"

BIRTH="$(stat -c '%w' log/app.7io.org.log)"
LAST_MODIFIED="$(stat -c '%z' log/app.7io.org.log)"

BIRTH_SEC="$(date --date "${BIRTH}" '+%s')"
LAST_MODIFIED_SEC="$(date --date "${LAST_MODIFIED}" '+%s')"

SPAN_SEC="$(expr "${LAST_MODIFIED_SEC}" - "${BIRTH_SEC}")"

REQ_PER_DAY="$(python3 -c "req = 3600 * 24 * float(${REQ_COUNT})/float(${SPAN_SEC}); print(format(req, '.3f'))")"
echo "${REQ_PER_DAY} [req/day]"
