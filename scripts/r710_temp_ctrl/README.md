# Dell r710 Temperature/Fan Control Script

This script is run on a regular basis (via cron) in order to apply some slightly less aggressive (though far stupider) fan control to my r710. The default, dynamic control results in fans that are slightly louder than a chinook trying to take off and is thus only used if the temperature sensors report a high temperature. Otherwise, the fans are set to run at a stately 1560 RPM, which results in a PC-like level of noise.

The script uses `ipmitool` and thus relies on the Dell iDRAC's IPMI interface being available. This requires hitting Ctrl+E during the boot process to access remote access configuration, and then enabling the setting in the resulting menu.

### Credit
I developed this script after heavy inspiration from the following:
- https://github.com/NoLooseEnds/Scripts
- https://jacobjangles.com/hushing-the-dell-r710-fans
- https://reddit.com/r/homelab/comments/b20p7o/super_easy_way_to_make_an_r710_really_quiet