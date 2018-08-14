#
# Rust
#
# Rust is a systems programming language sponsored by Mozilla Research.
# Link: https://www.rust-lang.org

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_RUST_SHOW="${SPACESHIP_RUST_SHOW=true}"
SPACESHIP_RUST_PREFIX="${SPACESHIP_RUST_PREFIX="$SPACESHIP_PROMPT_DEFAULT_PREFIX"}"
SPACESHIP_RUST_SUFFIX="${SPACESHIP_RUST_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_RUST_SYMBOL="${SPACESHIP_RUST_SYMBOL="𝗥 "}"
SPACESHIP_RUST_COLOR="${SPACESHIP_RUST_COLOR="red"}"
SPACESHIP_RUST_VERBOSE_VERSION="${SPACESHIP_RUST_VERBOSE_VERSION=false}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current version of Rust
spaceship_async_job_load_rust() {
  [[ $SPACESHIP_RUST_SHOW == false ]] && return

    async_job spaceship spaceship_async_job_rust $PWD
}

spaceship_async_job_rust() {
  builtin cd -q $1 2>/dev/null

  # If there are Rust-specific files in current directory
  setopt extendedglob
  [[ -f Cargo.toml || -n *.rs(#qN^/) ]] || return

  spaceship::exists rustc || return

  local rust_version=$(rustc --version | cut -d' ' -f2)

  if [[ $SPACESHIP_RUST_VERBOSE_VERSION == false ]]; then
  	local rust_version=$(echo $rust_version | cut -d'-' -f1) # Cut off -suffixes from version. "v1.30.0-beta.11" or "v1.30.0-nightly"
  fi

  echo "v$rust_version"
}

spaceship_rust() {
  [[ -z "${SPACESHIP_ASYNC_RESULTS[spaceship_async_job_rust]}" ]] && return

  spaceship::section \
    "$SPACESHIP_RUST_COLOR" \
    "$SPACESHIP_RUST_PREFIX" \
    "${SPACESHIP_RUST_SYMBOL}${SPACESHIP_ASYNC_RESULTS[spaceship_async_job_rust]}" \
    "$SPACESHIP_RUST_SUFFIX"
}
