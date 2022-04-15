Select *
from Covid_Data_analysis..[Covid-Deaths-data] 
order by 3,4


--Select *
--from Covid_Data_analysis..[Covid-vaccination-data] 
--order by 3,4

Select location, date, total_cases,new_cases, total_deaths, population
from Covid_Data_analysis..[Covid-Deaths-data] 
order by 1,2

-- DEATH PERCENTAGE

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from Covid_Data_analysis..[Covid-Deaths-data]
order by 1,2	

--TOTAL CASES PERCENTAGE OVER POPLULATION
Select location, date, total_cases, population, (total_cases/population)*100 as CasesPercentage
from Covid_Data_analysis..[Covid-Deaths-data]
order by 1,2	

-- HIGHEST INFECTION RATES IN AMONG THE COUNTRIES WITH PERCENTAGE

Select location, population, MAX(total_cases) as HighestInfection,  MAX((total_cases/population))*100 as InfectionPercentage
from Covid_Data_analysis..[Covid-Deaths-data]
Group by location,population
order by 4 desc

-- HIGHEST DEATHCOUNT WITH PERCENTAGE AMONG ALL COUNTRIES

Select location, MAX(cast(total_deaths as int)) as HighestDeath,  MAX((total_deaths/population))*100 as DeathPercentage
from Covid_Data_analysis..[Covid-Deaths-data]
where continent is not NULL
Group by location
order by 2 desc

-- HIGHEST DEATHCOUNT WITH PERCENTAGE AMONG ALL COUNTRIES

Select continent, MAX(cast(total_deaths as int)) as HighestDeath,  MAX((total_deaths/population))*100 as DeathPercentage
from Covid_Data_analysis..[Covid-Deaths-data]
where continent is not NULL
Group by continent
order by 2 desc 

--TOTAL CASES AND DEATHS

Select  SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
from Covid_Data_analysis..[Covid-Deaths-data]
where continent is not NULL
order by 1,2 

--VACCINATED POPULATION JOIN OPERATION

Select D.continent,D.location,D.date, population, V.new_vaccinations 
From Covid_Data_analysis..[Covid-Deaths-data] D
Join Covid_Data_analysis..[Covid-vaccination-data] V
on D.location=V.location
and D.date=V.date
where D.continent is not NULL
order by 2,3

--VACCINATED POPULATION JOIN OPERATION + PARTITION BY LOCATION

Select D.continent,D.location,D.date, D.population, V.new_vaccinations, 
SUM(cast(V.new_vaccinations as bigint)) OVER (Partition by D.location Order by D.location, D.date) as rolling_vaccCount
From Covid_Data_analysis..[Covid-Deaths-data] D
Join Covid_Data_analysis..[Covid-vaccination-data] V
on D.location=V.location
and D.date=V.date
where D.continent is not NULL
order by 2,3

--VACCINATION PERCENTAGE OVER POPULATION (CTE)
With Vacper (continent, location, date, population, new_vaccinations,rolling_vaccCount)
as
(Select D.continent,D.location,D.date, D.population, V.new_vaccinations, 
SUM(cast(V.new_vaccinations as bigint)) OVER (Partition by D.location Order by D.location, D.date) as rolling_vaccCount
From Covid_Data_analysis..[Covid-Deaths-data] D
Join Covid_Data_analysis..[Covid-vaccination-data] V
on D.location=V.location
and D.date=V.date
where D.continent is not NULL
)

select *, (rolling_vaccCount/population)*100 as Vacc_percentage
From Vacper



 



