-- 전 사원의 급여의 합계, 평균, 최대값, 최소값, 사원수
select department_id, job_id, sum(salary), round(avg(salary)), max(salary), min(salary), count(*)
from employees
group by department_id, job_id
having sum(salary) >= 50000
order by department_id ;

-- 직무별 급여 합계를 구하고, 합계가 30000이상인 자료만 표시
-- 합계를 이용해서 내림차순 정렬
select job_id, sum(salary) 
from employees
group by job_id
having sum(salary) >= 30000
order by 2 desc;

-- 회사 관리자 수 표시
select count(distinct manager_id) as 관리자수
from employees;

--추가 수당을 받는 사원 수
select count(*)
from employees
--추가 수당이 없는 사원 수
where commission_pct is null;

-- 사원의 급여의 최대값과 최소값의 차이 표시
select max(salary)- min(salary) as 차이
from employees;

-- 부서번호가 50번 이상인 부서만 표시
-- 최소 입사사원의 입사일과, 가장 최근 입사자의 입사일 표시
-- 부서별 급여 합계가 30000이상인 자료만 표시
select department_id, min(hire_date),max(hire_date),sum(salary)
from employees
where department_id >= 50
group by department_id
having sum(salary) < 30000
order by department_id;

-- 1. 그룹 함수는 여러 행에 적용되어 그룹 당 하나의 결과를 출력한다. 
-- 2. 그룹 함수는 계산에 널을 포함한다. 
-- 3. WHERE 절은 그룹 계산에 행(row)을 포함시키기 전에 행을 제한한다. 
-- 4. 모든 사원의 급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 열 레이블을 각각 Maximum, Minimum, Sum, Average로 지정하고 결과를 정수로 반올림하도록 작성하시오.
select max(salary) as Maximum, min(salary) as Minimum, sum(salary) as Sum, round(avg(salary)) as Average
from employees;
-- 5. 위의 질의를 수정하여 각 업무 유형(job_id)별로 급여 최고액, 최저액, 총액 및 평균액을 표시하시오. 
select job_id, max(salary) as Maximum, min(salary) as Minimum, sum(salary) as Sum, round(avg(salary)) as Average
from employees
group by job_id;

-- 6. 업무별 사원 수를 표시하는 질의를 작성하시오.
select job_id, count(employee_id)
from employees
group by job_id;

-- 7. 관리자 수를 확인하시오. 열 레이블은 Number of Managers로 지정하시오. (힌트: MANAGER_ID 열을 사용)
select count(manager_id) as NumberofManagers
from employees;

-- 8. 최고 급여와 최저 급여의 차액을 표시하는 질의를 작성하고 열 레이블을 DIFFERENCE로 지정하시오.
select max(salary)-min(salary) as DIFFERENCE
from employees;

-- 9. 관리자 번호, 해당 관리자에 속한 사원의 최저 급여를 표시하시오. 관리자를 알 수 없는 사원, 최저 급여가 6,000 미만인 그룹은 제외시키고 결과를 최저급여에 대한 내림차순으로 정렬하시오.
select manager_id, min(salary) 
from employees
where manager_id is not null
and salary <= 6000
group by manager_id 
order by 2 desc;

-- 10. 업무를 표시한 다음 해당 업무에 대해 부서 번호별(부서 20, 50, 80, 90) 급여 합계와  모든 사원의 급여 총액을 각각 표시하는 질의를 작성하고, 각 열에 적합한 머리글을 지정하시오
SELECT 
    job_id AS "업무",  -- 업무 표시
    sum(decode(department_id, 20, salary, 0)) AS "부서 20 급여 합계",  -- 부서 20 급여 합계
    sum(decode(department_id, 50, salary, 0)) AS "부서 50 급여 합계",  -- 부서 50 급여 합계
    sum(decode(department_id, 80, salary, 0)) AS "부서 80 급여 합계",  -- 부서 80 급여 합계
    sum(decode(department_id, 90, salary, 0)) AS "부서 90 급여 합계",  -- 부서 90 급여 합계
    sum(salary) AS "전체 급여 합계"  -- 전체 급여 합계
from 
    employees
group by 
    job_id;  -- 업무별로 그룹화

--join
-- 부서코드, 부서이름, 사원번호, 이름
select employee_id, first_name, e. department_id, department_name
from employees e, departments d
where e.department_id(+) = d.department_id;

--직무에 해당하는 급여의 최소 최대값
select first_name, e.job_id, salary, j.job_id, min_salary, max_salary
from employees e, jobs j
where e.job_id = j.job_id
order by first_name;


--셀프 조인  사원번호, 이름, 상사의 번호, 상사이름
select e.employee_id, e.first_name, e.manager_id, e2.employee_id, e2.first_name 
from employees e, employees e2
where e.manager_id = e2.employee_id;

-- 부서코드, 부서이름, 위치한 도시명
select department_id, department_name,d.location_id, l.location_id, city
from departments d, locations l
where d.location_id = l.location_id
order by department_id;

--표준조인 ( natural join)
select employee_id, department_name, e.department_id
from employees e ,departments d
where e.department_id = d.department_id and e.manager_id = d.manager_id
order by department_id;

--using절 사용
select employee_id, department_id, department_name
from employees e join departments d using(department_id)
order by department_id;

--on절 사용
select employee_id, d.department_id, department_name
from employees e right join departments d on(e.department_id = d.department_id)
order by department_id;

--급여가 13,000초과인 사원들의 부서정보와 사원정보를 출력
--부서번호, 부서이름, 사원번호, first_name, 급여 출력
--기본 방시(+), SQL-99방식
select d.department_id, department_name, employee_id, first_name, salary
from employees e join departments d on(e.department_id = d.department_id)
where salary > 13000
order by e.department_id;

--부서번호, 부서이름, 평균급여(정수로 반올림), 최대급여, 최소급여, 사원수 출력
select d.department_id, department_name, round(avg(salary)), max(salary), min(salary), count(*)
from employees e join departments d on(e.department_id = d.department_id)
group by d.department_id, department_name 
order by d.department_id;

-- 모든 사원 정보가 포함된 결과를 부서번호, first_name 순으로 정렬하여 출력
-- 부서번호, 부서이름, 사원번호, first_name, 직책명(job_title), 급여 출력
select d.department_id, department_name, employee_id, first_name, job_id, salary
from employees e left join departments d on(e.department_id = d.department_id)
order by d.department_id;

--모든부서, 사원정보, 사원의 상관정보를 부서번호와 사원번호 순으로 정렬하여 출력
-- 부서번호, 부서이름, 사원번호, first_name, 상관번호(manager_id),급여, 상관사원번호(employee_id),상관이름(first_name) 출력
select d.department_id, department_name, 
        e.employee_id, e.first_name, e.manager_id, e.salary,
        e2.employee_id, e2.first_name
from employees e right join departments d on(e.department_id = d.department_id)
                left join employees e2 on(e.manager_id = e2.employee_id); 

-- selcet 나타나고다 하는 필드명
-- from table, join( table1 join table2 조건절(using(필드명),on(비교식)))
-- where  조건절
-- group by  그룹화활 필드명
-- having 그룹화한 결과를 이용한 조건절
-- order by 정렬을 할 필드명


-- 1. LOCATIONS, COUNTRIES 테이블을 사용하여 모든 부서의 주소를 생성하는 query를 작성하시오. 
-- 출력에 위치 ID, 주소, 구/군, 시/도 및 국가를 표시하며, NATURAL JOIN을 사용하여 결과를 생성합니다.
select location_id, state_province, city, street_address,country_name
from locations l natural join countries c;

--2. 모든 사원의 last_name, 소속 부서번호, 부서 이름을 표시하는 query를 작성하시오.
select last_name, d.department_id, d.department_name
from employees e join departments d on(d.department_id = e.department_id);

--3. Toronto에 근무하는 사원에 대한 보고서를 필요로 합니다. toronto에서 근무하는 모든 사원의 last_name, 직무, 부서번호, 부서 이름을 표시하시오. (힌트 : 3-way join 사용)
select e.last_name, e.job_id, e.department_id, d.department_name
from employees e join departments d on e.department_id = d.department_id join locations l on d.location_id = l.location_id
where l.city = 'Toronto';

--4. 사원의 last_name, 사원 번호를 해당 관리자의 last_name, 관리자 번호와 함께 표시하는 보고서를 작성하시오.  열 레이블을 각각 Employee, Emp#, Manager, Mgr#으로 지정하시오. 
select e.last_name, e.employee_id, e.manager_id, e2.last_name
from employees e join employees e2 on(e.manager_id = e2.employee_id);

--5. King과 같이 해당 관리자가 지정되지 않은 모든 사원을 표시하도록 4번 문장을 수정합니다. 사원 번호순으로 결과를 정렬하시오. 
select e.last_name, e.employee_id, e.manager_id, e2.last_name, e2.employee_id
from employees e left join employees e2 on(e.manager_id = e2.employee_id)
where e.manager_id is null
order by e.employee_id;

--6. 사원의 last_name, 부서 번호,  같은 부서에 근무하는 모든 사원을 표시하는 보고서를 작성하시오. 각 열에 적절한 레이블을 자유롭게 지정해 봅니다.
SELECT e1.last_name AS Employee_Last_Name,
       e1.department_id AS Department_ID,
       e2.last_name AS Colleague_Last_Name
FROM employees e1
JOIN employees e2 ON e1.department_id = e2.department_id
WHERE e1.employee_id != e2.employee_id
ORDER BY e1.department_id, e1.last_name;

--7. 직무, 급여에 대한 보고서를 필요로 합니다. 먼저 JOBS테이블의 구조를 표시한 다음, 모든 사원의 이름, 직무, 부서 이름, 급여를 표시하는 query를 작성하시오


----- 서브커리-----------
-- 부서명이 IT인 사원의 이름과 부서코드 출력
select first_name, department_id
from employees
where department_id = (select department_id
                        from departments 
                        where upper(department_name) = 'IT'); -- 부서명이 it인 
                        
-- 표시 필드: 사원번호, 사원의 이름, 급여
-- 조건 : 사원전체 급여의 평균 이하인 사원만 출력
select employee_id, first_name, salary
from employees
where salary <= all (select avg(salary)
                        from employees);
                        
--- 최대
select employee_id, first_name, salary
from employees
where salary = (select max(salary)
                        from employees);

--최소
select employee_id, first_name, salary
from employees
where salary = (select min(salary)
                        from employees);
                        
                        
 --1. Zlotkey와 동일한 부서에 속한 모든 사원의 이름과 입사일을 표시하는 질의를 작성하시오. Zlotkey는 결과에서 제외하시오.
 --2. 급여가 평균 급여보다 많은 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 결과를 급여에 대해 오름차순으로 정렬하시오.
 --3. 이름에 u가 포함된 사원과 같은 부서에서 일하는 모든 사원의 사원 번호와 이름을 표시하는 질의를 작성하고 질의를 실행하시오.
 --4. 부서 위치 ID가 1700인 모든 사원의 이름, 부서 번호 및 업무 ID를 표시하시오.
 --5. King에게 보고하는(manager가 King) 모든 사원의 이름과 급여를 표시하시오.
 select last_name, salary, manager_id
 from employees
 where manager_id in (select employee_id
                        from employees
                        where lower(last_name) = 'King');
                        
 --6. Executive 부서의 모든 사원에 대한 부서 번호, 이름, 업무 ID를 표시하시오.
 --7. 평균 급여보다 많은 급여를 받고, 이름에 u가 포함된 사원과 같은 부서에 근무하는 모든 사원의 사원번호, 이름, 급여를 표시하시오                      