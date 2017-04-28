#!/bin/bash
#
JIRA_CONFIG="autojira.config"
HTTP_DOWNLOAD_TOOL="wget"
#
#wget -O <friendly_name>.xls --ignore-length=on "http://<jira_server>/sr/jira.issueviews:searchrequest-excel-all-fields/<filter_id>/SearchRequest-<filter_id>.xls?tempMax=1000&os_username=$USERNAME&os_password=$PASSWORD”
#
init_vars()
{
    OUTPUT_FILE=`cat ${JIRA_CONFIG} | grep aj_output_file | cut -d '=' -f 2`
    OUTPUT_OPTIONS=`cat ${JIRA_CONFIG} | grep aj_output_options | cut -d '=' -f2-`
    JIRA_SERVER=`cat ${JIRA_CONFIG} | grep aj_jira_server | cut -d '=' -f 2`
    FILTER_ID=`cat ${JIRA_CONFIG} | grep aj_filter_id | cut -d '=' -f 2`
    TEMP_MAX=`cat ${JIRA_CONFIG} | grep aj_temp_max | cut -d '=' -f 2`
    USER_NAME=`cat ${JIRA_CONFIG} | grep aj_user_name | cut -d '=' -f 2`
    PASSWORD=`cat ${JIRA_CONFIG} | grep aj_pass_word | cut -d '=' -f 2`
    JIRA_URL=`cat ${JIRA_CONFIG} | grep aj_jira_url | cut -d '=' -f 2-`
}
#
print_vars()
{
    echo OutputFile : ${OUTPUT_FILE}
    echo OutputOptions : ${OUTPUT_OPTIONS}
    echo JiraServer : ${JIRA_SERVER}
    echo FilterId : ${FILTER_ID}
    echo TempMax : ${TEMP_MAX}
    echo UserName : ${USER_NAME}
    echo Password : ${PASSWORD}
    echo JiraUrl : ${JIRA_URL}
}
#
form_wget_url()
{
WGET_URL=`echo ${JIRA_URL} | sed -e "s/{1}/${JIRA_SERVER}/g" | sed -e "s/{2}/${FILTER_ID}/g" | sed -e "s/{3}/${TEMP_MAX}/g" | sed -e "s/{4}/${USER_NAME}/g" | sed -e "s/{5}/${PASSWORD}/g"`
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
${HTTP_DOWNLOAD_TOOL} -q -O ${OUTPUT_FILE} ${OUTPUT_OPTIONS} ${WGET_URL}
#
