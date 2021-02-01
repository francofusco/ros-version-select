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


# Allows to auto-detect changes in the config-rosX.bash files.
# It takes one parameter: the number of the ROS version (either 1 or 2).
add_date_info() {
  source_file="$ROS_VERSION_SELECT_DIR/config-ros$1.bash"
  date=$(stat -c %y "$source_file")
  echo "ROS_VERSION_SELECT_MODIFICATION_DATE=\"$date\"" >> $ROS_VERSION_SELECT_DIR/config-ros.bash
  echo "ROS_VERSION_SELECT_SOURCE_FILE=\"$source_file\"" >> $ROS_VERSION_SELECT_DIR/config-ros.bash
  echo "update_config() { activate_rosX_no_cleanup $1; }" >> $ROS_VERSION_SELECT_DIR/config-ros.bash
  cat $ROS_VERSION_SELECT_DIR/date-utils.bash >> $ROS_VERSION_SELECT_DIR/config-ros.bash
}


# Internal function: it simply replaces the config file with an "empty" file.
deactivate_ros_no_cleanup() {
  touch_empty_config
  echo 'echo "All ROS versions have been deactivated"' >> $ROS_VERSION_SELECT_DIR/config-ros.bash
}


# Internal function: it creates the config file for the given ROS version.
# It takes one parameter: the number of the ROS version (either 1 or 2).
activate_rosX_no_cleanup() {
  touch_empty_config
  add_date_info $1
  echo ""
  echo ""
  cat $ROS_VERSION_SELECT_DIR/config-ros$1.bash >> $ROS_VERSION_SELECT_DIR/config-ros.bash
}


# Function to be executed to "deactivate" both ROS1 and ROS2.
deactivate_ros() {
  deactivate_ros_no_cleanup
  cleanup_command
}


# Function to be executed when switching to ROS1
activate_ros1() {
  activate_rosX_no_cleanup 1
  cleanup_command
}


# Function to be executed when switching to ROS2
activate_ros2() {
  activate_rosX_no_cleanup 2
  cleanup_command
}


# If the generic config-ros file does not exist, generate an empty configuration file.
if [ ! -f $ROS_VERSION_SELECT_DIR/config-ros.bash ]; then
  deactivate_ros_no_cleanup
fi
# Finally, source the config-ros file.
source $ROS_VERSION_SELECT_DIR/config-ros.bash
