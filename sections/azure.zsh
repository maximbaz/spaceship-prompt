#
# Microsoft Azure
#
# The Azure CLI is a unified tool to manage Azure services.
# Link: https://github.com/Azure/azure-cli

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_AZURE_SHOW="${SPACESHIP_AZURE_SHOW=true}"
SPACESHIP_AZURE_PREFIX="${SPACESHIP_AZURE_PREFIX="using "}"
SPACESHIP_AZURE_SUFFIX="${SPACESHIP_AZURE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_AZURE_SYMBOL="${SPACESHIP_AZURE_SYMBOL="☁️ "}"
SPACESHIP_AZURE_COLOR="${SPACESHIP_AZURE_COLOR="208"}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

spaceship_async_job_load_azure() {
  [[ $SPACESHIP_AZURE_SHOW == false ]] && return

  async_job spaceship spaceship_async_job_azure
}

spaceship_async_job_azure() {
  echo $(az account show --query name --output tsv 2>/dev/null)
}

# Shows selected Azure CLI subscription.
spaceship_azure() {
  [[ -z "${SPACESHIP_ASYNC_RESULTS[spaceship_async_job_azure]}" ]] && return

  spaceship::section \
    "$SPACESHIP_AZURE_COLOR" \
    "$SPACESHIP_AZURE_PREFIX" \
    "${SPACESHIP_AZURE_SYMBOL}${SPACESHIP_ASYNC_RESULTS[spaceship_async_job_azure]}" \
    "$SPACESHIP_AZURE_SUFFIX"
}
