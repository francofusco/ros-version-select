#!/bin/bash

# Message that should be printed when attempting to run the "activate_rosX"
# commands without having setup the required environment variable.
MISSING_ENV_VAR_MSG="Sorry, the environment variable 'ROS_VERSION_SELECT_DIR' has not been defined. Please, set it in order to use ros-version-select utilities."


# If the environment variable ROS_VERSION_SELECT_DIR has not been defined, just exit.
if [[ -z "${ROS_VERSION_SELECT_DIR}" ]]; then
  echo "$MISSING_ENV_VAR_MSG"
  return
fi


# Function to be called after completing a "setup command".
cleanup_command() {
  # TODO: I would love to execute something like this:
  #   gnome-terminal && exit
  # however, it does not start a "fresh terminal"...
  echo "Switch completed! Please close this terminal and open a new one :)"
}


# Copy the empty template.
# NOTE: this assumes that the ROS_VERSION_SELECT_DIR environment variable has
# been set properly.
touch_empty_config() {
  cp $ROS_VERSION_SELECT_DIR/config-ros-template.bash $ROS_VERSION_SELECT_DIR/config-ros.bash
}


# Internal function: it simply replaces the config file with an "empty" file.
deactivate_ros_no_cleanup() {
  touch_empty_config
  echo 'echo "All ROS versions have been deactivated"' >> $ROS_VERSION_SELECT_DIR/config-ros.bash
}


# Function to be executed to "deactivate" both ROS1 and ROS2.
deactivate_ros() {
  deactivate_ros_no_cleanup
  cleanup_command
}


# Function to be executed when switching to ROS1
activate_ros1() {
  touch_empty_config
  cat $ROS_VERSION_SELECT_DIR/config-ros1.bash >> $ROS_VERSION_SELECT_DIR/config-ros.bash
  cleanup_command
}


# Function to be executed when switching to ROS2
activate_ros2() {
  touch_empty_config
  cat $ROS_VERSION_SELECT_DIR/config-ros2.bash >> $ROS_VERSION_SELECT_DIR/config-ros.bash
  cleanup_command
}


# If the generic config-ros file does not exist, generate an empty configuration file.
if [ ! -f $ROS_VERSION_SELECT_DIR/config-ros.bash ]; then
  deactivate_ros_no_cleanup
fi
# Finally, source the config-ros file.
source $ROS_VERSION_SELECT_DIR/config-ros.bash
