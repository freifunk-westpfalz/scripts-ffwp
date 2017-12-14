#!/bin/bash
#Distribution for batman tg table
#https://gist.github.com/LongHairedHacker/8583205a7d9f78909b71e8b9d7811360
batctl tg | grep -oP "via ([0-9a-f:]*)" | cut -d " " -f 2 | sort | uniq -c | sort -g
