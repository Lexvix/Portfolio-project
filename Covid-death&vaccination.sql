/*
Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/


SELECT * FROM portfolio.`covid-death` 
where continent <> '' 
order by 3,4;

SELECT * FROM portfolio.`covid-vaccinations` 
where continent <> '' 
order by 3,4;

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM portfolio.`covid-death` order by 1,2;

SELECT location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM portfolio.`covid-death` 
where location like 'Australia'
order by 1,2;

SELECT location, date, population, total_cases,  (total_cases/population)*100 as PercentpopulationInfected
FROM portfolio.`covid-death` 
where location like 'Australia'
order by 1,2;




SELECT continent, MAX(cast(total_deaths as signed))as totaldeathcount
FROM portfolio.`covid-death` 
where continent <> '' 
group by continent
order by totaldeathcount desc;

#1#
SELECT #date,
sum(new_cases) as total_cases, sum(cast(new_deaths as signed)) as total_deaths, sum(cast(new_deaths as signed))/sum(new_cases)*100 as DeathPercentage
FROM portfolio.`covid-death` 
where continent <> '' 
#group by date
order by 1,2;


#2#
select location, sum(cast(new_deaths as signed)) as totaldeathcount
from portfolio.`covid-death` 
where continent = ''
and location not in ('World', 'European Union','International','High income','Low income')
group by location
order by totaldeathcount desc;


#3#
SELECT location, population, max(total_cases) as HighestInfectionCount,  max(total_cases/population)*100 as PercentpopulationInfected
FROM portfolio.`covid-death` 
where continent <> '' 
group by location, population
order by PercentpopulationInfected desc;


#4#
SELECT location, date, population, max(total_cases) as highestinfectioncount,  max(total_cases/population)*100 as PercentpopulationInfected
FROM portfolio.`covid-death` 
#where location like 'Australia'
group by location, population, date
order by PercentpopulationInfected desc;




SELECT dea.continent, dea.location, dea.date, dea.population, convert(vac.new_vaccinations, signed),
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by dea.location, dea.date) as Rolling_vaccinated
FROM portfolio.`covid-death` dea
JOIN portfolio.`covid-vaccinations` vac
    on dea.location = vac.location
    and dea.date = vac.date 
where dea.continent <> '' 
order by 2,3;



#use CTE

with PopulationVsVaccination(continent, location, date, population, new_vaccination, rollingpeoplevaccinated)
as
(
SELECT dea.continent, dea.location, dea.date, dea.population, convert(vac.new_vaccinations, signed),
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by dea.location, dea.date) as Rolling_vaccinated
#(Rolling_vaccinated/dea.population)*100 as vaccinated_rate
FROM portfolio.`covid-death` dea
JOIN portfolio.`covid-vaccinations` vac
    on dea.location = vac.location
    and dea.date = vac.date 
where dea.continent <> '' 
#order by 2,3
)
select *,(rollingpeoplevaccinated/population)*100 as vaccinated_rate
from PopulationVsVaccination;


#temp table

create table if not exists percentpopulationvaccinated
(
continent text,
location text,
date text,
population int,
new_vaccination int,
rolling_vaccination bigint
);

insert into percentpopulationvaccinated
SELECT dea.continent, dea.location, dea.date, dea.population,
convert(vac.new_vaccinations, unsigned) as new_vaccinations,
sum(cast(vac.new_vaccinations as unsigned)) over (partition by dea.location order by dea.location, dea.date)
as Rolling_vaccinated
FROM portfolio.`covid-death` dea
JOIN portfolio.`covid-vaccinations` vac
    on dea.location = vac.location
    and dea.date = vac.date 
where dea.continent <> '' and new_vaccinations <> '';
select *
from percentpopulationvaccinated;

create view percentpopulationvaccinated 
as
SELECT dea.continent, dea.location, dea.date, dea.population,
convert(vac.new_vaccinations, unsigned) as new_vaccinations,
sum(cast(vac.new_vaccinations as unsigned)) over (partition by dea.location order by dea.location, dea.date)
as Rolling_vaccinated
FROM portfolio.`covid-death` dea
JOIN portfolio.`covid-vaccinations` vac
    on dea.location = vac.location
    and dea.date = vac.date 
where dea.continent <> '' and new_vaccinations <> '';

