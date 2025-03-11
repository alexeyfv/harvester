# 1. Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Build the project
COPY ./ ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

# 2. Create runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy the binaries
COPY --from=build /app/out .

# Install PowerShell and Playwright with dependencies, then clean up
RUN apt update && \ 
    # Install PowerShell (https://github.com/mu88/ScreenshotCreator/blob/main/src/ScreenshotCreator.Api/install-powershell-amd64.sh)
    apt install -y curl gpg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --yes --dearmor --output /usr/share/keyrings/microsoft.gpg && \
    sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list' && \
    apt update && \ 
    apt install -y powershell && \
    # Install Playwright
    pwsh playwright.ps1 install --with-deps chromium && \
    # Clean up
    apt remove -y curl gpg powershell && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["dotnet", "Harvester.dll"]
