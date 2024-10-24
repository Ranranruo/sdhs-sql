CREATE TABLE department(
	deptno NUMBER(6) NOT NULL PRIMARY KEY,
	Deptname VARCHAR2(10),
	Floor NUMBER(2)
)
DROP TABLE employee;

INSERT INTO department VALUES (1, '기획', 8);
INSERT INTO department VALUES (2, '개발', 10);
INSERT INTO department VALUES (3, '영업', 9);
INSERT INTO department VALUES (4, '총무', 9);

SELECT * FROM DEPARTMENT;
SELECT * FROM employee;

CREATE TABLE human(
	gender VARCHAR()
)

CREATE TABLE department(
	deptno NUMBER(6) NOT NULL PRIMARY KEY,
	Deptname VARCHAR2(10),
	Floor NUMBER(2)
)
CREATE TABLE employee(
	Empno NUMBER(6) NOT NULL PRIMARY KEY,
	Empname VARCHAR2(9),
	Title VARCHAR2(6),
	Salary NUMBER(10),
	Supervisor number(5),
	dno number(1)
)

DROP TABLE employee;

INSERT INTO employee VALUES (1001, '박철수', '대리', 3000000, 1002, 1);
INSERT INTO employee VALUES (1002, '이민호', '과장', 3500000, 1003, 3);
INSERT INTO employee VALUES (1003, '김영희', '부장', 4000000, 1006, 2);
INSERT INTO employee VALUES (1004, '황진희', '대리', 3000000, 1002, 2);
INSERT INTO employee VALUES (1005, '정진우', '사원', 2500000, 1004, 1);
INSERT INTO employee VALUES (1006, '박현석', '이사', 5500000, NULL, 1);
INSERT INTO employee VALUES (1007, '김정현', '사원', 2500000, 1001, NULL);

SELECT * FROM employee;

-- 급여의 내림차순으로 정렬한 후  상위 2개의 정보만 조회하기
SELECT * FROM (SELECT * FROM EMPLOYEE order by salary desc) WHERE rownum <= 2;

-- 모든 사원의 수 조회하기
SELECT count(*) FROM EMPLOYEE;

-- 모든 사원의 평균 급여와 최대 급여를 조회하기
SELECT avg(salary), max(salary) FROM employee;

-- 모든 사원들의 중복을 제거한 급여의 개수와 평균 조회하기
SELECT count(distinct salary), avg(distinct salary) FROM employee;

SELECT DISTINCT salary FROM employee;

-- 자신의 상관이 있는 사원의 수 조회하기
-- 카운팅중 null 값이 있다면 카운트에 포함하지 않
SELECT COUNT(supervisor) FROM employee;

DELETE employee WHERE empno = 1008;
UPDATE employee SET salary = 1855000 WHERE empno = 1008;

-- 급여의 평균을 소수점 둘째 자리까지 조회하기
SELECT to_char(avg(salary), '9999999.99') FROM EMPLOYEE;

-- 급여를 천 단위마다 쉼표 찍어서 조회하기
SELECT to_char(salary, '9,999,999') FROM employee;
SELECT to_char(salary, 'fm9,999,999') FROM employee;

-- 각 부서별 급여의 합계를 구하기
SELECT dno, SUM(salary) FROM employee GROUP BY dno;

-- 각 부서별 사원수 구하기
SELECT dno, COUNT(*) FROM employee GROUP BY dno;

-- 사원수가 2명 이상인 부서에 대해서 부서별 사원수 구하기
SELECT dno, COUNT(*) FROM employee GROUP BY dno HAVING COUNT(*) >= 2;

-- 부서 번호가 1이 아닌 부서에 대하여 부서별 사원수 구하기
SELECT dno, COUNT(*) FROM employee WHERE dno != 1 GROUP BY dno;

-- 평균급여가 300만원을 초과하는 부서에 대하여 부서별 사원수와 평균 급여 구하여 부서별 사원수의 오름차순으로 조회하기
SELECT dno, COUNT(*), AVG(salary) FROM employee GROUP BY dno HAVING AVG(salary) > 3000000 ORDER BY COUNT(*) ASC;

-- 급여가 500만원 이하이고 부서가 있는 사원들에 대하여 사원들이 속한 부서번호 별로 그룹화하고,
-- 사원수가 2명 이상이면서 2번 부서가 아닌 부서에 대하여 부서번호, 부서별 사원수, 평균급여, 최대 급여를 조회하기

SELECT dno, COUNT(*), AVG(salary), MAX(salary)
FROM employee
WHERE salary <= 5000000 AND dno IS NOT NULL AND dno <> 2
GROUP BY dno
HAVING COUNT(*) >= 2

SELECT deptno
FROM DEPARTMENT
UNION ALL
SELECT salary
FROM EMPLOYEE

-- 김영희가 속한 부서이거나 영업부의 부서번호를 조회하기
SELECT dno
FROM employee
WHERE empname = '김영희'
UNION
SELECT deptno
FROM department
WHERE deptname = '영업'

-- 김영희 또는 이민호가 속한 부서이거나 영업부 부서 번호를 중복을 포함하여 조회하기
SELECT dno
FROM employee
WHERE empname = '김영희' OR empname = '이민호'
UNION
SELECT deptno
FROM department
WHERE deptname = '영업'

-- 김영희 또는 이민호가 속한 부서이거나 영업부 부서 번호를 중복을 포함하여 조회하기
SELECT dno
FROM employee
WHERE empname = '김영희' OR empname = '이민호'
UNION ALL
SELECT deptno
FROM department
WHERE deptname = '영업'
ORDER BY dno

-- 김영희 또는 이민호가 속한 부서이면서 영업부의 부서번호 조회하기
SELECT dno
FROM employee
WHERE empname = '김영희' OR empname = '이민호'
INTERSECT
SELECT deptno
FROM department
WHERE deptname = '영업'
ORDER BY dno

-- 소속된 직원이 한 명도 없는 부서 번호를 조회하기

SELECT deptno
FROM DEPARTMENT
MINUS
SELECT salary
FROM EMPLOYEE

-- 두 개 테이블 조인
SELECT deptname, empname
FROM department, employee
WHERE department.deptno = employee.dno

SELECT deptname dname, empname ename
FROM department d, employee e
WHERE d.deptno = e.dno

SELECT department.deptname, employee.empname
FROM department, employee
WHERE deptno = dno

SELECT detpname, empname
FROM employee JOIN department
ON department.deptno = employee.dno

-- 직책이 같은 사원들의 사원번호, 이름, 직책을 조회하기
SELECT e1.empno, e1.empname, e1.title, e2.empno, e2.empname, e2.title
FROM employee e1, employee e2
WHERE e1.title = e2.title
AND e1.empname <> e2.empname
AND e1.empno < e2.empno

-- 모든 직원의 번호, 부서명, 이름, 직급을 조회하기(NULL포함)
SELECT dno, deptname, empname, title
FROM employee, department
WHERE dno = deptno

SELECT dno, deptname, empname, title
FROM employee LEFT OUTER JOIN department
ON dno = deptno

SELECT dno, deptname, empname, title
FROM employee RIGHT OUTER JOIN department
ON dno = deptno

SELECT dno, deptname, empname, title
FROM employee FULL OUTER JOIN department
ON dno = deptno

-- 모든 부서에 속한 직원들 조회하기(NULL포함)
SELECT dno, deptname, empname, title
FROM employee FULL OUTER JOIN department
ON dno = deptno

-- 모든 직원에 대하여 이름, 직급, 직속, 부하직원의 이름, 직급 조회하기
SELECT e1.empname, e1.title, e2.empname, 2.title
FROM employee e1, employee e2
WHERE e1.empno = e2.supervisor
ORDER BY e1.empno

-- 모든 직원에 대하여 이름, 직급, 직속 상관의 이름, 직급 조회하기
SELECT e1.empname, e1.title, e2.empname, 2.title
FROM employee e1, employee e2
WHERE e1.supervisor = e2.empno

-- 모든 직원에 대하여 이름, 직급과 직속 상관의 이름을 검색하되 모든 상관과 모든 부하직원이 나타나도록 조회하기
SELECT e1.empname, e1.title, e2.empname, 2.title
FROM employee e1 FULL OUTER JOIN employee e2
WHERE e1.supervisor = e2.empno

-- 부서코드가 1인 직원의 모든 정보 조회하기
SELECT * FROM employee WHERE dno = 1

-- 기획부인 직원의 모든 정보 조회하기
select employee.* from employee, department
where dno = deptno and deptname

select * from employee
where dno in (select deptno from department where deptname = '기획')
-- 부서코드가 1아 어난 직원의 모든정보 조회하기
select * from employee where dno <> 1

-- 기획부가 아닌 직원의 모든 정보 조회하기
select employee.* from employee ,department where deptname != '기획' and deptno = dno;
select employee.* from employee ,department where deptno = dno and deptname != '기획';

-- 부서코드가 1 또는 2인 사원의 모든 정보 조회하기 이거
SELECT * FROM employee WHERE dno = 1 OR dno = 2
SELECT * FROM employee WHERE dno in (1, 2)

-- 부서가 '기획'또는 '개발'인 직원의 모든 정보 조회하기
select * from employee right outer join department d on d.deptname = '개발' or d.deptname = '기획'
select * from employee left outer join department d on d.deptname = '개발' or d.deptname = '기획'

-- 부서코드가 1또는 2가 아닌 직원의 모든 정보 조회하기
select * from employee
where ()dno != 1 and dno != 2) or dno is null;

-- 부서가 '기획' 또는 '개발'이 아닌 직원의 모든 정보조회하기
select * from department, employee where deptname !='기획' and deptname !='개발'

select employee.*
from department, employee
where dno = deptno
and deptname !='기획' and deptname !='개발'

-- 1번 부서에 근무하는 직원들의 직급, 이름, 급여를 검색하여 급여의 오름차순으로 정렬하기
select title, empname, salary
from employee
where dno = 1
order by salary asc

-- 기획부에 근무하는 직원들의 직급, 이름, 급여를 검색하여 급여의 오름차순으로 정렬하기
select e.title, e.empname, e.salary
from employee e
join department d
on e.dno = d.deptno
where d.deptname = '기획'
order by e.salary asc;

-- 각 부서별 급여의 함계를 구하기
select d.deptname,sum(e.salary)
from department d
left outer join employee e on d.deptno = e.dno
group by d.deptname

-- 각 부서별 사원수 구하기
select deptname, count(employee.*)
from department, employee
where deptno = dno
group by deptname

-- 각 부서별 급여의 최대값 구하기
select deptname, max(salary)
from department, employee
where deptno = dno
group by deptname

-- 영업부가 아닌 부서의 사원수와 월급의 합계 구하기
select count(*), sum(salary)
from employee
where dno <> (select deptno from department where deptname = '영업')

select count(*), sum(salary)
from employee
where dno in (select deptno from department where deptname <> '영업')

select count(*), sum(salary)
from employee, department
where dno = deptno
and deptname <> '영업'


-- 1 모든 사원의 직급을 중복없이 검색하세요
SELECT distinct title
FROM employee


-- 2 가장 급여를 많이 받는 사원과 가장 급여를 적게 받는 사원 검색
SELECT *
FROM employee 
WHERE salary IN((SELECT MAX(salary) FROM employee), (SELECT MIN(salary) FROM employee))
ORDER BY salary DESC

-- 3 가장 급여를 많이 받는 사람이 소속된 부서에 속한 모든 사원을 검색하세요.
SELECT *
FROM employee
WHERE dno
IN (SELECT dno FROM employee WHERE salary IN(SELECT MAX(salary) FROM employee))

-- 4 모든 부서에 속한 사원의 수를 부서명과 사원수로 검색하세요.
SELECT d.deptname, COUNT(e.dno)
FROM department d
JOIN employee e ON d.deptno = e.dno
GROUP BY d.deptname

SELECT deptname, count(empno)
FROM department LEFT OUTER JOIN employee
ON deptno = dno
GROUP BY deptname

-- 5 8층에 있는 사원수를 검색하세요.
SELECT COUNT(*)
FROM department d
JOIN employee e
ON e.dno = d.deptno
GROUP BY d.floor
HAVING d.floor = 8

-- 6 상사와 다른 부서에 속한 모든 사원의 정보를 검색하세요.
SELECT e.*
FROM employee e, employee s
WHERE e.supervisor = s.empno
AND s.dno <> e.dno

-- 7 상사와 같은 부서에 속한 모든 사원의 정보를 검색하세요.
SELECT e.*
FROM employee e, employee s
WHERE e.supervisor = s.empno
AND s.dno = e.dno

-- 8 상사가 없는 모든 사원의 정보를 검색하세요.
SELECT *
FROM employee
WHERE supervisor IS NULL

-- 9 월급이 15%인상한 경우 회사가 더 지급해야 하는 금액을 검색하세요.
SELECT SUM(salary * 1.15) - SUM(salary)
FROM employee 

-- 10 8층에 있는 대리의 이름, 부서명, 급여를 검색하세요.
SELECT e.empname, d.deptname, e.salary
FROM employee e
JOIN department d ON e.dno = d.deptno
WHERE e.title = '대리' AND d.floor = 8

-- 11 모든 사원의 직급별 평균 급여를 검색하세요.
SELECT e.title, AVG(e.salary)
FROM employee e
GROUP BY e.title

-- 12 기획부가 아닌 부서의 평균 급여를 검색하세요.
SELECT AVG(e.salary)
FROM employee e
JOIN department d ON e.dno = d.deptno
WHERE d.deptname <> '기획'

-- 10층에 근무하는 사원의 급여총합을 구하시오
select *
from employee join department
where e.floor = 8
 
SELECT *
FROM employee JOIN department ON 
-- 13 직급별 급여 총액이 가장 큰 직급의 직급명, 평균급여, 사원수를 검색하세요
SELECT title, AVG(salary), COUNT(*)
FROM employee
HAVING SUM(salary) = (SELECT MAX(SUM(salary)) FROM employee GROUP BY title)
GROUP BY title

-- 14 모든 사원의 사원이름과 상사의 이름을 검색하세요.
SELECT e1.empname, e2.empname
FROM employee e1
JOIN employee e2 ON e1.supervisor = e2.empno


-- 15 모든 직원의 사원이름과 부서 이름을 검색하세요.
SELECT e.empname, d.deptname
FROM employee e
JOIN department d ON e.dno = d.deptno

-- 16 모든 직원의 사원이름과 부하직원의 이름을 검색하세요.
SELECT e1.empname, e2.empname
FROM employee e1
JOIN employee e2 ON e1.empno = e2.supervisor

-- 17 기획부서나 영업부서에 속한 사원의 이름을 검색하세요.
SELECT e.empname
FROM employee e
JOIN department d ON e.dno = d.deptno
WHERE d.deptname IN ('기획', '영업')

-- 18 기획부서나 영업부서에 속하지 않은 사원의 이름을 검색하세요.
SELECT e.empname
FROM employee e
JOIN department d ON e.dno = d.deptno
WHERE d.deptname NOT IN ('기획', '영업')

-- 19 소속 직원이 하나도 없는 부서명을 검색하세요.
SELECT d.deptname
FROM department d JOIN employee e ON d.deptno = e.dno
WHERE e.dno IS NULL
	
-- 질의하기(10)

-- 황진희와 같은 부서에 근무하는 사원들의 이름과 부서 이름 조회하기
SELECT empname, deptname
FROM employee, department
WHERE dno = deptno
AND dno IN (SELECT dno FROM employee WHERE empname = '황진희')

-- 부서별 평균급여가 황진희보다 높은 부서에 대하여 부서번호와 평균급여를 조회하기
SELECT dno, AVG(salary)
FROM employee
HAVING AVG(salary) > (SELECT salary FROM employee WHERE empname = '황진희')
GROUP BY dno

-- 각 부서별 급여를 가장 많이 받는 직원 조회하기
SELECT *
FROM employee e1
WHERE salary = (SELECT MAX(salary) FROM employee e2 WHERE e1.dno = e2.dno GROUP BY dno)
ORDER BY dno

-- 부서의 모든 직원이 황진희 보다 월급을 많이 받는 부서의 직원 조회하기
SELECT *
FROM employee e1
WHERE (SELECT salary FROM employee WHERE empname = '황진희') < ALL (SELECT salary FROM employee e2 WHERE e1.dno = e2.dno)
AND dno IS NOT NULL

SELECT * FROM employee WHERE dno = (
	SELECT dno 
	FROM employee e
	WHERE salary > (
		SELECT salary
		FROM employee
		WHERE empname = '황진희'
		)
	GROUP BY dno
	HAVING COUNT(*) = (
		SELECT COUNT(*)
		FROM employee
		GROUP BY dno
		HAVING dno = e.dno
	)
)
-- 급여가 300만원을 초과하는 직원이 속한 부서와 같은 부서에 근무하는 직원 조회하기(in)
SELECT *
FROM employee
WHERE dno in (
	SELECT dno
	FROM employee
	WHERE salary > 3000000
	)

-- 개발부서의 최대급여보다 많은 급여를 받는 직원 조회하기
SELECT *
FROM employee
WHERE salary > (
	SELECT MAX(salary)
	FROM employee, department
	WHERE dno = deptno
	AND deptname = '개발'
	)
	
-- 개발부서의 급여보다 많은 급여를 받는 직원 조회하기(all)
SELECT *
FROM employee
WHERE salary > ALL (
	SELECT salary
	FROM employee, department
	WHERE dno = deptno
	AND deptname = '개발'
	)
	
-- 개발부서의 최소급여보다 적은 급여를 받는 직원 조회하기
SELECT *
FROM employee
WHERE salary < ALL (
	SELECT salary
	FROM employee, department
	WHERE dno = deptno
	AND deptname = '개발'
	)
	
-- 기획부나 영업부에 근무하는 직원들의 이름과 부서번호를 조회하기
SELECT empname, dno
FROM employee e
WHERE dno IN (
	SELECT deptno
	FROM department
	WHERE deptname = '기획'
	OR deptname = '영업'
	)
	
SELECT empname, dno
FROM employee, department
WHERE dno = deptno
AND deptname IN ('기획', '영업')

-- 연산자의 우선순위로 인해서 AND 연산이 먼저 수행되고 그 다음에 OR연산자가 수행되서
-- 괄호를 쓰지 않으면 원하는 결과가 나오지 않는다.
SELECT empname, dno
FROM employee INNER JOIN department
ON dno = deptno
AND ( deptname = '기획'
OR deptname = '양압')
-- 기획부나 영업부에 근무하지 않는 직원들의 이름과 부서 조회하기
SELECT empname, dno
FROM employee department
ON dno = deptno
WHERE deptname NOT IN ('기획', '영업')

-- 황진희와 같은 직급의 직원들이 근무하는 부서 이름 조회하기
SELECT deptname FROM department LEFT OUTER JOIN employee
ON deptno = dno
WHERE title = (SELECT title FROM employee WHERE empname = '황진희') AND empname != '황진희'

-- 자신이 속한 부서의 평균 급여보다 많은 급여를 받는 직원들의 이름, 부서번호, 급여 조회하기(신민석)
SELECT empname, dno, salary
FROM department 
INNER JOIN employee
ON deptno = dno
WHERE SALARY > (SELECT AVG(salary) FROM employee WHERE deptno = dno)

SELECT empname, e.dno, salary
FROM employee e, (SELECT dno, AVG(salary) avg_salary FROM employee GROUP BY dno) avg
WHERE e.dno = avg.dno
AND salary > avg_salary

-- 문제랑 상관없는 SQL
SELECT empname dno
FROM employee LEFT OUT JOIN department
ON dno = deptno
WHERE deptname NOT IN ('기획', '영업')
OR dno IS null;

-- 직원이 2명 이상인 부서의 부서이름 조회하기(의준홍)
SELECT deptname
FROM department, employee
WHERE deptno = dno
HAVING count(*) >=
GROUP BY deptname

-- 부서별 직원들의 최대 급여를 부서명, 부서별 직원 최대 급여 순으로 조회하기(윤지상)
SELECT deptname, MAX(salary)
FROM employee, department
WHERE dno = deptno
GROUP BY deptname

-- 기획부서에 근무하는 직원들의 모든 정보 조회하기(이석훈)
SELECT *
FROM employee e JOIN department d
ON e.dno = d.deptno
WHERE deptname = '기획'

SELECT *
FROM employee
WHERE EXISTS (SELECT * FROM department WHERE deptname = '기획' AND deptno = dno)

-- 기획부서에 근무하지 않는 직원들의 모든 정보 조회하기(이은상)
-- 이때는 부서가 null인 아이는 가져오지 않는다.
SELECT *
FROM employee, department
WHERE deptno = dno
AND deptname != '기획'

-- 기획부서에 근무하지 않는 직원들의 모든 정보 조회하기 EXISTS 사용해서
-- 이떄는 부서가 null인 아이도 가져온다.
SELECT *
FROM employee
WHERE NOT EXISTS (SELECT * FROM department WHERE deptname = '기획' AND deptno = dno)

-- 직급이 대리이면 대머리로 바꾸고 나머지 직읍은 그대로 조회하기
SELECT DECODE(title, '대리', '대머리', title)
FROM employee

-- 부서별 월급의 평균을 소수 2자리까지 나오게하고 세자리마다 쉼표 표시하기
-- fm: 포맷(결과값의 공백 삭제)
-- s: 사인(결과값 앞에 +기호 추가)
-- .: 소숫점
-- ,: 쉼표 추가

SELECT dno, TO_CHAR(AVG(salary), 's9,999,999.99')
FROM employee
GROUP BY dno

-- case 키워드
-- 기획부 월급평균, 영업부 월급평균 구하기
SELECT (AVG(salary)
FROM employee, department
WHERE dno = deptno
AND deptname = '기획'),
(AVG(salary)
FROM employee, department
WHERE dno = deptno
AND deptname = '영업')
FROM dual

SELECT AVG(CASE dno WHEN 1 THEN salary ELSE NULL END), AVG(CASE dno WHEN 2 THEN salary ELSE NULL END)
FROM employee

SELECT AVG(CASE deptname WHEN '기획' THEN salary ELSE NULL END) 기획부평균급여,
AVG(CASE deptname WHEN '기획' THEN salary ELSE NULL END) 영업부평균급여
FROM employee, department
WHERE dno = deptno

-- 월급이 300만원 이상인 사람들의 수와 미만인 사람들의 수 구하기
SELECT COUNT(CASE WHEN salary >= 3000000 THEN salary ELSE NULL END),AVG(CASE deptname WHEN '기획' THEN salary ELSE NULL END) 기획부평균급여,
COUNT(CASE WHEN salary < 3000000 THEN salary ELSE NULL END),AVG(CASE deptname WHEN '기획' THEN salary ELSE NULL END) 기획부평균급여
FROM employee

-- 직급이 대리이면 대머리로 바꾸고 나머지 직급은 그대로 조회하기(case)
SELECT CASE title WHEN '대리' THEN '대머리' ELSE title END
FROM employee

-- 1번부서는 기획, 2번부서는 영엽으로 조회하기
SELECT CASE dno WHEN 1 THEN '기획' WHEN 2 THEN '영업' END
FROM employee    

-- 400만원 이상이면 고임금자, 300만원 미만은 저임금자, 그 사이는 중위임금자(이정우)
SELECT CASE WHEN salary >= 4000000 THEN '고임금자'
WHEN salary < 3000000 then '저임금자'
ELSE '중위임금자' END
FROM employee

-- 이사 부장은 노쟁불가, 나머지는 노쟁가능(진효빈)
SELECT title, CASE title WHEN '부장' THEN '임원'
WHEN '이사' THEN '임원'
ELSE '노조원' END
FROM employee

SELECT title, CASE WHEN title IN('부장', 이사) THEN '임원'
ELSE '노조원' END

-- rank
-- 월급의 역순으로 순위 구하
SELECT empname, salary, rank() OVER (ORDER BY salary DESC)
FROM employee

-- 월급의 역순으로 순위를 중복순위를 없어지지 않도록 하기
SELECT empname, salary, dense_rank() OVER (ORDER BY salary DESC)
FROM employee

-- 월급의 역순으로 순위 구하기, 동일 순위의 경우 두번째 조건(부서번호의 오름차순) 으로 순위 구하기
-- Oracle에서는 NULL이 숫자보다 크다.
SELECT empname, dno, salary, RANK() OVER (ORDER BY salary DESC, dno ASC)
FROM employee

-- 선생님 SQL 문제

CREATE TABLE member_tbl(
	id VARCHAR2(5) NOT NULL PRIMARY KEY,
	name VARCHAR2(20),
	gender VARCHAR2(3)
)

INSERT INTO member_tbl(id, name, gender) VALUES ('10301', '권기현', '남');
INSERT INTO member_tbl(id, name, gender) VALUES ('10302', '구지우', '여');
INSERT INTO member_tbl(id, name, gender) VALUES ('10303', '권태준', '남');
INSERT INTO member_tbl(id, name, gender) VALUES ('10304', '금기연', '여');
INSERT INTO member_tbl(id, name, gender) VALUES ('10305', '김영진', '남');
INSERT INTO member_tbl(id, name, gender) VALUES ('10401', '김주현', '남');
INSERT INTO member_tbl(id, name, gender) VALUES ('10402', '김태민', '여');
INSERT INTO member_tbl(id, name, gender) VALUES ('10403', '임수민', '여');
INSERT INTO member_tbl(id, name, gender) VALUES ('10404', '남상도', '남');
INSERT INTO member_tbl(id, name, gender) VALUES ('10405', '조은호', '여');




<<<<<<< HEAD
=======
-- `부서별 직원들의 최대 급여를 부서명, 부서별 직원 최대 급여 순으로 조회하기
>>>>>>> cddd14ef518385cdbd25af51c8fafdfee17bc1f8
