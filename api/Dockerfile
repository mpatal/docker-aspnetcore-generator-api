# Build Stage
FROM microsoft/aspnetcore-build:2 AS build-env
WORKDIR /api

COPY api.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -o /publish

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj
 
#enable before for a quick alr check on build below is susceptible for caching using docker run --rm <tag> ls -alR after build alternative
#RUN ls -alR
 
# copy src
COPY . .
 
# test
ENV TEAMCITY_PROJECT_NAME=fake
RUN dotnet test tests/tests.csproj

# Runtime Image Stage
FROM microsoft/aspnetcore:2
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT ["dotnet", "api.dll"]