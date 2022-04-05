#DDL语句
select database();
show databases;
use testdatabase;
drop database testdatabase;
show databases;

create database test_database;
show databases;

use test_database;

select database();
show tables;
create table test_table
(
    id   int comment '序号',
    name varchar(10) comment '姓名'
) comment '测试表';
desc test_table;
show create table test_table;
drop table make;
use world;
drop table make;
use test_database;
alter table test_table
    add age tinyint unsigned comment '年龄';
desc test_table;
alter table test_table
    add longname tinyint unsigned comment '大姓名';
alter table test_table
    add gender char(1) comment '性别';
alter table test_table
    modify longname int;
alter table test_table
    change longname bigname bigint comment '大名子';
show create table test_table;
alter table test_table
    add agetest tinyint unsigned comment '年龄';
alter table test_table
    add entrydate date comment '入职日期';
alter table test_table
    drop agetest;
alter table test_table rename to my_test_table;
alter table my_test_table rename to test_table;


#DML
insert into test_table(id, name, age, bigname, gender, entrydate)
values (5, 'mick', 41, 23241, 'W', '2019-4-19');
select *
from test_table;

update test_table
set name='MC',
    age=35
where id = 3;
update test_table
set gender='W'
where id = 2;
update test_table
set entrydate='2009-1-10'
where id = 4;
update test_table
set gender='M';
delete
from test_table
where id = 2;
select *
from test_table;

select name, id, age
from test_table;
select name as '姓名'
from test_table;
select name '名字'
from test_table;
select distinct name '姓名'
from test_table;

select distinct age '年龄'
from test_table;

#DQL
select *
from test_table;
select *
from test_table
limit 3;
select *
from test_table
where test_table.gender = 'M'
  and age <= 23;
select *
from test_table
where age in (59, 35);
select *
from test_table
where age = 59
   or age = 35;
select *
from test_table
where age != 35;
select *
from test_table
where age <> 35;
select *
from test_table
where age > 50
   or age < 30;
select *
from test_table
where age between 30 and 50;
select *
from test_table
where name like '__';
select *
from test_table
where name like '%e';


#DQL_聚合函数_纵向计算
select count(id)
from test_table;
select count(*)
from test_table;
select avg(age)
from test_table;
select max(age)
from test_table;
select min(age)
from test_table;
select sum(age)
from test_table;
select sum(age)
from test_table
where test_table.gender = 'M';


#DQL_分组查询
select gender, count(*)
from test_table
group by gender;
select gender, avg(age)
from test_table
group by gender;

select gender, count(*)
from test_table
where age > 25
group by gender
having count(*) >= 1;
select gender, count(*) bieming
from test_table
where age > 25
group by gender
having bieming >= 1;
select gender, count(*) '别名'
from test_table
where age > 25
group by gender
having '别名' >= 1;#这个别名不行
select gender, count(*) as 别名
from test_table
where age > 25
group by gender
having 别名 >= 1;#这个别名可以
select gender, count(*) 别名
from test_table
where age > 25
group by gender
having 别名 >= 1;
#这个别名可以，as省略


#DQL_排序查询
select *
from test_table
order by id asc;
select *
from test_table
order by age;#asc默认
select *
from test_table
order by age desc;
select *
from test_table
order by age desc, id asc;

#DQL_分页查询
select *
from test_table;
select *
from test_table
limit 0,2;
select *
from test_table
limit 2,2;


select *
from test_table
where age in (23, 59)
  and test_table.gender = 'M';

select *
from test_table
where test_table.gender = 'M'
  and age between 25 and 60
  and name like '_C';

select test_table.gender, count(*)
from test_table
where age < 50
order by gender;

select name, age
from test_table
where age > 25
order by age asc;

#DQL_执行顺序
#from >where>group by>select>order by>limit    设置别名只能前面定义后面使用 asc升序，desc降序


#DCL_管理用户
use mysql;
select *
from user;#这个表存了用户明细

create user 'test_me'@'localhost' identified by '123456';
create user 'test_everyone'@'%' identified by '123456';#任意主机
alter user 'test_me'@'localhost' identified with mysql_native_password by '111111';
drop user 'test_me'@'localhost';

#DCL_控制权限
show grants for 'test_me'@'localhost';
show grants for 'root'@'localhost';
grant all on test_database.* to 'test_me'@'localhost';#授权所有权限
grant all on *.* to 'test_me'@'localhost';
revoke all on test_database.* from 'test_me'@'localhost';
#撤销权限

#字符串函数,只针对字符串，对其他类型不起作用
select concat('my', ' ', 'SQL');
select lower('SQL');
select upper('hello!');
select lpad('me', 10, '-');
select Rpad('me', 10, '-');
select trim('   This is my name.   ');
select substring('hello my SQL ', 7, 2);

use test_database;
update test_table
set name=lpad(name, 5, '-');
select *
from test_table;

#数值函数
select ceil(1.1);
select floor(1.9);
select rand();
select mod(5, 3);
select round(3.14159265358979323846, 2)

select lpad(round(rand() * 1000000, 0), 6, 0);
#生成随机6位数验证码

#时间函数
select curdate();
select curtime();
select now();
select YEAR(now());
select MONTH(now());
select DAY(now());
select date_add(now(), interval 50 day);
select datediff('2022-2-2', '2019-2-8');

select id, name, datediff(now(), test_table.entrydate) as ’入职天数‘
from test_table
order by ’入职天数‘ desc;#这个排序会出错
select id, name, datediff(now(), test_table.entrydate) as 入职天数
from test_table
order by 入职天数 desc;

select id, name, datediff(now(), test_table.entrydate) as day
from test_table
order by id desc;


#流程控制函数
select if(true, 'ok', 'error');
select ifnull(NULL, 'false');

select name,
       (case gender when 'W' then 'girl' when 'M' then 'boy' else 'nothing' end) as '男女'
from test_table;

select name,
       (case when age < 30 then '年轻人' when age > 50 then '老年人' else '中年人' end)    '年份',#注意和上面有不同，这个是范围，上面找不出来
       (case when age < 30 then '年轻人' when age > 50 then '老年人' else '中年人' end) as '年纪'#注意和上面有不同，这个是范围，上面找不出来
from test_table;


#约束
create table test_user
(
    id     int unsigned not null primary key auto_increment comment 'ID',
    name   varchar(10)  not null comment '姓名',
    number int unsigned unique comment '编号',
    age    tinyint unsigned check ( age < 120 and age > 1) comment '年龄',
    status char(1) default 1 comment '状态',
    gender char(1) check ( gender = 'M' or gender = 'W' ) comment '性别'
) comment '测试用户表';

insert into test_user(name, number, age, status, gender)
values ('jim11', 23411093, 27, 1, 'W'),
       ('jim12', 790112343, 38, 0, 'M');

#外键约束
create table test_status
(
    st  char(1) unique comment '状态',
    emp varchar(10) comment '描述'
) comment '测试状态表';

insert into test_status(st, emp)
values ('1', '良好'),
       ('0', '不及格'),
       ('2', '优秀');
insert into test_status(st, emp)
values ('1', '良好');


alter table test_user
    add constraint fk_test_user_status foreign key (status) references test_status (st);#要有数据，添加外键
alter table test_user
    drop foreign key fk_test_user_status;
#删除外键

#外键约束_cascade外键级联约束同步更新或者删除，no action ,restrict,不同步，不删除，set null置空
alter table test_user
    add constraint fk_test_user_status foreign key (status) references test_status (st) on update cascade on delete cascade;
#cascade外键级联约束

#多表查询—_内连接
select *
from test_user,
     test_status
where test_status.st = test_user.status;
#多表查询内连接

#多表查询—_左外连接=左边表全部数据（没有关联的外键数据）+内连接
select *
from test_user
         left outer join test_status on test_status.st = test_user.status;
select *
from test_user
         RIGHT outer join test_status on test_status.st = test_user.status;
#多表查询—_自连接
select 员工.name, 领导.name
from test_user 领导,
     test_user 员工
where 员工.leader = 领导.id;#多表查询—_自连接,领导没有上级领导
select *
from test_user;
#多表查询—_自连接+左外连接（左员工表，显示所有员工及交集，老板没有领导也是员工，也查询)
select 员工.name '员工', 领导.name '所属领导'
from test_user 员工
         left outer join test_user 领导 on 员工.leader = 领导.id;


#联合查询_返回字段要相同_大概是OR的关系
select *
from test_user
where id > 10
union all
select *
from test_user
where age < 50;

select *
from test_user
where id > 10
union
select *
from test_user
where age < 40;

select *
from test_user
where id > 10
   or age < 40;

#多表查询—子查询—标量子查询
select *
from test_user
where status = (select st from test_status where emp = '优秀');#括号只能返回一个值
select *
from test_user
where status < (select st from test_status where emp = '优秀');

#多表查询—子查询—列子查询in ,not in ,all ,any ,some ,any=some
select *
from test_user
where status in (select st from test_status where st < 2);
select *
from test_user
where status > all (select st from test_status where st < 2);
select *
from test_user
where status > any (select st from test_status where st < 2);

#多表查询—子查询—行子查询in ,not in ,=，<>
select gender, leader
from test_user
where status = 2;
select *
from test_user
where (gender, leader) = (select gender, leader from test_user where status = 2);
#括号里只能返回1行

#多表查询—子查询—表子查询
select *
from test_user
where (gender, leader) in (select gender, leader from test_user where status = 2 or status = 1);#括号里返回多行

select e.name, e.gender, d.emp
from (select * from test_user where gender = 'W') e
         left join test_status d on e.status = d.st;


#需求测试
select u.name, u.age, t.emp
from test_user u,
     test_status t
where u.status = t.st;

create table test_grade
(
    id     int unsigned not null primary key auto_increment comment 'ID',
    lage   tinyint unsigned check ( lage < 120 and lage > 1) comment '最低年龄',
    hage   tinyint unsigned check ( hage < 120 and hage > 1) comment '最高年龄',
    status varchar(10) comment '分类',
    salary int comment '工资'
) comment '测试_分类表';

select u.name, u.age, g.status
from test_user u,
     test_grade g
where u.age between g.lage and g.hage;#包含等于，隐式内连接
select u.name, u.age, g.status
from test_user u,
     test_grade g
where u.age >= g.lage
  and u.age <= g.hage;


select distinct u.age, u.gender
from test_user u
         inner join test_status s on u.status = s.st
where age < 50;#去重distinct
select u.age, u.gender
from test_user u
         inner join test_status s on u.status = s.st
where age < 50;#内连接

select u.name 姓名, s.emp 状态, g.status 分类
from test_status s,
     test_user u,
     test_grade g
where s.st = u.status
  and (u.age between g.lage and g.hage)
  and s.emp = '良好';
#三张表 两个关系加一个条件，隐式内连接

#格式化上面的代码
select u.name 姓名, s.emp 状态, g.status 分类
from test_status s,
     test_user u,
     test_grade g
where s.st = u.status
  and (u.age between g.lage and g.hage)
  and s.emp = '良好';

select avg(u.age)
from test_user u,
     test_grade g
where u.age between g.lage and g.hage
  and g.status = '中年人';

select * from test_user u where u.age>(select avg(u.age) from test_user u);#查询比平均年龄高的员工

select count(u.age) from test_user u where u.age>(select avg(u.age) from test_user u);#查询比平均年龄高的员工的数量
