--������ռ�
create tablespace zx datafile 'D:/ww/zx.dbf' size 10m;
--�����û�
create user zhengxin identified by zhengxin default tablespace zx;
--�鿴ϵͳ�е������û�
select * from dba_users;
--�鿴ϵͳ�еĽ�ɫ��Ȩ��
select * from dba_sys_privs;
--Ϊ�û���Ȩ
grant CREATE SESSION to zhengxin;
grant CREATE TABLE to zhengxin;
--���Ϊ�û���Ȩ����Ҫһ��Ȩ��һ��Ȩ�޵ĸ��衣
--����ͨ�������ɫ�ķ�ʽ
grant dba to zhengxin;
--����ѧ����
create table student(
stuno number(4) primary key,
name varchar2(15),
sex char(2),
javascore number(4,2),
cscore number(4,2),
province varchar2(10),
city varchar2(10),
birthday date);
--��ѯ��ǰϵͳ�е�����
--dual: ����oracle�е�һ�����
select sysdate from dual; --��Ӧ�����ڸ�ʽ�ǣ���-��-��
select to_char(sysdate,'yyyy-mm-dd') from dual;--MM��mmһ��
--ע������Ժ����ѯ����oracleϵͳ�е����ݣ���ô��ʹ�����
select 5 + 3 from dual;
/*
��ѯ������﷨��
select ...  Ҫ��ѯ������
from ...  Ҫ��ѯ�������������ű�
[where ...] ���������ǶԲ�ѯ���ݵ�һ���޶�����һ��ɸѡ�Ĺ���
*/
--����в������� ������﷨�� insert into ����(�ֶ���1,...) values(ֵ1,...)
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(1,'л���','Ů',99,88,'����ʡ','������','28-12��-78');commit;
/*
oracle�н������ַ�����ʽ ת���� ����  ==> ʹ��to_date()
          ����  ת����  �ַ���  ==>  ʹ��to_char()
*/
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(2,'����','��',91,62.5,'������ʡ','��������',to_date('1985-12-02','yyyy-MM-dd'));commit;
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(3,'����','��',82,73,'����ʡ','������',to_date('1991-11-11','yyyy-MM-dd'));commit;
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(4,'л����','��',78,82,'������ʡ','Į����',to_date('1987-05-08','yyyy-MM-dd'));commit;
insert into student(stuno,name,sex,javascore,cscore,province,city,birthday) 
values(5,'����','Ů',90,74,'�㽭ʡ','������',to_date('1974-10-01','yyyy-MM-dd'));commit;
/*
oracle�е��������
1������������� +  -  *  /
2������������� ||
3���Ƚ�(��ϵ)������� >  >=  <  <=  =  !=       һ�����ڲ�ѯ�������С�
4���߼�������� and  or  not
5�����������
*/
--���󣺲�ѯ����ѧ���������Ϳ��Գɼ�(�ܷ�),ƽ����
select name,javascore + cscore,(javascore + cscore)/2 from student;
--���󣺲�ѯ����ѧ���������ͼ�ͥסַ(ʹ��һ����ʾ)�� Ϊ��ȡ��������ȡ����ʱ������дas��Ҳ���Բ�д����
select name ����,province || city as ��ͥסַ from student;
--���󣺲�ѯ1980���Ժ������ѧ����
--���䡢���䡣--> �Ժ��ڽ��и��Ӳ�ѯʱ�������䡣�磺��ѯ1980���Ժ������ѧ����-->���䣺 ��ѯѧ�� --> ������(�Ӷ��� --> Լ��������)
select * from student where to_char(birthday,'yyyy') >= 1980;
/*
������primary key ����Ψһ�ı�ʶ���ݿ���е�һ�����ݡ���������
�����ݿ��н������б���Ҫ����������ͨ�������������������ԡ�
�ڳ��õ����ݿ�MySQL��SQLServer�б������������Դ����������Է�ʽ��auto_increment
������oracle�У���������������޷��������ġ���ô��ν����
  oracle���ṩ��һ�����ݽṹ�����У�
  ����֮�⣺���о���Ϊ���е������ṩ����ģ�Ϊ���ṩ������ֵ�ġ�
*/
--�������ű�
create table t_dept(deptno number primary key,name varchar2(20),address varchar2(20));
--��������
create sequence seq_dept;
--��������ṩ��������ֵ��  ��������.nextval
insert into t_dept(deptno,name,address) values(seq_dept.nextval,'WEB�з���','2-204');commit;
insert into t_dept(deptno,name,address) values(seq_dept.nextval,'JAVA�з���','2-201');commit;
insert into t_dept(deptno,name,address) values(seq_dept.nextval,'���Բ�','3-304');commit;
insert into t_dept(deptno,name,address) values(seq_dept.nextval,'�⺣������','8-808');commit;
/*
������primary key ����Ψһ�ı�ʶ���ݿ���е�һ�����ݡ���������
Ψһ��: unique ����Ψһ�ı�ʶ���ݿ���е�һ�����ݡ� ҵ������
�����references ����(�ֶ���)һ�ű��е�ĳ���ֶε����ݣ������������һ�ֱ�ͨ��������һ�ű�Ĳ����޸ĵ�����(������Ψһ��)
*/
--����Ա����
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
--�޸ı������﷨���� rename ���� to �±���;�� alter table ���� rename to �±���;
rename emp to t_emp;
alter table t_emp rename to emp;
--�޸ı��е��ֶ������﷨��alter table ���� rename column ���� to ������
alter table t_emp rename column brithday to birthday;
--�޸ı��е��ֶε������﷨��alter table ���� modify �ֶ��� ������;
alter table t_emp modify province varchar2(20);
--Ϊ������ֶ��﷨��alter table ���� add �ֶ��� ����;
alter table t_emp add hiredate date;
--����Ҽ���һ���ֶ�abc��Ŀ����Ϊ����ɾ������һ��
alter table t_emp add abc date;
--ɾ�����е��ֶ��﷨��alter table ���� drop column �ֶ���;
alter table t_emp drop column abc;
/*
�Ա�ṹ���޸� С�᣺
1,�޸ı���   alter table ���� rename to �±���;       rename ���� to �±���;
2,�޸��ֶ���  alter table ���� rename column �ֶ��� to ���ֶ���;
3,�޸�����    alter table ���� modify �ֶ��� ������;
4,����ֶ�    alter table ���� add �ֶ��� ����;
5,ɾ���ֶ�    alter table ���� drop column �ֶ���;
*/
--ΪԱ�����������
--˼�����κα�Ӧ�ö�����������ϣ������ֵ�ܹ���������==> ��������
--���⣺���ű�ʹ��ͬһ�������Ƿ��У�  ���У����ǲ��ã����飺���һ�ű��ʹ��һ�����С�
create sequence seq_emp;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0018','л���',2000,8888,1000,to_date('1982-11-03','yyyy-MM-dd'),'����ʡ','������',2,to_date('2014-12-22','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0001','������',1800,9999.99,2000,to_date('1976-05-23','yyyy-MM-dd'),'����ʡ','������',1,to_date('2018-11-05','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0002','����',2300,9100,2500,to_date('1979-02-28','yyyy-MM-dd'),'����ʡ','������',1,to_date('2002-01-01','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0003','����',500,1800,300,to_date('1990-01-19','yyyy-MM-dd'),'�㽭ʡ','������',2,to_date('2015-11-11','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0004','�����Դ�',2300,5500,1800,to_date('1982-06-18','yyyy-MM-dd'),'�㽭ʡ','������',2,to_date('2008-08-04','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0005','л����',4200,8989,3000,to_date('1994-04-12','yyyy-MM-dd'),'����ʡ','ĳĳ��',3,to_date('2011-11-12','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0006','����',1000,1200,800,to_date('1985-05-12','yyyy-MM-dd'),'����ʡ','�Ͼ���',3,to_date('2012-01-04','yyyy-MM-dd'));commit;
insert into t_emp(id,empno,name,basesalary,jobsalary,gradesalary,birthday,province,city,deptnum,hiredate)
values(seq_emp.nextval,'e0007','������',9999,9999,9999,to_date('1962-01-17','yyyy-MM-dd'),'�㶫ʡ','������',4,to_date('1998-01-23','yyyy-MM-dd'));commit;
/*
oracle�еĺ����� ���к���    ���к���(�ۺϺ���) 
���к�������Ҫ����Բ�ѯ�Ľ����ÿһ�����ݽ��д���ġ� ���ں�������ѧ��������ֵ����
  ���ں�����months_between()   add_months()  extract()
  ��ѧ������ȡ���� 
    tranc(n); ֱ�ӽ�ȡС����󡣱�ע��trunc(n,m);��ȡ����ȡn��������ұ���С�����mλ��
    ceil();  ����ȡ��
    floor(); ����ȡ��
    �������룺round(n[,m]) : n��Ҫ��������������m��С���������λ
  ��ֵ������ nvl(n,m); ���nΪnull��ȥmʹ�ã���Ȼȥnʹ�á�
���к���(�ۺϺ���)����Բ�ѯ�Ľ����ĳһ���е������н��д���ġ�
  sum() ���   avg() ��ƽ����   count() ����    max() ���ֵ  min() ��Сֵ
  ���⽲��count():��Ҫ����д������count(*)   ��count(�ֶ���)
  ͻ�����⣺ʹ��count()ʵ�ּ���ʱ����������ʹ�õ����ֶ���������ֶβ����ֵΪnull���򲻼��������Խ��飬��ʹ���ֶν��м���ʱ������ʹ��������
*/
--��ѯ��������֮�������ٸ���
select months_between(sysdate,'27-2��-19') from dual;--�������д��ǰ��
--����������ʹ��ϵͳ����ѯÿ��Ա���������Լ���ְ��ʱ��(һ����ְ�˶��ٸ���)    --һ���¾���һ���µ�Ǯ
select name,months_between(sysdate,hiredate) from t_emp;
--���󣺿������е�Ա����������ְһ���¾���һ���µĹ���(��������+��λ����)
select name,months_between(sysdate,hiredate) * (basesalary + jobsalary) from t_emp;
--��ʾ��ѧ�����е�trunc()
select trunc(88.0001) from dual;
select trunc(88.467,2) from dual;
--��ʾ��ѧ�����е�ceil()��floor()
select ceil(99.0001) from dual;
select ceil(99.9999) from dual;
select floor(99.0001) from dual;
select floor(99.9999) from dual;
--���󣺿������е�Ա����������ְһ���¾���һ���µĹ���(��������+��λ����)��ע������һ���²��㡣
select name,trunc(months_between(sysdate,hiredate)) * (basesalary + jobsalary) from t_emp;
select name,floor(months_between(sysdate,hiredate)) * (basesalary + jobsalary) from t_emp;
--���󣺿������е�Ա����������ְһ���¾���һ���µĹ���(��������+��λ����)��ע������һ���°�һ�����㡣
select name,ceil(months_between(sysdate,hiredate)) * (basesalary + jobsalary) from t_emp;
--������ѧ�����е���������round()
select round(23.48) from dual;
select round(23.48,1) from dual;
--���󣺿������е�Ա����������ְһ���¾���һ���µĹ���(��������+��λ����)��ע���������롣
select name,round(months_between(sysdate,hiredate)) * (basesalary + jobsalary) from t_emp;
--���󣺲�ѯ�¸������յ���ЩԱ�������������գ�
select name,to_char(birthday,'yyyy-MM-dd') from t_emp where to_char(sysdate,'MM') + 1 = to_char(birthday,'MM')
--����SQL���õĵط��������ǰ����12�¡�
--��oracle���ṩ��һ�����ں�����add_months()
select add_months(sysdate,-1) from dual;
select name,to_char(birthday,'yyyy-MM-dd') from t_emp where to_char(add_months(sysdate,1),'MM') = to_char(birthday,'MM');
--��ʹ��to_char(),����ȡ�����գ�extract(year/month/day from ����)
select extract(year from sysdate) from dual;
select name,to_char(birthday,'yyyy-MM-dd') from t_emp
where extract(month from add_months(sysdate,1)) = extract(month from birthday);
--���󣺲�ѯ����Ա�������������ǵĹ���(��������+��λ����)��
--��ʵ����ѧ����ʱ�������һ��ֵΪnull�����������Ľ������null.  
--���⣺��ν���ڼ������ж�ֵ�Ƿ�Ϊnull,����������ٿ�ֵ���� nvl()  ��PL/SQL
select name,nvl(basesalary,0) + nvl(jobsalary,0) from t_emp;
--���󣺲�ѯԱ����ƽ������
select avg(basesalary+jobsalary) from t_emp;
--���󣺲�ѯһ���ж���Ա��
select count(*) from t_emp;
select count(id) from t_emp;
--ʹ��sum��count����ƽ������
select sum(basesalary+jobsalary) / count(id) from t_emp;
/*
��ѯ���﷨�ṹ��
select  ��ѯ������
from   Ҫ���������������(ͨ���Ǳ�)
[where]  ������ɸѡ   ����ǰɸѡ
[group by] ����
[having] ������ɸѡ   �����ɸѡ
[order by] ����   Ĭ�������� desc������  asc: ���򣬿�ʡ�ԡ�
*/
/*����1������ڶ���ѯʱ�����ű�������ͬ���Ƶ��ֶΣ�����Ҫͨ������(���߱���)��ָ�����ֶε����������ű�
    ����ֶ�ֻ������һ�ű��г��֣�����Բ�ʹ�ñ���.ȥָ�򣬵�ȻҲ����ʹ�á�
       (1)ȡ�������Բ�ѯ����ȡ��������ʹ��as��Ҳ���Բ�ʹ��;
       (2)���һ��Ϊ��ȡ�˱�������ô�ڲ�ѯ���б���ʹ�ñ�ı�����ָ����;
       (3)����ȡ������ʱ�򣬲���ʹ��as��
  ����2���ڽ��ж���ѯʱ��ͨ��Ҫ���������֮������ӹ�ϵ�������ֹ�ϵͨ��ʹ�������ά��
*/
--���󣺲�ѯ���������Լ��ò��ŵ��ܹ��ʡ�
select t_dept.name,sum(basesalary + jobsalary) from t_dept,t_emp 
where t_dept.deptno = t_emp.deptnum 
group by t_dept.name;

select d.name ��������,sum(basesalary + jobsalary) as �ܹ��� from t_dept d,t_emp e 
where d.deptno = e.deptnum 
group by d.name;
/*
ʹ�������ά�����ű�����ӹ�ϵ�Ĳ�ѯ����֮Ϊ������Ӳ�ѯ��
 ���Ӳ�ѯ����Ҫ��Ϊ�����Ӻ������ӡ� ���������ַ�Ϊ�������Ӻ��������ӡ�
 �����Ӻ������ӵ�����
    ��1�������Ӳ�ѯ��������������������Щ���ݣ�
    ��2��������������/�ұ�Ϊ�����ұ��뽫�����е����ݶ���ѯ�������ӱ���û����֮��Ӧ�����ݣ�����null��ʾ��
���Ӳ�ѯ���Լ���һ���﷨��select ��ѯ������ from ��1 inner/left/right join ��2 on ����    ��ע������������
*/
select e.name,d.name from t_emp e inner join t_dept d on e.deptnum = d.deptno;
--�ȼ�������д����
select e.name,d.name from t_emp e, t_dept d where e.deptnum = d.deptno;
--���󣺲�ѯ���еĲ������ƺͲ����е�Ա�������ơ�
select d.name,e.name from t_dept d left join t_emp e on d.deptno = e.deptnum;
select d.name,e.name from t_emp e right join t_dept d on d.deptno = e.deptnum;
--���󣺲�ѯ�ܹ��ʳ���20000����Щ���ŵ����Ƽ����ܹ��ʡ�
select d.name deptname,sum(basesalary + jobsalary) as totalsalary from t_dept d,t_emp e 
where d.deptno = e.deptnum
group by d.name;
--���Խ�����SQL��ѯ�����Ľ��������һ�������ͨ���Ӳ�ѯ�ķ�ʽʵ������
select * from(
  select d.name deptname,sum(basesalary + jobsalary) as totalsalary from t_dept d,t_emp e
  where d.deptno = e.deptnum
  group by d.name)
where totalsalary > 20000; --�ڲ�ѯ�Ľ����ɸѡ
--ͨ��having�ķ�ʽʵ�ֲ�ѯ
select d.name deptname,sum(basesalary + jobsalary) as totalsalary from t_dept d,t_emp e
where d.deptno = e.deptnum
group by d.name
having sum(basesalary + jobsalary) > 20000
order by totalsalary asc;
--���󣺲�ѯÿ�����ŵı�ţ���߹��ʺ���͹���
--�ڲ�ѯʱ�����select���оۺϺ������ǾۺϺ������ж����������group by�С�
select deptnum, max(basesalary + jobsalary), min(basesalary + jobsalary) from t_emp
group by deptnum;
--���󣺲�ѯÿ�����ŵ����ƣ���߹��ʺ���͹���
select d.name,max(basesalary + jobsalary), min(basesalary + jobsalary) from t_dept d inner join t_emp e 
on d.deptno = e.deptnum
group by d.name;
--���󣺲�ѯÿ�����ŵ���߹��ʻ���͹��ʵ���ЩԱ�������֣����ʺͼ�ͥ��ַ��
select e.name,e.basesalary + e.jobsalary, e.province || e.city,e.deptnum from t_emp e
inner join(
  select deptnum, max(basesalary + jobsalary) maxsalary, min(basesalary + jobsalary) minsalary from t_emp
  group by deptnum
) mm
on (basesalary + jobsalary = mm.maxsalary or basesalary + jobsalary = mm.minsalary) and e.deptnum = mm.deptnum;
--��ҳ��ѯ
--ͨ��ID�ǿ϶�����ʵ�ַ�ҳ�ģ���Ϊ���е������ǿ��ܱ�ɾ���ģ���ôID�Ͳ������ˡ�
select * from t_emp where id >= 1 and id <= 3;
--��ôͨ��ʲô��ʵ�ַ�ҳ�أ� ʹ��rownum  --> α��
select rownum,name from t_emp;
--����rowid
select rowid,rownum,name from t_emp;
/*
rowid: �����ڱ��е��е�Ψһ��ʶ��
rownum: ��ѯ�����Ľ������������кš�
*/
--���󣺷�ҳ��ѯ��ÿҳ��ʾ3�����ݡ�
select * from t_emp where rownum <= 3;  --��һҳ
select * from t_emp where id <= 6 and id >= 4;
select * from t_emp where rownum <= 6 and rownum >= 4;  --����
--where ���ڲ�ѯ����������ɸѡ�������ǶԲ�ѯ���յĽ������ɸѡ��
--rownumȡ����û�����⣬ȡ���޻�������⣬����Ϊwhere��ɸѡ����
--oracle�з�ҳ��ѯ��Ҫ������
--1����ѯ���е�
select * from t_emp;
--2,ȡ���޲���rownum�洢��һ���������
select r.*,rownum rowno from(select * from t_emp)r where rownum <= 6;
--3,ȡ����
select * from(select r.*,rownum rowno from(select * from t_emp)r where rownum <= 6) where rowno >= 4;
--���󣺽�һ������������ݸ��Ƶ���һ�ű���
select * from t_emp t where id = 3;
create table tt_emp as select * from t_emp;
select * from tt_emp where id = 3;
/*����
    ���ã���߲�ѯ��Ч�ʡ�
�����С���������ͼ�����̡������ȶ���oracle���ݿ�ʵ���еĶ������Ƕ��ж����Ĵ洢�ռ䡣
oracle�У��������(Լ��)����Ĭ�ϵ�Ϊ������һ����Ӧ�����������������ֺ�������Լ��������ͬ��
  ͬʱ�������ɾ�����е�����Լ��Ҳ�ἶ��ɾ����Ӧ��������
*/
--���󣺲�ѯ�����2��Ա��
select * from t_emp where id = 2;
select id,rowid from t_emp;
/*
ɾ��Լ�����﷨��
  alter table ���� drop constraint Լ����;
���Լ�����﷨��
  alter table ���� add [constraint Լ������] Լ������;
*/
--˼����ɾ�����е�����Լ����
alter table t_emp drop constraint SYS_C005574;
--����Ϊ��t_emp��id�ֶ��������Լ��
--����Լ��������Ĭ������ϵͳ�Զ����ɵġ�
alter table t_emp add primary key(id);--�Զ�����Լ������
alter table t_emp add constraint emp_id_pk primary key(id);--�Զ���Լ������
/*
���⣺��������Ϊʲô�죿 ��ͼ������2.png  ��ʲô�ط�Ӧ���������� �ڲ�ѯ�����б�Ƶ����Ϊ�������ֶΡ�
��������Ĭ�Ͼ�����������Ϊʲô�أ� ��Ϊ��������Ψһ�ԣ��ǾͿ���ͨ������ֱ�Ӳ���һ���ܾ�׼�����ݡ�
*/
--Ψһ��Լ��������Լ��һ��������Ĭ��ȥ������Ӧ��������
alter table t_emp add unique(name);
alter table t_emp drop constraint SYS_C005579;
alter table t_emp add constraint t_emp_name_unique unique(name);
alter table t_emp drop constraint t_emp_name_unique;
/*
���⣺������е�name����Ҫ�������Ψһ��Լ�������Ǿ�������name�ֶν��в��ң���ô�죿
�𣺲���ͨ��Ψһ��Լ���ķ�ʽ�Զ���������ˣ�������Ҫ����Ϊ�����ֶ�ȥ����������
��������:create index ������ on ����(�ֶ���)
ɾ������:drop index ������;
*/
create index index_emp_name on t_emp(name);
drop index index_emp_name;
--Ҫ���ڱ�t_emp�У����ֺ͵�ַ��Ψһ��ʶһ����ʦ��Ϣ��
--�ڱ�t_emp�У����ֿ�����ͬ����ַҲ������ͬ���������ֺ͵�ַ����ͬʱ��ͬ.
--��һ�ű��У�һ�����ݵ�Ψһ���ɶ���ֶ�ȷ��������ͨ�����������ķ�ʽ��ʵ�֡�  --����
alter table t_emp add constraint name_city_unique unique(name,city); 
--��ѯ����Ϊ л��� ��Ա��
select * from t_emp where name = 'л���';
--��ѯ��ַΪ ������ ��Ա��
select * from t_emp where city = '������';
--��ѯ����Ϊ л��� �ҵ�ַ�� ������ ��Ա��
select * from t_emp where name = 'л���' and city = '������';
--������ͨ������������������ġ�  Ҳ���Բ�ȥ����Լ����Ҳ���Դ�������������
alter table t_emp drop constraint name_city_unique;
create index index_emp_name_city on t_emp(name,city);--�˽�
drop index index_emp_name_city;
--���󣺲�ѯ1982���Ա��
select * from t_emp where to_char(birthday,'yyyy') = '1982';
--�������Ӧ���л�Ƶ����ͨ�����յ���ݲ���Ա������ô��ʱ�������Ա���������������
create index index_emp_birthday on t_emp(birthday);
select * from t_emp where to_char(birthday,'yyyy') = '1982';--�������������� 
select * from t_emp where birthday = '03-11��-82';  --������������
drop index index_emp_birthday;
--Ҫ����where��� to_char(birthday,'yyyy')��������������Ҫ������������
create index index_emp_birthday_year on t_emp(to_char(birthday,'yyyy'));
select * from t_emp where to_char(birthday,'yyyy') = '1982';--������������ 
select * from t_emp where birthday = '03-11��-82';  --��������������
--����Ϊ���ּ�����
create index index_emp_name on t_emp(name);
--���󣺲�ѯ����������Ա��
select * from t_emp where name like '��%';--ģ����ѯ �ᾭ������
--�����޸ı����6��Ա���ĳ���Ϊ  ������
update t_emp set city = '������' where id = 6;--�ᾭ������
/*
��ͼ����ͼ�ͱ����С�����һ��������oracle���ݿ��е�һ��ʵ����Ҳ�ܹ�������С�����һ��������ͼ���д�����ɾ����
��ͼ�����ã������ڱ�������Ҫ��Ƶ��ʹ�õ�������ȡ���������ⲿ����ֱ��ʹ�á�
��ͼ���Ĺ�ϵ�� ���ݴ洢�ڱ��У���ͼ�ǻ��ڱ���ͼ�������ڹ���ӱ��в�ѯ�����Ľ����
ΪʲôҪ��ͼ��
  ������һ�ҹ�˾��һ����ҵ����ϵͳ�����ڹ�����ҵ���ճ�������ҵ����һ���ǳ���Ҫ�����ڰ�����Ҫ�Ľ�ɫ�������ܼࡣ
    ��ÿ��Ƶ��ʹ�ø�ϵͳ����ѯԱ����н�������
    Ա������Ϣ�ڴ���һ�ű��У�t_emp: id,name,sex,birthday,ismarry,hiredate,address,phone,basesalary��jobsalary��gradesalary,....
    ���ǲ���ֻ����Ա�������ֺ͹��ʡ�
    Ŀǰ�Ľ��������ֱ�Ӵӱ��в�ѯ��select name,basesalary,jobsalary,gradesalary from t_emp;
    ̫��ʱ����ϣ������ѯ�������ܹ���������ʹ����ͼ��
*/
create table t_emp1(id number(4) primary key,name varchar2(20),sex char(2),age number(3),
province varchar2(20),city varchar2(20),basesalary number(7,2),jobsalary number(7,2));
create sequence seq_emp1;
insert into t_emp1(id,name,sex,age,province,city,basesalary,jobsalary)
values(seq_emp1.nextval,'Lucy','Ů',23,'����ʡ','������',6231,8232);commit;
insert into t_emp1(id,name,sex,age,province,city,basesalary,jobsalary)
values(seq_emp1.nextval,'Lily','Ů',21,'����ʡ','�Ϸ���',2011,1200);commit;
insert into t_emp1(id,name,sex,age,province,city,basesalary,jobsalary)
values(seq_emp1.nextval,'LiLei','��',25,'����ʡ','�Ͼ���',5000,7210);commit;
insert into t_emp1(id,name,sex,age,province,city,basesalary,jobsalary)
values(seq_emp1.nextval,'HanMeimei','Ů',23,'�㽭ʡ','������',5000,1200);commit;
--���󣺲�ѯԱ���ı�ţ����ֺ͹���
select id,name,basesalary,jobsalary from t_emp1;
--ϣ��������ѯ������������һ�ֽṹ�������������Ժ�ֱ��ʹ�á�
--���ֽṹ  ����  ��ͼ��
--������ͼ���﷨�� create view ��ͼ�� as ��ѯ���;
--ɾ����ͼ���﷨�� drop view ��ͼ��;
create view v_emp as select id,name,basesalary,jobsalary from t_emp1;
--1������ͼ�в�������  �ܹ����������ݻᷴӳ�����С�
insert into v_emp(id,name,basesalary,jobsalary)values(10,'Pony',8210,9999);commit;
--2����ͼ��ɾ������ �ܹ����������ݻᷴӳ�����С�
delete from v_emp where id = 10;commit;
--3���޸����� �ܹ����������ݻᷴӳ�����С�
update v_emp set name = 'Flex' where id = 4;commit;
--4����ѯ
select * from v_emp;
--���ϣ��ٶ���ͼ�������һ������CRUD(��ɾ�Ĳ�)�������ڶ���ͼ�ĳɹ��������ܹ���ӳ�����С�
--�������������޸ı��е����ݣ����Ƿ�Ҳ�ܹ���������Ӧ����ͼ�С�
--�����е�����Ա���Ļ���������500.  ���е����ݸ���Ҳ�ᷴӳ����ͼ�С�
update t_emp1 set basesalary = basesalary + 500; commit;
--���⣺�����ͼ�е����Ǳ��еļ����С�
create view v_emp1 as select id,name,basesalary+jobsalary salary from t_emp1;
update v_emp1 set salary = 4000 where id = 2;--�޷���ӳ������
update t_emp1 set jobsalary = 2000 where id = 2;--���Է�ӳ����ͼ��
--ɾ����ͼ
drop view v_emp1;
--������ͼ��ʱ��Ϊ��ѯ����ȡ����
create view v_emp1 as select id,name empname,basesalary+jobsalary salary,province||city address from t_emp1;
--�޸���ͼ�б��Ϊ4��Ա��������Ϊ��Lucs
update v_emp1 set empname = 'Lucs' where id = 4; --����ȡ����������ʵ���޸Ĳ��໥��ӳ
--�޸���ͼ�б��Ϊ2��Ա���ĵ�ַΪ������ʡ�ߺ���
update v_emp1 set address = '����ʡ�ߺ���' where id = 2;--�����У�����ͼ���޷��޸�
/*
С�᣺
  1����ͼ���Ĺ�ϵ
  2����ͼ������ɾ�Ĳ����
  3�����е����ݵ��޸ı�Ȼ�ᷴӳ����ͼ��
  4����ͼ�е����ݲ���һ���ܸģ�ֻҪ�ܱ��޸ı�Ȼ�ᷴӳ�����С�
*/
--���ϣ����������ͼֻ�ܹ��鿴���������޸� ��������ͼ�����ǳ�֮Ϊ ֻ����ͼ
create view v_emp2 as select id,name,basesalary,jobsalary from t_emp1 with read only;  --ֻ����ͼ
--����ͼv_emp2�н����Ϊ2��Ա���Ļ�������+1000
update v_emp2 set basesalary = 3011 where id = 2;
--������ͼ����ͼ�е������ǻ������ʵ���5000����ЩԱ������Ϣ
create view v_emp3 as select id,name,basesalary,jobsalary from t_emp1 where basesalary < 5000;
--�����޸���ͼ�е�ĳ�����ݣ����������ʸĳ�5000.
update v_emp3 set basesalary = 4999 where id = 4;commit;
--��Ȼ��������ͼv_emp3�в�ѯ��������Ӧ�����������ġ�������޸Ĵ����ݣ�ҲӦ���ڸ�������Χ�ڡ�
drop view v_emp3;
create view v_emp3 as select id,name,basesalary,jobsalary from t_emp1 where basesalary < 5000 with check option;
/*
PL/SQL:
  SQL: �ṹ����ѯ����
    ��Ҫʹ�õ��У�DDL:create��drop��alter; DML: insert,delete,update,select��TCL:commit��rollback
  PL: Procedural Language  ���̻����ԡ�
PL/SQL: ��ʵ������SQL����֮�Ͻ�������չ����չ�˹��̻����ԡ�
  ���̻�����ָ����ʲô���������ͺñ�c�����еĺ����еĴ��룬java�з����еĴ���Ƭ��
ѧϰ�κ�һ�����ԣ���ʼѧϰ�����﷨��helloword���������������͡����̿������
PL/SQL�е��������ͣ���֧��oracle����������������ͣ�number,varchar2,char,date�ȡ������ñ��е��ֶε����� %type
PL/SQL�и�ֵ���� :=   �ڶ�̬��ֵ into
PL/SQL�Ļ����ṹ��
  declare  --��ѡ���������
    ������ ���� [:= ֵ];     
  begin   --����  
    �����
  end;   --����
*/
begin
  dbms_output.put_line('Hello,PL/SQL');
end;
--������������name��age��Ȼ��Ϊname��age��ֵ�����
declare
  name varchar2(20) ;
  age number(3);
begin
  name:= '��С�';
  age := 39;
  dbms_output.put_line('������' || name ||',���䣺'||age);
end;
--��ѯ���Ϊ4��Ա�������ֺ�����,�������DBMS��
select name,age from t_emp1 where id = 4;
declare
 empno t_emp1.id%type := 4;
 name t_emp1.name%type;
 empage t_emp1.age%type;
begin
  select name,age into name,empage from t_emp1 where id = empno;
  dbms_output.put_line('������' || name ||',���䣺'||empage);
end;
/*
PL/SQL�ж����������ֵ
  ��ֵͨ�����ַ�ʽ��  ��:=   ��into
  ����������﷨��  ������  ����
  ���ͣ���oracle��֧�ֵ���������  ��%type  ��%rowtype  ��record
*/
--���󣺲�ѯԱ�����еı��Ϊ3��Ա����������Ϣ���������
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
  ��������PL/SQL����У����Ƿ���һ�ű�������кܶ��ֶΣ�������30������
��ô��PL�о�Ҫ����30�������������ݡ���ʹû�в�ѯ30�У�ֻ��ѯ20�С���ʵ��ѯ����Ҳ�Ƚ϶࣬
�Ǿͻ��̫���ʱ���ڶ�������ϡ���ʱ��oracle�ṩ����һ�����ͽṹ������������⡣
���ͣ�%rowtype
  ��⣺���е�һ������==>һ����¼==>һ��ʵ��==>һ������
���������ĽǶȿ������е�һ�о���һ������ %rowtype���ڱ������е�һ���ж������͡�
*/
declare
  v_emp t_emp1%rowtype;--��ʱ��������Ͷ�Ӧ�ű��е�һ��
begin
  select id,name,sex,age,province,city,basesalary,jobsalary
  into v_emp
  --into v_emp.id,v_emp.name,v_emp.sex,v_emp.age,v_emp.province,v_emp.city,v_emp.basesalary,v_emp.jobsalary
  from t_emp1
  where id = 3;
  dbms_output.put_line(v_emp.name || ',' || v_emp.jobsalary);
end;

-- ���Ǹ�˵��%rowtype����������һ���������ͣ�������������������һ�ű��е��ж������͡�
-- ��������ǲ�ѯ���������Զ��ű��еĶ���С����ǿ���Ϊÿ���ж���������ڽ�ֵ���磺
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
-- ���ϵ�PL/SQL����ж���ı���������Ҳ���Զ�����а�װ��һ�����͡�
declare
 type empdept is record(
  v_empname t_emp.name%type,
  v_empage t_emp.age%type,
  v_deptname t_dept.name%type
 );
 v_empdept empdept;
begin
  select t_emp.name,t_emp.age,t_dept.name
  --into v_empdept  --��ѯ����Ҫ��empdept�����˳�򱣳�һ�£������һ�£���Ҫ�ֶ�д
  into v_empdept.v_empname,v_empdept.v_empage,v_empdept.v_deptname
  from t_emp,t_dept
  where t_emp.deptid = t_dept.id and t_emp.id = 2;
end;

--����ʾ��
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
    dbms_output.put_line('�����Ҳ�����');
  when too_many_rows then
    dbms_output.put_line('��ѯ������̫�࣡');
  when others then
    dbms_output.put_line('��������');
end;
/*
�����쳣���ͣ�
no_data_found: ����δ�ҵ�
others�������쳣  ���൱��java�е�Exception
*/
set serveroutput on;--����������
/*
PL/SQL�е����̿�����䣺
  ��Ҫ��Ϊ���֣���֧(ѡ��)�ṹ��ѭ���ṹ
  ��֧�ṹ��
    ��if�ṹ
      ��-�ټ�if�ṹ
        if ���� then
          ����;
        end if;
      ��-��if-else�ṹ
        if ���� then
          ����
        else
          ����
        end if;
      ��-�۶���if�ṹ
        if ���� then
          ����
        elsif ���� then     --elsif�����ж��
          ����
        else               --else�����һ����
          ����
        end if;
    ��case�ṹ    --����ֵ�ж�
    �﷨һ��
       case ����
        when ֵ then   --when���Գ��ֶ��
          ����
        ...
        else          --���һ��
          ����
       end case;
     �﷨����
       case
         when ���� = ֵ then
           ����
         ...
         else
          ����
       end case;
  ѭ���ṹ��
    ��while
      while ���� loop
        ����
      end loop;
    ��do-while
       loop
        ����/ѭ����
        exit when ����;
       end loop;
    ��for
      for ���� in ���� loop
        ����/ѭ����
      end loop;
*/
--������if�ṹ 
--���󣺲�ѯָ��Ա���Ļ������ʣ��������6000������Լ����ȥ�Ի���һ�Ρ�
declare
  v_basesalary t_emp1.basesalary%type;
begin
  select basesalary into v_basesalary from t_emp1 where id = 1;
  if v_basesalary > 6000 then
    dbms_output.put_line('���ϴ�����ȥ�Ի���һ��');
  end if;
end;
--���󣺲�ѯָ��Ա���Ļ������ʣ��������6000������Լ����ȥ�Ի���һ��;��Ȼ�Լ��·��ݡ�
declare
  v_basesalary t_emp1.basesalary%type;
begin
  select basesalary into v_basesalary from t_emp1 where id = 2;
  if v_basesalary > 6000 then
    dbms_output.put_line('���ϴ�����ȥ�Ի���һ��');
  else
    dbms_output.put_line('�Լ��·��ݣ�');
  end if;
end;
--���󣺲�ѯָ��Ա���Ļ������ʣ��������6000������Լ����ȥ�Ի���һ��;�������4000�Լ��¹��ӣ���Ȼ�ڼҿ���ͷ��
declare
  v_basesalary t_emp1.basesalary%type;
begin
  select basesalary into v_basesalary from t_emp1 where id = 2;
  if v_basesalary > 6000 then
    dbms_output.put_line('���ϴ�����ȥ�Ի���һ��');
  elsif v_basesalary > 4000 then
    dbms_output.put_line('�Լ��·��ݣ�');
  else
    dbms_output.put_line('�Լ��ڼҿ���ͷ��');
  end if;
end;
--���󣺲�ѯָ��Ա�����������Ա�����Ա���'��'�����'xxx�ǹ���'�������'Ů'�������'xxx��ǧ��'����Ȼ���'�������'
declare
  v_name t_emp1.name%type;
  v_sex t_emp1.sex%type;
begin
  select name,sex into v_name,v_sex from t_emp1 where id = 2;
  if v_sex = '��' then
    dbms_output.put_line(v_name||'�ǹ��ӡ�');
  elsif v_sex = 'Ů' then
    dbms_output.put_line(v_name||'��ǧ��');
  else
    dbms_output.put_line(v_name||'�ǵ��������');
  end if;
end;
--�����ıȽ�����ʵ�ֵ�ֵ�Ƚϣ�Ҳ����ʹ��case�ṹ
--case�﷨һ��
declare
  v_name t_emp1.name%type;
  v_sex t_emp1.sex%type;
  v_msg varchar2(10);
begin
  select name,sex into v_name,v_sex from t_emp1 where id = 2;
  case v_sex
    when '��' then
      v_msg := '����';
      --dbms_output.put_line(v_name||'�ǹ���!��');   
    when 'Ů' then
      v_msg := 'ǧ��';
      --dbms_output.put_line(v_name||'��ǧ��!��');
    else
      v_msg := '����������';
      --dbms_output.put_line(v_name||'�ǵ���������!��');
  end case;
  dbms_output.put_line(v_name||'��'||v_msg);
end;
--case�﷨����
declare
  v_name t_emp1.name%type;
  v_sex t_emp1.sex%type;
  v_msg varchar2(10);
begin
  select name,sex into v_name,v_sex from t_emp1 where id = 2;
  case 
    when v_sex = '��' then
      v_msg := '����'; 
    when v_sex = 'Ů' then
      v_msg := 'ǧ��';
    else
      v_msg := '����������';
  end case;
  dbms_output.put_line(v_name||'��'||v_msg);
end;
--ѭ���ṹ
--whileѭ��
--�������8�䣺��С贰����ա�
declare
  v_count number(2) := 1;
begin
  while v_count <= 8 loop
    dbms_output.put_line('��С贰����ա�');
    v_count := v_count + 1;
  end loop;
end;
--����1��100��������
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
--do-whileѭ��
--�������10�䣺���������ˡ�
declare
  v_count number(2) := 1;
begin
  loop
    dbms_output.put_line('���������ˡ�');
    v_count := v_count + 1;
    exit when v_count > 10;
  end loop;
end;
--forѭ��
--�������6��'����Բ���Ҳ�ǲ���'
declare
  --v_count number(2); --��for�б������Բ��ö��塣
begin
  for v_count in 1..6 loop
    dbms_output.put_line('����Բ���Ҳ�ǲ���');
  end loop;
end;
--�α�  �α�����ã������ѯ�Ľ�������д����ѯ�����ݡ�
--���󣺲�ѯ���е�Ա����Ϣ������ÿ��Ա����Ϣ�����DBMS�С�
select * from t_emp1;
/*
Ҫ���д����ѯ�����ݣ��뵽ʹ���αꡣ
�α��ʹ�ò��裺
�ٶ����α꣺cursor �α�����[(�����б�)] is ��ѯ���; �磺cursor emp_sor is select * from t_emp;
�ڴ��α꣺open �α�����; �磺open emp_sor;
��ȡֵ��fetch �α����� into ����; --��ζ��ǰ��Ҫ����ñ����������α�ָ�����һ�����ݡ��磺fetch emp_sor into ����;
  --��ע1��һ����ʼȡֵ�����¶�һ��,һ��fetch��ֻ��ȡһ�����ݡ�
  --��ע2��%found ��ʾ�α�ȡ��ֵ ��  %notfound ��ʾ�α�û��ȡ��ֵ
�ܹر��α꣺close �α�����; �磺close emp_sor;
*/
declare
  cursor emp_sor is select * from t_emp1;--�����α�
  v_emp t_emp1%rowtype;--����һ�����������ڽ����α굱ǰָ�����һ�����ݵ�ֵ
begin
  open emp_sor;  --���α�
  fetch emp_sor into v_emp;  --ȡֵ
  while emp_sor%found loop
    dbms_output.put_line(v_emp.id||','||v_emp.name||','||v_emp.age);
    fetch emp_sor into v_emp;
  end loop;
  close emp_sor;  --�ر��α�
end;
--ʹ��do-whileѭ��  loopѭ��
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
--forѭ��
/*
ʹ��for�������α꣬����ĵط��У�1������Ҫ�ֶ����αꣻ2������Ҫ�ֶ��ر��αꣻ
3����for��ֱ��ȡֵ������fetch��4�����ڽ����α���ָ��������ݵı��������ȶ��塣
*/
declare
 cursor emp_sor is select * from t_emp1;
begin
  for v_emp in emp_sor loop --�����Ż��Զ����α�
   dbms_output.put_line(v_emp.id||'-'||v_emp.name||'-'||v_emp.age);
  end loop;
end;
--����д������ʵʹ�õ��α꣺��ʽ�α�
begin
  for v_emp in (select * from t_emp1) loop 
   dbms_output.put_line(v_emp.id||'--'||v_emp.name||'--'||v_emp.age);
  end loop;
end;
--�α�ķ��ࣺ��ʽ�αꡢ��ʽ�αꡣ
--���󣺲�ѯʡ����xx����ЩԱ������Ϣ���������DBMS��
--�α��еĲ����ڶ���ʱ�����Ͳ��ܼӾ���
declare
  cursor emp_sor(pro varchar2) is select * from t_emp1 where province = pro;
  v_emp t_emp1%rowtype;
begin
  open emp_sor('�㽭ʡ');
  loop
    fetch emp_sor into v_emp;
    exit when emp_sor%notfound;
    dbms_output.put_line(v_emp.id||','||v_emp.name||','||v_emp.province);
  end loop;
  close emp_sor;
end;
--����ʹ���α�������е�Ա����Ϣ������ǽ���ʡ�Ļ�������+1000���㽭ʡ+500  ����ʡ+300  ������100
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
      when '����ʡ' then
        add_basesalary := 1000;
        --update t_emp set basesalary = basesalary + 1000 where id = v_emp.id;
      when '�㽭ʡ' then
        add_basesalary := 500;
        --update t_emp set basesalary = basesalary + 500 where id = v_emp.id;
      when '����ʡ' then
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
ǰ���PL/SQL�����ԡ��顱����ʽ�������ݡ�PL/SQL�Ļ����ṹ�����Ǿͳ�֮Ϊ���顱��
  ��򵥵Ľṹ��begin..end;   ��չһ�㣺declare..begin..exception..end;
���⣺�鶼���ڵ�ʱ������¡�����һ��ִ��һ�Ρ�ϣ���ܽ������Ĵ�����з�װ��Ȼ��ͱ���һ�Ρ������˶�ε���ִ�С�
  ��ν����==>ʹ�ô洢���̻��ߺ�����
--���̣�����ǰ��ѧ���ı����С���������ͼ��һ������oracle�е�һ��ʵ����
  ���֣�oracleʵ���Ĵ�������ͨ��create table|sequence|index|view������
            ͨ��drop table|sequence|index|view��ɾ���ġ�
  ���ԣ������ܱ�ͨ��⣺���̵Ĵ�����ɾ�������������Ƶġ�
���̴������﷨�ǣ�
  create procedure ������[(�����б�)]
  is|as   --�������� ����
  begin   --�����   ����
  end;    --����    ����
ע�����������Ͳ��ܼӾ��ȡ�
����ɾ�����﷨�ǣ�drop procedure ������;
*/
create or replace procedure showMe
as
begin
  dbms_output.put_line('Hi,MM!');
end;
drop procedure showMe;
--���̵ĵ���
begin
  showMe;
  showMe;
end;
--����һ�����̣���ʾһ��is|as�������
create or replace procedure sayHello
is
  v_name varchar2(10) := '��ΰ��';
begin
  dbms_output.put_line('��,'||v_name);
end;
begin
  sayHello;
end;
--��ʾ������һ�����̣�����̴���ֵ
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
--���󣺴���һ���洢���̣����벿�ŵı�ţ����֡���ַ�������Ŵ������޸Ķ�Ӧ�����ݣ��������������롣
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
  updateDept(2,'�ƶ�����','2-321');
end;
/*
 ����: ���Ƕ�һ��PL/SQL��ķ�װ��Ŀ���ǿɹ��ⲿ(�Ժ�ĳ���)���á�
 ����(�洢)���̵��﷨��
  create [or replace] procedure ������[(�����б�)] 
  is    --���������������
  begin
  end;
*/
--�����ǣ�����֪������ͨ�������б�����̴���ֵ����ô�������������߻ش�ֵ��
--���Ľ�������ǣ�ͨ������������
--�ɼ����ڹ����У��������Է�Ϊ���֣���������������������ң���������ʹ��������������ж����
--���󣺴���һ�����̣�����Ա���ı�ţ���ѯԱ�������������䡣
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
--ʹ�ô�������
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
�����ͱ���ͼ�����������С����̵�һ��������oralce�е�ʵ����
������
 �ع������Ѿ�ѧ���ĺ��������к������ۺϺ���
  ���к��������ں�������ѧ��������ֵ������
  �ۺϺ�����count  sum  max  min  avg��
 ����һ�����Ϻ��������ʹ�õģ� ����SQL�����ʹ�õġ�
    �磺select max(age) from t_emp;
�Զ��庯����
  create [or replace] function ������[(�����б�)]
  return  --���巵������ ����
  is    --�������
  begin  --��Ŀ�ʼ
  end;   --��Ľ���
ɾ��������drop function ������;
ע���������͹�����������ͬ��
*/
--���󣺲�ѯ���Ϊx��Ա���Ľϸ߹��ʵ��ǲ��ֹ��ʡ�
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
  dbms_output.put_line('�ϸߵ��ǲ��ֹ����ǣ�' || v_max);
end;
--���ϴ��룬ֻ��һ������ѣ����ܱ��ⲿ���ã����Ҫ�����ã���ô��ʱ�������������з�װ��
--��װ�����̡�������
--���֣��ÿ�ᱻSQL�����ұ�����һ������ֵ ����ʱ�뵽ʹ�ú�����
create or replace function getMaxSalary(eid number)
return number     --���ܼӷֺ�
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
--�����ĵ��ã�����������SQL���ʽ�е��ã�Ҳ����ֱ�ӵ��á����ƹ��̵ĵ���
create or replace function sayHello1(name varchar2)
return varchar2
as
begin
  return 'Hello,'||name;
end;
select sayHello1(name) from t_emp;
select sayHello1('ΰ��') from dual;
declare
  v_info varchar2(20);
begin
  v_info := sayHello1('Boly');
  dbms_output.put_line(v_info);
end;
/*
��������Ҳ�Ǻͱ���ͼ��һ����Ҳ��oracle���ݿ��е�һ������(ʵ��)��
  create table ����         drop table ����
  create index ������       drop index ������
  create sequence ������    drop sequence ������
  create view ��ͼ��        drop view ��ͼ��
  create procedure ������   drop procedure ������
  create function ������    drop function ������
�������������ض�����Ϊ�´������¼��������Ĳ�����
 �ɼ�������������Ҫ����Ա�ֶ����õģ��������¼������ġ�
  ������⣺����һ�ű��û���t_user. ����(����Աt_admin)���Զ��û�������ɾ�Ĳ������
�������������﷨��
  �������ļ򵥷��ࣺ ǰ�ô�����before�����ô�����after
  create [or replace] trigger ��������
  ������������
  declare     --����ʹ��is|as    ����ʡ��
  begin
  end;
ɾ�����������﷨��drop trigger ��������;
*/
create table t_user(id number(4) primary key,name varchar2(20),age number(3));
create table t_log(id number(4) primary key,log_action varchar2(30),log_date date,log_user varchar2(20));
create sequence seq_log;
--����������
--��ȷ����ɾ�����е�����֮��Ҫ��ɾ��������¼��������μ�¼������һ�ű��в���һ����¼��Ϣ��
create or replace trigger user_trigger
after delete or update or insert on t_user
declare
  v_action varchar2(20) := '��������';
begin
  if deleting then
    v_action := 'ɾ������';
  elsif inserting then
    v_action := '�������';
  elsif updating then
    v_action := '�޸Ĳ���';
  end if;
  insert into t_log(id,log_action,log_date,log_user) values(seq_log.nextval,v_action,sysdate,'Lucy');
end;
delete from t_user where id = 2;commit;
update t_user set age = 20 where id = 3;commit;
insert into t_user(id,name,age) values(9,'�°���СȮһ��',24);commit;
--���ϲ���
--��ѯ������(����Ա���û�)�����֡����˴���t_empԱ������Ϊ����Ա����tt_emp��Ϊ�û�������tt_emp�ɲ�����297�д��룩��
select name from t_emp;--��ѯ����Ա����(��Ա����������Ա��)
alter table tt_emp rename column name to username;
--�˴����ֶ�ɾ�����޸ļ���tt_emp�е����ݣ��Է��������ѯʹ��
select username from tt_emp;--��ѯ�û�����
select name,username from t_emp,tt_emp;--������Ӳ�ѯ
--���϶����ܽ������ģ���ô��ʱ����Ҫ�����ζ�����ѯ�Ľ�����ӡ� <���ϲ���>
--�ظ�����ֻ����һ��
select name ���� from t_emp union select username from tt_emp;
--�ظ����ݳ��ֶ��
select name ���� from t_emp union all select username from tt_emp;
--��ѯ�ظ�����
select name ���� from t_emp intersect select username from tt_emp;
--ǰ��Ľ����ȥ���ظ�����
select name ���� from t_emp minus select username from tt_emp;
/*
ת��������
  1���������ַ���֮�䣺 to_char()  to_date()
  2���������ַ���֮�䣺tO_char()  to_number()
*/
--�����t_emp1,���л�������4000�͸�λ����4999.5�� Ҫ���ѯ���������ݸ�ʽΪ ��8,999.50
select 4000 + 4999.5 ���� from dual;
select to_char(4000 + 4999.5,'L0,000.00') from dual;--L ����ҵĻ��Ҹ�ʽ
select to_char(4000 + 4999.5,'$0,000.00') from dual;--$ ��Ԫ�Ļ��Ҹ�ʽ
create table t_emp2(id number(4) primary key,name varchar2(20),base varchar2(20),job varchar2(20));
insert into t_emp2(id,name,base,job) values(1,'lucy','$4,000','$4,999.5');commit;
select name,base + job from t_emp2;--�ַ������޷����мӷ������
select name,to_number(base,'$0,000.00') + to_number(job,'$0,000.00') from t_emp2;
select name,to_char(to_number(base,'$0,000.00') + to_number(job,'$0,000.00'),'$0,000.00') from t_emp2;
--ת��ʱ�����ҵ����ָ�ʽֻ����0����9.
select name,to_number(base,'$9,999.99') + to_number(job,'$0,909.00') from t_emp2;