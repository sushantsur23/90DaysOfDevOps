# Day 07 — Linux File System and Troubleshooting Scenarios

## Part 1: Linux File System Hierarchy

| Directory | Purpose | What I found | I would use this when... |
|---|---|---|---|
| `/` | The root of the Linux filesystem; every other directory exists below it. | `total 52` | I need to understand the top-level filesystem or locate a directory. |
| `/home` | Contains home directories and personal files for normal users. | `total 4` | I need to inspect a user's files, scripts, or configuration. |
| `/root` | Home directory of the root/superuser account. | `No output` | I need to troubleshoot files belonging specifically to the root account. |
| `/etc` | Contains system-wide configuration files. | `total 768` | I need to inspect or troubleshoot system/service configuration. |
| `/var/log` | Contains system and application logs, although some modern services use journald directly. | `total 764` | I need evidence about service failures or system activity. |
| `/tmp` | Temporary working space used by applications and users. | `total 20` | I need a temporary location for testing or troubleshooting files. |
| `/bin` | Traditionally contains essential user commands; on many modern distributions it is linked to `/usr/bin`. | `lrwxrwxrwx 1 root root 7 Jan  2  2026 /bin -> usr/bin` | I need to understand where essential command binaries are located. |
| `/usr/bin` | Contains a large collection of user-space executable programs. | `total 505212` | I need to locate installed commands or executable programs. |
| `/opt` | Common location for optional or third-party application software. | `total 48` | I need to inspect software installed outside the standard package locations. |

### Hands-on Checks

Largest entries are under `/var/log`:

```text
8.0K	/var/log/chrome.supervisord.log
8.0K	/var/log/fontconfig.log
32K	/var/log/alternatives.log
500K	/var/log/apt
680K	/var/log/dpkg.log
```

**Observation:** This quickly identifies which log directories/files are consuming the most space.

**Hostname configuration:**

```text
e0114389ca42
```

**Observation:** `/etc/hostname` stores the system hostname.

**Home directory:**

```text
total 60
drwx--s--- 9 oai  oai_shared 4096 Aug 22 04:10 .
drwxr-xr-x 3 root root       4096 Aug  3 18:26 ..
-rwx--s--- 1 oai  oai_shared  220 Jan  2  2026 .bash_logout
-rwx--s--- 1 oai  oai_shared 3640 Aug  3 18:28 .bashrc
drwxr-xr-x 3 oai  oai_shared 4096 Aug 22 04:10 .cache
drwx--s--- 3 oai  oai_shared 4096 Jul 29 04:12 .chromium
drwx--s--- 3 oai  oai_shared 4096 Jul 29 04:12 .config
drwxr-sr-x 3 oai  oai_shared 4096 Aug 22 04:10 .ipython
-rw-r--r-- 1 root oai_shared   10 Aug 22 04:10 .nssdbp
```

**Observation:** `ls -la ~` shows normal and hidden files in the current user's home directory.

---

## Part 2: Scenario-Based Troubleshooting

### Solved Example — Check a Service

```bash
systemctl status nginx
systemctl list-units --type=service
systemctl is-enabled nginx
```

**Flow:** Check current state → investigate available services → verify whether the service starts automatically.

**Lesson:** Start with `status`; use the result to decide what to inspect next.

### Scenario 1 — Service Not Starting

**Problem:** `myapp` failed after a reboot.

```text
Step 1: systemctl status myapp
Why: Confirm whether myapp is active, failed, or stopped.

Step 2: journalctl -u myapp -n 50 --no-pager
Why: Look for the immediate error or failure reason.

Step 3: systemctl is-enabled myapp
Why: Check whether myapp is configured to start during boot.

Step 4: systemctl cat myapp
Why: Inspect the service unit configuration and startup command.
```

**Troubleshooting flow:** `status → logs → boot configuration → service definition`

### Scenario 2 — High CPU Usage

**Problem:** The application server is slow.

```text
Step 1: top
Why: Get a live view of CPU usage and identify the busiest processes.

Step 2: ps aux --sort=-%cpu | head -10
Why: Display processes ordered by CPU consumption.

Step 3: ps -p <PID> -o pid,ppid,pcpu,pmem,comm
Why: Inspect the selected process more closely.

Step 4: systemctl status <service>
Why: Determine whether the high-CPU process belongs to a managed service.
```

**Troubleshooting flow:** `live metrics → identify PID → inspect process → map process to service`

### Scenario 3 — Finding Service Logs

**Problem:** A developer asks where the logs for a systemd-managed service are.

```text
Step 1: systemctl status docker
Why: Confirm the service name and current state.

Step 2: journalctl -u docker -n 50 --no-pager
Why: Read the latest 50 Docker service log entries.

Step 3: journalctl -u docker -f
Why: Follow new log entries in real time while reproducing the issue.
```

**Important:** For systemd-managed services, journald is usually the first place to check. The application may also write separate logs elsewhere.

### Scenario 4 — File Permission Issue

**Problem:** `/home/user/backup.sh` returns `Permission denied`.

```text
Step 1: ls -l /home/user/backup.sh
Why: Check whether the execute (`x`) permission is present.

Step 2: chmod +x /home/user/backup.sh
Why: Add execute permission to the script.

Step 3: ls -l /home/user/backup.sh
Why: Verify that the `x` permission was added.

Step 4: ./backup.sh
Why: Run the script again and confirm whether the permission problem is resolved.
```

**Troubleshooting flow:** `inspect permissions → change permission → verify → retest`

## DevOps Troubleshooting Mindset

Do not start by randomly restarting services or changing configuration.

Use this repeatable pattern:

**Identify → Check → Collect Evidence → Isolate → Fix → Verify**

The objective is to understand **where the problem lives** before deciding **what action to take**.
