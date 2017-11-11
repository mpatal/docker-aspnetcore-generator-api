FROM microsoft/dotnet:2-sdk AS build-env
WORKDIR /integration

COPY integration.csproj .
#RUN dotnet restore

COPY . .
# OPTIONAL for faster runtime
RUN dotnet build

ENTRYPOINT ["dotnet", "test"]