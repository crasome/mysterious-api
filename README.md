[![Build Status](https://travis-ci.org/crasome/mysterious-api.svg?branch=twitter_demo)](https://travis-ci.org/crasome/mysterious-api)
[![Coverage Status](https://coveralls.io/repos/crasome/mysterious-api/badge.png?branch=twitter_demo)](https://coveralls.io/r/crasome/mysterious-api?branch=twitter_demo)

# Here you can find a lot of test tasks done by me, switch branches to see them all.

# Twitter demo app

TASK: 

Make a simple web app where you can display tweets based on search
term provided. It can be a super simple page with input field on the
top of it. Results can be shown right under the input.

We expect it to be written in the way so that it could go in
production and maintained by your team mates. Its up to you how you
want to write it, and libraries you want to use, etc. We expect you to
spend on it no more than 3 hours.

# Usage

Before start, add valid credentials to the .env (see .env.example)

To run all specs:

```
rake
```

To start server:

```
dotenv rackup
```

# TODO

* New UI
* Throttling (RackAttack)
* Docs
* Depending on the purpose:
  * login to Twitter
  * rotated keys
