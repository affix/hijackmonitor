HijackMonitor
==============

HijackMonitor is a tool to monitor a domain for DNS hijacking. It is container based and can be run standalone or as a Kubernetes CronJob.

## Usage

### Standalone

```bash
$ docker run -it --rm -e HOST=hackerone.com -e DISCORD_WEBHOOK=https://discord.com/api/webhooks/... affixxx/hijackmonitor:latest
```

### Kubernetes CronJob

```bash
$ cat <<EOF> /tmp/cron.yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: hackerone
spec:
  schedule: "0 * * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: hackerone
            image: affixxx/hijackmonitor:latest
            env:
            - name: HOST
              value: "hackerone.com"  # Replace this with your hostname
            - name: DISCORD_WEBHOOK_URL
              valueFrom:              # Replace this with the value of your webhook url, remember webhook URLs are sensitive
                secretKeyRef:
                  name: discord-webhook
                  key: password
            imagePullPolicy: Always
          restartPolicy: Never
EOF
$ kubectl apply -f /tmp/cron.yaml
```