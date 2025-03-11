# Harvester

Harvester is a demo .NET application that demonstrates how to scrape data using C# and Playwright.

## Prerequisites

- .NET 8.0 SDK
- Docker (optional, for containerized deployment)

## Getting Started

### Running Locally

```sh
dotnet run
```

### Running with Docker

```sh
docker build -t harvester .
docker run --rm harvester
```

## How It Works

1. The application launches a Chromium browser instance using Playwright.
2. It navigates to a specified webpage.
3. It extracts the necessary content based on the provided selectors.
4. The result is printed to the console.

## License

This project is licensed under the MIT License.
