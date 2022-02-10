FROM mcr.microsoft.com/dotnet/sdk:6.0
ARG BUILD_CONFIGURATION=Debug
ENV ASPNETCORE_ENVIRONMENT=Development
ENV DOTNET_USE_POLLING_FILE_WATCHER=true

WORKDIR /src

COPY ["DevopsTest.Build/DevopsTest.Build.csproj", "DevopsTest.Build/"]


COPY . .
WORKDIR /src/DevopsTest.Build
RUN dotnet build -c $BUILD_CONFIGURATION