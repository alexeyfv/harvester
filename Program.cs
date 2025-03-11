using System.Text.RegularExpressions;
using Microsoft.Playwright;

// 1. Launch a browser
using var playwright = await Playwright.CreateAsync();
await using var browser = await playwright.Chromium.LaunchAsync();
var context = await browser.NewContextAsync();

// 2. Go to the page
var page = await context.NewPageAsync();
await page.GotoAsync("https://career.habr.com/vacancies");

// 3. Extract the necessary content
ILocator locator = page.GetByText(new Regex("Найден. (\\d+) ваканс"));
var content = await locator.TextContentAsync(new() { Timeout = 2000 });

var i = content!.IndexOf(' ');
content = content[i..].Trim();
i = content.IndexOf(' ');
content = content[..i].Trim();

Console.WriteLine($"There are {content} vacancies on Habr Career");
