create table if not exists suppliers
(
  _id int not null auto_increment,
  name varchar(255) not null,
  email varchar(320) not null,
  primary key (_id)
) engine = innodb;

create table if not exists supp_tel
(
  supp_id int not null,
  number varchar(50) not null,
  primary key (number),
  foreign key (supp_id) references suppliers(_id)
) engine = innodb;

create table if not exists supp_part
(
  supp_id int not null,
  part_id int not null,
  primary key (supp_id, part_id),
  foreign key (supp_id) references suppliers(_id),
  foreign key (part_id) references parts(_id)
) engine = innodb;

create table if not exists orders
(
  _id int not null auto_increment,
  _when date not null,
  supp_id int not null,
  primary key (_id),
  foreign key (supp_id) references suppliers(_id)
) engine = innodb;

create table if not exists order_items
(
  order_id int not null,
  part_id int not null,
  qty int not null,
  primary key (order_id, part_id),
  foreign key (order_id) references orders(_id),
  foreign key (part_id) references parts(_id)
) engine = innodb;
