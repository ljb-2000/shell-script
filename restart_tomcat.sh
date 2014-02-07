#!/bin/bash
#Author:David.Zhang
#Date:2014-01-28
#About:restart Tomcat service

export JAVA_HOME=/opt/jdk1.6.0_35
export TOMCAT_HOME=/opt/data/tomcat

function restartTomcat(){
    echo "Attempting to find process id for Tomcat ..."
    PID=`ps -ef |grep java| grep -v grep |awk {'print $2'}`

    if [ "$PID" == "" ]
    then
        echo "Tomcat does not appear to be running ..."
    else
        echo "Killing Tomcat using process id for $PID"
        kill -9 $PID
        echo "Waiting for process $PID to end ..."
        while `ps -ef | grep $PID | grep -v grep > /dev/null`;do
            sleep 1
        done
    fi

    #delete Tomcat Cache
    echo "Deleting Tomcat Cache..."
    rm $TOMCAT_HOME/work/* -rf

    #start Tomcat Service
    echo "start Tomcat service..."
    $TOMCAT_HOME/bin/startup.sh
}

restartTomcat