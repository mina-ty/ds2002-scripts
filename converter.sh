#!/bin/bash

# escape upon any error
set -e

# set file name
file='remote-data'

# 1. retrieve file
echo "Attempting curl fetch" || exit 1
/usr/bin/curl -o $file.tar.gz https://s3.amazonaws.com/ds3002-cli/remote/remote-data.tar.gz
echo "Success curl fetch" || exit 1
sleep 5

# 2. decompress
echo "Decompressing now..."
/usr/bin/tar -xzvf $file.tar.gz
sleep 5

# 3. output the length of the file in lines
echo "Number of lines in file is: "
/usr/bin/wc -l $file.tsv || exit 1;
sleep 5

# 4. convert to csv
echo "Converting to CSV"
/usr/bin/tr '\t' ',' < $file.tsv > $file.csv || exit 1;
sleep 5

# 5. zip it up
echo "Zipping up"
/usr/bin/zip $file.zip $file.csv || exit 1;
sleep 5

# 6. send it off to s3
# echo "Shipping to S3"
# /usr/local/bin/aws s3 cp remote-data.zip s3://ds3002-resources/zips/ || exit 1;
# sleep 5

# 7. send an AWS sns message
# echo "Sending SNS message"
# /usr/local/bin/aws sns publish public --topic-arn arn_name --message "Success"
