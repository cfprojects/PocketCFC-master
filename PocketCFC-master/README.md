# PocketCFC

A CFML wrapper for the [Pocket API] (http://getpocket.com/developer/) which allows you to authenticate with the API and get, add and modify items in the user's Pocket list.

[A demo is available to view here.] (http://www.simonbingham.me.uk/projects/PocketCFC)

## Requirements

ColdFusion or Railo.

## Instructions

1. Create an instance of the Pocket.cfc object. You will need to [obtain and consumer key for your application](http://getpocket.com/developer/apps/new). `redirectURI` is the page to which Pocket will redirect following authentication of the user.

	`session.Pocket = new model.Pocket(consumerKey=consumerKey, redirectURI=redirectURI);`
	
2. Make a call to the Pocket API to retrieve a request token.

	`response = session.Pocket.retrieveRequestToken();`
	
3. If the request token is retrieved successfully redirect to Pocket to complete authentication.

	`session.Pocket.redirectToAuth();`
	
4. On the callback page make a call to the API to retrieve an access token.

	`response = session.Pocket.retrieveAccessToken();`
	
5. That's it! If everything has worked correctly you can now make requests to the API to get, add and modify items in the user's Pocket list.

	`response = session.Pocket.get();`
