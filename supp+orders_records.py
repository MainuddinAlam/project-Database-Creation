import json

"""supp+orders_records.py
Read the records suppliers_100.json and orders_4000.json,
and create the json records for:
- suppliers
- supp_tel
- parts
- supp_part
- orders
- order_items
"""

# store the supplier records to be written to the file
supp_list = []
# store the telephone records to be written to the file
tel_list = []
# store the order records to be written to the file
order_list = []
# store the items records to be written to the file
item_list = []
# store the supplier: set of parts
supp_parts = {}
# store the supp_part records to be written to the file
supp_part_list = []

# read the supplier input file
with open('suppliers_100.json') as json_file:
    # read the data as json
    input_list = json.load(json_file)

    # loop through the input suppliers
    for supplier in input_list:
        # build the supplier dictionary
        supp = {"_id": supplier["_id"],
                "name": supplier["name"],
                "email": supplier["email"]
                }
        for number in supplier["tel"]:
            # build the supplier tel dictionary
            tel = {
                "supp_id": supplier["_id"],
                "number": number["number"]
            }
            tel_list.append(tel)
        supp_list.append(supp)

# open supp.json to output supplier record
with open("suppliers.json", mode="w") as supp_file:
    for supplier in supp_list:
        json.dump(supplier, supp_file)
        supp_file.write("\n")

# open tel.json to output supplier telephone number record
with open("supp_tel.json", mode="w") as tel_file:
    for tel in tel_list:
        json.dump(tel, tel_file)
        tel_file.write("\n")

# read the orders input file
with open('orders_4000.json') as json_file:
    # loop through the input orders
    for i, order_input in enumerate(json_file):
        # convert the string input in to a dictionary
        input_order = json.loads(order_input)

        # build the order dictionary
        order = {
            "_id": i + 1,
            "_when": input_order["when"],
            "supp_id": input_order["supp_id"],
        }
        order_list.append(order)

        # loop through the items in the order
        for order_item in input_order["items"]:
            # build the order_item dictionary
            order_item = {
                "order_id": i + 1,
                "part_id": order_item["part_id"],
                "qty": order_item["qty"]
            }
            item_list.append(order_item)

            # check if supp_part dictionary contains the supp_id
            if not input_order["supp_id"] in supp_parts:
                # initialize it to an empty set
                supp_parts[input_order["supp_id"]] = set()

            # add the part_id into the set for the supp_id
            supp_parts[input_order["supp_id"]].add(order_item["part_id"])

# open orders.json to output orders record
with open("orders.json", mode="w") as order_file:
    for order in order_list:
        json.dump(order, order_file)
        order_file.write("\n")

# open items.json to output order items record
with open("order_items.json", mode="w") as items_file:
    for item in item_list:
        json.dump(item, items_file)
        items_file.write("\n")

# loop through the suppliers in supp_parts
for supplier in supp_parts:
    # loop through the parts of the supplier
    for part in supp_parts[supplier]:
        # build the supp_part dictionary
        supp_part_dict = {
            "supp_id": supplier,
            "part_id": part
        }
        supp_part_list.append(supp_part_dict)

# open supp_part.json to output supplier part record
with open("supp_part.json", mode="w") as supp_part_file:
    for sp in supp_part_list:
        json.dump(sp, supp_part_file)
        supp_part_file.write("\n")
