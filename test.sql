--  1�� . ��� ���̺��� �޿��� 7000�̻� 12000�����̸�, �̸�(last_name)�� 'H'�� �����ϴ� ����� �����ȣ, �̸�(last_name),�޿�, �μ���ȣ�� ���
select employee_id, last_name, salary, department_id
from employees
where salary between 7000 and 12000 
        and last_name like 'H%';

--2��. 50���� 60�� �μ� ���� ��� �޿��� 5000���� ���� ����� �����ȣ, �̸�(last_name), ����(job_id), �޿�, �μ���ȣ�� ���
select employee_id, last_name, job_id, salary, department_id
from employees
where department_id = 50 or department_id = 60 and salary > 5000;


-- 3��. �����ȣ, �̸�(last_name), �޿�, �λ�� �޿�
--�λ�� �޿� => �޿��� 3000���ϸ� 20%
--           => �޿��� 9000���ϸ� 15%
--           => �޿��� 14000���ϸ� 10%
--           ������ ����

select employee_id, first_name, salary,
       case
           when salary <= 5000 then salary * 2.0  
           when salary <= 10000 then salary * 1.50  
           when salary <= 15000 then salary * 1.00  
           when salary >=15001 then salary    
       end as increased_salary
from employees;

--4��. departments ���̺�� locations ���̺� ���Ͽ� join�� �����Ͽ� �μ���ȣ, �μ��̸�, ���ø��� ���
select department_id, department_name, city
from departments d join locations l on (d.location_id = l.location_id);

--5��. ���������� ����Ͽ� "it" �μ����� �ٹ��ϴ� (�μ��̸��� it��) ������� �����ȣ, �̸�(last_name), ����(job_id)�� ���
select employee_id, last_name, job_id
from employees
where department_id = (select department_id
                            from departments
                            where lower(department_name) = 'it');
--6��. 2005�� ������ �Ի��� ����� �� job_id�� ST_CLERK�� ����� ��� �����͸� ���
select employee_id, 
       first_name,
       last_name,
       email,
       phone_number,
       hire_date,
       job_id
from employees
where hire_date < to_date('2005-01-01','yyyy-mm-dd') and job_id = 'ST_CLERK';

--7��. Ŀ�̼��� �޴� ����� �̸�(last_name), ����, �޿�, Ŀ�̼��� ǥ���ϸ鼭 �����͸� �޿��� ���� ���� �������� ����
select last_name, job_id, salary, commission_pct
from employees
where commission_pct is not null
order by 3 desc;

--8��. 
create table prof(
            profno number(4),
            name varchar2(15) not null,
            id varchar2(15) not null,
            hiredate date,
            pay number(4)
            );

--9��-1.
insert into prof
values(1001 , 'Mark', 'm1001', '07/03.01', 800);

insert into prof
values(1003 , 'Adam', 'a1003', '11/03.02', 0);
commit;

--2.
update prof 
set pay = 1200
where profno = 1001;

--3��
delete prof
where profno = 1003;

--10��.
--(1)
alter table prof 
add constraint prof_profno_pk primary key (profno);

--(2)
alter table prof 
add(gender    varchar2(3));

--(3)
alter table prof 
modify(name    varchar2(20));

commit;