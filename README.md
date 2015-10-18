## Log Polar H7 data

Install bluez which comes with gatttool and hciscan.

```
sudo apt-get install bluez
sudo apt-get install git
git clone https://github.com/Quiri/polar
cd polar
```

Put on the device and look for it's MAC address. You can use

```
sudo hcitool lescan
```

or use the the `scan` script to scan for devices for 10 seconds and print the unique MAC addresses to stdout.

```
.\scan
```

Start logging by:
```
./start MAC > your_file &
```

End logging with
```
./stop MAC >> your_file
```

This logs the heartrate notifications and the start and end system time.
The second hex number is the heart rate.


If you want to start logging multiple devices simultaneously, you can use the `startall` script. It takes MAC addresses as input and the directory to write the logs to as a parameter. If directory does not exist, it will be created. The logfile have the names MACaddress.csv.

Scan MAC addr. and start logging for all found devices:
```
./scan | /.startall .
```

Start all from a file:
```
# Make a file with MAC addresses, e.g. scan it or write it:
./scan > MACaddr
nano MACaddr

# Start from file, write to directory test1/group1:
cat MACaddr | ./startall test1/group1
#or
./startall test1/group1 < MACaddr
```

Stop all logging activity with
```
./killall
```

which is basically just the
```
kill `pgrep gatttool`
```

command.
