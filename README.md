# Pupil Docker Image

Docker image for Pupil Capture.

## Usage

This container can be used to run the Pupil Capture app.
We provide a service that enters the BASH shell of the container, however one could easily update the `command` in the `docker-compose.yml` file to `command: python3 main.py capture` in order to automatically start the Pupil Capture app.

This container can be used to generate configuration files for other pupil capture instances. To do so:
1. Start the container with the BASH shell from the docker-compose yaml file. This should start you in the `pupil_src` directory and mount a `pupil_capture_settings` volume.
2. Run `python3 main.py capture` to start the Pupil Capture app.
3. Configure the Pupil Capture app as needed.
4. Exit the Pupil Capture app. (`CTRL+C` in the terminal.)
5. The capture settings will be updated in the `pupil/capture_settings` directory which is associated with the `pupil_capture_settings` volume.
6. Exit the container.

Doing the above will store the pupil capture settings on the host machine in the `pupil_capture_settings` directory. This directory can be copied to other projects as needed.
The `pupil_capture_settings` directory may need permissions updated to allow one to copy and paste the files to other projects, this can be done with `sudo chown -R $USER:$USER pupil_capture_settings` from the root repository directory.