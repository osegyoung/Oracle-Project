select sysdate -1, 3+5 from dual;

select upper('ye dam'), lower('YE DAM'), initcap('  YE DAM')
from dual;

-- first_name에  s가 들어있는 사원의 이름, 급여, 부서명 조회
select first_name, salary, department_id
from employees
where lower(first_name) like '%s%'; -- 소문자와 대문자가 들어있는 사원이름들이 다 나옴.