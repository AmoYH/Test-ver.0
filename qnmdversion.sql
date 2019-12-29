--创建表空间
create tablespace 空间名 datafile '数据文件绝对路径' size 空间大小;
--创建用户
create user 用户名 identified by 密码 default tablespace 空间名;
--查看系统中的所有用户
select * from dba_users;
--查看系统中的角色和权限
select * from dba_sys_privs;
--为用户授权
grant CREATE SESSION to 用户名;
grant CREATE TABLE to 用户名;
--创建序列（实现自增长）
create sequence sequence_name;
	--可多次使用达到按增长取值的作用
	sequence_name.nextval;
/*
主键：primary key 用于唯一的标识数据库表中的一条数据。物理主键
唯一键: unique 用于唯一的标识数据库表中的一条数据。 业务主键
外键：references 表名(字段名)一张表中的某个字段的数据，如果其来自另一种表，通常来自另一张表的不被修改的数据(主键或唯一键)
*/
eg. id-primary key
	no-unique
	deptnum number references t_dept(deptno)

/*
对表结构的修改 小结：
1,修改表名   alter table 表名 rename to 新表名;       rename 表名 to 新表名;
2,修改字段名  alter table 表名 rename column 字段名 to 新字段名;
3,修改类型    alter table 表名 modify 字段名 新类型;
4,添加字段    alter table 表名 add 字段名 类型;
5,删除字段    alter table 表名 drop column 字段名;
*/

/*
oracle中的函数： 单行函数    多行函数(聚合函数) 可套娃
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
/*
使用外键来维护多张表的连接关系的查询：称之为表的连接查询。 就套娃就完事了
 连接查询：主要分为内连接和外连接。 而外连接又分为左外连接和右外连接。
 内连接和外连接的区别：
    （1）内连接查询的是所有满足条件的那些数据；
    （2）外连接是以左/右表为主表，且必须将主表中的数据都查询出来，从表中没有与之对应的数据，则以null表示。
连接查询有自己的一套语法：select 查询的内容 from 表1 inner/left/right join 表2 on 条件    备注：条件必须有
*/
/*
rowid: 数据在表中的行的唯一标识；
rownum: 查询出来的结果（虚拟表）的行号。
*/
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
