
#
# https://snapcraft.ninja/2020/08/06/starting-systemd-in-wsl-when-you-login-to-windows-youll-be-astounded-by-the-speed-improvement/
#
# https://linux.die.net/man/1/daemonize => disconnect from anything and run in background
# https://linux.die.net/man/1/unshare =>
#
#    --pid: new pid namespace
#      --fork: new process will be in pid namespace
#      --mount-proc: allow /proc
#
# mount binfmt_misc:
#          binfmt_misc is a kernel feature which allows invoking almost every program by simply typing its name
#          in the shell. It recognises the binary-type by matching some bytes at the beginning of the file with
#          a magic byte sequence (masking out specified bits) you have supplied.
#

#
# wsl:
#    -e: skip default shell
#

#
# systemd:
#    targets:
#       systemctl list-units --type=target
#
#    dependencies:
#       systemctl list-dependencies multi-user.target
#
#    dependants:
#       systemctl list-dependencies --all --reverse ssh.service
#
# snap: basic.target
# ssh: could-init.service, multi-user.target

wsl -t ubuntu

Start-Sleep -Seconds 1

# wsl.exe -d ubuntu -u root -e /usr/bin/bash -c "/usr/bin/daemonize /usr/bin/unshare --fork --mount-proc --pid -- /usr/bin/bash -c 'mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc; exec systemd --unit=ssh.service,snapd.service  &> /tmp/wsl-daemon2.log' &> /tmp/wsl-daemon.log"
# wsl.exe -d ubuntu -u root -e /usr/bin/bash -c `
#     "/usr/bin/unshare --fork --mount-proc --pid -- /usr/bin/bash -c 'mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc; exec systemd --unit=basic.target' "

wsl.exe -d ubuntu -e /usr/bin/bash -c 'ls /var/run/nologin'

wsl.exe -d ubuntu -u root -e /usr/bin/bash -c `
    "/usr/bin/unshare --fork --mount-proc --pid -- /usr/bin/bash -c 'mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc; exec systemd --unit=basic.target --unit=ssh.service' "

# /usr/sbin/sshd -D
#

# --unit=systemd-user-sessions.service

# rm -f /var/run/nologin

#    "/usr/bin/daemonize " + `
