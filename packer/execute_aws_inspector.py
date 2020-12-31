import boto3
import os, sys
import datetime, time
import xml.etree.cElementTree as etree

# initialize boto library for AWS Inspector
client = boto3.client('inspector')

# set assessment template for stack
stack = os.environ['STACK']

# start assessment run
assessment = client.start_assessment_run(
        assessmentTemplateArn = 'arn:aws:inspector:us-east-1:650139481770:target/0-tpFINDNu/template/0-BfRQytvh',
	assessmentRunName = datetime.datetime.now().isoformat()
)

# wait for the assessment to finish
time.sleep(1020)

# list findings
findings = client.list_findings(
	assessmentRunArns = [
		assessment['assessmentRunArn'],
	],
	filter={
		'severities': [
			'High','Medium',
		],
	},
	maxResults=100
)

# describe findings and output to JUnit 
testsuites = etree.Element("testsuites")
testsuite = etree.SubElement(testsuites, "testsuite", name="Common Vulnerabilities and Exposures-1.1")

for item in findings['findingArns']:
	description = client.describe_findings(
		findingArns=[
			item,
		],
		locale='EN_US'
	)

	for item in description['findings']:
		testcase = etree.SubElement(testsuite, "testcase", name=item['severity'] + ' - ' + item['title'])
		etree.SubElement(testcase, "error", message=item['description']).text = item['recommendation']

tree = etree.ElementTree(testsuites)
tree.write("inspector-junit-report.xml")
