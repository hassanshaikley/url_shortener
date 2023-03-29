# UrlShortener

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix

## CI Steps

- `mix hex.audit` to check for unused deps
- `mix format --dry-run --check-formatted` to check format
- `mix compile --all-warnings --warning-as-errors` to make sure compilation is successful
- `mix ecto.create && mix ecto.migrate && mix ecto.rollback --all` to make sure database goes forward and backward
- `mix credo --strict` to analyze the code
- `mix sobelow` to run security oriented static analysis of the code
- `mix test` to run the tests

## Potential improvements

- Check that a get request for the URL returns a 200 before creating a Link
- Instead of logging in the tests use another method of verifying that code path is executed
