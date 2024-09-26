CREATE TABLE department(
	deptno NUMBER(6) NOT NULL PRIMARY KEY,
	Deptname VARCHAR2(10),
	Floor NUMBER(2)
)
DROP TABLE department;

INSERT INTO department VALUES (1, '기획', 8);
INSERT INTO department VALUES (2, '개발', 10);
INSERT INTO department VALUES (3, '영업', 9);
INSERT INTO department VALUES (4, '총무', 9);

SELECT * FROM DEPARTMENT;

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
INSERT INTO employee VALUES (1007, '김정현', '사원', 2500000, 1001, 1);

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


-- 1
SELECT distinct title FROM employee

-- 2
SELECT * FROM employee WHERE salary IN((SELECT MAX(salary) FROM employee), (SELECT MIN(salary) FROM employee)) ORDER BY salary DESC

-- 3 
SELECT * FROM employee WHERE dno IN (SELECT dno FROM employee WHERE salary IN(SELECT MAX(salary) FROM employee))

-- 4
SELECT d.deptname, COUNT(e.dno) FROM department d JOIN employee e ON d.deptno = e.dno GROUP BY d.deptname

-- 5
SELECT COUNT(*) FROM department d JOIN employee e ON e.dno = d.deptno GROUP BY d.floor HAVING d.floor = 8

-- 6
SELECT e1 FROM employee e1, employee e2 WHERE e1.dno 

SELECT * FROM employee
SELECT * FROM department