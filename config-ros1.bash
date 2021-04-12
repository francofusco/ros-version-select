# source the "main" setup.bash file of the ROS1 distribution we want to use.
source /opt/ros/noetic/setup.bash

# ROS_WS_ROOT is where I store all my catkin workspaces
export ROS_WS_ROOT=$HOME/programming/ROS
alias roshome="cd $ROS_WS_ROOT"

# source my personal workspaces
source $ROS_WS_ROOT/flightmare_ws/devel/setup.bash
source $ROS_WS_ROOT/qualisys_ws/devel/setup.bash
source $ROS_WS_ROOT/active_workspace/devel/setup.bash

# As detailed in flightmare (https://github.com/uzh-rpg/flightmare/wiki/Install-with-ROS#install-flightmare)
export FLIGHTMARE_PATH="$ROS_WS_ROOT/flightmare_ws/src/flightmare"

# Finally, make sure that every time we open a console, we are greeted with a
# message informing us about the version we are using
echo "Working with ROS1 $ROS_DISTRO"
