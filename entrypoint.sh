#!/bin/bash
PATH=/root/.pdtm/go/bin:$PATH


echo "Generating Notify config"
cat <<EOF> /tmp/notify-config.yaml
discord:
  - id: "crawl"
    discord_channel: "default"
    discord_username: "Takeover Bot"
    discord_format: "🟦 FINDING 🟦 \n\n {{data}}"
    discord_webhook_url: "$DISCORD_WEBHOOK_URL"
EOF

echo "Updating nuclei"
nuclei -silent -update-templates -ud /tmp/nuclei-templates

echo "Starting check on $HOST"

subfinder -d $HOST -silent | nuclei -silent -t /tmp/nuclei-templates/http/takeovers | notify -pc /tmp/notify-config.yaml -p discord