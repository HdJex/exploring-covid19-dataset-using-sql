SELECT * FROM `atharva-408813.covid.coviddeath` LIMIT 1000;

SELECT * FROM `atharva-408813.covid.covidvaccine` LIMIT 1000;

# select the data we are using

select location, date, total_cases, new_cases, total_deaths, population 
from `atharva-408813.covid.coviddeath`;

-- total cases vs total deaths

select location, date, total_cases, total_deaths, population , (total_deaths/total_cases)*100 as death_pert
from `atharva-408813.covid.coviddeath`
order by 1,2;


-- total cases vs population


select location, date, total_cases, total_deaths, population , (total_cases/population)*100 as death_pert 
from `atharva-408813.covid.coviddeath`
where location = "India"
order by 1,2;


-- countries with highest infection rate as compared to the population

select location,  max(total_cases) as highest_infection_rate,  population , max((total_cases/population)*100) as pert_affected
from `atharva-408813.covid.coviddeath`
group by location, population 
order by pert_affected desc;



-- countries with lowest infection rate as compared to the population

select location,  min(total_cases) as highest_infection_rate,  population , min((total_cases/population)*100) as pert_affected
from `atharva-408813.covid.coviddeath`
group by location, population 
order by pert_affected desc;

-- contries with higehst death rate


select location,  max(total_deaths) as highest_death_count,  population , max((total_deaths/total_cases)*100) as pert_died
from `atharva-408813.covid.coviddeath`
where continent is not null
group by location, population 
order by highest_death_count desc;


-- continents with higehst death rate

select continent ,  max(total_deaths) as highest_death_count
from `atharva-408813.covid.coviddeath`
where continent is not null
group by continent  
order by highest_death_count desc;

-- looking at total population vs vaccination

SELECT dea.location, dea.date, dea.population, dea.continent,vac.new_vaccinations,
sum(cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as rollingpeoplevaccinated
FROM `atharva-408813.covid.coviddeath` dea
JOIN `atharva-408813.covid.covidvaccine` vac
ON dea.location = vac.location
AND dea.date = vac.date
where dea.continent is not null
order by 1,2;





