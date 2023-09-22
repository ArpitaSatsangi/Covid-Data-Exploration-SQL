Select *
From PortfolioProject..CovidDeaths
where continent is not null
order by 3,4


Select Location, date, total_cases,total_deaths, population
From PortfolioProject..CovidDeaths
order by 3,4


-- Total Cases vs Total Deaths
Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location = 'India'
order by 1,2



-- Total Cases vs POPULATION
Select Location, date, total_cases,population, (total_cases/population)*100 as CovidCasesPercentage
From PortfolioProject..CovidDeaths
--Where location = 'India'
order by 1,2


--looking at counties with highest infection rate wrt population 
select location, max(total_cases) as HighInfectionCount,  population, max((total_cases/population))*100 as PercentagePopulationInfection
from PortfolioProject..CovidDeaths
group by location, population
order by PercentagePopulationInfection DESC

--countries with maximum death count 
select location, max(cast(total_deaths as int)) as HighDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by location, population
order by HighDeathCount DESC



--continent with maximum death count 
select continent, max(cast(total_deaths as int)) as HighDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by HighDeathCount DESC

--let us try the same thing again
select location, max(cast(total_deaths as int)) as HighDeathCount
from PortfolioProject..CovidDeaths
where continent is null
group by location
order by HighDeathCount DESC



--GLOBAL NUMBERS

-- Total Cases vs Total Deaths
Select date, SUM(new_cases) as total_new_cases, SUM(cast(new_deaths as int)) as total_new_deaths,
 SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
group by date
order by 1,2

-- for whole world
Select SUM(new_cases) as total_new_cases, SUM(cast(new_deaths as int)) as total_new_deaths,
 SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where continent is not null
order by 1,2