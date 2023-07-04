create table if not exists parts
(
  _id int not null,
  price double(10,2),
  description varchar(50),
  primary key (_id)
) engine = innodb;
