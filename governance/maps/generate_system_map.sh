#!/data/data/com.termux/files/usr/bin/bash
set -e

MAP="governance/maps/system_map.md"

echo "# HHI Governance System Map" > "$MAP"
echo "Generated: $(date)" >> "$MAP"
echo "" >> "$MAP"

echo "## Core Surfaces" >> "$MAP"
echo "- runtime/telemetry" >> "$MAP"
echo "- runtime/evidence" >> "$MAP"
echo "- runtime/drift" >> "$MAP"
echo "- runtime/escalation" >> "$MAP"
echo "- runtime/assurance" >> "$MAP"
echo "- runtime/logs" >> "$MAP"

echo "" >> "$MAP"
echo "## Operational Scripts (system/)" >> "$MAP"
echo "- drift_runner.sh" >> "$MAP"
echo "- escalation_checker.sh" >> "$MAP"
echo "- assurance_daemon.sh" >> "$MAP"
echo "- metadata_stamper.sh" >> "$MAP"
echo "- report_generator.sh" >> "$MAP"

echo "" >> "$MAP"
echo "## Intelligence Layer (governance/)" >> "$MAP"
echo "- dashboard generator" >> "$MAP"
echo "- routing map generator" >> "$MAP"
echo "- system map generator" >> "$MAP"
echo "- canonical term enforcement" >> "$MAP"
echo "- repo integrity guardian" >> "$MAP"

echo "[HHI] System map generated."
