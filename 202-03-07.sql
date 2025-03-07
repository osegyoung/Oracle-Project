select sysdate -1, 3+5 from dual;

select upper('ye dam'), lower('YE DAM'), initcap('  YE DAM')
from dual;

-- first_name에  s가 들어있는 사원의 이름, 급여, 부서명 조회
select first_name, salary, department_id
from employees
where lower(first_name) like '%s%'; -- 소문자와 대문자가 들어있는 사원 이름들이 다 나옴.

--'ye' 'dam' => ye dam
-- concat() concat는 문자를 연결해주는 함수
select concat('ye',concat(' ','dam')) as concat문제
from dual;


--이름에서 세번째 글자만 표시,이름의 글자수 표시
--이름에 a의 위치 표시(소,대문자 구별 없이 찾음)
--last_name 10자리에 표시, 왼쪽에 *로 채우기 ( lpad: 왼쪽 채우기, rpad: 오른쪽 채우기)
--급여  표시, % : 1000달러 -> 급여가 5000 %%%%%  
--부서코드가 80인 데이터 조회
select first_name, 
substr(first_name,3,1) as 첫글자, 
length(first_name) as 글자수, 
instr(lower(first_name),'a') as a_위치,
rpad(last_name,10,'*') as 마지막이름, 
department_id as 부서,
salary,
rpad(salary,salary/1000 + length(salary),'%') as 급여
from employees
where department_id = 80;

select lengthb('abc'), lengthb('한글')
from dual;

--주민번호의 뒷자리를 ****** 마킹 substr을 사용해서 다른 데이터가 들어와도 *로 표시 할 수 있음. 
select '050307-4224587' as 주민등록번호,replace('050307-4224587',substr('050307-4224587',-6,6),'******') as 뒷자리나만보임안알려,
trim('  한글'),' 한글',
trim('a' from 'aaaffffaaa'),
ltrim('<_aaa_>', '_>')
from dual;

--사원번호가 홀수면 1, 짝수면 0이 표시
--사원번호, 이름, 홀짝구분
select employee_id, first_name as 홀짝구분, mod(employee_id,2) --mod : 나머지를 구해주는 함수
from employees;

--사번, 이름, 입사일, 입사6개월 지난 시점의 날짜, 근속개월
select employee_id, first_name, hire_date,
        add_months(hire_date, 6),
       trunc( months_between(sysdate, hire_date) /12) as 몇개월차,
       next_day(sysdate,'수') as 다음날,
       last_day(sysdate) as 마지막날
from employees;

--날짜
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


-- 23) 사원 테이블의 이름을 조회. 단 첫 번째 컬럼은 이름을 대문자로 출력하고, 두 번째 컬럼은 이름을 소문자로 출력하고, 세 번째 컬럼은 이름의 첫 번째 철자는 대문자로, 나머지는 소문자로 조회.
select first_name, upper(first_name) as 첫번째, lower(first_name) as 두번째, initcap(first_name) AS 세번째 
from employees;


-- 24) 이름이 alexander(모두 소문자로 변환)인 사원의 이름과 월급 조회.
select first_name, salary
from employees
where lower(first_name) = 'alexander';

-- 25) 영어 단어 SMITH에서 SMI만 잘라서 조회.
 select substr('SMITH',1,3)
 from dual;

-- 26) 사원들의 이름(last_name)과 이름의 철자 개수를 출력.
select last_name, length(last_name)
from employees;


-- 27) 이름에 소문자 a가 존재하는 경우 몇 번째 자리에 위치하는지 조회.
select first_name, instr(first_name,'a')
from employees;

-- 28) 사원들의 이름과 월급을 조회. 단 월급 컬럼의 자릿수를 10자리로 하고, 월급을 출력하고 남은 나머지 자리에 *(별표)를 채워서 조회. 10자리로 하고, 월급을 출력하고 남은 나머지 자리에 *(별표)를 채워서 조회.


-- 29) 사원들의 이름과 월급 조회. 단 월급은 1000을 네모(■) 하나로 출력.
-- 30) 숫자 876.567을 소수점 두 번째 자리까지 출력(반올림 처리)-- 31) 숫자 876.567을 소수 첫째 자리까지 출력(버림 처리)-- 32) 숫자 10을 3으로 나눈 나머지 값을 출력.
-- 33) 사원 번호와 사원 번호가 홀수이면 1, 짝수이면 0을 출력면 0을 출력.
-- 34) 사원번호가 짝수인 사원들의 사원 번호와 이름을 조회
-- 35) 사원의 이름과 입사한 날짜부터 오늘까지 총 몇 달을 근무했는지 조회(정수). 
select first_name,hire_date,trunc(months_between(sysdate,hire_date))||'개월' as 근속개월
from employees;


--변환 함수
--문자 변화함수: 숫자, 날짜 => 문자
-- #이 나온 이유는 자리가 부족하기 때문
select first_name, hire_date,to_char(hire_date,'yyyy/mm/dd day'),to_char(salary,'9999') 
from employees
where department_id =50;

alter session set
nls_date_format ='rr/mm/dd';

-- 추가수당 => 수당율이 null이면 200, 아니면 급여 * 수당율
--사번, 이름, 급여 추가수당
select employee_id, first_name, salary, 
    nvl2(commission_pct, commission_pct*salary, 200) as 추가수당
from employees;

--if-then-else
--급여가 < 1000 30% 인상, < 2000 %20 인상 , < 3000 %10 인상, 나머지는 동결
select first_name, salary, 
        case when salary < 1000 then salary*1.3
             when salary < 2000 then salary*1.2
             when salary < 3000 then salary*1.1
             else salary
             end
        as "인상된 급여"
from employees;

--부서코드가 20,30,50 -> '서울'
--60,70,80 -> '대구'
--나머지 -> '제주도'
select first_name, department_id,
case when department_id = 20 or department_id = 30 or department_id =50 then '서울'
     when department_id = 60 or department_id =70 or department_id = 80 then '대구'
     else '제주도'
     end
     as "부서분류"
from employees;

-- 36) 2018년 10월 1일에서 2019년 6월 1일 사이의 총일수 출력.
-- 37) 2018년 10월 1일에서 2019년 6월 1일 사이의 총 주(Week) 수를 출력(정수).
-- 38) 2023년 5월 1일로부터 100달 뒤의 날짜 출력.
-- 39) 2023년 5월 1일로부터 100일 후 날짜 출력.
-- 40) 2023년 6월 30일 이후 바로 돌아올 화요일의 날짜 출력
-- 41) 2023년 9월 19일 이후 바로 돌아올 토요일의 날짜 출력
-- 42) 오늘 이후 돌아올 금요일의 날짜 출력
-- 43) 2020년 5월 22일부터 100달 뒤에 돌아오는 화요일의 날짜 출력
-- 44) 오늘부터 100달 뒤에 돌아오는 월요일의 날짜 출력
-- 45) 2019년 5월 22일 해당 달의 마지막 날짜가 어떻게 되는지 조회
-- 46) 오늘부터 이번 달 말일까지 총 며칠 남았는지 조회
-- 47) 이름이 SUSAN인 사원의 이름, 입사일, 입사한 달의 마지막 날짜를 조회
-- 48) 이름(last_name)이 GRANT(대문자로 변환)인 사원의 이름과 입사한 요일을 출력하고, GRANT의 월급에 천단위를 구분할 수 있는 콤마(,)를 붙여 조회
-- 50) 2008년도에 입사한 사원의 이름과 입사일 조회(to_char 함수 사용)
-- 51) 월급이 1500 이상인 사원의 이름과, 월급에 천단위를 구분할 수 있는 콤마(,)와 화폐단위를 붙여 조회
-- 52) 2005년 06월 14일에 입사한 사원의 이름과 입사일 조회(to_date 함수 사용)
-- 53) 사원의 이름과 커미션을 조회. (단 커미션이 NULL인 사원들은 0)
-- 54) 직업이 'SA_MAN' 또는 'IT_PROG' 인 사원의 월급, 추가수당, 월급여 조회 - 추가수당 : 월급 * 커미션(단 커미션이 NULL인 경우 0)- 월급여 : 월급 + 추가수당

-- 55) 사원의 이름과 부서 번호, 보너스 조회보너스 : 부서 번호가 10번이면 300, 20번이면 400, 나머지 부서 번호는 0
select first_name, department_id, decode(department_id,10,300,20,400,0) as "조회보너스" 
from employees;

-- 56) 사원 번호와 사원 번호가 짝수인지 홀수인지를 조회
select employee_id, decode(mod(employee_id,2),0,'짝수',1,'홀수') as 사원번호유형 
from employees;

-- 57) 사원의 이름, 직업, 보너스 조회단 직무가 'SA_MAN'이면 보너스 5000나머지 직무는 보너스 2000
select first_name, job_id, decode(job_id,'SA_MAN',5000,2000) as "보너스"
from employees;

-- 58) 사원의 이름, 직업, 월급, 보너스 조회- 보너스 : 월급이 3000이상이면 500, 월급이 2000이상 3000미만이면 300, 월급이 1000이상 2000 미만이면 200, 나머지는 0
select first_name, job_id, salary, 
        case when salary >= 3000 then 500 
             when salary >= 2000 or salary < 3000 then 300 
             when salary >= 1000 or salary < 2000 then 200
             else 0            
             end 
            as "보너스" 
from employees;

-- 59) 사원의 이름, 직업, 커미션, 보너스 조회. 보너스 : 커미션이 NULL이면 500, NULL이 아니면 0
-- 60) 사원의 이름, 직업, 보너스 조회 - 보너스는 직무가 'SA_MAN', 'PU_CLERK' 이면 500, 'ST_CLERK', 'FI_ACCOUNT'이면 400 나머지  0