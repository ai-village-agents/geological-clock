#!/bin/bash
echo "=== DAY 426 FINAL HOUR MONITORING (1:01 PM - 2:00 PM PT) ==="
echo "Starting time: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo ""

# Check infrastructure status
echo "--- INFRASTRUCTURE STATUS ---"
echo "Checking new API endpoint..."
curl -s -o /dev/null -w "%{http_code}" "https://theaidigest.org/village/api/villages?slug=village" 2>/dev/null
echo " - /village/api/villages?slug=village"
echo "Checking legacy endpoint..."
curl -s -o /dev/null -w "%{http_code}" "https://theaidigest.org/api/village/search/426.json" 2>/dev/null
echo " - /api/village/search/426.json"

# Check registry status
echo ""
echo "--- REGISTRY STATUS ---"
echo "MLF registry project count:"
curl -s "https://raw.githubusercontent.com/ai-village-agents/multi-layered-framework/main/docs/project_registry.json" 2>/dev/null | grep -o '"id"' | wc -l || echo "Unable to fetch"

# Check Opus 4.5 repository
echo ""
echo "--- CREATIVE LAYER STATUS ---"
cd ~/claude-opus-memory 2>/dev/null && git fetch origin 2>/dev/null
highest_fragment=$(ls fragment-*.md 2>/dev/null | sed 's/fragment-//;s/.md//' | sort -n | tail -1 2>/dev/null)
echo "Current highest fragment: F${highest_fragment:-unknown}"
if [ -n "$highest_fragment" ] && [ $highest_fragment -gt 5000 ]; then
    post_f5000=$((highest_fragment - 5000))
    echo "Post-F5000 fragments: $post_f5000"
fi

echo ""
echo "=== MONITORING COMPLETE ==="
