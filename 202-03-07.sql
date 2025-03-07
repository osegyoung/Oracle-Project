select sysdate -1, 3+5 from dual;

select upper('ye dam'), lower('YE DAM'), initcap('  YE DAM')
from dual;

-- first_name��  s�� ����ִ� ����� �̸�, �޿�, �μ��� ��ȸ
select first_name, salary, department_id
from employees
where lower(first_name) like '%s%'; -- �ҹ��ڿ� �빮�ڰ� ����ִ� ��� �̸����� �� ����.

--'ye' 'dam' => ye dam
-- concat() concat�� ���ڸ� �������ִ� �Լ�
select concat('ye',concat(' ','dam')) as concat����
from dual;


--�̸����� ����° ���ڸ� ǥ��,�̸��� ���ڼ� ǥ��
--�̸��� a�� ��ġ ǥ��(��,�빮�� ���� ���� ã��)
--last_name 10�ڸ��� ǥ��, ���ʿ� *�� ä��� ( lpad: ���� ä���, rpad: ������ ä���)
--�޿�  ǥ��, % : 1000�޷� -> �޿��� 5000 %%%%%  
--�μ��ڵ尡 80�� ������ ��ȸ
select first_name, 
substr(first_name,3,1) as ù����, 
length(first_name) as ���ڼ�, 
instr(lower(first_name),'a') as a_��ġ,
rpad(last_name,10,'*') as �������̸�, 
department_id as �μ�,
salary,
rpad(salary,salary/1000 + length(salary),'%') as �޿�
from employees
where department_id = 80;

select lengthb('abc'), lengthb('�ѱ�')
from dual;

--�ֹι�ȣ�� ���ڸ��� ****** ��ŷ substr�� ����ؼ� �ٸ� �����Ͱ� ���͵� *�� ǥ�� �� �� ����. 
select '050307-4224587' as �ֹε�Ϲ�ȣ,replace('050307-4224587',substr('050307-4224587',-6,6),'******') as ���ڸ��������ӾȾ˷�,
trim('  �ѱ�'),' �ѱ�',
trim('a' from 'aaaffffaaa'),
ltrim('<_aaa_>', '_>')
from dual;

--�����ȣ�� Ȧ���� 1, ¦���� 0�� ǥ��
--�����ȣ, �̸�, Ȧ¦����
select employee_id, first_name as Ȧ¦����, mod(employee_id,2) --mod : �������� �����ִ� �Լ�
from employees;

--���, �̸�, �Ի���, �Ի�6���� ���� ������ ��¥, �ټӰ���
select employee_id, first_name, hire_date,
        add_months(hire_date, 6),
       trunc( months_between(sysdate, hire_date) /12) as �����,
       next_day(sysdate,'��') as ������,
       last_day(sysdate) as ��������
from employees;

--��¥
alter session set
nls_date_format = 'rrrr-mm-dd';

select * 
from employees;

select sysdate,
        round(sysdate,'cc'),
        round(sysdate,'yyyy'),
        round(sysdate,'q'),
        round(sysdate,'ddd')
from dual;


select sysdate,
        trunc(sysdate,'cc'),
        trunc(sysdate,'yyyy'),
        trunc(sysdate,'q'),
        trunc(sysdate,'ddd'),
        sysdate + 10        
from dual;


-- 23) ��� ���̺��� �̸��� ��ȸ. �� ù ��° �÷��� �̸��� �빮�ڷ� ����ϰ�, �� ��° �÷��� �̸��� �ҹ��ڷ� ����ϰ�, �� ��° �÷��� �̸��� ù ��° ö�ڴ� �빮�ڷ�, �������� �ҹ��ڷ� ��ȸ.
select first_name, upper(first_name) as ù��°, lower(first_name) as �ι�°, initcap(first_name) AS ����° 
from employees;


-- 24) �̸��� alexander(��� �ҹ��ڷ� ��ȯ)�� ����� �̸��� ���� ��ȸ.
select first_name, salary
from employees
where lower(first_name) = 'alexander';

-- 25) ���� �ܾ� SMITH���� SMI�� �߶� ��ȸ.
 select substr('SMITH',1,3)
 from dual;

-- 26) ������� �̸�(last_name)�� �̸��� ö�� ������ ���.
select last_name, length(last_name)
from employees;


-- 27) �̸��� �ҹ��� a�� �����ϴ� ��� �� ��° �ڸ��� ��ġ�ϴ��� ��ȸ.
select first_name, instr(first_name,'a')
from employees;

-- 28) ������� �̸��� ������ ��ȸ. �� ���� �÷��� �ڸ����� 10�ڸ��� �ϰ�, ������ ����ϰ� ���� ������ �ڸ��� *(��ǥ)�� ä���� ��ȸ. 10�ڸ��� �ϰ�, ������ ����ϰ� ���� ������ �ڸ��� *(��ǥ)�� ä���� ��ȸ.


-- 29) ������� �̸��� ���� ��ȸ. �� ������ 1000�� �׸�(��) �ϳ��� ���.
-- 30) ���� 876.567�� �Ҽ��� �� ��° �ڸ����� ���(�ݿø� ó��)-- 31) ���� 876.567�� �Ҽ� ù° �ڸ����� ���(���� ó��)-- 32) ���� 10�� 3���� ���� ������ ���� ���.
-- 33) ��� ��ȣ�� ��� ��ȣ�� Ȧ���̸� 1, ¦���̸� 0�� ��¸� 0�� ���.
-- 34) �����ȣ�� ¦���� ������� ��� ��ȣ�� �̸��� ��ȸ
-- 35) ����� �̸��� �Ի��� ��¥���� ���ñ��� �� �� ���� �ٹ��ߴ��� ��ȸ(����). 
select first_name,hire_date,trunc(months_between(sysdate,hire_date))||'����' as �ټӰ���
from employees;


--��ȯ �Լ�
--���� ��ȭ�Լ�: ����, ��¥ => ����
-- #�� ���� ������ �ڸ��� �����ϱ� ����
select first_name, hire_date,to_char(hire_date,'yyyy/mm/dd day'),to_char(salary,'9999') 
from employees
where department_id =50;

alter session set
nls_date_format ='rr/mm/dd';

-- �߰����� => �������� null�̸� 200, �ƴϸ� �޿� * ������
--���, �̸�, �޿� �߰�����
select employee_id, first_name, salary, 
    nvl2(commission_pct, commission_pct*salary, 200) as �߰�����
from employees;

--if-then-else
--�޿��� < 1000 30% �λ�, < 2000 %20 �λ� , < 3000 %10 �λ�, �������� ����
select first_name, salary, 
        case when salary < 1000 then salary*1.3
             when salary < 2000 then salary*1.2
             when salary < 3000 then salary*1.1
             else salary
             end
        as "�λ�� �޿�"
from employees;

--�μ��ڵ尡 20,30,50 -> '����'
--60,70,80 -> '�뱸'
--������ -> '���ֵ�'
select first_name, department_id,
case when department_id = 20 or department_id = 30 or department_id =50 then '����'
     when department_id = 60 or department_id =70 or department_id = 80 then '�뱸'
     else '���ֵ�'
     end
     as "�μ��з�"
from employees;

-- 36) 2018�� 10�� 1�Ͽ��� 2019�� 6�� 1�� ������ ���ϼ� ���.
-- 37) 2018�� 10�� 1�Ͽ��� 2019�� 6�� 1�� ������ �� ��(Week) ���� ���(����).
-- 38) 2023�� 5�� 1�Ϸκ��� 100�� ���� ��¥ ���.
-- 39) 2023�� 5�� 1�Ϸκ��� 100�� �� ��¥ ���.
-- 40) 2023�� 6�� 30�� ���� �ٷ� ���ƿ� ȭ������ ��¥ ���
-- 41) 2023�� 9�� 19�� ���� �ٷ� ���ƿ� ������� ��¥ ���
-- 42) ���� ���� ���ƿ� �ݿ����� ��¥ ���
-- 43) 2020�� 5�� 22�Ϻ��� 100�� �ڿ� ���ƿ��� ȭ������ ��¥ ���
-- 44) ���ú��� 100�� �ڿ� ���ƿ��� �������� ��¥ ���
-- 45) 2019�� 5�� 22�� �ش� ���� ������ ��¥�� ��� �Ǵ��� ��ȸ
-- 46) ���ú��� �̹� �� ���ϱ��� �� ��ĥ ���Ҵ��� ��ȸ
-- 47) �̸��� SUSAN�� ����� �̸�, �Ի���, �Ի��� ���� ������ ��¥�� ��ȸ
-- 48) �̸�(last_name)�� GRANT(�빮�ڷ� ��ȯ)�� ����� �̸��� �Ի��� ������ ����ϰ�, GRANT�� ���޿� õ������ ������ �� �ִ� �޸�(,)�� �ٿ� ��ȸ
-- 50) 2008�⵵�� �Ի��� ����� �̸��� �Ի��� ��ȸ(to_char �Լ� ���)
-- 51) ������ 1500 �̻��� ����� �̸���, ���޿� õ������ ������ �� �ִ� �޸�(,)�� ȭ������� �ٿ� ��ȸ
-- 52) 2005�� 06�� 14�Ͽ� �Ի��� ����� �̸��� �Ի��� ��ȸ(to_date �Լ� ���)
-- 53) ����� �̸��� Ŀ�̼��� ��ȸ. (�� Ŀ�̼��� NULL�� ������� 0)
-- 54) ������ 'SA_MAN' �Ǵ� 'IT_PROG' �� ����� ����, �߰�����, ���޿� ��ȸ - �߰����� : ���� * Ŀ�̼�(�� Ŀ�̼��� NULL�� ��� 0)- ���޿� : ���� + �߰�����

-- 55) ����� �̸��� �μ� ��ȣ, ���ʽ� ��ȸ���ʽ� : �μ� ��ȣ�� 10���̸� 300, 20���̸� 400, ������ �μ� ��ȣ�� 0
select first_name, department_id, decode(department_id,10,300,20,400,0) as "��ȸ���ʽ�" 
from employees;

-- 56) ��� ��ȣ�� ��� ��ȣ�� ¦������ Ȧ�������� ��ȸ
select employee_id, decode(mod(employee_id,2),0,'¦��',1,'Ȧ��') as �����ȣ���� 
from employees;

-- 57) ����� �̸�, ����, ���ʽ� ��ȸ�� ������ 'SA_MAN'�̸� ���ʽ� 5000������ ������ ���ʽ� 2000
select first_name, job_id, decode(job_id,'SA_MAN',5000,2000) as "���ʽ�"
from employees;

-- 58) ����� �̸�, ����, ����, ���ʽ� ��ȸ- ���ʽ� : ������ 3000�̻��̸� 500, ������ 2000�̻� 3000�̸��̸� 300, ������ 1000�̻� 2000 �̸��̸� 200, �������� 0
select first_name, job_id, salary, 
        case when salary >= 3000 then 500 
             when salary >= 2000 or salary < 3000 then 300 
             when salary >= 1000 or salary < 2000 then 200
             else 0            
             end 
            as "���ʽ�" 
from employees;

-- 59) ����� �̸�, ����, Ŀ�̼�, ���ʽ� ��ȸ. ���ʽ� : Ŀ�̼��� NULL�̸� 500, NULL�� �ƴϸ� 0
-- 60) ����� �̸�, ����, ���ʽ� ��ȸ - ���ʽ��� ������ 'SA_MAN', 'PU_CLERK' �̸� 500, 'ST_CLERK', 'FI_ACCOUNT'�̸� 400 ������  0