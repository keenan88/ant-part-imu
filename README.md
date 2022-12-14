# ant-part-imu

*Expected software:* Linux 22.04, Docker 20.10.17. 

*Expected hardware:* Adafruit BNO055 and CP2104 USB-to-UART Bridge (see https://github.com/flynneva/bno055 for hardware wiring) 

*Dependencies:* https://github.com/flynneva/bno055: commit 11e4bed (Cloned automatically in dockerfile)

*Permissions*: Sudo permissions on your system.

**Setup instructions:**
1. Wire your BNO055 to your CP2104 Bridge. Plug the bridge into your computer.
2. Clone this repo and cd into it
3. Copy ros2.rules to /etc/udev/rules.d/ and run **$sudo udevadm control --reload-rules && sudo service udev restart && sudo udevadm trigger**
4. cd to /dev and run $ls, you should see a device named IMU_UART_bridge.
5. cd back to this repository. Within the repo, cd into docker, and run **$docker compose up -d**. Then run **$docker exec -it bno055_test bash** to enter into the container.
6. Within the container, run **$source /opt/ros/galactic/setup.bash** and **$ros2 topic echo /bno055/imu**. A stream of IMU data should appear on the screen.

**Calibration:**

See this video for calibration theory for BNO_055: https://www.youtube.com/watch?v=yPfQK75dZbU.
To view BNO055's calibration status, make sure the BNO_055 node is running (see the command to start it in imu-container-start.sh), and then run **$ros2 topic echo /bno055/calib_status**. Follow the steps from the linked video above to fully calibrate the sensor.

**Xacro/URDF Customizations:**

As per https://github.com/flynneva/bno055/blob/main/bno055/params/bno055_params.yaml, it is expected that the BNO055 is rigidly attached to a link named "bno055". Within https://github.com/keenan88/ant-part-imu/blob/main/imu-container-start.sh, a transform is setup between "bno055" and "base_link". You can change the relationship between the 2 links, or the links themselves, to fit into your codebase.

**Docker Customizations:**

If you don't want to run this repo with a seperate docker compose command from the rest of your codebase, copy/paste docker-compose.yaml from "bno055_test" downwards into your existing docker compose file, and add IMU_bno055.Dockerfile and imu-container-start.sh to your codebase. You may have to update filepaths in the bno055_test compose, if you split the compose/Dockerfile/script files into seperate directories.
