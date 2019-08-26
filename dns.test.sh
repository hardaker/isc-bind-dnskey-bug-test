#!/bin/bash

. config.sh

# kill anything left-over/running when started
$stopcmd
sleep 5

# loop for $iterations runs
attempt=1
while [ $attempt -lt $iterations ] ; do
    echo `date` "------------ restarting iteration #$attempt"
    timestamp=`date +%s`

    # start recording packets
    tcpdump -w $output_dir/tcpdump.$timestamp -s 0 -i $capture_interface port 53 &

    # copy in the "bad" managed keys file
    cp $managed_bad $vardir/managed-keys.bind

    $startcmd
    sleep 5

    # dig each TLD $digs_per_iteration times sleeping in between
    dig_num=1
    while [ $a -lt $digs_per_iteration ] ; do
	echo `date` -- "start dig run $a"
	for suffix in $TLDs ; do
	    echo "--- $suffix" >> $output_dir/dig.$timestamp
	    dig @localhost $prefix_for_TLD.$suffix >> $output_dir/dig.$timestamp
	    sleep $tld_sleep
	done

	echo `date` -- "sleeping 30"
	sleep $dig_sleep
	
	dig_num=$(($dig_num + 1))
    done

    # stop named
    $stopcmd
    
    sleep 2

    # stop tcpdump
    killall tcpdump

    # sleep until the next run
    sleep $iteration_sleep

    attempt=$(($attempt + 1))
done
