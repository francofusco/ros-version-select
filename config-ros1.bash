# source the "main" setup.bash file of the ROS1 distribution we want to use.
source /opt/ros/noetic/setup.bash

# ROS_HOME is where I store all my catkin workspaces
export ROS_HOME=$HOME/programming/ROS
alias roshome="cd $ROS_HOME"

# source my personal workspaces
source $ROS_HOME/commons/devel/setup.bash

# Finally, make sure that every time we open a console, we are greeted with a
# message informing us about the version we are using
echo "Working with ROS1 $ROS_DISTRO"
