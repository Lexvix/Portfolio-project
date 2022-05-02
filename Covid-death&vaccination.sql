SELECT * FROM portfolio.`covid-death` 
where continent is not null 
order by 3,4;

SELECT * FROM portfolio.`covid-vaccinations` 
where continent is not null 
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

SELECT location, population, max(total_cases) as HighestInfectionCount,  max(total_cases/population) as PercentpopulationInfected
FROM portfolio.`covid-death` 
where continent is not null 
group by location, population
order by PercentpopulationInfected desc;


SELECT continent, MAX(cast(total_deaths as signed))as totaldeathcount
FROM portfolio.`covid-death` 
where continent is not null 
group by continent
order by totaldeathcount desc;


SELECT #date,
sum(new_cases) as total_cases, sum(cast(new_deaths as signed)) as total_deaths, sum(cast(new_deaths as signed))/sum(new_cases)*100 as DeathPercentage
FROM portfolio.`covid-death` 
where continent is not null 
#group by date
order by 1,2;





SELECT dea.continent, dea.location, dea.date, dea.population, convert(vac.new_vaccinations, signed),
sum(cast(vac.new_vaccinations as signed)) over (partition by dea.location order by dea.location, dea.date) as Rolling_vaccinated
FROM portfolio.`covid-death` dea
JOIN portfolio.`covid-vaccinations` vac
    on dea.location = vac.location
    and dea.date = vac.date 
where not dea.continent is null
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
where dea.continent is not null 
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
where dea.continent is not null and dea.location = 'Australia' and
 dea.date <'2021/08/01';
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
where dea.continent is not null and dea.location = 'Australia' and
 dea.date <'2021/08/01';



