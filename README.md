# NeepBlogBackend

Aims to be a re-implementation of https://github.com/mxhold/peep_blog_backend but using Neo4J as a backend (compatibility not guaranteed). Currently very much a playground.

It uses a very simple custom connector for Neo4J (see lib/neep_blog_backend/neo4j_connector.ex) that currently only creates nodes with a label on them (in other words no relationships). The connector does try to use and respect the Ecto models and their changesets.

It exposes a simple JSON api for articles here:

`http://host:port/api/articles`

Big thanks to people on Slack and elsewhere who have helped with my questions.
