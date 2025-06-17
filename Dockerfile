# Use the official .NET 8 SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["sampleDockerAPI.csproj", "./"]
RUN dotnet restore "sampleDockerAPI.csproj"

# Copy the remaining source code and build the application
COPY . .
RUN dotnet publish "sampleDockerAPI.csproj" -c Release -o /app/publish

# Use the .NET 8 ASP.NET runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .

# Expose the default ASP.NET Core port
EXPOSE 80

# Start the application
ENTRYPOINT ["dotnet", "sampleDockerAPI.dll"]
