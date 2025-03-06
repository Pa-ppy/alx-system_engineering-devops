# AirBnB clone v2 - Application Server

This directory contains the Flask application server setup for the AirBnB clone Project

## Steps:

- Installed net-tools on the server (sudo apt-get install net-tools)
- Cloned `AirBnB_clone_v2` repository.
- Installed gunicorn using pip3 (pip3 install gunicorn)
- Added ~/.local/bin to the PATH (export PATH=$PATH:~/.local/bin)

### Testing:

Use `curl http://127.0.0.1:5000/airbnb-onepage/` to verify the application is running in a different terminal server.

#### Checks

- Ensure gunicorn is added to path, running and serving the Flask application on port `5000`
- Ensure nginx is installed on server.
