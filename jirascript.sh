#!/bin/bash
#Echo asking the arugment
#declare variable

echo Please enter the time
read HOUR
#echo ${HOUR}
#URL = http://www.cs.usm.maine.edu/~boothe/cos285/syllabus-285-f16.
#
#wget -O file.pdf http://www.cs.usm.maine.edu/~boothe/cos285/syllabus-285-f16.${HOURS}
echo http://www.cs.usm.maine.edu/~boothe/cos285/syllabus-285-f16."$HOURS"
