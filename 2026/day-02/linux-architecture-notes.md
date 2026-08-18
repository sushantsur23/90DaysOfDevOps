## Linux Architecture at a Glance

Linux can be viewed as layers: user applications → shell/utilities → system calls → kernel → hardware. The kernel manages CPU, memory, processes, filesystems, devices, and networking. 

## Process States

A Linux process moves through different states during its lifecycle:

- Running : The process is currently executing on the CPU or is ready to run.
- Sleeping : The process is waiting for an event. `S` usually means interruptible sleep; `D` is uninterruptible sleep, commonly associated with I/O.
- Stopped : Execution has been suspended, often by a job-control signal or debugger.
- Zombie : The process has finished, but its parent has not yet collected its exit status. A zombie does not consume CPU, but its process-table entry remains.
- Dead : A transient state where the process has been terminated and is being cleaned up.



## 5 Daily Linux Commands

- `ps aux` — List running processes and resource usage.
- `top` — Monitor CPU, memory, load, and processes in real time.
- `systemctl status <service>` — Check whether a systemd service is running and inspect recent status information.
- `journalctl -u <service>` — Review logs for a systemd-managed service.
- `df -h` — Quickly check filesystem capacity and identify disks approaching full utilization.

## Practical Troubleshooting Flow

When a Linux service fails, start with process → service → logs → resources:

`ps/top` → `systemctl status` → `journalctl` → `df -h`

This simple sequence helps determine whether the problem is a process failure, service-management issue, application error, or resource constraint.


