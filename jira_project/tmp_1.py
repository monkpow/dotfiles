# This script shows how to use the client in anonymous mode
# against jira.atlassian.com.

from jira.client import JIRA

options = {
  'server': 'https://brighttag.atlassian.net',
}

jira = JIRA(options, basic_auth=("nkrimm", "rz8GDj's"))
#jira = JIRA(options)

# Get all projects viewable by anonymous users.
projects = jira.projects()

print(projects)


new_issue = jira.create_issue(project={'key': 'TST'}, summary='New issue from jira-python',
                              description='Look into this one', issuetype={'name': 'Story'})

# Sort available project keys, then return the second, third, and fourth keys.
keys = sorted([project.key for project in projects])[2:5]

print(jira.search_issues('project=ACT and assignee=currentUser()'))

# Get an issue.
issue = jira.issue('TST-1')
print ('printing')
print issue

## Find all comments made by Atlassians on this issue.
#import re
#atl_comments = [comment for comment in issue.fields.comment.comments
                #if re.search(r'@atlassian.com$', comment.author.emailAddress)]

## Add a comment to the issue.
jira.add_comment(issue, 'I have added a comment to this issue via API')

## Change the issue's summary and description.
issue.update(summary="This issue has been updated", description='Changed the summary to be different.')
