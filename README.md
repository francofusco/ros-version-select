# ros-version-select

Simple scripts to switch between ROS 1 and 2.

The way it works is described briefly in the following:

- If you were using ROS1 only, you would add few lines to your `~/.bashrc`,
  usually to source the `setup.bash` files of the distro and of your catkin
  workspace(s).
- Similarly, if you wanted to use only ROS2, you would source the
  `local_setup.bash` files of your colcon workspace(s) inside your `~/.bashrc`.
- However, you have **both** ROS1 and ROS2! You *could* add all the
  instructions into the `~/.bashrc`, commenting those of ROS1 when you want to
  use ROS2 and vice-versa.

The scripts in here basically automate the last step.
In this sense, they do not really make you switch between the two ROS versions.
Instead, they just execute the setup required to work with either version,
"keeping in memory" which of the two you wish to use in new terminals.



## Configuration

In your `~/.bashrc` file, add the following:

```
export ROS_VERSION_SELECT_DIR="/path/to/this/repository"
source "$ROS_VERSION_SELECT_DIR/ros-version-select.bash"
```

Make sure to properly update the content of `ROS_VERSION_SELECT_DIR`! It should
look like `ROS_VERSION_SELECT_DIR="$HOME/ros-version-select"`, but of
course it will depend on where you cloned this repo.

Now, edit the `config-ros1.bash` and `config-ros2.bash` files. Each of them
should contain the code that you want to execute when opening a terminal to
work with either of the two ROS versions.



## Usage

The following new commands can be now used in your console:

- `activate_ros1`: "enables" the use of ROS1 when opening a new console. In
  practice, commands such as `roscore` or `rosrun` will become available in
  new consoles!
- `activate_ros2`: "enables" the use of ROS2 when opening a new console. In
  practice, commands such as `ros2 run` will become available in new consoles!
- `deactivate_ros`: "disables" both ROS1 and ROS2. New consoles will not
  understand commands such as `roscore` or `ros2 topic` anymore.

**NOTE**: after executing one of the commands above, you should close the
terminal(s) you are currently using.



## TODOs

### Restarting the terminal

It would be nice to be able to automatically "restart" the current session.
As an example, one could add to the end of each command the additional lines:

```
gnome-terminal
exit
```

This opens a new terminal and then closes the current one. However, this does
not work, since it seems that the new terminal "inherits" something from the
parent that launched it. As an example, if ROS1 is enabled and you type the
`deactivate_ros` function, you can still `roscore`! The objective would be
to substitute the `gnome-terminal` command with something equivalent to
pressing the `CTRL+ALT+T` shortcut.
