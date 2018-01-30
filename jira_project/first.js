var JiraApi = require('jira').JiraApi;
var config = {};
config.host = 'brighttag.atlassian.net';
config.port= '8080';
config.user='nkrimm';
config.password='rz8GDj\'s';
var jira = new JiraApi('https', config.host, config.port, config.user, config.password, '2.0.alpha1');
var issueNumber = 'TST-2';
jira.findIssue(issueNumber, function(error, issue) { console.log('Status: ' + issue.fields.status.name); });
