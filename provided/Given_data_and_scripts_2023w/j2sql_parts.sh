#!/bin/bash
#          
#  Write below your own credentials
user="u01"
pass="x"
db="u01"
#
echo
#
mongoimport -d "$db" -c parts -u "$user" --password="$pass" --type="json" --file="parts_100.json" 
mongoexport -d "$db" -c parts -u "$user" -p "$pass" --type=csv --fields "_id,price,description" | tail -n +2 > parts.csv
#
echo "source parts_table.sql;" | mysql -u "$user" --password="$pass" "$db"
mysqlimport --fields-terminated-by=, --user="$user" --password="$pass" --local "$db" parts.csv
echo
