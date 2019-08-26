# Configuration settings for the various scripts

# iterations to run
iterations=20
digs_per_iteration=10

# where to store the results (assumes cwd)
output_dir=`pwd`

# capture interface/addresses
capture_interface=wlp4s0
capture_address=10.1.0.4

# how to generate the queries to send...
# a combination of PREFIX and TLD
# (the prefix must be set in extract-data.py too)
prefix_for_TLD=broken.bind.test
TLDs=com org eu net info biz edu

# environment setup - using the system resolver
stopcmd="systemctl stop named"
startcmd="systemctl start named"
vardir=/var/named/dynamic/

# sleep settings between various run components
tld_sleep=1
dig_sleep=30
iteration_sleep=5

# environment setup - using a specifically compiled version
prefix="/usr/local/bind-9.11.5-P4"
stopcmd="killall named"
startcmd="$prefix/sbin/named -u named"
vardir="$prefix/var/named/dynamic/"
managed_bad=$output_dir/managed_keys.bad

