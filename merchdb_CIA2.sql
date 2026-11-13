create database merchdb;
use merchdb;
create table students (
    student_id int primary key,
    student_name varchar(50) not null,
    city varchar(30),
    state varchar(30),
    email varchar(50),
    age int check (age >= 18),
    age_group varchar(15) default 'NA'
);
insert into students (student_id, student_name, city, state, email, age) values
(1, 'Prachi Sahu', 'Bhopal', 'Madhya Pradesh', 'prachisahu@gmail.com', 27),
(2, 'Kashish Pai', 'Mardol', 'Goa', 'kashish.pai@gmail.com', 24),
(3, 'Anjaneshwari', 'Vishakhapatnam', 'Andhra Pradesh', 'anjaneshwari@gmail.com', 23),
(4, 'Clinton R', 'Bangalore', 'Karnataka', 'clintonr@gmail.com', 25),
(5, 'Ranit Ghosh', 'Kolkata', 'West Bengal', 'ranitghoshDADA@gmail.com', 33),
(6, 'Khushi Mathur', 'Lucknow', 'Uttar Pradesh', 'khushimathur@gmail.com', 22),
(7, 'Snigdha Kuri', 'Guwahati', 'Assam', 'snigdha.kuri@gmail.com', 24),
(8, 'Nikhil Jiji', 'Kochi', 'Kerala', 'nikhiljiji@gmail.com', 26),
(9, 'Ritik Albert', 'Kochi', 'Kerala', 'ritikalbert@gmail.com', 23),
(10, 'Calvin Joseph', 'Mumbai', 'Maharashtra', 'calvinjoseph@gmail.com', 27),
(11, 'Alex Abraham', 'Thrissur', 'Kerala', 'alexabraham@gmail.com', 30),
(12, 'Taruni Gopi', 'Hyderabad', 'Telangana', 'tarunigopi@gmail.com', 22),
(13, 'Ruth Wilson', 'Kochi', 'Kerala', 'ruthwilson@gmail.com', 25),
(14, 'Balakiran', 'Chennai', 'Tamil Nadu', 'balakiran@gmail.com', 28),
(15, 'Anulipi Sarkar', 'Kolkata', 'West Bengal', 'anulipi.sarkar@gmail.com', 23),
(16, 'Atif Khan', 'Jamshedpur', 'Jharkhand', 'atifkhan@gmail.com', 24),
(17, 'Kuber Arora', 'Pune', 'Maharashtra', 'kuberarora@gmail.com', 26);
select * from students;
alter table students add phone varchar(15);
update students set phone = '98765' where student_id = 1;
update students set phone = '91234' where student_id = 2;
update students set phone = '99887' where student_id = 3;
update students set phone = '12344' where student_id = 4;
update students set phone = '99857' where student_id = 5;
update students set phone = '99811' where student_id = 6;
update students set phone = '93210' where student_id = 7;
update students set phone = '99990' where student_id = 8;
update students set phone = '34567' where student_id = 9;
update students set phone = '13579' where student_id = 10;
update students set phone = '99817' where student_id = 11;
update students set phone = '39887' where student_id = 12;
update students set phone = '90087' where student_id = 13;
update students set phone = '93487' where student_id = 14;
update students set phone = '95687' where student_id = 15;
update students set phone = '96807' where student_id = 16;
update students set phone = '93577' where student_id = 17;
select * from students;
alter table students add constraint uq_email unique (email);
desc students;
update students
set age_group = case
    when age >= 30 then '30 and above'
    when age >= 25 then '25 to 29'
    else 'below 25'
end
where student_id > 0;
select student_id, student_name, age, age_group from students;
create table orders (
    order_id int primary key,
    student_id int,
    order_date date,
    amount decimal(10,2) default 0,
    status varchar(20),
    city varchar(30),
    priority varchar(10),
    foreign key (student_id) references students(student_id)
);
insert into orders (order_id, student_id, order_date, status) values
(1, 1, '2026-10-02', 'pending'),
(2, 2, '2026-10-05', 'delivered'),
(3, 3, '2026-10-08', 'pending'),
(4, 4, '2026-10-10', 'cancelled'),
(5, 5, '2026-10-12', 'pending'),
(6, 6, '2026-10-15', 'delivered'),
(7, 7, '2026-10-18', 'pending'),
(8, 8, '2026-10-20', 'pending'),
(9, 9, '2026-10-22', 'delivered'),
(10, 10, '2026-10-25', 'pending');

create table order_items (
    item_id int primary key,
    order_id int,
    item_name varchar(50),
    qty int,
    price decimal(10,2),
    foreign key (order_id) references orders(order_id)
);
insert into order_items values
(1, 1, 'Hoodie', 1, 899),
(2, 1, 'Track Pants', 1, 599),
(3, 2, 'T-Shirt', 2, 449),
(4, 3, 'Jacket', 1, 1499),
(5, 3, 'Shorts', 1, 399),
(6, 4, 'Trousers', 1, 799),
(7, 5, 'Shirt', 1, 699),
(8, 6, 'Hoodie', 1, 899),
(9, 7, 'Jeans', 1, 1199),
(10, 7, 'Shirt', 1, 699),
(11, 8, 'T-Shirt', 1, 449),
(12, 9, 'Jacket', 1, 1499),
(13, 10, 'Kurta', 1, 999),
(14, 10, 'Shorts', 2, 399),
(15, 6, 'Track Pants', 1, 599),
(16, 8, 'Shirt', 1, 699),
(17, 1, 'T-Shirt', 1, 449);
select * from orders;
select * from order_items;
update orders
set status = 'shipped'
where status = 'pending' and order_date <= '2026-10-15' and order_id > 0;
select * from orders;
update orders o
set amount = (select sum(qty * price)
              from order_items i
              where i.order_id = o.order_id)
where order_id > 0;
select order_id, student_id, amount from orders;
update orders
set priority = case
    when status = 'cancelled' then 'none'
    when amount >= 1500 then 'high'
    when amount >= 800 and status = 'pending' then 'medium'
    else 'low'
end
where order_id > 0;
select order_id, amount, status, priority from orders;
update orders o
join students s on o.student_id = s.student_id
set o.city = s.city
where o.order_id > 0;
select o.order_id, s.student_name, o.city, s.state from orders o
join students s on o.student_id = s.student_id;
create table invoices (
    inv_id int primary key,
    order_id int,
    student_id int,
    inv_amount decimal(10,2),
    total_billed decimal(10,2)
);
insert into invoices (inv_id, order_id, student_id, inv_amount) values
(1, 1, 1, 1947),
(2, 2, 2, 898),
(3, 3, 3, 1000),
(4, 3, 3, 898),
(5, 4, 4, 799),
(6, 5, 5, 699),
(7, 6, 6, 1000),
(8, 6, 6, 498),
(9, 7, 7, 1898),
(10, 8, 8, 1148),
(11, 9, 9, 1499),
(12, 10, 10, 1797);
update invoices i
set total_billed = (select total from
                      (select student_id, sum(inv_amount) as total
                       from invoices
                       group by student_id) t
                    where t.student_id = i.student_id)
where inv_id > 0;
select * from invoices;
create table deliveries (
    del_id int primary key,
    order_id int,
    ship_date date,
    expected_date date,
    status varchar(20)
);
insert into deliveries values
(1, 1, '2026-10-03', '2026-10-07', 'delayed'),
(2, 2, '2026-10-06', '2026-10-09', 'on time'),
(3, 3, '2026-10-09', '2026-10-13', 'delayed'),
(4, 5, '2026-10-13', '2026-10-16', 'on time'),
(5, 6, '2026-10-16', '2026-10-20', 'delayed'),
(6, 7, '2026-10-19', '2026-10-23', 'on time'),
(7, 8, '2026-10-21', '2026-10-24', 'delayed'),
(8, 9, '2026-10-23', '2026-10-27', 'on time'),
(9, 10, '2026-10-26', '2026-10-30', 'delayed'),
(10, 4, '2026-10-11', '2026-10-15', 'on time');
select * from deliveries;
update deliveries
set expected_date = date_add(expected_date, interval 3 day)
where status = 'delayed' and del_id > 0;
select * from deliveries;
insert into students (student_id, student_name, city, state, email, age)
values (18, 'Test User', 'Delhi', 'Delhi', 'prachisahu19@gmail.com', 25);
-- Foreign keys added to connect invoices and deliveries in the ER diagram
alter table invoices
    add constraint fk_inv_order foreign key (order_id) references orders(order_id),
    add constraint fk_inv_student foreign key (student_id) references students(student_id);
alter table deliveries
    add constraint fk_del_order foreign key (order_id) references orders(order_id);
