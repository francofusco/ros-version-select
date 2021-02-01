modif_date=$(stat -c %y "$ROS_VERSION_SELECT_SOURCE_FILE")

if [[ $modif_date != $ROS_VERSION_SELECT_MODIFICATION_DATE ]]; then
  echo "Detected change of $ROS_VERSION_SELECT_SOURCE_FILE"
  update_config
  source $ROS_VERSION_SELECT_DIR/config-ros.bash
  return
fi
