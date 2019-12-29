--创建表空间
create tablespace zx datafile 'D:/ww/zx.dbf' size 10m;
--创建用户
create user zhengxin identified by zhengxin default tablespace zx;
--查看系统中的所有用户
select * from dba_users;
--查看系统中的角色和权限
select * from dba_sys_privs;
--为用户授权
grant CREATE SESSION to zhengxin;
grant CREATE TABLE to zhengxin;
--如果为用户授权，需要一个权限一个权限的赋予。
--可以通过授予角色的方式
grant dba to zhengxin;
--创建学生表
create table student(
stuno number(4) primary key,
name varchar2(15),
sex char(2),
javascore number(4,2),
cscore number(4,2),
province varchar2(10),
city varchar2(10),
birthday date);
--查询当前系统中的日期
--dual: 这是oracle中的一张虚表。
select sysdate from dual; --对应的日期格式是：日-月-年
select to_char(sysdate,'yyyy-mm-dd') from dual;--MM和mm一样
--注：如果以后你查询的是oracle系统中的数据，那么就使用虚表。
select 5 + 3 from dual;
/*
查询的最简单语法：
select ...  要查询的内容
from ...  要查询的内容来自哪张表
[where ...] 条件，就是对查询数据的一个限定，起到一个筛选的功能
*/
--向表中插入数据 插入的语法： insert into 表名(字段名1,...) values(值1,...)
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(1,'谢大脚','女',99,88,'辽宁省','铁岭市','28-12月-78');commit;
/*
oracle中将日期字符串格式 转换成 日期  ==> 使用to_date()
          日期  转换成  字符串  ==>  使用to_char()
*/
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(2,'刘能','男',91,62.5,'黑龙江省','哈尔滨市',to_date('1985-12-02','yyyy-MM-dd'));commit;
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(3,'赵四','男',82,73,'江苏省','苏州市',to_date('1991-11-11','yyyy-MM-dd'));commit;
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(4,'谢广坤','男',78,82,'黑龙江省','漠河市',to_date('1987-05-08','yyyy-MM-dd'));commit;
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(5,'王云','女',90,74,'浙江省','杭州市',to_date('1974-10-01','yyyy-MM-dd'));commit;
/*
oracle中的运算符：
1、算术运算符： +  -  *  /
2、连接运算符： ||
3、比较(关系)运算符： >  >=  <  <=  =  !=       一般用在查询的条件中。
4、逻辑运算符： and  or  not
5、其它运算符
*/
--需求：查询所有学生的姓名和考试成绩(总分),平均分
select name,javascore + cscore,(javascore + cscore)/2 from student;
--需求：查询所有学生的姓名和家庭住址(使用一列显示)。 为列取别名（在取别名时，可以写as，也可以不写。）
select name 姓名,province || city as 家庭住址 from student;
--需求：查询1980年以后出生的学生。
--扩句、缩句。--> 以后在进行复杂查询时，先缩句。如：查询1980年以后出生的学生。-->缩句： 查询学生 --> 再扩句(加定语 --> 约束、条件)
select * from student where to_char(birthday,'yyyy') >= 1980;
/*
主键：primary key 用于唯一的标识数据库表中的一条数据。物理主键
在数据库中建表，表中必须要有主键，且通常主键采用自增长策略。
在常用的数据库MySQL和SQLServer中表的主键本身就自带自增长策略方式，auto_increment
但是在oracle中，表的主键本身是无法自增长的。那么如何解决？
  oracle中提供了一种数据结构：序列！
  言下之意：序列就是为表中的主键提供服务的，为其提供自增长值的。
*/
--创建部门表
create table t_dept(deptno number primary key,name varchar2(20),address varchar2(20));
--创建序列
create sequence seq_dept;
--序列如何提供自增长的值？  答：序列名.nextval
insert into t_dept(deptno,name,address) values(seq_dept.nextval,'WEB研发部','2-204');commit;
insert into t_dept(deptno,name,address) values(seq_dept.nextval,'JAVA研发部','2-201');commit;
insert into t_dept(deptno,name,address) values(seq_dept.nextval,'测试部','3-304');commit;
insert into t_dept(deptno,name,address) values(seq_dept.nextval,'外海合作部','8-808');commit;
/*
主键：primary key 用于唯一的标识数据库表中的一条数据。物理主键
唯一键: unique 用于唯一的标识数据库表中的一条数据。 业务主键
外键：references 表名(字段名)一张表中的某个字段的数据，如果其来自另一种表，通常来自另一张表的不被修改的数据(主键或唯一键)
*/
--创建员工表
create table emp(
id number primary key,
empno varchar2(20) unique,
name varchar2(30) not null,
basesalary number(6,2),
jobsalary number(6,2),
gradesalary number(6,2),
brithday date,
province number,
city varchar2(20),
deptnum number references t_dept(deptno));
--修改表名的语法：① rename 表名 to 新表名;② alter table 表名 rename to 新表名;
rename emp to t_emp;
alter table t_emp rename to emp;
--修改表中的字段名称语法：alter table 表名 rename column 列名 to 新列名
alter table t_emp rename column brithday to birthday;
--修改表中的字段的类型语法：alter table 表名 modify 字段名 新类型;
alter table t_emp modify province varchar2(20);
--为表添加字段语法：alter table 表名 add 字段名 类型;
alter table t_emp add hiredate date;
--随便乱加了一个字段abc，目的是为下面删除服务一下
alter table t_emp add abc date;
--删除表中的字段语法：alter table 表名 drop column 字段名;
alter table t_emp drop column abc;
/*
对表结构的修改 小结：
1,修改表名   alter table 表名 rename to 新表名;       rename 表名 to 新表名;
2,修改字段名  alter table 表名 rename column 字段名 to 新字段名;
3,修改类型    alter table 表名 modify 字段名 新类型;
4,添加字段    alter table 表名 add 字段名 类型;
5,删除字段    alter table 表名 drop column 字段名;
*/
--为员工表插入数据
--思考：任何表应该都有主键，且希望主键值能够自增长。==> 依赖序列
--问题：多张表使用同一个序列是否行？  答：行！但是不好！建议：最好一张表就使用一个序列。
create sequence seq_emp;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0018','谢大脚',2000,8888,1000,to_date('1982-11-03','yyyy-MM-dd'),'辽宁省','铁岭市',2,to_date('2014-12-22','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0001','王长贵',1800,9999.99,2000,to_date('1976-05-23','yyyy-MM-dd'),'江苏省','徐州市',1,to_date('2018-11-05','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0002','刘能',2300,9100,2500,to_date('1979-02-28','yyyy-MM-dd'),'辽宁省','铁岭市',1,to_date('2002-01-01','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0003','赵四',500,1800,300,to_date('1990-01-19','yyyy-MM-dd'),'浙江省','杭州市',2,to_date('2015-11-11','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0004','刘大脑袋',2300,5500,1800,to_date('1982-06-18','yyyy-MM-dd'),'浙江省','温州市',2,to_date('2008-08-04','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0005','谢广坤',4200,8989,3000,to_date('1994-04-12','yyyy-MM-dd'),'辽宁省','某某市',3,to_date('2011-11-12','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0006','王云',1000,1200,800,to_date('1985-05-12','yyyy-MM-dd'),'江苏省','南京市',3,to_date('2012-01-04','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0007','王大拿',9999,9999,9999,to_date('1962-01-17','yyyy-MM-dd'),'广东省','广州市',4,to_date('1998-01-23','yyyy-MM-dd'));commit;
/*
oracle中的函数： 单行函数    多行函数(聚合函数) 
单行函数：主要是针对查询的结果的每一行数据进行处理的。 日期函数、数学函数、空值函数
  日期函数：months_between()   add_months()  extract()
  数学函数：取整： 
    tranc(n); 直接截取小数点后。备注：trunc(n,m);截取，截取n这个数，且保留小数点后m位。
    ceil();  向上取整
    floor(); 向下取整
    四舍五入：round(n[,m]) : n是要被四舍五入数，m是小数点后保留几位
  空值函数： nvl(n,m); 如果n为null则去m使用，不然去n使用。
多行函数(聚合函数)：针对查询的结果的某一列中的所有行进行处理的。
  sum() 求和   avg() 求平均数   count() 计数    max() 最大值  min() 最小值
  特殊讲解count():主要两种写法：①count(*)   ②count(字段名)
  突出问题：使用count()实现计数时，尤其其中使用的是字段名，如果字段查出的值为null，则不计数。所以建议，在使用字段进行计数时，尽量使用主键。
*/
--查询两个日期之间相差多少个月
select months_between(sysdate,'27-2月-19') from dual;--大的日期写在前面
--需求：人事在使用系统，查询每个员工的姓名以及入职的时长(一共入职了多少个月)    --一个月就赔一个月的钱
select name,months_between(sysdate,hiredate) from t_emp;
--需求：开除所有的员工，按照入职一个月就赔一个月的工资(基本工资+岗位工资)
select name,months_between(sysdate,hiredate) * (basesalary + jobsalary) from t_emp;
--演示数学函数中的trunc()
select trunc(88.0001) from dual;
select trunc(88.467,2) from dual;
--演示数学函数中的ceil()和floor()
select ceil(99.0001) from dual;
select ceil(99.9999) from dual;
select floor(99.0001) from dual;
select floor(99.9999) from dual;
--需求：开除所有的员工，按照入职一个月就赔一个月的工资(基本工资+岗位工资)，注：不满一个月不算。
select name,trunc(months_between(sysdate,hiredate)) * (basesalary + jobsalary) from t_emp;
select name,floor(months_between(sysdate,hiredate)) * (basesalary + jobsalary) from t_emp;
--需求：开除所有的员工，按照入职一个月就赔一个月的工资(基本工资+岗位工资)，注：不满一个月按一个月算。
select name,ceil(months_between(sysdate,hiredate)) * (basesalary + jobsalary) from t_emp;
--测试数学函数中的四舍五入round()
select round(23.48) from dual;
select round(23.48,1) from dual;
--需求：开除所有的员工，按照入职一个月就赔一个月的工资(基本工资+岗位工资)，注：四舍五入。
select name,round(months_between(sysdate,hiredate)) * (basesalary + jobsalary) from t_emp;
--需求：查询下个月生日的那些员工（姓名和生日）
select name,to_char(birthday,'yyyy-MM-dd') from t_emp where to_char(sysdate,'MM') + 1 = to_char(birthday,'MM')
--以上SQL不好的地方：如果当前月是12月。
--在oracle中提供了一个日期函数：add_months()
select add_months(sysdate,-1) from dual;
select name,to_char(birthday,'yyyy-MM-dd') from t_emp where to_char(add_months(sysdate,1),'MM') = to_char(birthday,'MM');
--不使用to_char(),来获取年月日，extract(year/month/day from 哪里)
select extract(year from sysdate) from dual;
select name,to_char(birthday,'yyyy-MM-dd') from t_emp
where extract(month from add_months(sysdate,1)) = extract(month from birthday);
--需求：查询所有员工的姓名和他们的工资(基本工资+岗位工资)。
--在实现数学运算时，如果有一个值为null，则计算出来的结果就是null.  
--问题：如何解决在计算中判断值是否为null,解决方法：①空值函数 nvl()  ②PL/SQL
select name,nvl(basesalary,0) + nvl(jobsalary,0) from t_emp;
--需求：查询员工的平均工资
select avg(basesalary+jobsalary) from t_emp;
--需求：查询一共有多少员工
select count(*) from t_emp;
select count(id) from t_emp;
--使用sum和count计算平均工资
select sum(basesalary+jobsalary) / count(id) from t_emp;
/*
查询的语法结构：
select  查询的内容
from   要查的内容来自哪里(通常是表)
[where]  条件，筛选   分组前筛选
[group by] 分组
[having] 条件，筛选   分组后筛选
[order by] 排序   默认是升序。 desc：降序；  asc: 升序，可省略。
*/
/*问题1：如果在多表查询时，多张表中有相同名称的字段，则需要通过表名(或者别名)来指定该字段到底来自哪张表
    如果字段只在其中一张表中出现，则可以不使用表名.去指向，当然也可以使用。
       (1)取别名：对查询的列取别名可以使用as，也可以不使用;
       (2)如果一旦为表取了别名，那么在查询列中必须使用表的别名来指定列;
       (3)表在取别名的时候，不能使用as。
  问题2：在进行多表查询时，通常要建立表与表之间的连接关系，而这种关系通常使用外键来维护
*/
--需求：查询部门名称以及该部门的总工资。
select t_dept.name,sum(basesalary + jobsalary) from t_dept,t_emp 
where t_dept.deptno = t_emp.deptnum 
group by t_dept.name;

select d.name 部门名称,sum(basesalary + jobsalary) as 总工资 from t_dept d,t_emp e 
where d.deptno = e.deptnum 
group by d.name;
/*
使用外键来维护多张表的连接关系的查询：称之为表的连接查询。
 连接查询：主要分为内连接和外连接。 而外连接又分为左外连接和右外连接。
 内连接和外连接的区别：
    （1）内连接查询的是所有满足条件的那些数据；
    （2）外连接是以左/右表为主表，且必须将主表中的数据都查询出来，从表中没有与之对应的数据，则以null表示。
连接查询有自己的一套语法：select 查询的内容 from 表1 inner/left/right join 表2 on 条件    备注：条件必须有
*/
select e.name,d.name from t_emp e inner join t_dept d on e.deptnum = d.deptno;
--等价于以下写法：
select e.name,d.name from t_emp e, t_dept d where e.deptnum = d.deptno;
--需求：查询所有的部门名称和部门中的员工的名称。
select d.name,e.name from t_dept d left join t_emp e on d.deptno = e.deptnum;
select d.name,e.name from t_emp e right join t_dept d on d.deptno = e.deptnum;
--需求：查询总工资超过20000的那些部门的名称及其总工资。
select d.name deptname,sum(basesalary + jobsalary) as totalsalary from t_dept d,t_emp e 
where d.deptno = e.deptnum
group by d.name;
--可以将上述SQL查询出来的结果看成是一个虚拟表。通过子查询的方式实现需求
select * from(
  select d.name deptname,sum(basesalary + jobsalary) as totalsalary from t_dept d,t_emp e
  where d.deptno = e.deptnum
  group by d.name)
where totalsalary > 20000; --在查询的结果后筛选
--通过having的方式实现查询
select d.name deptname,sum(basesalary + jobsalary) as totalsalary from t_dept d,t_emp e
where d.deptno = e.deptnum
group by d.name
having sum(basesalary + jobsalary) > 20000
order by totalsalary asc;
--需求：查询每个部门的编号，最高工资和最低工资
--在查询时，如果select后有聚合函数，非聚合函数的列都必须出现在group by中。
select deptnum, max(basesalary + jobsalary), min(basesalary + jobsalary) from t_emp
group by deptnum;
--需求：查询每个部门的名称，最高工资和最低工资
select d.name,max(basesalary + jobsalary), min(basesalary + jobsalary) from t_dept d inner join t_emp e 
on d.deptno = e.deptnum
group by d.name;
--需求：查询每个部门的最高工资或最低工资的那些员工的名字，工资和家庭地址。
select e.name,e.basesalary + e.jobsalary, e.province || e.city,e.deptnum from t_emp e
inner join(
  select deptnum, max(basesalary + jobsalary) maxsalary, min(basesalary + jobsalary) minsalary from t_emp
  group by deptnum
) mm
on (basesalary + jobsalary = mm.maxsalary or basesalary + jobsalary = mm.minsalary) and e.deptnum = mm.deptnum;
--分页查询
--通过ID是肯定不能实现分页的，因为表中的数据是可能被删除的，那么ID就不连续了。
select * from t_emp where id >= 1 and id <= 3;
--那么通过什么来实现分页呢？ 使用rownum  --> 伪列
select rownum,name from t_emp;
--补充rowid
select rowid,rownum,name from t_emp;
/*
rowid: 数据在表中的行的唯一标识；
rownum: 查询出来的结果（虚拟表）的行号。
*/
--需求：分页查询，每页显示3条数据。
select * from t_emp where rownum <= 3;  --第一页
select * from t_emp where id <= 6 and id >= 4;
select * from t_emp where rownum <= 6 and rownum >= 4;  --不行
--where 是在查询过程中逐条筛选，而不是对查询最终的结果进行筛选。
--rownum取上限没有问题，取下限会出现问题，就因为where的筛选规则。
--oracle中分页查询需要三步走
--1，查询所有的
select * from t_emp;
--2,取上限并将rownum存储到一个虚拟表中
select r.*,rownum rowno from(select * from t_emp)r where rownum <= 6;
--3,取下限
select * from(select r.*,rownum rowno from(select * from t_emp)r where rownum <= 6) where rowno >= 4;
--需求：将一个表的所有数据复制到另一张表上
select * from t_emp t where id = 3;
create table tt_emp as select * from t_emp;
select * from tt_emp where id = 3;
/*索引
    作用：提高查询的效率。
表、序列、索引、视图、过程、函数等都是oracle数据库实例中的对象，它们都有独立的存储空间。
oracle中，表的主键(约束)都会默认的为其生成一个对应的索引。索引的名字和主键的约束名称相同。
  同时，如果你删除表中的主键约束也会级联删除对应的索引。
*/
--需求：查询编号是2的员工
select * from t_emp where id = 2;
select id,rowid from t_emp;
/*
删除约束的语法：
  alter table 表名 drop constraint 约束名;
添加约束的语法：
  alter table 表名 add [constraint 约束名称] 约束类型;
*/
--思考？删除表中的主键约束。
alter table t_emp drop constraint SYS_C005574;
--需求：为表t_emp的id字段添加主键约束
--发现约束的名称默认是由系统自动生成的。
alter table t_emp add primary key(id);--自动生成约束名字
alter table t_emp add constraint emp_id_pk primary key(id);--自定义约束名字
/*
问题：①有索引为什么快？ 见图：索引2.png  ②什么地方应该用索引？ 在查询过程中被频繁作为条件的字段。
发现主键默认就有索引，那为什么呢？ 因为主键具有唯一性，那就可以通过主键直接查找一条很精准的数据。
*/
--唯一键约束和主键约束一样，都会默认去创建对应的索引。
alter table t_emp add unique(name);
alter table t_emp drop constraint SYS_C005579;
alter table t_emp add constraint t_emp_name_unique unique(name);
alter table t_emp drop constraint t_emp_name_unique;
/*
问题：如果表中的name不需要对其进行唯一键约束，但是经常会以name字段进行查找，怎么办？
答：不能通过唯一键约束的方式自动添加索引了，我们需要单独为表中字段去创建索引。
创建索引:create index 索引名 on 表名(字段名)
删除索引:drop index 索引名;
*/
create index index_emp_name on t_emp(name);
drop index index_emp_name;
--要求：在表t_emp中，名字和地址来唯一标识一个老师信息。
--在表t_emp中，名字可以相同，地址也可以相同，但是名字和地址不能同时相同.
--在一张表中，一条数据的唯一性由多个字段确定，可以通过联合主键的方式来实现。  --掌握
alter table t_emp add constraint name_city_unique unique(name,city); 
--查询名字为 谢大脚 的员工
select * from t_emp where name = '谢大脚';
--查询地址为 铁岭市 的员工
select * from t_emp where city = '铁岭市';
--查询名字为 谢大脚 且地址是 铁岭市 的员工
select * from t_emp where name = '谢大脚' and city = '铁岭市';
--以上是通过联合组件生成索引的。  也可以不去创建约束，也可以创建联合索引。
alter table t_emp drop constraint name_city_unique;
create index index_emp_name_city on t_emp(name,city);--了解
drop index index_emp_name_city;
--需求：查询1982年的员工
select * from t_emp where to_char(birthday,'yyyy') = '1982';
--如果：在应用中会频繁的通过生日的年份查找员工，那么这时候可以在员工的生日添加索引
create index index_emp_birthday on t_emp(birthday);
select * from t_emp where to_char(birthday,'yyyy') = '1982';--不经过上述索引 
select * from t_emp where birthday = '03-11月-82';  --经过上述索引
drop index index_emp_birthday;
--要想让where后的 to_char(birthday,'yyyy')经过索引，就需要创建函数索引
create index index_emp_birthday_year on t_emp(to_char(birthday,'yyyy'));
select * from t_emp where to_char(birthday,'yyyy') = '1982';--经过上述索引 
select * from t_emp where birthday = '03-11月-82';  --不经过上述索引
--继续为名字加索引
create index index_emp_name on t_emp(name);
--需求：查询所有姓王的员工
select * from t_emp where name like '王%';--模糊查询 会经过索引
--需求：修改编号是6的员工的城市为  沈阳市
update t_emp set city = '沈阳市' where id = 6;--会经过索引
/*
视图：视图和表、序列、索引一样，都是oracle数据库中的一个实例。也能够像表、序列、索引一样，对视图进行创建和删除。
视图的作用：它基于表，将表中要被频繁使用的数据提取出来，供外部程序直接使用。
视图与表的关系： 数据存储在表中，视图是基于表、视图就是用于管理从表中查询出来的结果。
为什么要视图？
  举例：一家公司有一个企业管理系统，用于管理企业的日常事务。企业中有一个非常重要的人在扮演重要的角色，财务总监。
    他每天频繁使用该系统，查询员工的薪资情况。
    员工的信息在存在一张表中：t_emp: id,name,sex,birthday,ismarry,hiredate,address,phone,basesalary，jobsalary，gradesalary,....
    但是财务只关心员工的名字和工资。
    目前的解决方案：直接从表中查询：select name,basesalary,jobsalary,gradesalary from t_emp;
    太耗时，就希望将查询的数据能够独立管理，使用视图。
*/
create table t_emp1(id number(4) primary key,name varchar2(20),sex char(2),age number(3),
province varchar2(20),city varchar2(20),basesalary number(7,2),jobsalary number(7,2));
create sequence seq_emp1;
insert into t_emp1(id,name,sex,age,province,city,basesalary,jobsalary)
values(seq_emp1.nextval,'Lucy','女',23,'江苏省','徐州市',6231,8232);commit;
insert into t_emp1(id,name,sex,age,province,city,basesalary,jobsalary)
values(seq_emp1.nextval,'Lily','女',21,'安徽省','合肥市',2011,1200);commit;
insert into t_emp1(id,name,sex,age,province,city,basesalary,jobsalary)
values(seq_emp1.nextval,'LiLei','男',25,'江苏省','南京市',5000,7210);commit;
insert into t_emp1(id,name,sex,age,province,city,basesalary,jobsalary)
values(seq_emp1.nextval,'HanMeimei','女',23,'浙江省','杭州市',5000,1200);commit;
--需求：查询员工的编号，名字和工资
select id,name,basesalary,jobsalary from t_emp1;
--希望：将查询出来的数据用一种结构管理起来，供以后直接使用。
--这种结构  就是  视图。
--创建视图的语法： create view 视图名 as 查询语句;
--删除视图的语法： drop view 视图名;
create view v_emp as select id,name,basesalary,jobsalary from t_emp1;
--1、向视图中插入数据  能够插入且数据会反映到表中。
insert into v_emp(id,name,basesalary,jobsalary)values(10,'Pony',8210,9999);commit;
--2、视图中删除数据 能够插入且数据会反映到表中。
delete from v_emp where id = 10;commit;
--3、修改数据 能够插入且数据会反映到表中。
update v_emp set name = 'Flex' where id = 4;commit;
--4、查询
select * from v_emp;
--综上：①对视图可以像表一样进行CRUD(增删改查)操作；②对视图的成功操作都能够反映到表中。
--反过来，我们修改表中的数据，看是否也能够级联到对应的视图中。
--将表中的所有员工的基本工资涨500.  表中的数据更新也会反映到视图中。
update t_emp1 set basesalary = basesalary + 500; commit;
--问题：如果视图中的列是表中的计算列。
create view v_emp1 as select id,name,basesalary+jobsalary salary from t_emp1;
update v_emp1 set salary = 4000 where id = 2;--无法反映到表中
update t_emp1 set jobsalary = 2000 where id = 2;--可以反映到视图中
--删除试图
drop view v_emp1;
--创建试图的时候，为查询的列取别名
create view v_emp1 as select id,name empname,basesalary+jobsalary salary,province||city address from t_emp1;
--修改试图中编号为4的员工的名字为：Lucs
update v_emp1 set empname = 'Lucs' where id = 4; --简单列取别名，可以实现修改并相互反映
--修改试图中编号为2的员工的地址为：安徽省芜湖市
update v_emp1 set address = '安徽省芜湖市' where id = 2;--计算列，在视图中无法修改
/*
小结：
  1、视图与表的关系
  2、视图可以增删改查操作
  3、表中的数据的修改必然会反映到视图中
  4、视图中的数据并不一定能改，只要能被修改必然会反映到表中。
*/
--如果希望创建的视图只能供查看而不允许修改 ，这种视图，我们称之为 只读视图
create view v_emp2 as select id,name,basesalary,jobsalary from t_emp1 with read only;  --只读视图
--在视图v_emp2中将编号为2的员工的基本工资+1000
update v_emp2 set basesalary = 3011 where id = 2;
--创建视图，视图中的数据是基本工资低于5000的那些员工的信息
create view v_emp3 as select id,name,basesalary,jobsalary from t_emp1 where basesalary < 5000;
--需求：修改试图中的某个数据，将基本工资改成5000.
update v_emp3 set basesalary = 4999 where id = 4;commit;
--既然在上述试图v_emp3中查询的数据是应该满足条件的。如果你修改此数据，也应该在改条件范围内。
drop view v_emp3;
create view v_emp3 as select id,name,basesalary,jobsalary from t_emp1 where basesalary < 5000 with check option;
/*
PL/SQL:
  SQL: 结构化查询语言
    主要使用的有：DDL:create，drop，alter; DML: insert,delete,update,select；TCL:commit，rollback
  PL: Procedural Language  过程化语言。
PL/SQL: 其实就是在SQL基础之上进行了扩展，扩展了过程化语言。
  过程化语言指的是什么？举例：就好比c语言中的函数中的代码，java中方法中的代码片。
学习任何一门语言，开始学习基本语法：helloword，变量和数据类型、流程控制语句
PL/SQL中的数据类型：①支持oracle本身的所有数据类型：number,varchar2,char,date等。②引用表中的字段的类型 %type
PL/SQL中赋值：① :=   ②动态赋值 into
PL/SQL的基本结构：
  declare  --可选，定义变量
    变量名 类型 [:= 值];     
  begin   --必须  
    代码块
  end;   --必须
*/
begin
  dbms_output.put_line('Hello,PL/SQL');
end;
--定义两个变量name和age，然后为name和age赋值并输出
declare
  name varchar2(20) ;
  age number(3);
begin
  name:= '李小璐';
  age := 39;
  dbms_output.put_line('姓名：' || name ||',年龄：'||age);
end;
--查询编号为4的员工的名字和年龄,并输出到DBMS中
select name,age from t_emp1 where id = 4;
declare
 empno t_emp1.id%type := 4;
 name t_emp1.name%type;
 empage t_emp1.age%type;
begin
  select name,age into name,empage from t_emp1 where id = empno;
  dbms_output.put_line('姓名：' || name ||',年龄：'||empage);
end;
/*
PL/SQL中定义变量并赋值
  赋值通过两种方式：  ①:=   ②into
  变量定义的语法：  变量名  类型
  类型：①oracle中支持的数据类型  ②%type  ③%rowtype  ④record
*/
--需求：查询员工表中的编号为3的员工的所有信息，并输出。
select * from t_emp1 where id = 3;
declare
  v_id t_emp1.id%type;
  v_name t_emp1.name%type;
  v_sex t_emp1.sex%type;
  v_age t_emp1.age%type;
  v_province t_emp1.province%type;
  v_city t_emp1.city%type;
  v_basesalary t_emp1.basesalary%type;
  v_jobsalary t_emp1.jobsalary%type;
begin
  select id,name,sex,age,province,city,basesalary,jobsalary
  into v_id,v_name,v_sex,v_age,v_province,v_city,v_basesalary,v_jobsalary
  from t_emp1
  where id = 3;
  dbms_output.put_line(v_name || ',' || v_jobsalary);
end;
/*
  在上述的PL/SQL语句中，我们发现一张表中如果有很多字段（假设有30个），
那么在PL中就要定义30个变量接收数据。即使没有查询30列，只查询20列。其实查询的列也比较多，
那就会耗太多的时间在定义变量上。此时，oracle提供了另一种类型结构来解决这种问题。
类型：%rowtype
  理解：表中的一行数据==>一条记录==>一个实体==>一个对象
从面向对象的角度看：表中的一行就是一个对象。 %rowtype就在表述表中的一个行对象类型。
*/
declare
  v_emp t_emp1%rowtype;--此时这个变量就对应着表中的一行
begin
  select id,name,sex,age,province,city,basesalary,jobsalary
  into v_emp
  --into v_emp.id,v_emp.name,v_emp.sex,v_emp.age,v_emp.province,v_emp.city,v_emp.basesalary,v_emp.jobsalary
  from t_emp1
  where id = 3;
  dbms_output.put_line(v_emp.name || ',' || v_emp.jobsalary);
end;

-- 我们刚说，%rowtype就描述的是一个对象类型，但是它仅仅描述的是一张表中的行对象类型。
-- 如果，我们查询的数据来自多张表中的多个列。我们可以为每个列定义变量用于接值。如：
declare
 v_empname t_emp.name%type;
 v_empage t_emp.age%type;
 v_deptname t_dept.name%type;
begin
  select t_emp.name,t_emp.age,t_dept.name 
  into v_empname,v_empage,v_deptname
  from t_emp,t_dept
  where t_emp.deptid = t_dept.id and t_emp.id = 2;
end;
-- 以上的PL/SQL语句中定义的变量，我们也可以对其进行包装成一个类型。
declare
 type empdept is record(
  v_empname t_emp.name%type,
  v_empage t_emp.age%type,
  v_deptname t_dept.name%type
 );
 v_empdept empdept;
begin
  select t_emp.name,t_emp.age,t_dept.name
  --into v_empdept  --查询的列要和empdept定义的顺序保持一致，如果不一致，就要手动写
  into v_empdept.v_empname,v_empdept.v_empage,v_empdept.v_deptname
  from t_emp,t_dept
  where t_emp.deptid = t_dept.id and t_emp.id = 2;
end;

--简单演示：
declare
  type temp_emp is record(
    v_name t_emp1.name%type,
    v_age t_emp1.age%type,
    v_basesalary t_emp1.basesalary%type
  );
  v_emp temp_emp;
begin
  select name,age,basesalary into v_emp from t_emp1;
 -- where id = 6;
  dbms_output.put_line(v_emp.v_name||','||v_emp.v_age||','||v_emp.v_basesalary);
exception
  when no_data_found then
    dbms_output.put_line('数据找不到！');
  when too_many_rows then
    dbms_output.put_line('查询的行数太多！');
  when others then
    dbms_output.put_line('其它错误！');
end;
/*
常见异常类型：
no_data_found: 数据未找到
others：所有异常  就相当于java中的Exception
*/
set serveroutput on;--开启输出语句
/*
PL/SQL中的流程控制语句：
  主要分为两种：分支(选择)结构；循环结构
  分支结构：
    ①if结构
      ①-①简单if结构
        if 条件 then
          代码;
        end if;
      ①-②if-else结构
        if 条件 then
          代码
        else
          代码
        end if;
      ①-③多重if结构
        if 条件 then
          代码
        elsif 条件 then     --elsif可以有多个
          代码
        else               --else最多有一个。
          代码
        end if;
    ②case结构    --做等值判断
    语法一：
       case 变量
        when 值 then   --when可以出现多次
          代码
        ...
        else          --最多一个
          代码
       end case;
     语法二：
       case
         when 变量 = 值 then
           代码
         ...
         else
          代码
       end case;
  循环结构：
    ①while
      while 条件 loop
        代码
      end loop;
    ②do-while
       loop
        代码/循环体
        exit when 条件;
       end loop;
    ③for
      for 变量 in 数列 loop
        代码/循环体
      end loop;
*/
--举例：if结构 
--需求：查询指定员工的基本工资，如果超过6000，晚上约妹子去吃黄粱一梦。
declare
  v_basesalary t_emp1.basesalary%type;
begin
  select basesalary into v_basesalary from t_emp1 where id = 1;
  if v_basesalary > 6000 then
    dbms_output.put_line('晚上带妹子去吃黄粱一梦');
  end if;
end;
--需求：查询指定员工的基本工资，如果超过6000，晚上约妹子去吃黄粱一梦;不然自己下饭馆。
declare
  v_basesalary t_emp1.basesalary%type;
begin
  select basesalary into v_basesalary from t_emp1 where id = 2;
  if v_basesalary > 6000 then
    dbms_output.put_line('晚上带妹子去吃黄粱一梦');
  else
    dbms_output.put_line('自己下饭馆！');
  end if;
end;
--需求：查询指定员工的基本工资，如果超过6000，晚上约妹子去吃黄粱一梦;如果超过4000自己下馆子，不然在家啃馒头。
declare
  v_basesalary t_emp1.basesalary%type;
begin
  select basesalary into v_basesalary from t_emp1 where id = 2;
  if v_basesalary > 6000 then
    dbms_output.put_line('晚上带妹子去吃黄粱一梦');
  elsif v_basesalary > 4000 then
    dbms_output.put_line('自己下饭馆！');
  else
    dbms_output.put_line('自己在家啃馒头！');
  end if;
end;
--需求：查询指定员工的姓名和性别，如果性别是'男'则输出'xxx是公子'，如果是'女'则输出是'xxx是千金'，不然输出'第三宠物！'
declare
  v_name t_emp1.name%type;
  v_sex t_emp1.sex%type;
begin
  select name,sex into v_name,v_sex from t_emp1 where id = 2;
  if v_sex = '男' then
    dbms_output.put_line(v_name||'是公子。');
  elsif v_sex = '女' then
    dbms_output.put_line(v_name||'是千金。');
  else
    dbms_output.put_line(v_name||'是第三方宠物。');
  end if;
end;
--上述的比较是在实现等值比较，也可以使用case结构
--case语法一：
declare
  v_name t_emp1.name%type;
  v_sex t_emp1.sex%type;
  v_msg varchar2(10);
begin
  select name,sex into v_name,v_sex from t_emp1 where id = 2;
  case v_sex
    when '男' then
      v_msg := '公子';
      --dbms_output.put_line(v_name||'是公子!。');   
    when '女' then
      v_msg := '千金';
      --dbms_output.put_line(v_name||'是千金!。');
    else
      v_msg := '第三方宠物';
      --dbms_output.put_line(v_name||'是第三方宠物!。');
  end case;
  dbms_output.put_line(v_name||'是'||v_msg);
end;
--case语法二：
declare
  v_name t_emp1.name%type;
  v_sex t_emp1.sex%type;
  v_msg varchar2(10);
begin
  select name,sex into v_name,v_sex from t_emp1 where id = 2;
  case 
    when v_sex = '男' then
      v_msg := '公子'; 
    when v_sex = '女' then
      v_msg := '千金';
    else
      v_msg := '第三方宠物';
  end case;
  dbms_output.put_line(v_name||'是'||v_msg);
end;
--循环结构
--while循环
--需求：输出8句：李小璐棒棒哒。
declare
  v_count number(2) := 1;
begin
  while v_count <= 8 loop
    dbms_output.put_line('李小璐棒棒哒。');
    v_count := v_count + 1;
  end loop;
end;
--需求：1到100的整数和
declare
  v_num number(3) := 1;
  v_sum number(5) := 0;
begin
  while v_num <= 100 loop
    v_sum := v_sum + v_num;
    v_num := v_num + 1;
  end loop;
  dbms_output.put_line('result = ' || v_sum);
end;
--do-while循环
--需求：输出10句：亮亮凉凉了。
declare
  v_count number(2) := 1;
begin
  loop
    dbms_output.put_line('亮亮凉凉了。');
    v_count := v_count + 1;
    exit when v_count > 10;
  end loop;
end;
--for循环
--需求：输出6句'猪肉吃不起，也惹不起！'
declare
  --v_count number(2); --在for中变量可以不用定义。
begin
  for v_count in 1..6 loop
    dbms_output.put_line('猪肉吃不起，也惹不起！');
  end loop;
end;
--游标  游标的作用：处理查询的结果，逐行处理查询的数据。
--需求：查询所有的员工信息，并将每个员工信息输出到DBMS中。
select * from t_emp1;
/*
要逐行处理查询的数据，想到使用游标。
游标的使用步骤：
①定义游标：cursor 游标名称[(参数列表)] is 查询语句; 如：cursor emp_sor is select * from t_emp;
②打开游标：open 游标名称; 如：open emp_sor;
③取值：fetch 游标名称 into 变量; --意味着前面要定义该变量来接收游标指向的这一条数据。如：fetch emp_sor into 变量;
  --备注1：一旦开始取值先向下动一行,一次fetch就只会取一行数据。
  --备注2：%found 表示游标取到值 ；  %notfound 表示游标没有取到值
④关闭游标：close 游标名称; 如：close emp_sor;
*/
declare
  cursor emp_sor is select * from t_emp1;--定义游标
  v_emp t_emp1%rowtype;--定义一个变量，用于接收游标当前指向的这一行数据的值
begin
  open emp_sor;  --打开游标
  fetch emp_sor into v_emp;  --取值
  while emp_sor%found loop
    dbms_output.put_line(v_emp.id||','||v_emp.name||','||v_emp.age);
    fetch emp_sor into v_emp;
  end loop;
  close emp_sor;  --关闭游标
end;
--使用do-while循环  loop循环
declare
  cursor emp_sor is select * from t_emp1;
  v_emp t_emp1%rowtype;
begin
  open emp_sor;
  loop
    fetch emp_sor into v_emp;
    exit when emp_sor%notfound;
    dbms_output.put_line(v_emp.id||';'||v_emp.name||';'||v_emp.age);
  end loop;
  close emp_sor;
end;
--for循环
/*
使用for来遍历游标，特殊的地方有：1、不需要手动打开游标；2、不需要手动关闭游标；
3、在for中直接取值，无需fetch；4、用于接收游标所指向的行数据的变量无需先定义。
*/
declare
 cursor emp_sor is select * from t_emp1;
begin
  for v_emp in emp_sor loop --隐藏着会自动打开游标
   dbms_output.put_line(v_emp.id||'-'||v_emp.name||'-'||v_emp.age);
  end loop;
end;
--以下写法中其实使用到游标：隐式游标
begin
  for v_emp in (select * from t_emp1) loop 
   dbms_output.put_line(v_emp.id||'--'||v_emp.name||'--'||v_emp.age);
  end loop;
end;
--游标的分类：显式游标、隐式游标。
--需求：查询省份是xx的那些员工的信息，并输出到DBMS中
--游标中的参数在定义时，类型不能加精度
declare
  cursor emp_sor(pro varchar2) is select * from t_emp1 where province = pro;
  v_emp t_emp1%rowtype;
begin
  open emp_sor('浙江省');
  loop
    fetch emp_sor into v_emp;
    exit when emp_sor%notfound;
    dbms_output.put_line(v_emp.id||','||v_emp.name||','||v_emp.province);
  end loop;
  close emp_sor;
end;
--需求：使用游标遍历所有的员工信息，如果是江苏省的基本工资+1000，浙江省+500  安徽省+300  其他加100
declare
  cursor e_sor is select * from t_emp1;
  v_emp t_emp1%rowtype;
  add_basesalary number(4);
begin
  open e_sor;
  loop
    fetch e_sor into v_emp;
    exit when e_sor%notfound;
    case v_emp.province
      when '江苏省' then
        add_basesalary := 1000;
        --update t_emp set basesalary = basesalary + 1000 where id = v_emp.id;
      when '浙江省' then
        add_basesalary := 500;
        --update t_emp set basesalary = basesalary + 500 where id = v_emp.id;
      when '安徽省' then
        add_basesalary := 300;
        --update t_emp set basesalary = basesalary + 300 where id = v_emp.id;
      else
        add_basesalary := 100;
        --update t_emp set basesalary = basesalary + 100 where id = v_emp.id;
    end case;
    update t_emp1 set basesalary = basesalary + add_basesalary where province = v_emp.province;
    commit;
  end loop;
end;
/*
前面的PL/SQL都是以“块”的形式处理数据。PL/SQL的基本结构，我们就称之为“块”。
  最简单的结构：begin..end;   扩展一点：declare..begin..exception..end;
问题：块都是在当时的情况下、编译一次执行一次。希望能将这个块的代码进行封装、然后就编译一次、供别人多次调用执行。
  如何解决？==>使用存储过程或者函数。
--过程：它和前面学过的表、序列、索引、视图等一样都是oracle中的一个实例。
  发现：oracle实例的创建都是通过create table|sequence|index|view来创建
            通过drop table|sequence|index|view来删除的。
  所以，我们能变通理解：过程的创建和删除和以上是类似的。
过程创建的语法是：
  create procedure 过程名[(参数列表)]
  is|as   --声明变量 必须
  begin   --代码块   必须
  end;    --结束    必须
注：参数的类型不能加精度。
过程删除的语法是：drop procedure 过程名;
*/
create or replace procedure showMe
as
begin
  dbms_output.put_line('Hi,MM!');
end;
drop procedure showMe;
--过程的调用
begin
  showMe;
  showMe;
end;
--创建一个过程，演示一下is|as定义变量
create or replace procedure sayHello
is
  v_name varchar2(10) := '大伟哥';
begin
  dbms_output.put_line('嗨,'||v_name);
end;
begin
  sayHello;
end;
--演示：创建一个过程，向过程传入值
create or replace procedure addNum(firstNum number,secondNum number)
is
  res number(4);
begin
  res := firstNum + secondNum;
  dbms_output.put_line('result = ' || res);
end;
begin
  addNum(4,19);
  addNum(89,21);
end;
--需求：创建一个存储过程，传入部门的编号，名字、地址。如果编号存在则修改对应的数据，如果不存在则插入。
create or replace procedure updateDept(deptid number,deptname varchar2,deptaddr varchar2)
is
  v_count number(3);
begin
  select count(deptno) into v_count from t_dept where deptno = deptid;
  if v_count > 0 then
    update t_dept set name = deptname,address = deptaddr where deptno = deptid;
  else
    insert into t_dept(deptno,name,address) values(deptid,deptname,deptaddr);
  end if;
  commit;
end;
begin
  updateDept(2,'移动服务部','2-321');
end;
/*
 过程: 就是对一段PL/SQL块的封装。目的是可供外部(以后的程序)调用。
 创建(存储)过程的语法：
  create [or replace] procedure 过程名[(参数列表)] 
  is    --声明变量，必须的
  begin
  end;
*/
--问题是：我们知道可以通过参数列表向过程传递值。那么过程如何向调用者回传值？
--它的解决方案是：通过传出参数。
--可见：在过程中，参数可以分为两种：传入参数、传出参数。且，传入参数和传出参数都可以有多个。
--需求：创建一个过程，传入员工的编号，查询员工的姓名和年龄。
create or replace procedure getInfo(eid number)
is
  v_name t_emp1.name%type;
  v_age t_emp1.age%type;
begin
  select name,age into v_name,v_age from t_emp1 where id = eid;
  dbms_output.put_line(v_name || ',' || v_age);
end;
begin
 getInfo(2);
end;
--使用传出参数
create or replace procedure getInfo(eid number,ename out varchar2,eage out number)
is
begin
  select name,age into ename,eage from t_emp1 where id = eid;
end;
declare
 v_id t_emp.id%type := 3;
 v_name t_emp1.name%type;
 v_age t_emp1.age%type;
begin
   getInfo(v_id,v_name,v_age);
   dbms_output.put_line(v_name||'-'||v_age);
end;
/*
函数和表、视图、索引、序列、过程等一样，都是oralce中的实例。
函数：
 回顾我们已经学过的函数：单行函数、聚合函数
  单行函数：日期函数、数学函数、空值函数。
  聚合函数：count  sum  max  min  avg等
 回忆一下以上函数是如何使用的？ 是在SQL语句中使用的。
    如：select max(age) from t_emp;
自定义函数：
  create [or replace] function 函数名[(参数列表)]
  return  --定义返回类型 必须
  is    --定义变量
  begin  --块的开始
  end;   --块的结束
删除函数：drop function 函数名;
注：函数名和过程名不能相同。
*/
--需求：查询编号为x的员工的较高工资的那部分工资。
declare
  v_id t_emp1.id%type := 2;
  v_base t_emp1.basesalary%type;
  v_job t_emp1.jobsalary%type;
  v_max number(6,2);
begin
  select basesalary,jobsalary into v_base,v_job from t_emp1 where id = v_id;
  if v_base >= v_job then
    v_max := v_base;
  else
    v_max := v_job;
  end if;
  dbms_output.put_line('较高的那部分工资是：' || v_max);
end;
--以上代码，只是一个块而已，不能被外部调用，如果要被调用，那么这时候必须对这个块进行封装。
--封装：过程、函数。
--发现：该块会被SQL调用且必须有一个返回值 ，此时想到使用函数。
create or replace function getMaxSalary(eid number)
return number     --不能加分号
is
  v_base t_emp1.basesalary%type;
  v_job t_emp1.jobsalary%type;
  v_max number(6,2);
begin
   select basesalary,jobsalary into v_base,v_job from t_emp1 where id = eid;
   if v_base >= v_job then
    v_max := v_base;
   else
    v_max := v_job;
   end if;
   return v_max;
end;
drop function getMaxSalary;
select name,sex,age,getMaxSalary(id) from t_emp1;
--函数的调用，不仅可以在SQL表达式中调用，也可以直接调用。类似过程的调用
create or replace function sayHello1(name varchar2)
return varchar2
as
begin
  return 'Hello,'||name;
end;
select sayHello1(name) from t_emp;
select sayHello1('伟哥') from dual;
declare
  v_info varchar2(20);
begin
  v_info := sayHello1('Boly');
  dbms_output.put_line(v_info);
end;
/*
触发器：也是和表、视图等一样，也是oracle数据库中的一个对象(实例)。
  create table 表名         drop table 表名
  create index 索引名       drop index 索引名
  create sequence 序列名    drop sequence 序列名
  create view 视图名        drop view 视图名
  create procedure 过程名   drop procedure 过程名
  create function 函数名    drop function 函数名
触发器：是在特定的行为下触发的事件而产生的操作。
 可见：触发器不需要程序员手动调用的，它是由事件产生的。
  举例理解：如有一张表：用户名t_user. 我们(管理员t_admin)可以对用户进行增删改查操作。
创建触发器的语法：
  触发器的简单分类： 前置触发器before、后置触发器after
  create [or replace] trigger 触发器名
  触发器的类型
  declare     --不能使用is|as    可以省略
  begin
  end;
删除触发器的语法：drop trigger 触发器名;
*/
create table t_user(id number(4) primary key,name varchar2(20),age number(3));
create table t_log(id number(4) primary key,log_action varchar2(30),log_date date,log_user varchar2(20));
create sequence seq_log;
--创建触发器
--明确：在删除表中的数据之后要将删除操作记录下来？如何记录：向另一张表中插入一条记录信息。
create or replace trigger user_trigger
after delete or update or insert on t_user
declare
  v_action varchar2(20) := '其它操作';
begin
  if deleting then
    v_action := '删除操作';
  elsif inserting then
    v_action := '插入操作';
  elsif updating then
    v_action := '修改操作';
  end if;
  insert into t_log(id,log_action,log_date,log_user) values(seq_log.nextval,v_action,sysdate,'Lucy');
end;
delete from t_user where id = 2;commit;
update t_user set age = 20 where id = 3;commit;
insert into t_user(id,name,age) values(9,'奥巴马小犬一狼',24);commit;
--集合操作
--查询所有人(管理员、用户)的名字。（此处用t_emp员工表作为管理员表，用tt_emp作为用户表（关于tt_emp可产看第297行代码））
select name from t_emp;--查询管理员姓名(用员工表做管理员表)
alter table tt_emp rename column name to username;
--此处可手动删除和修改几条tt_emp中的数据，以方便后续查询使用
select username from tt_emp;--查询用户姓名
select name,username from t_emp,tt_emp;--表的连接查询
--以上都不能解决需求的，那么这时候需要将两次独立查询的结果连接。 <集合操作>
--重复数据只出现一次
select name 姓名 from t_emp union select username from tt_emp;
--重复数据出现多次
select name 姓名 from t_emp union all select username from tt_emp;
--查询重复数据
select name 姓名 from t_emp intersect select username from tt_emp;
--前面的结果中去除重复数据
select name 姓名 from t_emp minus select username from tt_emp;
/*
转换函数：
  1、日期与字符串之间： to_char()  to_date()
  2、数字与字符串之间：tO_char()  to_number()
*/
--假设表t_emp1,中有基本工资4000和岗位工资4999.5。 要求查询出来的数据格式为 ￥8,999.50
select 4000 + 4999.5 工资 from dual;
select to_char(4000 + 4999.5,'L0,000.00') from dual;--L 人民币的货币格式
select to_char(4000 + 4999.5,'$0,000.00') from dual;--$ 美元的货币格式
create table t_emp2(id number(4) primary key,name varchar2(20),base varchar2(20),job varchar2(20));
insert into t_emp2(id,name,base,job) values(1,'lucy','$4,000','$4,999.5');commit;
select name,base + job from t_emp2;--字符串是无法进行加法运算的
select name,to_number(base,'$0,000.00') + to_number(job,'$0,000.00') from t_emp2;
select name,to_char(to_number(base,'$0,000.00') + to_number(job,'$0,000.00'),'$0,000.00') from t_emp2;
--转换时，货币的数字格式只能是0或者9.
select name,to_number(base,'$9,999.99') + to_number(job,'$0,909.00') from t_emp2;