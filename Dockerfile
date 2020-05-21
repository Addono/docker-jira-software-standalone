FROM addono/atlassian-sdk

COPY ./plugin .

ENTRYPOINT ["atlas-run"]

