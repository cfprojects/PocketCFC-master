<cfscript>
response = session.Pocket.retrieveAccessToken();

if (response.success) 
{
	location("get.cfm", false);
} 
else 
{
	location("error.cfm", false);
}
</cfscript>
