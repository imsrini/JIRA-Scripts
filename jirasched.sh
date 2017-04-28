#!/bin/bash
#
HTTP_DOWNLOAD_TOOL="wget"
JIRA_CONFIG="jirasched.config"
JIRA_SCHED_LAST_RUN_FILE="jirasched.lastrun"
#
init_vars()
{
    OUTPUT_FILE=`cat ${JIRA_CONFIG} | grep aj_output_file | cut -d '=' -f 2-`
    WGET_PRE_URL=`cat ${JIRA_CONFIG} | grep aj_pre_url | cut -d '=' -f2-`
    JIRA_SERVER=`cat ${JIRA_CONFIG} | grep aj_jira_server | cut -d '=' -f 2-`
    JIRA_POST_URL=`cat ${JIRA_CONFIG} | grep aj_post_url | cut -d '=' -f 2-`
    JIRA_URL=`cat ${JIRA_CONFIG} | grep aj_jira_url | cut -d '=' -f 2-`
    JIRA_JQL_STR=''
    while read strLineA; do
        strLineB=`echo ${strLineA} | grep aj_jira_jql_key`
        if [ ! -z ${strLineB} ]
        then
            strValueX=`echo ${strLineB} | cut -d '=' -f 2-`
            strTempX=`echo ${strValueX} | cut -d '{' -f 2- | cut -d '}' -f 1`
            strParam=`echo ${strTempX}`
            while read strLineC; do
                strLineD=`echo ${strLineC} | grep aj_jira_jql_value`
                if [ ! -z ${strLineD} ]
                then
                    strTempY=`echo ${strLineD} | grep ${strParam}`
                    if [ ! -z ${strTempY} ]
                    then
                        strValueY=`echo ${strTempY} | cut -d '=' -f 2-`
                        strTempZ=`echo ${strValueX} | sed -e "s/{${strParam}}/${strValueY}/g"`
                        if [ ! -z ${JIRA_JQL_STR} ]
                        then
                            JIRA_JQL_STR=`echo ${JIRA_JQL_STR}%20AND%20${strTempZ}`
                        else
                            JIRA_JQL_STR=`echo ${strTempZ}`
                        fi
                    fi
                fi
            done <${JIRA_CONFIG}
        fi
    done <${JIRA_CONFIG}
}
#
print_vars()
{
    echo OutputFile : ${OUTPUT_FILE}
    echo OutputOptions : ${OUTPUT_OPTIONS}
    echo JiraServer : ${JIRA_SERVER}
    echo FilterId : ${FILTER_ID}
    echo TempMax : ${TEMP_MAX}
    echo JiraUrl : ${JIRA_URL}
}
#
form_wget_url()
{
    WGET_TEMP_URL=`echo ${JIRA_URL} | sed -e "s/{1}/${JIRA_SERVER}/g"`
    WGET_TEMP_URL=`echo ${WGET_TEMP_URL} | sed -e "s/{2}/${JIRA_JQL_STR}/g"`
    if [ -f ${JIRA_SCHED_LAST_RUN_FILE} ]
    then
        JIRA_LAST_RUN=`cat ${JIRA_SCHED_LAST_RUN_FILE}`
        JIRA_CURR_RUN=$(date +%s)
        JIRA_SECS_DIFF=$(( ${JIRA_CURR_RUN} - ${JIRA_LAST_RUN} ))
        JIRA_HOURS_DIFF=$(( ${JIRA_SECS_DIFF} / 3600 ))
        if [ ${JIRA_HOURS_DIFF} -le 0 ]
        then
            JIRA_HOURS_DIFF=1
        fi
    else
        JIRA_HOURS_DIFF=17 
    fi
    WGET_TEMP_URL=`echo ${WGET_TEMP_URL} | sed -e "s/{3}/${JIRA_HOURS_DIFF}/g"`
    WGET_URL=`echo ${WGET_TEMP_URL}${JIRA_POST_URL}`
    echo ${WGET_URL}
}
#
init_vars
#
#print_vars
#
form_wget_url
#
#echo ${WGET_URL}
#
#${HTTP_DOWNLOAD_TOOL} -q -O ${OUTPUT_FILE} ${OUTPUT_OPTIONS} ${WGET_URL}
#
LAST_RUN_TIME=$(date +%s)
echo ${LAST_RUN_TIME} > ${JIRA_SCHED_LAST_RUN_FILE}
#
#
#
