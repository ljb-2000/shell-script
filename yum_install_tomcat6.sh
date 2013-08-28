#!/bin/bash
#tomcat6 install for Centos6.4

rpmforge=http://apt.sw.be/redhat/el6/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
epel=ftp://ftp.univie.ac.at/systems/linux/fedora/epel/beta/6/i386/epel-release-6-5.noarch.rpm
jpackage=http://mirrors.dotsrc.org/jpackage/6.0/generic/free/RPMS/jpackage-utils-5.0.0-7.jpp6.noarch.rpm

#First we are going to prepare the repository
yum -y install yum-priorities
rpm -Uvh $rpmforge
rpm -Uvh $epel
rpm -Uvh $jpackage

#Next we will install Java and Tomcat6

yum -y install java
yum -y install tomcat6 tomcat6-webapps tomcat6-admin-webapps

#Finally we can launch Tomcat6
service tomcat6 start