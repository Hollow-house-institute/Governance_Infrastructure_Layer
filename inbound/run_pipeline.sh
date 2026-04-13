#!/data/data/com.termux/files/usr/bin/bash

echo "=== HHI PIPELINE START ==="

# 1. Generate post
./inbound/daily_post.sh

# 2. Show latest post
echo
echo "=== LATEST POST ==="
cat inbound/logs/post_$(date +%F).txt

# 3. Show leads file
echo
echo "=== LEADS TRACKING ==="
cat inbound/leads/LEADS.csv

echo
echo "Next steps:"
echo "- Post to LinkedIn"
echo "- Post to DEV"
echo "- Send 5 outreach messages"

echo "=== PIPELINE END ==="
