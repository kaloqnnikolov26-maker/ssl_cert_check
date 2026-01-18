#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="${CONFIG_FILE:-websites.conf}"

WARN_DAYS="${WARN_DAYS:-30}"
CRIT_DAYS="${CRIT_DAYS:-7}"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "ERROR: Config file not found: $CONFIG_FILE"
  exit 1
fi

echo "SSL Certificate Expiry Check"
echo "============================"

while read -r HOST; do
  [[ -z "$HOST" ]] && continue

  echo "Host: $HOST"

  CERT_INFO=$(echo | openssl s_client -servername "$HOST" -connect "$HOST:443" 2>/dev/null || true)

  if [[ -z "$CERT_INFO" ]]; then
    echo "  ERROR: Unable to retrieve certificate"
    echo ""
    continue
  fi

  EXPIRY_DATE=$(echo "$CERT_INFO" | openssl x509 -noout -enddate 2>/dev/null | cut -d= -f2)

  if [[ -z "$EXPIRY_DATE" ]]; then
    echo "  ERROR: Invalid certificate data"
    echo ""
    continue
  fi

  EXPIRY_TS=$(date -d "$EXPIRY_DATE" +%s)
  NOW_TS=$(date +%s)
  DAYS_LEFT=$(( (EXPIRY_TS - NOW_TS) / 86400 ))

  echo "  Expiry Date : $EXPIRY_DATE"
  echo "  Days Left   : $DAYS_LEFT"

  if (( DAYS_LEFT <= CRIT_DAYS )); then
    echo "  STATUS      : CRITICAL"
  elif (( DAYS_LEFT <= WARN_DAYS )); then
    echo "  STATUS      : WARNING"
  else
    echo "  STATUS      : OK"
  fi

  echo ""
done < "$CONFIG_FILE"

