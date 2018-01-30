# This script shows how to use the client in anonymous mode
# against jira.atlassian.com.

from jira.client import JIRA

options = {
  'server': 'https://brighttag.atlassian.net',
}

user_name = 'nkrimm'
password = "rz8GDj's"

def get_connection():
  return JIRA(options, basic_auth=(user_name, password))
