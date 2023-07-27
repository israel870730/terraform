#! /bin/bash
set -euo pipefail

# SOURCE_DIR="$(dirname "$(dirname "$(readlink -fm "$0")")")"
SECRETS_FILE=${1:-/renovite/reno-cloud-deployment/infrastructure/renovite/common/secrets.yaml}

# Decrypt Secret Data
OUTPUT=$(sops -d "${SECRETS_FILE}" )

printf "%s\n" "${OUTPUT}"