use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :neep_blog_backend, NeepBlogBackend.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :neep_blog_backend, NeepBlogBackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "neep_blog_backend_test",
  pool: Ecto.Adapters.SQL.Sandbox, # Use a sandbox for transactional testing
  size: 1

config :neep_blog_backend, NeepBlogBackend.Neo4j,
  username: "neo4j",
  password: "admin",
  host: "localhost",
  port: "7474"