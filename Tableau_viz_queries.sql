


--COUNTING TOTAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From Covid_Data_analysis..[Covid-Deaths-data]
where continent is not null 
order by 1,2

--DEATH COUNT BY CONTINENTS
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Covid_Data_analysis..[Covid-Deaths-data]
Where continent is null 
and location not in ('World', 'European Union', 'International','Upper middle income','High income','Lower middle income','Low income')
Group by location
order by TotalDeathCount desc

--WORLDWIDE INFECTION RATE

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Covid_Data_analysis..[Covid-Deaths-data]
Group by Location, Population
order by PercentPopulationInfected desc

--INFACTION TIMEFRAME
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Covid_Data_analysis..[Covid-Deaths-data]
Group by Location, Population, date
order by PercentPopulationInfected desc

