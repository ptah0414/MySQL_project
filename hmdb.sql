drop database if exists hmdb;
create database hmdb;
use hmdb;

drop table if exists product;
create table product(
   product_id int primary key,
   product_name varchar(20),
   price int,
   category varchar(20),
   product_desc varchar(20),
   sku varchar(20)
);

drop table if exists discount;
create table discount(
   discount_id int,
   discount_percent int,
   discount_desc varchar(20),
   primary key(discount_id)
);

drop table if exists order_items;
create table order_items(
   order_items_id int primary key,
   product_id int,
   foreign key(product_id) references product(product_id)
);

drop table if exists user;
create table user(
   user_id int primary key,
   username varchar(20),
   name varchar(20),
   gender varchar(5),
   address varchar(30),
   telephone_number varchar(13)
);

drop table if exists item_cart;
create table item_cart(
   item_cart_id int primary key,
   quantity int,
   product_id int,
   user_id int,
   foreign key(product_id) references product(product_id),
   foreign key(user_id) references user(user_id)
);

drop table if exists order_details;
create table order_details(
   order_details_id int primary key,
   product_number int,
   total_price int,
   user_id int,
   order_items_id int,
   foreign key(user_id) references user(user_id),
   foreign key(order_items_id) references order_items(order_items_id)
);

drop table if exists payment_details;
create table payment_details(
   payment_id int primary key,
   amount int,
   provider varchar(20),
   status varchar(20),
   receipt varchar(20),
   order_details_id int,
   foreign key(order_details_id) references order_details(order_details_id)
);

-- discount table
insert into discount values (00001, 13, "shoes");
insert into discount values (00242, 22, "bags");
insert into discount values (28489, 04, "shorts");
insert into discount values (33902, 30, "wallets");
insert into discount values (45354, 63, "hoodies");

-- product table
insert into product values (45924, "red shoes", 30000, "shoes", "for women", "K898290"); 
insert into product values (34892, "students bag", 40000, "bags", "for students", "B939309");
insert into product values (88392, "khaki shorts", 20000, "shorts", "military style", "S839329");
insert into product values (00372, "black wallet", 100000, "wallets", "for business men", "W384248");
insert into product values (74022, "micky mouse hoodie", 60000, "hoodies", "disney merch", "H383024");

-- user table
insert into user values (1,'hhshin','신현호','M','경기도 수원시 영통구','01000000000');
insert into user values (2,'gunnoo','이건우','M','서울특별시 마포구', '01000000001');
insert into user values (3,'Kindess','박친절','F','대구광역시 달성구','01000000011');
insert into user values (4,'James98','호현호','M','서울특별시 중구','01000000111');
insert into user values (5,'hello02','우건우','M','서울특별시 성북구','01011000000');

-- item_cart table
insert into item_cart values ('200',1,45924,1);
insert into item_cart values ('210',2,34892,2);
insert into item_cart values ('220',3,88392,3);
insert into item_cart values ('230',2,00372,4);
insert into item_cart values ('240',7,74022,5);


-- showing product_id of which price is more than 35000 won and quantity is over two
select P.product_id
from product as P 
where P.price > 35000 and product_id in (select I.product_id
										from item_cart as I
										where I.quantity > 2);
                                        
-- showing user's name whose gender is male and who has a product in his item cart and product's id is '372'
select U.name 
from user as U
where U.gender = 'M' and U.user_id = (select I.user_id
									from item_cart as I 
									where I.product_id = '372');
                                    
-- if there is no over-priced product, then show all the products
select *
from product
where not exists
	(select product_id
	 from product
	 where price > 1000000000);
     
-- if there's on sale more than 50%, then show all the products
select *
from product
where exists
	(select *
	 from discount
	 where discount_percent > 50);
     
     
show global variables like "log_bin_trust_function_creators";
set global log_bin_trust_function_creators = 1; 

-- a procedure which shows the number of users in 'User' table
drop procedure if exists sum_of_user;
delimiter &
create procedure sum_of_user()
begin
	select count(*) from user;
end &
delimiter ;

call sum_of_user();


-- returns the user_id of newly inserted person
drop function if exists insert_user
delimiter $$
create function insert_user(
    username varchar(30),
    name varchar(20),
    gender varchar(5),
    address varchar(20),
    telephone_number varchar(13)
)returns int
begin
	declare user_id int;
    select count(*) into user_id from user;
    insert into user values(user_id+1, username, name, gender,address,telephone_number);
    return user_id + 1;
end $$
delimiter ;

select insert_user('gugu', 'Jame','F','수원시 영통구','0104880778000');

select * from user;