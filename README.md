# ant-part-imu

Expected software: Linux 22.04, Docker 20.10.17.
Expected hardware: Adafruit BNO055 and CP2104 USB-to-UART Bridge (see https://github.com/flynneva/bno055 for hardware wiring)

Setup instructions

1. Wire your BNO055 to your CP2104 Bridge. Plug the bridge into your computer.
2. Clone this repo and cd into it
3. Copy ros2.rules to /etc/udev/rules.d/ and run $sudo udevadm control --reload-rules && sudo service udev restart && sudo udevadm trigger.
4. cd to /dev and run $ls, you should see a device named IMU_UART_bridge.
5. cd back to this repository. Within the repo, cd into docker, and run $docker compose up -d. Then run $docker exec -it bno055_test bash to enter into the container.
6. Within the container, run $source /opt/ros/galactic/setup.bash and $ros2 topic echo /bno055/imu. A stream of IMU data should appear on the screen.

Customizations:

As per https://github.com/flynneva/bno055/blob/main/bno055/params/bno055_params.yaml, it is expected that the BNO055 is rigidly attached to a link named "bno055". Within imu-container-start.sh, a transform is setup between "bno055" and "base_link". You can change the relationship between the 2 links, or the links themselves, to fit into your codebase.
