--joining both tables on the basis of date and location
Select *
From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.date = vac.date
	and dea.location = vac.location


--total vaccinations
Select dea.continent, dea.location,dea.date,dea.population, vac.new_vaccinations
, sum(convert(int, vac.new_vaccinations)) 
over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated

From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.date = vac.date
	and dea.location = vac.location
where dea.continent is not null
order by 2,3



--total population vs vaccinations

--use CTE
with popvsvac (continent,location,date,population,new_vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location,dea.date,dea.population, vac.new_vaccinations
, sum(convert(int, vac.new_vaccinations)) 
over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated

From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.date = vac.date
	and dea.location = vac.location
where dea.continent is not null
)
select *, (RollingPeopleVaccinated/population)*100 as percentage
from popvsvac


--temp table
drop table if exists  #percentagePopulationVaccinated
create table #percentagePopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric, 
RollingPeopleVaccinated numeric
)
insert into #percentagePopulationVaccinated
Select dea.continent, dea.location,dea.date,dea.population, vac.new_vaccinations
, sum(convert(int, vac.new_vaccinations)) 
over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated

From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.date = vac.date
	and dea.location = vac.location
where dea.continent is not null
select *, (RollingPeopleVaccinated/population)*100 as percentage
from #percentagePopulationVaccinated



--creating view for storing data visualisation
create view percentPopulationVaccinatedd as
Select dea.continent, dea.location,dea.date,dea.population, vac.new_vaccinations
, sum(convert(int, vac.new_vaccinations)) 
over(partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated

From PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.date = vac.date
	and dea.location = vac.location
where dea.continent is not null

select *
from percentPopulationVaccinatedd
