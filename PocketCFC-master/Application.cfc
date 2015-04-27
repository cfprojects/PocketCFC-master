<cfscript>
component {
	this.applicationroot = getDirectoryFromPath(getCurrentTemplatePath());
	this.sessionmanagement = true;
	this.mappings[ "/model" ] = this.applicationroot & "model/";

	// your Pocket API consumer key
	variables.consumerKey = "19839-e0fd2b78b6db076adece1e4b";
	
	// the uri to redirect to following authentication
	variables.redirectURI = "http://www.simonbingham.me.uk/projects/PocketCFC/callback.cfm";

	void function onSessionStart() 
	{
		session.Pocket = new model.Pocket(consumerKey=variables.consumerKey, redirectURI=variables.redirectURI);
	}
	
	void function onRequestStart() 
	{
		if (StructKeyExists(url, "reload")) 
		{
			onSessionStart();
		}
	}
}
</cfscript>
