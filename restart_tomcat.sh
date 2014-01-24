#!/bin/bash
#Author:David.Zhang

TOMCAT_PATH="/opt/data/tomcat"
START_TOMCAT_SHELL="${TOMCAT_PATH}/bin/startup.sh"
STOP_TOMCAT_SHELL="${TOMCAT_PATH}/bin/shutdown.sh"

function stopTomcat {
    $STOP_TOMCAT_SHELL 
    if [[ $? -eq 0 ]];then
        echo "停止成功!"
    else
        echo "停止失败!"
        exit
    fi
}

function startTomcat {
    $START_TOMCAT_SHELL
    if [[ $? -eq 0 ]];then
        echo "启动成功!"
    else
        echo "启动失败!"
        exit
    fi
}

function main {
    ps aux | grep java | grep -v grep
    if [[ $? -eq 0 ]];then
        stopTomcat
        sleep 5
    fi
    startTomcat
}

main
