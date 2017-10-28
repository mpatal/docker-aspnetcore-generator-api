# Build stage
FROM microsoft/aspnetcore-build:2 as build-env

WORKDIR /generator

# restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

#enable before for a quick alr check on build below is susceptible for caching using docker run --rm <tag> ls -alR after build alternative
#RUN ls -alR

# copy src
COPY . .

# test
RUN dotnet test tests/tests.csproj

# publish
RUN dotnet publish api/api.csproj -o /publish

# Runtime stage
FROM microsoft/aspnetcore:2

WORKDIR /publish
COPY --from=build-env /publish .

#run the published value
ENTRYPOINT ["dotnet", "api.dll"]



