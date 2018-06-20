#
# Tox
#
# tox is a generic virtualenv management and test command line tool
# Link: https://tox.readthedocs.io/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_TOX_SHOW="${SPACESHIP_TOX_SHOW=true}"
SPACESHIP_TOX_PREFIX="${SPACESHIP_TOX_PREFIX=""}"
SPACESHIP_TOX_SUFFIX="${SPACESHIP_TOX_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_TOX_SYMBOL="${SPACESHIP_TOX_SYMBOL="  "}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_async_job_load_tox() {
  [[ $SPACESHIP_TOX_SHOW == false ]] && return

  async_job spaceship spaceship_async_job_tox "$PWD"
}

spaceship_async_job_tox() {
  builtin cd -q "$1" 2>/dev/null
  [[ -f tox.ini ]] \
    && { command tox -q >/dev/null 2>&1 \
      && { echo 'OK' } \
      || { echo 'FAIL' }} \
    || echo ""
}

# Shows tox status
spaceship_tox() {
  [[ -z "${SPACESHIP_ASYNC_RESULTS[spaceship_async_job_tox]}" ]] && return
  [[ "${SPACESHIP_ASYNC_RESULTS[spaceship_async_job_tox]}" == "OK" ]] && SPACESHIP_TOX_COLOR="green"
  [[ "${SPACESHIP_ASYNC_RESULTS[spaceship_async_job_tox]}" == "FAIL" ]] && SPACESHIP_TOX_COLOR="red"

  [[ $SPACE ]]
  spaceship::section \
    "$SPACESHIP_TOX_COLOR" \
    "$SPACESHIP_TOX_PREFIX" \
    "${SPACESHIP_TOX_SYMBOL}${SPACESHIP_ASYNC_RESULTS[spaceship_async_job_tox]}" \
    "$SPACESHIP_TOX_SUFFIX"
}
