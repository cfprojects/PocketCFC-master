<cfscript>
response = session.Pocket.retrieveRequestToken();

if (response.success) 
{
	session.Pocket.redirectToAuth();
} 
else 
{
	location("error.cfm", false);
}
</cfscript>
