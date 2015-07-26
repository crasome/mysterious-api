[![Build Status](https://travis-ci.org/crasome/mysterious-api.svg?branch=offer_api_demo)](https://travis-ci.org/crasome/mysterious-api)
[![Coverage Status](https://coveralls.io/repos/crasome/mysterious-api/badge.png?branch=offer_api_demo)](https://coveralls.io/r/crasome/mysterious-api?branch=offer_api_demo)

# Mysterious Expense Tracker

Ruby Developer Challenge

The goal of this challenge is to create a web application which consumes the Fyber Offer

API and renders its responses.

To solve this challenge you should use Ruby and you could use any framework of your

choice. Make sure your code is covered by tests.

Steps

1. Read the Fyber Offer API specification at

http://developer.fyber.com/content/ios/offer-wall/offer-api/.

2. Create a form asking for these parameters (see the specs.):

a. uid

b. pub0

c. page

3. Make the request to the API passing the params and the authentication hash

4. Get the result from the response.

5. Check the hash in the response to make sure that it is a real response.

6. Render the offers in a view

a. If we have offers there we render them (title, thumbnail lowres and payout)

b. If we have no offers there we render a message like ‘No offers available’

7. Deploy your solution so that we can interact with it in a web browser.

8. Running rake at the root directory of your project should run the tests.

Params to be used

appid: 157

format: json

device_id: 2b6f0cc904d137be2e1730235f5664094b83

locale: de

ip: 109.235.143.113 (german IP)

offer_types: 112

API Key: b07a12df7d52e6c118e5d47d3f9e60135b109a1f

Notes:

All of the data necessary to complete this challenge is provided here. No additional

accounts are required.

Fyber was previously called SponsorPay, you will find references ​throughout the

documentation.

How to proceed:

1. Create a Github repository and send us the URL together with the URL of running

solution (where you have deployed to)

2. Commit as you go so we can see your progress. Don’t only do one commit at the

end.

3. Write your thoughts about how you chose to do the work/design/etc in the

Readme file.

4. Note: design for only having one app / appID.

``` sh
rails s
```

and go to [/docs](http://localhost:3000/docs)
