select* 
from user_constraints;

select*
from user_cons_columns;

alter table dept -- 제약조건
add constraint dept_deptno_pk primary key(deptno);

delete dept 
where locno is null;

alter table dept -- 제약조건
modify (dname varchar2(20) not null);

alter table dept -- 제약조건 삭제
drop constraint sys_c007036;

alter table dept -- 제약조건 primary key 삭제
drop constraint DEPT_DEPTNO_PK;


alter table dept --기본키 설정(deptno)
add constraint dept_deptno_pk primary key (deptno);

alter table dept -- locno : not null 지정
modify (locno varchar2(20) not null);

--뷰
create or replace view vdept50
as select employee_id, first_name,hire_date, salary, salary*12 as annsal
            from employees
            where  department_id = 50;
select *
from vdept50;

--view 급여가 10000이상인 사원 maxsal_view
-- 사번, 이름(first_name), 입사일자, 직무, 부서코드, 부서이름, 급여
create or replace view maxsal_view -- 기존에 만든 테이블에서 열을 추가 하고 싶으면 (or replace)를 넣어야함.
as select e.employee_id, e.first_name, hire_date, job_id, d.department_id, d.department_name, salary
            from employees e join departments d on(e.department_id = d.department_id)
            where salary >= 10000;
select *
from maxsal_view;

select*
from user_indexes;

select*
from user_ind_columns;

create sequence dept_deptno_sq -- 시퀀스
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

drop sequence dept_deptno_sq; -- 시퀀스 삭제

--시퀀스를 이용해서 데이터 추가
create SEQUENCE dept_deptno_sq -- 시퀀스 생성 , 증가 10, 초기값 ?, 최대값 400, 
 increment by 10
    start with 360
    maxvalue 400
    nocycle
    nocache;

create synonym empt -- 동의어
for employees;

select*
from empt;

create synonym dep -- 동의어 생성
for departments;

-- 사원번호, 이름, 부서코드, 부서명, 위치코드
-- synonym 이용
select employee_id, first_name, dep.department_name, location_id
from empt join dep on(empt.department_id = dep.department_id);

select*
from system_privilege_map;

select rownum, e.*
from (select *
        from empt 
        order by salary desc) e 
where rownum <=3;


