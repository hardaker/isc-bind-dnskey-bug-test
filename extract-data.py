#!/usr/bin/python3

import re
import fileinput

starttime=None
timeoffset=None

prefix_for_TLD="broken.bind.test"

# poor mans tcpdump data extraction regex
# match a timestamp, a type and a query name
querymatch=re.compile('^([0-9]+)\..* ([A-Z]+)\? ([^ ]+)')

# ignore host (ie, a co)

# print the FSDB header
print("#fsdb -F t timestamp timeoffset type name")

# read all the tcpdump lines for matching queries
for line in fileinput.input():
    result = querymatch.match(line)
    if result:
        if starttime:
            timeoffset = int(result.group(1)) - starttime
        else:
            starttime = int(result.group(1))
            timeoffset = 0
        if result.group(3) != '.' and result.group(3).find(prefix_for_TLD) < 0:
            continue

        # results printed are in the form
        #    TIME \t TIMEOFFSET \t QUERY_TYPE \t QUERY_NAME
        #
        # where TIMEOFFSET is the number of seconds since the start of
        # the capture
        print("\t".join([result.group(1), str(timeoffset),
                         result.group(2), result.group(3)]))
    
