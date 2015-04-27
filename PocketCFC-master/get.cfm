<cfset response = session.Pocket.get()>

<cfinclude template="inc/header.cfm">

<cfoutput>
	<cfif response.success>
		<cfset list = DeserializeJSON(response.content).list>
		
		<h1>PocketCFC</h1>
		
		<cfloop collection="#list#" item="item">
			<cfset theItem = list[item]>
			
			<cfif StructKeyExists(theItem, "is_article") && theItem.is_article>
				<h2><a href="#theItem.resolved_url#">#theItem.resolved_title#</a></h2>
				<p>#theItem.excerpt#</p>
			</cfif>
		</cfloop>
	<cfelse>
		<cflocation url="error.cfm" addtoken="false">
	</cfif>
</cfoutput>

<cfinclude template="inc/footer.cfm">
