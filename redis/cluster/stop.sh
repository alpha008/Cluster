#!/bin/sh
ps -ef | grep redis | grep -v grep | awk '{print $2}' | xargs kill -9