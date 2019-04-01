#!/bin/bash

set -ex

apt-get update && apt-get install -y nginx

cat > /var/www/html/index.nginx-debian.html <<EOF
  <!DOCTYPE html>
  <html>
  <head>
  <title>Welcome to nginx!</title>
  <style>
      body {
          width: 60em;
          margin: 0 auto;
          font-family: Tahoma, Verdana, Arial, sans-serif;
      }
  </style>
  </head>
  <body>
  <h1>Welcome to The Norfolk Public Library</h1>
<h2> What Exactly is Cloud Computing presented by 757ColorCoded</h2>
  <p>Thank you for coming to todays presentation.  Check out our website <a href="https://757colorcoded.org" >757ColorCoded SON!!</a>  </p>
 <p>You are at this IP: <script type="text/javascript">
    var ip = location.host;
    document.write(ip);
</script></p>
</body>
  </html>
EOF
