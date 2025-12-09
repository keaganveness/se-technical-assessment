const http = require('http');
const os = require('os');

const PORT = 8080;

const app = http.createServer((req, res) => {
  const hostname = os.hostname();
  const time = new Date().toISOString();

  const html = `
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Systems Engineer Technical Assessment</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
      Roboto, Helvetica, Arial, sans-serif;
      display: grid;
      place-items: center;
      min-height: 90vh;
      background-color: #f4f7f6;
      color: #333;
    }
    .container {
      background-color: #ffffff;
      border-radius: 12px;
      padding: 2rem 3rem;
      box-shadow: 0 10px 25px rgba(0,0,0,0.05);
      text-align: center;
    }
    h1 {
      color: #1a5a96;
      margin-top: 0;
    }
    p {
      font-size: 1.1rem;
      line-height: 1.6;
    }
    code {
      background-color: #eef;
      padding: 0.25rem 0.5rem;
      border-radius: 6px;
      font-size: 1rem;
      font-family: "Courier New", Courier, monospace;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>Hello, Candidate!</h1>
    <p>This response was served by container <code>${hostname}</code>.</p>
    <p>Server time is: <code>${time}</code>.</p>
    <p><small>If you reload this page, you should see the *same* time if caching is working correctly.</small></p>
  </div>
</body>
</html>
  `;

  res.statusCode = 200;
  res.end(html);
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}/`);
});