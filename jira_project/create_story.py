# This script shows how to use the client in anonymous mode
# against jira.atlassian.com.

import jiraconnect

jira = jiraconnect.get_connection()

project = { 'key': 'TST' }
issuetype = { 'name': 'Story' }

new_issue = jira.create_issue(project={'key': 'TST'}, summary='A serious newly added item', issuetype={'name': 'Story'})

print("{0}: {1}".format(new_issue, new_issue.fields.summary))
