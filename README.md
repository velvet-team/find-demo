# Find Demo

This is a demo of how to use Velvet with OpenAI, built with Ruby on Rails.

It's a fairly vanilla Ruby on Rails application, so [set up Ruby and Postgres on your system](https://guides.rubyonrails.org/getting_started.html), add the `.env` file (below), install dependencies with `bundle install`, and run the server with `bin/dev`.

This repo expects a .env file with:

```
OPENAI_ACCESS_TOKEN=sk-...
VELVET_API_KEY=...
```

Get your OpenAI access token at [OpenAI.com](https://platform.openai.com/), and make a free Velvet API key at [usevelvet.com](https://usevelvet.com/).

This repo was made for a video about how Find AI uses Velvet. The changes from the video are available in [this commit](https://github.com/velvet-team/find-demo/commit/e988daf477d252d54e6ece3f988d9860df9284e0).
