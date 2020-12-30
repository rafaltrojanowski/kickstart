👉 I've also built Phoenix Kickstart Pro which is a version of Kickstart that includes payments with Stripe, Subscriptions, Pricing Plans, and much more.

Want to see how it works? Check out [the Kickstart walkthrough video](https://www.youtube.com/watch?v=Scl0UAd4c1E)

Live Demo: https://kickstart-pro.herokuapp.com/

# Phoenix Kickstart SaaS Template

All your Phoenix apps should start with set of default features. It's like Jumpstart Rails, for Phoenix.

# Getting started

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Create Admin Account

```bash
mix run priv/repo/seeds.exs
```

Admin Credentials:
```
admin@kickstart.com:password1234
```

## Social Login

Create .env file in project root with Facebook and Google credentials:

```
export FACEBOOK_CLIENT_ID="XXX"
export FACEBOOK_CLIENT_SECRET="XXX"
export GOOGLE_CLIENT_ID="XXX"
export GOOGLE_CLIENT_SECRET="XXX"
```

Run:
```bash
$ source .env
```

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Features

To get all available features, please read: [changelog](CHANGELOG.md)

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
