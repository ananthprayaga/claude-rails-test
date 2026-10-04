# Idea Vault 💡

A small Rails 8 app for storing and tracking your business ideas, styled with Tailwind CSS.

## Features

- Create, edit, and delete ideas with a title, description, category, target market, revenue model, and notes
- Track each idea through a pipeline: Brainstorming → Researching → Validating → Building → Launched (or Shelved)
- Rate an idea's potential from 1 to 5 stars and star your favourites
- Dashboard with per-status counts, search, filters (status, category, starred), and sorting
- Responsive layout with automatic dark mode

## Getting started

Requires Ruby 3.3+ and SQLite.

```sh
bundle install
bin/rails db:prepare   # create and migrate the database
bin/rails db:seed      # optional: add a few sample ideas
bin/dev                # starts the server and the Tailwind watcher
```

Then open http://localhost:3000. In GitHub Codespaces, open the forwarded port 3000 link instead; the development config allows the Codespaces proxy so forms submit correctly.

## Tests

```sh
bin/rails test
```
