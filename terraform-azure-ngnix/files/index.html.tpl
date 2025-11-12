
<!-- files/index.html.tpl
     Simple Hello World HTML rendered by Terraform (templatefile) and injected
     into the container on startup. You can extend styles/content freely. -->
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Hello from nginx on Azure</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <style>
    :root { color-scheme: light dark; }
    body { font-family: system-ui, Segoe UI, Roboto, Helvetica, Arial, sans-serif;
           margin: 0; padding: 2.5rem; line-height: 1.55; }
    .card { max-width: 760px; margin: 0 auto; padding: 2rem;
            border-radius: 14px; box-shadow: 0 6px 24px rgba(0,0,0,.12);
            background: rgba(255,255,255,.7); backdrop-filter: blur(6px); }
    code { background: #f3f3f3; padding: .2rem .45rem; border-radius: .35rem; }
  </style>
</head>
<body>
  <div class="card">
    <h1>👋 Hello World</h1>
    <p>Served by <strong>nginx</strong> on <strong>Azure Container Instances</strong>, provisioned via <strong>Terraform</strong>.</p>
    <p>Project: <code>${project_name}</code> · Stage: <code>${stage}</code></p>
    <p>Enjoy! — <em>${project_name}</em></p>
  </div>
</body>
</html>
