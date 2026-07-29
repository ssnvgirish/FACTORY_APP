#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
# Factory App — Migrate Cloud SQL + deploy Data Connect
# ═══════════════════════════════════════════════════════════════
#
# Fixes: Frames / Sheets "New Machine Health Report" submit errors
# caused by DB still on old rating schema while app uses maintenance
# entries.
#
# USAGE (from project root):
#   chmod +x tools/run_dataconnect_migration.sh
#   ./tools/run_dataconnect_migration.sh
#
# BEFORE running this script you MUST run the safe SQL prep:
#   firebase dataconnect:sql:shell --project prabitha-operations
#   # paste contents of tools/sql/07_safe_health_report_migration.sql
#
# AFTER this script finishes, re-apply master FKs:
#   firebase dataconnect:sql:shell --project prabitha-operations
#   # paste contents of tools/sql/03_enforce_master_reference_fks.sql
# ═══════════════════════════════════════════════════════════════

set -euo pipefail

PROJECT="prabitha-operations"
SERVICE="prabitha-operations-service"
LOCATION="asia-south1"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

cd "$ROOT"

echo ""
echo "════════════════════════════════════════════════════════"
echo " Data Connect migration + deploy"
echo " Project : $PROJECT"
echo " Service : $SERVICE ($LOCATION)"
echo "════════════════════════════════════════════════════════"
echo ""

if ! command -v firebase >/dev/null 2>&1; then
  echo "ERROR: firebase CLI not found. Install: npm i -g firebase-tools"
  exit 1
fi

echo ">>> Step 0: Confirm you already ran BOTH SQL prep scripts"
echo "    1. tools/sql/07_safe_health_report_migration.sql"
echo "    2. tools/sql/08_preflight_fix_migration_blockers.sql"
echo "    Via : Google Cloud SQL query window, or"
echo "          firebase dataconnect:sql:shell --project $PROJECT"
echo ""
read -r -p "Did you already run BOTH 07 and 08? [y/N] " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo ""
  echo "Open a SQL shell and paste that file first:"
  echo "  firebase dataconnect:sql:shell --project $PROJECT --service $SERVICE --location $LOCATION"
  echo ""
  echo "Then re-run this script."
  exit 1
fi

echo ""
echo ">>> Step 1: Show schema diff (for your review)"
firebase dataconnect:sql:diff \
  --project "$PROJECT" \
  --service "$SERVICE" \
  --location "$LOCATION" || true

echo ""
echo "WARNING: migrate will apply remaining schema changes."
echo "It may DROP unused columns/tables (old tools_count score fields,"
echo "dropdown_config, reference_table, etc.). Master FKs will be dropped"
echo "and must be re-applied with 03_enforce_master_reference_fks.sql."
echo ""
read -r -p "Continue with sql:migrate --force? [y/N] " CONFIRM2
if [[ ! "$CONFIRM2" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 1
fi

echo ""
echo ">>> Step 2: Migrate Cloud SQL schema"
firebase dataconnect:sql:migrate \
  --project "$PROJECT" \
  --service "$SERVICE" \
  --location "$LOCATION" \
  --force

echo ""
echo ">>> Step 3: Deploy Data Connect (schema + connectors)"
firebase deploy \
  --only dataconnect \
  --project "$PROJECT" \
  --force

echo ""
echo ">>> Step 4: Re-apply master reference FKs (required)"
echo "Migration drops the FK constraints from tools/sql/03_..."
echo "Open SQL shell and paste that file:"
echo ""
echo "  firebase dataconnect:sql:shell --project $PROJECT --service $SERVICE --location $LOCATION"
echo "  # paste tools/sql/03_enforce_master_reference_fks.sql"
echo ""
read -r -p "Press Enter after you have re-applied the FK script (or Ctrl+C to stop)..."

echo ""
echo ">>> Step 5: Final diff (should be empty or only legacy unused objects)"
firebase dataconnect:sql:diff \
  --project "$PROJECT" \
  --service "$SERVICE" \
  --location "$LOCATION" || true

echo ""
echo "════════════════════════════════════════════════════════"
echo " DONE"
echo ""
echo " Next:"
echo "  1. Rebuild / reinstall the Flutter app"
echo "  2. Retest: Frames / Sheets / Scrap Machine Health Report submit"
echo "  3. Retest: Admin → Reference Tables (weights + targets)"
echo "════════════════════════════════════════════════════════"
