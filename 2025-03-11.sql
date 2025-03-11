-- from 절에 사용
SELECT e.employee_id, e.first_name, e.department_id, e.salary, b.salavg
FROM employees e
JOIN (
    SELECT department_id, ROUND(AVG(salary), 2) AS salavg
    FROM employees
    GROUP BY department_id
) b ON e.department_id = b.department_id
WHERE e.salary = b.salavg;


--1. 사원테이블, 급여가 6500 이상 13000이하, 이름(last_name)이 'H'로 시작하는
--사원의 사원번호, 이름(last_name), 급여, 부서번호 출력
select employee_id, last_name, salary, department_id
from employees
where salary between 6500 and 13000 
        and last_name like 'H%';

-- 2. 50번, 60번 부서 직원 가운데 급여가 4000보다 많은 사원의 
--  사원번호, 이름, 직무, 급여, 부서번호 출력
select employee_id, first_name, job_id, department_id
from employees
where department_id =50 or department_id = 60 and salary > 4000;

-- 3.사원번호, 이름, 급여, 인상된 급여
--인상된 급여 => 급여가 3000이하면 30%
--           => 급여가 9000이하면 20%
--           => 급여가 14000이하면 10%
--           나머진 동결

SELECT employee_id, first_name, salary,
       CASE
           WHEN salary <= 3000 THEN salary * 1.30  -- 급여가 3000 이하일 경우 30% 인상
           WHEN salary <= 9000 THEN salary * 1.20  -- 급여가 9000 이하일 경우 20% 인상
           WHEN salary <= 14000 THEN salary * 1.10  -- 급여가 14000 이하일 경우 10% 인상
           ELSE salary  -- 그 외의 경우 급여 동결
       END AS increased_salary
FROM employees;


            
--4. 이름, 부서번호, 부서이름, 도시명을 출력 -- 표준조인
select e.first_name, e.department_id, d.department_name,l.city
from employees e left join departments d on(e.department_id = d.department_id)
                    left join locations l on(d.location_id = l.location_id);

--5. 서브쿼리 이용해서 'sales' 부서에서 일하는 사원들의 
--사원번호, 이름, 직무를 출력
select employee_id, first_name, job_id
from employees
where department_id = (select department_id
                        from departments
                        where department_name ='Sales');

--6. 2005년 이전에 입사한 사원들 중 직무가 'ST_CLECK'인 사원의 데이터 표시
select employee_id, job_id
from employees
where hire_date < to_date('2005-01-01','yyyy-mm-dd') and job_id = 'ST_CLERK';

--7. 추가 수당을 받는 사원의 이름, 직무, 급여, 추가수당율 표시
--급여에 대하여 내림차순 정렬
select first_name, job_id, salary, commission_pct
from employees
order by 3 desc;

--8. 부서별 급여 평균(정수), 합계 표시
--부서코드, 급여평균, 급여합계 출력
--급여합계가 50000이상인 자료만 출력
select department_id, round(avg(salary)), sum(salary)
from employees
group by department_id
having sum(salary) >= 50000;

--데이터 조작어
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

update employees -- 입력된 값을 수정
set department_id = 30
where department_id = 20; -- 조건 넣어줘야함.

select * from dept; -- 테이블 안 데이터 삭제
delete dept
where deptno = 200; -- 조건 넣어줘야함.

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

alter table dept -- 추가
add(bigo    varchar2(10));

alter table dept -- 테이블 구조 변경
modify (bigo varchar2(20));

alter table dept -- bigo 삭제
drop column bigo;

drop table dept;
rollback;

rename dept2 to dept;
alter table dept
rename COLUMN loc to locno;

comment on table dept
is '임시 테이블';
select * 
from user_tab_comments;
comment on column dept.locno
is '부서가 위치한 지역';
select * 
from user_col_comments;

-------------------p.324 문제 1번
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
-- 2번
alter table  EMP_HW 
add(bigo    varchar2(20));
--3번
alter table EMP_HW
modify(bigo   varchar2(30));
--4번
alter table EMP_HW
rename COLUMN bigo to remark;
--5번
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