#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/root/catkin_ws/src/turtlebot_autorace_2020_manipulator/turtlebot3_autorace_driving"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/root/catkin_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/root/catkin_ws/install/lib/python3/dist-packages:/root/catkin_ws/build/turtlebot3_autorace_driving/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/root/catkin_ws/build/turtlebot3_autorace_driving" \
    "/usr/bin/python3" \
    "/root/catkin_ws/src/turtlebot_autorace_2020_manipulator/turtlebot3_autorace_driving/setup.py" \
     \
    build --build-base "/root/catkin_ws/build/turtlebot3_autorace_driving" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/root/catkin_ws/install" --install-scripts="/root/catkin_ws/install/bin"