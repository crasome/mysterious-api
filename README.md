[![Build Status](https://travis-ci.org/crasome/mysterious-api.svg?branch=master)](https://travis-ci.org/crasome/mysterious-api)
[![Coverage Status](https://coveralls.io/repos/crasome/mysterious-api/badge.png?branch=master)](https://coveralls.io/r/crasome/mysterious-api?branch=master)


# Mysterious Ruby Backend

As a project you should create and put on Github (or Bitbucket) code written in Ruby. Subject is
not important it can be everything, only below requirements must be fulfilled:

**DONE**

- [x] It must by API (REST, JSON) [**JSON API** implemented]
- [x] It must be secured by basic auth
- [x] It must contain User mode - with different roles (admin, user, guest)
- [x] It must limit access to given part of API depend of User role [See [policies specs](https://github.com/crasome/mysterious-api/tree/master/spec/policies)]
- [x] Admin has access to everything
- [x] User can read all, create all, but update and deleted only his records
- [x] Guest has only read access
- [x] There should be at least 2 different models except User [**Document** and **Folder** added]
- [x] Those models should be in relation (1 to many) [Folder has many documents]

I choose gems and API format I am the lest familiar with.
As result example app should involve R&D and is not so boring to code :)
