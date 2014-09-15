[![Build Status](https://travis-ci.org/crasome/mysterious-api.svg?branch=master)](https://travis-ci.org/crasome/mysterious-api)
[![Coverage Status](https://coveralls.io/repos/crasome/mysterious-api/badge.png?branch=master)](https://coveralls.io/r/crasome/mysterious-api?branch=master)

# Mysterious Ruby Backend

TASK: 

As a project you should create and put on Github (or Bitbucket) code written in Ruby. Subject is
not important it can be everything, only below requirements must be fulfilled:

- [x] It must by API (REST, JSON) [[**JSON API**](http://jsonapi.org/format/) implemented]
- [x] It must be secured by basic auth
- [x] It must contain User mode - with different roles (admin, user, guest)
- [x] It must limit access to given part of API depend of User role [See [**policies specs**](https://github.com/crasome/mysterious-api/tree/master/spec/policies)]
- [x] Admin has access to everything
- [x] User can read all, create all, but update and deleted only his records
- [x] Guest has only read access
- [x] There should be at least 2 different models except User [**Document** and **Folder** added]
- [x] Those models should be in relation (1 to many) [**Folder** has many **Documents**]

**DONE**

I choose gems and API format I am the lest familiar with.
As result example app should involve R&D and is not so boring to code :)

I did not pay attention to user data and credentials as well as APP
security and deploy credentials. It is a demo app and I dont want to
go "full enterprise". Aproaches to deal with security vary across
organizations and usualy tighed with their internal software and
related departments.
