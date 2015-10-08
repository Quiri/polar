## Log Polar H7 data

Install bluez which comes with gatttool and hciscan.

Put on the device and look for it's MAC address. You can use

```
sudo hcitool lescan
```

Start logging by:
```
./start MAC > your_file &
```

End logging with
```
/.stop MAC >> your_file
```

This logs the heartrate notifications and the start and end system time.
The second hex number is the heart rate.
