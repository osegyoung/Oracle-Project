--  1번 . 사원 테이블에서 급여가 7000이상 12000이하이며, 이름(last_name)이 'H'로 시작하는 사원의 사원번호, 이름(last_name),급여, 부서번호를 출력
select employee_id, last_name, salary, department_id
from employees
where salary between 7000 and 12000 
        and last_name like 'H%';

--2번. 50번과 60번 부서 직원 가운데 급여가 5000보다 많은 사원의 사원번호, 이름(last_name), 업무(job_id), 급여, 부서번호를 출력
select employee_id, last_name, job_id, salary, department_id
from employees
where department_id = 50 or department_id = 60 and salary > 5000;


-- 3번. 사원번호, 이름(last_name), 급여, 인상된 급여
--인상된 급여 => 급여가 3000이하면 20%
--           => 급여가 9000이하면 15%
--           => 급여가 14000이하면 10%
--           나머진 동결

select employee_id, first_name, salary,
       case
           when salary <= 5000 then salary * 2.0  
           when salary <= 10000 then salary * 1.50  
           when salary <= 15000 then salary * 1.00  
           when salary >=15001 then salary    
       end as increased_salary
from employees;

--4번. departments 테이블과 locations 테이블에 대하여 join을 수행하여 부서번호, 부서이름, 도시명을 출려
select department_id, department_name, city
from departments d join locations l on (d.location_id = l.location_id);

--5번. 서브쿼리를 사용하여 "it" 부서에서 근무하는 (부서이름이 it인) 사원들의 사원번호, 이름(last_name), 업무(job_id)를 출력
select employee_id, last_name, job_id
from employees
where department_id = (select department_id
                            from departments
                            where lower(department_name) = 'it');
--6번. 2005년 이전에 입사한 사원들 중 job_id가 ST_CLERK인 사원의 모든 데이터를 출력
select employee_id, 
       first_name,
       last_name,
       email,
       phone_number,
       hire_date,
       job_id
from employees
where hire_date < to_date('2005-01-01','yyyy-mm-dd') and job_id = 'ST_CLERK';

--7번. 커미션을 받는 사원의 이름(last_name), 업무, 급여, 커미션을 표시하면서 데이터를 급여에 대한 내림 차순으로 정렬
select last_name, job_id, salary, commission_pct
from employees
where commission_pct is not null
order by 3 desc;

--8번. 
create table prof(
            profno number(4),
            name varchar2(15) not null,
            id varchar2(15) not null,
            hiredate date,
            pay number(4)
            );

--9번-1.
insert into prof
values(1001 , 'Mark', 'm1001', '07/03.01', 800);

insert into prof
values(1003 , 'Adam', 'a1003', '11/03.02', 0);
commit;

--2.
update prof 
set pay = 1200
where profno = 1001;

--3번
delete prof
where profno = 1003;

--10번.
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