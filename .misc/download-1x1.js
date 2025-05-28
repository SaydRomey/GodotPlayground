
// Requirements
// Node.js
// Puppeteer: Install via npm install puppeteer

// Run it:
// node download_1x1.js

const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

(async () => {
  const readline = require('readline').createInterface({
    input: process.stdin,
    output: process.stdout
  });

  const ask = question => new Promise(resolve => readline.question(question, resolve));

  const color = (await ask("Enter color code (8 hex digits, e.g., c9e2b3ff): ")).trim();
  const useDefault = (await ask("Use default Downloads folder? (y/n): ")).trim().toLowerCase();

  let destination;
  if (useDefault === 'y') {
    destination = path.join(require('os').homedir(), 'Downloads');
  } else {
    destination = (await ask("Enter full path to destination folder: ")).trim();
    if (!fs.existsSync(destination)) {
      console.log("Directory does not exist.");
      process.exit(1);
    }
  }

  readline.close();

  const url = `https://shoonia.github.io/1x1/#${color}`;

  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto(url);

  // Wait for canvas and get image data from download link
  await page.waitForSelector('#download');
  const dataUrl = await page.$eval('#download', el => el.href);

  const base64Data = dataUrl.replace(/^data:image\/png;base64,/, "");
  const filePath = path.join(destination, `${color}.png`);

  fs.writeFileSync(filePath, base64Data, 'base64');
  console.log(`PNG saved to: ${filePath}`);

  await browser.close();
})();
