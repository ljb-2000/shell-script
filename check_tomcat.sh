#!/bin/bash
#Author:David.Zhang

COMMAND=`ps aux | grep java | grep -v grep |awk '{print $2}'`

function checkTomcat_Stat {
    if [[ $COMMAND -eq NULL ]];then
        /opt/data/tomcat/bin/startup.sh
        if [[ $? -eq 0 ]];then
            echo "启动成功!"
        fi
    fi
}

checkTomcat_Stat
