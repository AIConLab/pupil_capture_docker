# Pupil Docker Image

Docker image for Pupil Capture.

## Setup

1. Clone the repository.
2. `cd .docker`
3. `docker-compose build`

## Usage

This container can be used to run the Pupil Capture app.
We provide a service that enters the BASH shell of the container, however one could easily update the `command` in the `docker-compose.yml` file to `command: python3 main.py capture` in order to automatically start the Pupil Capture app.

This container can be used to generate configuration files for other pupil capture instances. To do so:
- Connect the pupil glasses to the computer.
- Give xhost permissions to the container with `xhost +local:root` 
- Start the container: `docker compose run pupil_dev`
- Run `python3 main.py capture` to start the Pupil Capture app.
- Configure the Pupil Capture app as needed.
- Exit the Pupil Capture app. (`CTRL+C` in the terminal.)
- The capture settings will be updated in the `pupil/capture_settings` directory which is associated with the `pupil_capture_settings` volume.
- Exit the container.

Doing the above will store the pupil capture settings on the host machine in the `pupil_capture_settings` directory. This directory can be copied to other projects as needed.
The `pupil_capture_settings` directory may need permissions updated to allow one to copy and paste the files to other projects, this can be done with `sudo chown -R $USER:$USER pupil_capture_settings` from the root repository directory.