#!/bin/bash
echo "Hello World!"#!/bin/bash
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Student Details
# Name : jaimin patel,
#Student ID: 200355898


#This Script will provide following information
# 1. System name with domain name if it has one
# 2. IP addresses for this host by interface
# 3. OS version and name
# 4. CPU description
# 5. Memory installed
# 6. Available disk space on attached physical drives
# 7. Lists of Printers configured


#Assigning the default values and declaring the variables

default="show"

#Using variables

function usercmd {
  echo "
  One or more outputs can be shown for the following:
  $0 [-hp | --help menu]
  $0 [-dm | --Displaying domain name and host name]
  $0 [-ip | --Shows IP address of system]
  $0 [-os | --Operating System name]
  $0 [-cpu | --CPU details]
  $0 [-mmr | --RAM details]
  $0 [-ads | --Available Disk Space]
  $0 [-pf  | --Installed Printers list]
  "
}

function error {
  echo "$@" >&2
}
#conditions for commands to show requested data

while [ $# -gt 0 ]; do
  case "$1" in
    -hp)
    helpcmds="show"
    default="hide"
    ;;

    -dm)
    hostinfo="show"
    default="hide"
    ;;

    -ip)
    ipinfo="show"
    default="hide"
    ;;

    -os)
    osinfo="show"
    default="hide"
    ;;

    -cpu)
    CPUinfo="show"
    default="hide"
    ;;

    -mmr)
    RAMinfo="show"
    default="hide"
    ;;

    -ads)
    disinfo="show"
    default="hide"
    ;;

    -pf)
    printerinfo="show"
    default="hide"
    ;;
    *)
    error "
    '$1' Please read and choose options carefully"
    exit 1
    ;;
  esac
  shift
done

#Putting the data into variables using the commands
hostname="$(hostname)"
hostdomain="$(hostname -d)"

sysinfo=$(uname -o)
krnlinfo=$(uname -r)
addinfo=$(lsb_release -a)


ipaddress=$(hostname -I)

CPUinfo=$(lscpu)

mminfo=$(cat /proc/meminfo | grep "Mem")

disinfo=$(df -h)

printerinfo=$(lpstat -p)

#host information including domain
hf="
Your System Name is: $hostname
Your Domain Name is: $hostdomain
"

#IP address Details
ip="
IP address of your system is: $ipaddress
"

#Operating system information
os="
$addinfo
Kernel Version: $krnlinfo
System Type:    $sysinfo
"


#CPU details
cpd="
Your CPU Descreption is here:
$CPUinfo
"

#RAM details
mmd="
RAM on your device is: $mminfo
"

#Disk details
dsk="
$disinfo
"
#Printer details
pcf="
$printerinfo
"
# Getting the output
if [ "$default" = "show" -o "$hostinfo" = "show" ]; then
  echo "$hf"
fi

if [ "$default" = "show" -o "$ipinfo" = "show" ]; then
  echo "$ip"
fi

if [ "$default" = "show" -o "$osinfo" = "show" ]; then
  echo "$os"
fi

if [ "$default" = "show" -o "$CPUinfo" = "show" ]; then
  echo "$cpd"
fi

if [ "$default" = "show" -o "$RAMinfo" = "show" ]; then
  echo "$mmd"
fi

if [ "$default" = "show" -o "$disinfo" = "show" ]; then
  echo "$dsk"
fi

if [ "$default" = "show" -o "$printerinfo" = "show" ]; then
  echo "$pcf"
fi
