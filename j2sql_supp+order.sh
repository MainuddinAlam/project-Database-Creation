#!/bin/bash
#
# the following line assigns the username, password and database stored 
# as environment variables to the variables in this script
# done using export USER=<username> PASSWORD=<password> DB=<database>
user=$USER
pass=$PASSWORD
db=$DB

# create records
python3 ./supp+orders_records.py

# create the table in the mysql database
echo "source make_tables.sql;" | mysql -u "$user" --password="$pass" "$db"

# Retrieve the records for suppliers in a csv format
echo
#
mongoimport -d "$db" -c suppliers -u "$user" --password="$pass" --type="json" --file="suppliers.json"
mongoexport -d "$db" -c suppliers -u "$user" -p "$pass" --type=csv --fields "_id,name,email" | tail -n +2 > suppliers.csv
# import into tsv
cat suppliers.csv  |  tr  ","  "\t"  > suppliers.tsv
# add records to sql database
echo "load data local infile 'suppliers.tsv' into table suppliers" | mysql $db -u $user --password="$pass"
echo

# Retrieve the records for suppliers telephone numbers in a csv format
echo
#
mongoimport -d "$db" -c supp_tel -u "$user" --password="$pass" --type="json" --file="supp_tel.json" 
mongoexport -d "$db" -c supp_tel -u "$user" -p "$pass" --type=csv --fields "supp_id,number" | tail -n +2 > supp_tel.csv
# import into tsv
cat supp_tel.csv  |  tr  ","  "\t"  > supp_tel.tsv
# add records to sql database
echo "load data local infile 'supp_tel.tsv' into table supp_tel" | mysql $db -u $user --password="$pass"
echo

# Retrieve the records for suppliers parts relation in a csv format
echo
#
mongoimport -d "$db" -c supp_part -u "$user" --password="$pass" --type="json" --file="supp_part.json" 
mongoexport -d "$db" -c supp_part -u "$user" -p "$pass" --type=csv --fields "supp_id,part_id" | tail -n +2 > supp_part.csv
# import into tsv
cat supp_part.csv  |  tr  ","  "\t"  > supp_part.tsv
# add records to sql database
echo "load data local infile 'supp_part.tsv' into table supp_part" | mysql $db -u $user --password="$pass"
echo

# Retrieve the records for orders in a csv format
echo
#
mongoimport -d "$db" -c orders -u "$user" --password="$pass" --type="json" --file="orders.json" 
mongoexport -d "$db" -c orders -u "$user" -p "$pass" --type=csv --fields "_id,_when,supp_id" | tail -n +2 > orders.csv
# import into tsv
cat orders.csv  |  tr  ","  "\t"  > orders.tsv
# add records to sql database
echo "load data local infile 'orders.tsv' into table orders" | mysql $db -u $user --password="$pass"
echo

# Retrieve the records for orders items in a csv format
echo
#
mongoimport -d "$db" -c order_items -u "$user" --password="$pass" --type="json" --file="order_items.json" 
mongoexport -d "$db" -c order_items -u "$user" -p "$pass" --type=csv --fields "order_id,part_id,qty" | tail -n +2 > order_items.csv
# import into tsv
cat order_items.csv  |  tr  ","  "\t"  > order_items.tsv
# add records to sql database
echo "load data local infile 'order_items.tsv' into table order_items" | mysql $db -u $user --password="$pass"
echo
