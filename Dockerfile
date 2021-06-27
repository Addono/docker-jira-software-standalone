FROM addono/atlassian-sdk@sha256:12b2d4bd05d94cf5b1ea4c8f1c20ef08f5bf02b965a1105b011616626f08c10a

env JIRA_VERSION="8.9.0"

COPY ./plugin .

ENTRYPOINT ["atlas-run"]

