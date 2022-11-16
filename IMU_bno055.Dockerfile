FROM osrf/ros:galactic-desktop

# use bash instead of sh
SHELL ["/bin/bash", "-c"]
ENV DEBIAN_FRONTEND=noninteractive


# create workspace
RUN mkdir /ros2_ws
WORKDIR /ros2_ws

RUN git clone https://github.com/flynneva/bno055.git \
&& cd bno055 \
&& git checkout 11e4bed
RUN apt-get update && apt install -y usbutils python pip screen && pip install pyserial
RUN apt-get install -y ros-galactic-imu-tools

ADD ./imu-container-start.sh /imu-container-start.sh
RUN chmod +x /imu-container-start.sh

# add packages to path
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc
