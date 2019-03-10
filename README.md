# ahiru

[![Build Status](https://travis-ci.org/ninoseki/ahiru.svg?branch=master)](https://travis-ci.org/ninoseki/ahiru)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/ahiru/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/ahiru?branch=master)

Yet another Ruby gem for DuckDuckGo Search.

## Installation

```bash
% gem install ahiru
```

## Usage

```ruby
require "ahiru"

page = Ahiru::API.search(q: "test")
result = page.results.first
p result.title
# => "Test | Definition of Test by Merriam-Webster"
p result.url
# => "https://www.merriam-webster.com/dictionary/test"
p result.snippet
# => "(1): something (such as a series of questions or exercises) for measuring the skill, knowledge, intelligence, capacities, or aptitudes of an individual or group"

next_page = page.next_page if page.next_page?
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
