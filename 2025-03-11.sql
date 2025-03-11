-- from ���� ���
SELECT e.employee_id, e.first_name, e.department_id, e.salary, b.salavg
FROM employees e
JOIN (
    SELECT department_id, ROUND(AVG(salary), 2) AS salavg
    FROM employees
    GROUP BY department_id
) b ON e.department_id = b.department_id
WHERE e.salary = b.salavg;


--1. ������̺�, �޿��� 6500 �̻� 13000����, �̸�(last_name)�� 'H'�� �����ϴ�
--����� �����ȣ, �̸�(last_name), �޿�, �μ���ȣ ���
select employee_id, last_name, salary, department_id
from employees
where salary between 6500 and 13000 
        and last_name like 'H%';

-- 2. 50��, 60�� �μ� ���� ��� �޿��� 4000���� ���� ����� 
--  �����ȣ, �̸�, ����, �޿�, �μ���ȣ ���
select employee_id, first_name, job_id, department_id
from employees
where department_id =50 or department_id = 60 and salary > 4000;

-- 3.�����ȣ, �̸�, �޿�, �λ�� �޿�
--�λ�� �޿� => �޿��� 3000���ϸ� 30%
--           => �޿��� 9000���ϸ� 20%
--           => �޿��� 14000���ϸ� 10%
--           ������ ����

SELECT employee_id, first_name, salary,
       CASE
           WHEN salary <= 3000 THEN salary * 1.30  -- �޿��� 3000 ������ ��� 30% �λ�
           WHEN salary <= 9000 THEN salary * 1.20  -- �޿��� 9000 ������ ��� 20% �λ�
           WHEN salary <= 14000 THEN salary * 1.10  -- �޿��� 14000 ������ ��� 10% �λ�
           ELSE salary  -- �� ���� ��� �޿� ����
       END AS increased_salary
FROM employees;


            
--4. �̸�, �μ���ȣ, �μ��̸�, ���ø��� ��� -- ǥ������
select e.first_name, e.department_id, d.department_name,l.city
from employees e left join departments d on(e.department_id = d.department_id)
                    left join locations l on(d.location_id = l.location_id);

--5. �������� �̿��ؼ� 'sales' �μ����� ���ϴ� ������� 
--�����ȣ, �̸�, ������ ���
select employee_id, first_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name ='Sales');

--6. 2005�� ������ �Ի��� ����� �� ������ 'ST_CLECK'�� ����� ������ ǥ��
select employee_id, job_id
from employees
where hire_date < to_date('2005-01-01','yyyy-mm-dd') and job_id = 'ST_CLERK';

--7. �߰� ������ �޴� ����� �̸�, ����, �޿�, �߰������� ǥ��
--�޿��� ���Ͽ� �������� ����
select first_name, job_id, salary, commission_pct
from employees
order by 3 desc;

--8. �μ��� �޿� ���(����), �հ� ǥ��
--�μ��ڵ�, �޿����, �޿��հ� ���
--�޿��հ谡 50000�̻��� �ڷḸ ���
select department_id, round(avg(salary)), sum(salary)
from employees
group by department_id
having sum(salary) >= 50000;

--������ ���۾�
create table dept(
    deptno  number(4),
    dname   varchar2(20),
    loc     varchar2(20),
    make_date   date
);

insert into dept
values(10, 'sales', 'daegu', sysdate);

insert into dept
values(20, 'according','seoul', null);

insert into dept
values(30,'it','deagu','2025/02/05');

insert into dept
values(40,'programmer',null,'2024/12/31');

insert into dept
    select department_id, department_name, location_id, sysdate
    from departments;
    
commit;
delete dept;

rollback;
delete dept
where deptno = 100;

delete dept
where deptno = (select department_id
                from employees
                where employee_id = 150);
                
ROLLBACK;
delete departments
where department_id = 50;

delete employees
where department_id = 30;

update dept 
set deptno = 200
where deptno = 10;
rollback;
update dept
set dname = '777'
where dname = 'it';

update employees -- �Էµ� ���� ����
set department_id = 30
where department_id = 20; -- ���� �־������.

select * from dept; -- ���̺� �� ������ ����
delete dept
where deptno = 200; -- ���� �־������.

commit;
delete dept
where deptno = 20;

rollback;

delete dept
where deptno = 20;

savepoint a;

delete dept
where deptno = 30;

rollback to savepoint a; 
commit;

select *
from user_catalog;

create table emp
as
    select * 
    from employees
    where employee_id < 150;

alter table dept -- �߰�
add(bigo    varchar2(10));

alter table dept -- ���̺� ���� ����
modify (bigo varchar2(20));

alter table dept -- bigo ����
drop column bigo;

drop table dept;
rollback;

rename dept2 to dept;
alter table dept
rename COLUMN loc to locno;

comment on table dept
is '�ӽ� ���̺�';
select * 
from user_tab_comments;
comment on column dept.locno
is '�μ��� ��ġ�� ����';
select * 
from user_col_comments;

-------------------p.324 ���� 1��
create table EMP_HW(
    empno  number(4),
    dname   varchar2(10),
    job     varchar2(9),
    MGR     number(4),
    hiredate    date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
);
-- 2��
alter table  EMP_HW 
add(bigo    varchar2(20));
--3��
alter table EMP_HW
modify(bigo   varchar2(30));
--4��
alter table EMP_HW
rename COLUMN bigo to remark;
--5��
DELETE EMP_HW;
INSERT INTO EMP_HW
    SELECT EMPLOYEE_ID, 
    FIRST_NAME, 
    JOB_ID,
    MANAGER_ID,
    HIRE_DATE, 
    SALARY,
    COMMISSION_PCT,
    DEPARTMENT_ID,
    NULL  
    FROM EMPLOYEES;

alter table emp_hw
modify(deptno    number(5));

alter table emp_hw
modify(job   varchar2(10));

alter table emp_hw
modify(dname   varchar2(15));

commit;