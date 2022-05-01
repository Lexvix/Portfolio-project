SELECT * FROM portfolio.chicagopublicschools;

select count(*) from portfolio.chicagopublicschools
where Elementary_Middle_High_School = 'ES';

select max(SAFETY_SCORE)
as max_safety_score
from portfolio.chicagopublicschools;

select  NAME_OF_SCHOOL, SAFETY_SCORE from portfolio.chicagopublicschools
where SAFETY_SCORE = (select max(SAFETY_SCORE) from portfolio.chicagopublicschools);

select NAME_OF_SCHOOL, AVERAGE_STUDENT_ATTENDANCE
from portfolio.chicagopublicschools
order by AVERAGE_STUDENT_ATTENDANCE desc
limit 10;

select NAME_OF_SCHOOL, AVERAGE_STUDENT_ATTENDANCE
from portfolio.chicagopublicschools
where AVERAGE_STUDENT_ATTENDANCE <>''
order by AVERAGE_STUDENT_ATTENDANCE asc
limit 10; 

select NAME_OF_SCHOOL, AVERAGE_STUDENT_ATTENDANCE
from portfolio.chicagopublicschools
where 
AVERAGE_STUDENT_ATTENDANCE <>'' and
AVERAGE_STUDENT_ATTENDANCE < '70%';


select COMMUNITY_AREA_NAME, 
sum(COLLEGE_ENROLLMENT) as TOTAL_ENROLLMENTS
from portfolio.chicagopublicschools
group by COMMUNITY_AREA_NAME
order by TOTAL_ENROLLMENTS desc;


select COMMUNITY_AREA_NAME, 
sum(COLLEGE_ENROLLMENT) as TOTAL_ENROLLMENTS
from portfolio.chicagopublicschools
group by COMMUNITY_AREA_NAME
order by TOTAL_ENROLLMENTS asc
limit 5;


select NAME_OF_SCHOOL, SAFETY_SCORE
from portfolio.chicagopublicschools
order by SAFETY_SCORE asc
limit 5;
