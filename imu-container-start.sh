#!/usr/bin/env bash

cd /ros2_ws
source /opt/ros/galactic/setup.bash
colcon build
source install/setup.bash

X=0
Y=0
Z=0
r=0
p=0
y=0

ros2 run bno055 bno055 --ros-args --params-file ./bno055/bno055/params/bno055_params.yaml &
ros2 run tf2_ros static_transform_publisher $X $Y $Z $r $p $y base_link bno055 &
bash # So container doesn't close itself.
