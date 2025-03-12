select* 
from user_constraints;

select*
from user_cons_columns;

alter table dept -- ��������
add constraint dept_deptno_pk primary key(deptno);

delete dept 
where locno is null;

alter table dept -- ��������
modify (dname varchar2(20) not null);

alter table dept -- �������� ����
drop constraint sys_c007036;

alter table dept -- �������� primary key ����
drop constraint DEPT_DEPTNO_PK;


alter table dept --�⺻Ű ����(deptno)
add constraint dept_deptno_pk primary key (deptno);

alter table dept -- locno : not null ����
modify (locno varchar2(20) not null);

--��
create or replace view vdept50
as select employee_id, first_name,hire_date, salary, salary*12 as annsal
            from employees
            where  department_id = 50;
select *
from vdept50;

--view �޿��� 10000�̻��� ��� maxsal_view
-- ���, �̸�(first_name), �Ի�����, ����, �μ��ڵ�, �μ��̸�, �޿�
create or replace view maxsal_view -- ������ ���� ���̺��� ���� �߰� �ϰ� ������ (or replace)�� �־����.
as select e.employee_id, e.first_name, hire_date, job_id, d.department_id, d.department_name, salary
            from employees e join departments d on(e.department_id = d.department_id)
            where salary >= 10000;
select *
from maxsal_view;

select*
from user_indexes;

select*
from user_ind_columns;

create sequence dept_deptno_sq -- ������
    increment by 10
    start with 300
    maxvalue 1000
    nocycle
    nocache;
    
insert into dept
values (dept_deptno_sq.nextval,'QQQ','daegu', sysdate);

insert into dept
values (dept_deptno_sq.nextval,'WWW','seoul', sysdate);

rollback;

select*
from user_sequences;

drop sequence dept_deptno_sq; -- ������ ����

--�������� �̿��ؼ� ������ �߰�
create SEQUENCE dept_deptno_sq -- ������ ���� , ���� 10, �ʱⰪ ?, �ִ밪 400, 
 increment by 10
    start with 360
    maxvalue 400
    nocycle
    nocache;

create synonym empt -- ���Ǿ�
for employees;

select*
from empt;

create synonym dep -- ���Ǿ� ����
for departments;

-- �����ȣ, �̸�, �μ��ڵ�, �μ���, ��ġ�ڵ�
-- synonym �̿�
select employee_id, first_name, dep.department_name, location_id
from empt join dep on(empt.department_id = dep.department_id);

select*
from system_privilege_map;

select rownum, e.*
from (select *
        from empt 
        order by salary desc) e 
where rownum <=3;


