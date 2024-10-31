DROP TABLE customer;
DROP TABLE book;
DROP TABLE orders;

create table customer
(
   cno number primary key,
   name varchar2(10),
   address varchar2(30),
   phone varchar2(13)
);

create table book
(
   bno number primary key,
   name varchar2(50),
   publisher varchar2(50),
   price number
);

create table orders
(
   orderno number primary key,
   cno number,
   bno number,
   price number,
   sdate date,
   FOREIGN KEY (cno) REFERENCES customer(cno),
   FOREIGN KEY (bno) REFERENCES book(bno)
);

insert into customer
values (1, '박지성',    '영국 맨체스터', '000-5000-0001');
insert into customer
values (2,    '김연아', '대한민국 서울', '000-6000-0001');
insert into customer
values (3,    '장미란',    '대한민국 강원도', '000-7000-0001');
insert into customer
values (4,    '추신수',     '미국 클리블랜드', '000-8000-0001');
insert into customer
values (5,    '박세리', '대한민국 대전', null);

insert all
into book values (1,'축구의 역사', '굿스포츠', 7000)
into book values (2,'축구 아는 여자', '나무수',    13000)
into book values (3,'축구의 이해', '대한미디어',    22000)
into book values (4,'골프 바이블', '대한미디어',    35000)
into book values (5,'피겨 교본', '굿스포츠',    8000)
into book values (6,'역도 단계별 기술', '굿스포츠',    6000)
into book values (7,'야구의 추억', '이상미디어',    20000)
into book values (8,'야구를 부탁해', '이상미디어',    13000)
into book values (9,'올림픽 이야기', '삼성당    ',7500)
into book values (10,'Olympic Champions', 'Pearson',13000)
into orders values (1,    1,    1,    6000,    '2020-07-01')
into orders values (2,    1,    3,    21000,    '2020-07-03')
into orders values (3,    2,    5,    8000,    '2020-07-03')
into orders values (4,    3,    6,    6000,    '2020-07-04')
into orders values (5,    4,    7,    20000,    '2020-07-05')
into orders values (6,    3,    10,    12000,    '2020-07-07')
into orders values (7,    4,    8,    13000,    '2020-07-07')
into orders values (8,    3,    10,    12000,    '2020-07-08')
into orders values (9,    2,    10,    7000,    '2020-07—09')
into orders values (10,    3,    8,    13000,    '2020-07-10')
SELECT * FROM dual;

-- 기본 질의

-- 모든 도서의 이름과 가격을 검색하시오.
SELECT name, price FROM book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT * FROM book;

-- 도서 테이블에 있는 모든 출판사를 검색하시오.
SELECT publisher FROM book;

-- 도서 테이블에 있는 모든 출판사를 중복없이 검색하시오.
SELECT distinct publisher FROM book;

-- 조건 질의(1)

-- 가격이 20000원 미만인 도서를 검색하시오.
SELECT * FROM book WHERE price <= 20000;

-- 가격이 10000원 이상, 20000원 이하인 도서를 검색하시오.
SELECT * FROM book WHERE price >= 10000 AND price <= 20000;

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오
SELECT * FROM book WHERE publisher = '굿스포츠' OR publisher = '대한미디어';

-- 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 검색하시오
SELECT * FROM book WHERE publisher != '굿스포츠' AND publisher != '대한미디어';

-- '축구의 역사'를 출간한 출판사를 검색하시오
SELECT publisher FROM book WHERE name = '축구의 역사';

-- 도서이름에 '축구'가 포함된 출판사를 검색하시오.
SELECT publisher FROM book WHERE name LIKE '%축구%';

-- 도서이름의 왼쪽 두번째 위치에 '구' 라는 문자열을 갖는 도서를 검색하시오.
SELECT * FROM book WHERE name LIKE '_구%';

-- 조건 질의(2)

-- 축구에 관한 도서 중 가격이 20000원 이상인 도서를 검색하시오
SELECT * FROM book WHERE name LIKE '%축구%' AND price >= 20000; 

-- 도서를 이름순으로 검색하시오
SELECT * FROM book ORDER BY name;

-- 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT * FROM book ORDER BY price, name;

-- 도서를 가격의 내림차순으로 검색하고, 만약 가격이 같다면 출판사의 오름차순으로 출력하시오.
SELECT * FROM book ORDER BY price DESC, publisher ASC;

-- 집단함수와 GROUP BY 

-- 고객이 주문한 도서의 총판매액을 구하시오
SELECT SUM(price) FROM orders;

-- 2번 김연아 고객이 주문한 도서의 총판매액을 구하시오.
SELECT SUM(price) FROM orders WHERE cno = 2;

-- 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하시오
SELECT SUM(price), AVG(price), MIN(price), MAX(price) FROM orders;

-- 도서 판매 건수를 구하시오
SELECT COUNT(*) FROM orders;

-- 고객별로 주문한 도서의 총수량과 총판매액을 구하시오.
SELECT cno, COUNT(*), SUM(price) FROM orders GROUP BY cno;

-- 가격이 8천원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총수량을 구하시되. 단 2권 이상 구매한 고객만 구하시오
SELECT cno, COUNT(*) FROM orders WHERE price >= 8000 GROUP BY cno HAVING COUNT(*) >= 2;

-- SQL 연습2(with PPT)

-- 1. 고객과 고객의 주문을 조회하세요.
SELECT * FROM customer INNER JOIN orders ON customer.cno = orders.cno 

-- 2. 고객과 고객의 주문에 대해 고객별로 정렬하여 조회하세요.
SELECT * FROM customer INNER JOIN orders ON customer.cno = orders.cno ORDER BY customer.name

-- 3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하세요.
SELECT customer.name, orders.price FROM customer INNER JOIN orders ON customer.cno = orders.cno;

SELECT c.name, SUM(b.price)
FROM customer c, orders, book b
WHERE c.cno = orders.cno
AND b.bno = orders.bno
GROUP BY c.name;

-- 4. 고객별로 주문한 모든 도서의 총판매액을 구하고, 고객별로 정렬하세요.
SELECT c.name, SUM(price)
FROM customer c, orders
WHERE c.cno = orders.cno
GROUP BY c.name;


-- 5. 고객의 이름과 고객이 주문한 도서의 이름을 조회하세요. 
SELECT c.name, b.name
FROM customer c, book b, orders o
WHERE c.cno = o.cno
AND b.bno = o.bno

-- 6. 가격이 2만원 이상인 도서를 주문한 고객의 이름과 도서의 이름을 구하세요.
SELECT c.name, b.name
FROM customer c, book b, orders o
WHERE c.cno = o.cno
AND b.bno = o.bno
AND b.price >= 20000

-- 7. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매 가격을 구하세요.
SELECT c.name, SUM(o.price)
FROM customer c
LEFT OUTER JOIN orders o
ON c.cno = o.cno
GROUP BY c.name

-- 8. 가장 비싼 도서의 이름을 조회하세요.
SELECT name 
FROM book
WHERE price = (SELECT MAX(price) FROM book)

-- 9. 도서를 구매한 적이 있는 고객의 이름을 검색하세요
SELECT DISTINCT name
FROM customer
INNER JOIN orders
ON customer.cno = orders.cno

-- 10. `대한미디어`에서 출판한 도서를 구매한 고객의 이름을 조회하세요.
SELECT c.name
FROM customer c, book b, orders o
WHERE c.cno = o.cno
AND b.bno = o.bno
AND o.bno IN(SELECT bno FROM book WHERE publisher = '대한미디어')

-- 11. 출판사별로 출판사의 평균 도서가격 보다 비싼 도서를 조회하세요.
SELECT b1.publisher, b1.name
FROM book b1
WHERE price > (SELECT AVG(b2.price) FROM book b2 WHERE b2.publisher = b1.publisher)


-- 12. 도서를 주문하지 않은 고객의 이름을 조회하세요
SELECT c1.name
FROM customer c1
MINUS
SELECT c2.name
FROM customer c2, orders
WHERE c2.cno = orders.cno

-- 13. 주문이 있는 고객의 이름과 주소를 조회하세요.
SELECT c.name, c.address
FROM customer c
WHERE EXISTS(SELECT * FROM orders o WHERE o.cno = c.cno)

-- 14. 도서번호가 1인 도서의 이름을 조회하세요
SELECT name 
FROM book
WHERE bno = 1

-- 15. 가격이 2만원 이상인 도서의 이름을 조회하세요.
SELECT name
FROM book
WHERE price >= 20000

-- 16. 박지성의 총구매액을 조회하세요.
SELECT SUM(o.price)
FROM customer c, orders o
WHERE c.cno = o.cno
GROUP BY c.cno
HAVING c.cno = (SELECT cno FROM customer WHERE name = '박지성')

-- 17. 박지성이 구매한 도서의 수를 조회하세요.
SELECT COUNT(*)
FROM customer c, orders o
WHERE c.cno = o.cno
GROUP BY c.cno
HAVING c.cno = (SELECT cno FROM customer WHERE name = '박지성')

-- 18. 박지성이 구매한 도서의 출판사 수를 조회하세요.
SELECT COUNT(b.publisher)
FROM customer c, orders o, book b
WHERE c.cno = o.cno
AND b.bno = o.bno
AND c.cno = (SELECT cno FROM customer WHERE name = '박지성')

-- 19. 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이를 조회하세요.
SELECT b.name, b.price, (b.price - o.price)
FROM customer c, book b, orders o
WHERE c.cno = o.cno
AND b.bno = o.bno
AND c.name = '박지성'

-- 20. 박지성이 구매하지 않은 도서의 이름을 조회하세요.
SELECT b.name
FROM book b, orders o
WHERE b.bno = o.bno
AND o.cno <> (SELECT cno FROM customer WHERE name = '박지성')

-- 21. 서점에서 취급하고 있는 모든 도서의 총 수를 구하세요.
SELECT COUNT(*)
FROM book

-- 22. 서점에서 도서를 출고하는 출판사의 총 수를 구하세요.
SELECT COUNT(DISTINCT publisher)
FROM book

-- 23. 모든 고객의 이름과 주소를 조회하세요.
SELECT name, address
FROM customer

-- 24. 2020년 7월4일~2020년 7월 7일 사이에 주문받은 도서의 주문번호를 조회하세요.
SELECT orderno
FROM orders o
WHERE sdate >= '2020-07-04'
AND sdate <= '2020-07-07'

-- 25. 2020년 7월4일~2020년 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호를 조회하세요.
SELECT orderno
FROM orders o1
MINUS
SELECT orderno
FROM orders o2
WHERE sdate >= '2020-07-04'
AND sdate <= '2020-07-07'

-- 26. 성이 '김'씨인 고객의 이름과 주소를 조회하세요
SELECT name, address
FROM customer
WHERE name LIKE '김%';

-- 27. 성이 '김'씨이고, 이름이 '아'로 끝나는 고객의 이름과 주소를 조회하세요.
SELECT name, address
FROM customer
WHERE name LIKE '김%아';

-- 28. 주문하지 않은 고객의 이름을 조회하세요.
SELECT name
FROM customer
MINUS
SELECT DISTINCT name
FROM customer
INNER JOIN orders
ON customer.cno = orders.cno

-- 29. 주문 금액의 총액과 주문 금액의 평균을 조회하세요.
SELECT SUM(price), AVG(price)
FROM orders

-- 30. 고객의 이름과 고객별 구매금액을 조회하세요.
SELECT c.name, SUM(o.price)
FROM customer c, orders o
WHERE c.cno = o.cno
GROUP BY c.name

-- 31. 고객의 이름과 고객이 구매한 도서의 이름을 조회하세요.
SELECT c.name, b.name
FROM customer c, book b, orders o
WHERE c.cno = o.cno
AND b.bno = o.bno

-- 32. 도서의 가격과 판매가격의 차이가 가장 큰 주문을 조회하세요.
SELECT o.*
FROM book b, orders o
WHERE b.bno = o.bno
AND (b.price - o.price) = (SELECT MAX(b.price - o.price) FROM book b, orders o WHERE b.bno = o.bno)

-- 33. 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름을 조회하세요.

