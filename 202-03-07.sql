select sysdate -1, 3+5 from dual;

select upper('ye dam'), lower('YE DAM'), initcap('  YE DAM')
from dual;

-- first_name��  s�� ����ִ� ����� �̸�, �޿�, �μ��� ��ȸ
select first_name, salary, department_id
from employees
where lower(first_name) like '%s%'; -- �ҹ��ڿ� �빮�ڰ� ����ִ� ����̸����� �� ����.