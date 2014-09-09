[![Build Status](https://travis-ci.org/crasome/mysterious-api.svg?branch=master)](https://travis-ci.org/crasome/mysterious-api)
[![Code Climate](https://codeclimate.com/github/crasome/mysterious-api/badges/gpa.svg)](https://codeclimate.com/github/crasome/mysterious-api)
[![Coverage Status](https://coveralls.io/repos/crasome/mysterious-api/badge.png?branch=master)](https://coveralls.io/r/crasome/mysterious-api?branch=master)


# Mysterious Ruby Backend

As a project you should create and put on Github (or Bitbucket) code written in Ruby. Subject is
not important it can be everything, only below requirements must be fulfilled:

- [x] It must by API (REST, JSON) [**JSON API** implemented]
- [x] It must be secured by basic auth
- [x] It must contain User mode - with different roles (admin, user, guest)
- [x] It must limit access to given part of API depend of User role
- [x] Admin has access to everything
- [x] User can read all, create all, but update and deleted only his records
- [x] Guest has only read access
- [ ] There should be at least 2 different models except User [_TODO_]
- [ ] Those models should be in relation (1 to many) [_TODO_]

I choose gems and API format I am the lest familiar with so it example app should
involve R&D as well.
