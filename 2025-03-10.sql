-- �� ����� �޿��� �հ�, ���, �ִ밪, �ּҰ�, �����
select department_id, job_id, sum(salary), round(avg(salary)), max(salary), min(salary), count(*)
from employees
group by department_id, job_id
having sum(salary) >= 50000
order by department_id ;

-- ������ �޿� �հ踦 ���ϰ�, �հ谡 30000�̻��� �ڷḸ ǥ��
-- �հ踦 �̿��ؼ� �������� ����
select job_id, sum(salary) 
from employees
group by job_id
having sum(salary) >= 30000
order by 2 desc;

-- ȸ�� ������ �� ǥ��
select count(distinct manager_id) as �����ڼ�
from employees;

--�߰� ������ �޴� ��� ��
select count(*)
from employees
--�߰� ������ ���� ��� ��
where commission_pct is null;

-- ����� �޿��� �ִ밪�� �ּҰ��� ���� ǥ��
select max(salary)- min(salary) as ����
from employees;

-- �μ���ȣ�� 50�� �̻��� �μ��� ǥ��
-- �ּ� �Ի����� �Ի��ϰ�, ���� �ֱ� �Ի����� �Ի��� ǥ��
-- �μ��� �޿� �հ谡 30000�̻��� �ڷḸ ǥ��
select department_id, min(hire_date),max(hire_date),sum(salary)
from employees
where department_id >= 50
group by department_id
having sum(salary) < 30000
order by department_id;

-- 1. �׷� �Լ��� ���� �࿡ ����Ǿ� �׷� �� �ϳ��� ����� ����Ѵ�. 
-- 2. �׷� �Լ��� ��꿡 ���� �����Ѵ�. 
-- 3. WHERE ���� �׷� ��꿡 ��(row)�� ���Խ�Ű�� ���� ���� �����Ѵ�. 
-- 4. ��� ����� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ǥ���Ͻÿ�. �� ���̺��� ���� Maximum, Minimum, Sum, Average�� �����ϰ� ����� ������ �ݿø��ϵ��� �ۼ��Ͻÿ�.
select max(salary) as Maximum, min(salary) as Minimum, sum(salary) as Sum, round(avg(salary)) as Average
from employees;
-- 5. ���� ���Ǹ� �����Ͽ� �� ���� ����(job_id)���� �޿� �ְ��, ������, �Ѿ� �� ��վ��� ǥ���Ͻÿ�. 
select job_id, max(salary) as Maximum, min(salary) as Minimum, sum(salary) as Sum, round(avg(salary)) as Average
from employees
group by job_id;

-- 6. ������ ��� ���� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�.
select job_id, count(employee_id)
from employees
group by job_id;

-- 7. ������ ���� Ȯ���Ͻÿ�. �� ���̺��� Number of Managers�� �����Ͻÿ�. (��Ʈ: MANAGER_ID ���� ���)
select count(manager_id) as NumberofManagers
from employees;

-- 8. �ְ� �޿��� ���� �޿��� ������ ǥ���ϴ� ���Ǹ� �ۼ��ϰ� �� ���̺��� DIFFERENCE�� �����Ͻÿ�.
select max(salary)-min(salary) as DIFFERENCE
from employees;

-- 9. ������ ��ȣ, �ش� �����ڿ� ���� ����� ���� �޿��� ǥ���Ͻÿ�. �����ڸ� �� �� ���� ���, ���� �޿��� 6,000 �̸��� �׷��� ���ܽ�Ű�� ����� �����޿��� ���� ������������ �����Ͻÿ�.
select manager_id, min(salary) 
from employees
where manager_id is not null
and salary <= 6000
group by manager_id 
order by 2 desc;

-- 10. ������ ǥ���� ���� �ش� ������ ���� �μ� ��ȣ��(�μ� 20, 50, 80, 90) �޿� �հ��  ��� ����� �޿� �Ѿ��� ���� ǥ���ϴ� ���Ǹ� �ۼ��ϰ�, �� ���� ������ �Ӹ����� �����Ͻÿ�
SELECT 
    job_id AS "����",  -- ���� ǥ��
    sum(decode(department_id, 20, salary, 0)) AS "�μ� 20 �޿� �հ�",  -- �μ� 20 �޿� �հ�
    sum(decode(department_id, 50, salary, 0)) AS "�μ� 50 �޿� �հ�",  -- �μ� 50 �޿� �հ�
    sum(decode(department_id, 80, salary, 0)) AS "�μ� 80 �޿� �հ�",  -- �μ� 80 �޿� �հ�
    sum(decode(department_id, 90, salary, 0)) AS "�μ� 90 �޿� �հ�",  -- �μ� 90 �޿� �հ�
    sum(salary) AS "��ü �޿� �հ�"  -- ��ü �޿� �հ�
from 
    employees
group by 
    job_id;  -- �������� �׷�ȭ

--join
-- �μ��ڵ�, �μ��̸�, �����ȣ, �̸�
select employee_id, first_name, e. department_id, department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

--������ �ش��ϴ� �޿��� �ּ� �ִ밪
select first_name, e.job_id, salary, j.job_id, min_salary, max_salary
from employees e, jobs j
where e.job_id = j.job_id
order by first_name;


--���� ����  �����ȣ, �̸�, ����� ��ȣ, ����̸�
select e.employee_id, e.first_name, e.manager_id, e2.employee_id, e2.first_name 
from employees e, employees e2
where e.manager_id = e2.employee_id;

-- �μ��ڵ�, �μ��̸�, ��ġ�� ���ø�
select department_id, department_name,d.location_id, l.location_id, city
from departments d, locations l
where d.location_id = l.location_id
order by department_id;

--ǥ������ ( natural join)
select employee_id, department_name, e.department_id
from employees e ,departments d
where e.department_id = d.department_id and e.manager_id = d.manager_id
order by department_id;

--using�� ���
select employee_id, department_id, department_name
from employees e join departments d using(department_id)
order by department_id;

--on�� ���
select employee_id, d.department_id, department_name
from employees e right join departments d on(e.department_id = d.department_id)
order by department_id;

--�޿��� 13,000�ʰ��� ������� �μ������� ��������� ���
--�μ���ȣ, �μ��̸�, �����ȣ, first_name, �޿� ���
--�⺻ ���(+), SQL-99���
select d.department_id, department_name, employee_id, first_name, salary
from employees e join departments d on(e.department_id = d.department_id)
where salary > 13000
order by e.department_id;

--�μ���ȣ, �μ��̸�, ��ձ޿�(������ �ݿø�), �ִ�޿�, �ּұ޿�, ����� ���
select d.department_id, department_name, round(avg(salary)), max(salary), min(salary), count(*)
from employees e join departments d on(e.department_id = d.department_id)
group by d.department_id, department_name 
order by d.department_id;

-- ��� ��� ������ ���Ե� ����� �μ���ȣ, first_name ������ �����Ͽ� ���
-- �μ���ȣ, �μ��̸�, �����ȣ, first_name, ��å��(job_title), �޿� ���
select d.department_id, department_name, employee_id, first_name, job_id, salary
from employees e left join departments d on(e.department_id = d.department_id)
order by d.department_id;

--���μ�, �������, ����� ��������� �μ���ȣ�� �����ȣ ������ �����Ͽ� ���
-- �μ���ȣ, �μ��̸�, �����ȣ, first_name, �����ȣ(manager_id),�޿�, ��������ȣ(employee_id),����̸�(first_name) ���
select d.department_id, department_name, 
        e.employee_id, e.first_name, e.manager_id, e.salary,
        e2.employee_id, e2.first_name
from employees e right join departments d on(e.department_id = d.department_id)
                left join employees e2 on(e.manager_id = e2.employee_id); 

-- selcet ��Ÿ����� �ϴ� �ʵ��
-- from table, join( table1 join table2 ������(using(�ʵ��),on(�񱳽�)))
-- where  ������
-- group by  �׷�ȭȰ �ʵ��
-- having �׷�ȭ�� ����� �̿��� ������
-- order by ������ �� �ʵ��


-- 1. LOCATIONS, COUNTRIES ���̺��� ����Ͽ� ��� �μ��� �ּҸ� �����ϴ� query�� �ۼ��Ͻÿ�. 
-- ��¿� ��ġ ID, �ּ�, ��/��, ��/�� �� ������ ǥ���ϸ�, NATURAL JOIN�� ����Ͽ� ����� �����մϴ�.
select location_id, state_province, city, street_address,country_name
from locations l natural join countries c;

--2. ��� ����� last_name, �Ҽ� �μ���ȣ, �μ� �̸��� ǥ���ϴ� query�� �ۼ��Ͻÿ�.
select last_name, d.department_id, d.department_name
from employees e join departments d on(d.department_id = e.department_id);

--3. Toronto�� �ٹ��ϴ� ����� ���� ������ �ʿ�� �մϴ�. toronto���� �ٹ��ϴ� ��� ����� last_name, ����, �μ���ȣ, �μ� �̸��� ǥ���Ͻÿ�. (��Ʈ : 3-way join ���)
select e.last_name, e.job_id, e.department_id, d.department_name
from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id
where l.city = 'Toronto';

--4. ����� last_name, ��� ��ȣ�� �ش� �������� last_name, ������ ��ȣ�� �Բ� ǥ���ϴ� ������ �ۼ��Ͻÿ�.  �� ���̺��� ���� Employee, Emp#, Manager, Mgr#���� �����Ͻÿ�. 
select e.last_name, e.employee_id, e.manager_id, e2.last_name
from employees e join employees e2 on(e.manager_id = e2.employee_id);

--5. King�� ���� �ش� �����ڰ� �������� ���� ��� ����� ǥ���ϵ��� 4�� ������ �����մϴ�. ��� ��ȣ������ ����� �����Ͻÿ�. 
select e.last_name, e.employee_id, e.manager_id, e2.last_name, e2.employee_id
from employees e left join employees e2 on(e.manager_id = e2.employee_id)
where e.manager_id is null
order by e.employee_id;

--6. ����� last_name, �μ� ��ȣ,  ���� �μ��� �ٹ��ϴ� ��� ����� ǥ���ϴ� ������ �ۼ��Ͻÿ�. �� ���� ������ ���̺��� �����Ӱ� ������ ���ϴ�.
SELECT e1.last_name AS Employee_Last_Name,
       e1.department_id AS Department_ID,
       e2.last_name AS Colleague_Last_Name
FROM employees e1
JOIN employees e2 ON e1.department_id = e2.department_id
WHERE e1.employee_id != e2.employee_id
ORDER BY e1.department_id, e1.last_name;

--7. ����, �޿��� ���� ������ �ʿ�� �մϴ�. ���� JOBS���̺��� ������ ǥ���� ����, ��� ����� �̸�, ����, �μ� �̸�, �޿��� ǥ���ϴ� query�� �ۼ��Ͻÿ�


----- ����Ŀ��-----------
-- �μ����� IT�� ����� �̸��� �μ��ڵ� ���
select first_name, department_id
from employees
where department_id = (select department_id
                        from departments 
                        where upper(department_name) = 'IT'); -- �μ����� it�� 
                        
-- ǥ�� �ʵ�: �����ȣ, ����� �̸�, �޿�
-- ���� : �����ü �޿��� ��� ������ ����� ���
select employee_id, first_name, salary
from employees
where salary <= all (select avg(salary)
                        from employees);
                        
--- �ִ�
select employee_id, first_name, salary
from employees
where salary = (select max(salary)
                        from employees);

--�ּ�
select employee_id, first_name, salary
from employees
where salary = (select min(salary)
                        from employees);
                        
                        
 --1. Zlotkey�� ������ �μ��� ���� ��� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�. Zlotkey�� ������� �����Ͻÿ�.
 --2. �޿��� ��� �޿����� ���� ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� ����� �޿��� ���� ������������ �����Ͻÿ�.
 --3. �̸��� u�� ���Ե� ����� ���� �μ����� ���ϴ� ��� ����� ��� ��ȣ�� �̸��� ǥ���ϴ� ���Ǹ� �ۼ��ϰ� ���Ǹ� �����Ͻÿ�.
 --4. �μ� ��ġ ID�� 1700�� ��� ����� �̸�, �μ� ��ȣ �� ���� ID�� ǥ���Ͻÿ�.
 --5. King���� �����ϴ�(manager�� King) ��� ����� �̸��� �޿��� ǥ���Ͻÿ�.
 select last_name, salary, manager_id
 from employees
 where manager_id in (select employee_id
                        from employees
                        where lower(last_name) = 'King');
                        
 --6. Executive �μ��� ��� ����� ���� �μ� ��ȣ, �̸�, ���� ID�� ǥ���Ͻÿ�.
 --7. ��� �޿����� ���� �޿��� �ް�, �̸��� u�� ���Ե� ����� ���� �μ��� �ٹ��ϴ� ��� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�                      