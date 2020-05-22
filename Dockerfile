FROM addono/atlassian-sdk

env JIRA_VERSION="8.9.0"

COPY ./plugin .

ENTRYPOINT ["atlas-run"]

