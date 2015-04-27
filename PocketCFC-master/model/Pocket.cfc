<cfscript>
/**
* @displayname Pocket.cfc
* @output false
* @hint The Pocket object. Documentation: http://getpocket.com/developer/docs/overview
* @author Simon Bingham
* @website http://www.simonbingham.me.uk/
**/
component accessors="true" 
{
	/** PROPERTIES **/
	
	/**
	* @getter true
	* @setter true
	* @type string
	* @validate string
	* @hint The application consumer key.
	**/
	property name="consumerKey";

	/**
	* @getter true
	* @setter true
	* @type string
	* @validate string
	* @hint The redirect uri.
	**/
	property name="redirectURI";

	/**
	* @getter true
	* @setter true
	* @type string
	* @validate string
	* @hint The user's request token.
	**/
	property name="requestToken";

	/**
	* @getter true
	* @setter true
	* @type string
	* @validate string
	* @hint The user's access token.
	**/
	property name="accessToken";

	/** PUBLIC METHODS **/

	/**
	* @hint I return an initialised instance.
	* @output false
	* @consumerKey The API consumer key.
	* @redirectURI The redirect uri.
	**/
	Pocket function init(
		required string consumerKey, 
		required string redirectURI
	) 
	{
		setConsumerKey(arguments.consumerKey);
		setRedirectURI(arguments.redirectURI);
		return this;
	}

	/**
	* @hint I save an item to the user's Pocket list. Documentation: http://getpocket.com/developer/docs/v3/add
	* @output false
	* @url The URL of the item you want to save.
	* @title This can be included for cases where an item does not have a title, which is typical for image or PDF URLs. If Pocket detects a title from the content of the page, this parameter will be ignored.
	* @tags A comma-separated list of tags to apply to the item.
	**/
	struct function add(
		required string url,
		string title="",
		string tags=""	
	) 
	{
		local.result.success = false;
		httpService = new http();
		httpService.setMethod("post");
		httpService.setCharset("utf-8");
		httpService.setUrl("https://getpocket.com/v3/add");
		httpService.addParam(type="formfield", name="consumer_key", value=getConsumerKey());
		httpService.addParam(type="formfield", name="access_token", value=getAccessToken());
		httpService.addParam(type="formfield", name="url", value=arguments.url);
		if (Len(Trim(arguments.title))) httpService.addParam(type="formfield", name="title", value=arguments.title);
		if (Len(Trim(arguments.tags))) httpService.addParam(type="formfield", name="tags", value=Val(arguments.tags));
		local.response = httpService.send().getPrefix();
		if (200 == local.response.Responseheader.Status_Code) 
		{
			local.result.success = true;
			local.result.content = local.response.FileContent;
		}
		return local.result;
	}

	/**
	* @hint I retrieve the user's Pocket data. Documentation: http://getpocket.com/developer/docs/v3/retrieve
	* @output false
	* @state unread, archive or all
	* @favorite 0 or 1
	* @tag tag_name or _untagged_
	* @contentType article, video or image
	* @sort newest, oldest, title, site
	* @detailType simple, complete
	* @search Only return items whose title or url contain the search string.
	* @domain Only return items from a particular domain.
	* @since Only return items modified since the given since unix timestamp.
	* @count Only return count number of items.
	* @offset Used only with count; start returning from offset position of results.
	**/
	struct function get(
		string state="all",
		string favorite="",
		string tag="",
		string contentType="",
		string sort="newest",
		string detailType="simple",
		string search="",
		string domain="",
		date since="1348852386",
		string count="",
		string offset=""	
	) 
	{
		local.result.success = false;
		httpService = new http();
		httpService.setMethod("post");
		httpService.setCharset("utf-8");
		httpService.setUrl("https://getpocket.com/v3/get");
		httpService.addParam(type="formfield", name="consumer_key", value=getConsumerKey());
		httpService.addParam(type="formfield", name="access_token", value=getAccessToken());
		if (Len(Trim(arguments.state))) httpService.addParam(type="formfield", name="state", value=arguments.state);
		if (Len(Trim(arguments.favorite))) httpService.addParam(type="formfield", name="favorite", value=Val(arguments.favorite));
		if (Len(Trim(arguments.tag))) httpService.addParam(type="formfield", name="tag", value=arguments.tag);
		if (Len(Trim(arguments.contentType))) httpService.addParam(type="formfield", name="contentType", value=arguments.contentType);
		if (Len(Trim(arguments.sort))) httpService.addParam(type="formfield", name="sort", value=arguments.sort);
		if (Len(Trim(arguments.detailType))) httpService.addParam(type="formfield", name="detailType", value=arguments.detailType);
		if (Len(Trim(arguments.search))) httpService.addParam(type="formfield", name="search", value=arguments.search);
		if (Len(Trim(arguments.domain))) httpService.addParam(type="formfield", name="domain", value=arguments.domain);
		if (Len(Trim(arguments.since))) httpService.addParam(type="formfield", name="since", value=arguments.since);
		if (Len(Trim(arguments.count))) httpService.addParam(type="formfield", name="count", value=Val(arguments.count));
		if (Len(Trim(arguments.offset))) httpService.addParam(type="formfield", name="offset", value=Val(arguments.offset));
		local.response = httpService.send().getPrefix();
		if (200 == local.response.Responseheader.Status_Code) 
		{
			local.result.success = true;
			local.result.content = local.response.FileContent;
		}
		return local.result;
	}
	
	/**
	* @hint I modify a item to the user's Pocket list. Documentation: http://getpocket.com/developer/docs/v3/modify
	* @output false
	* @actions JSON array of actions.
	**/
	struct function modify(
		required string actions
	) 
	{
		local.result.success = false;
		httpService = new http();
		httpService.setMethod("post");
		httpService.setCharset("utf-8");
		httpService.setUrl("https://getpocket.com/v3/add");
		httpService.addParam(type="formfield", name="consumer_key", value=getConsumerKey());
		httpService.addParam(type="formfield", name="access_token", value=getAccessToken());
		httpService.addParam(type="formfield", name="actions", value=arguments.actions);
		local.response = httpService.send().getPrefix();
		if (200 == local.response.Responseheader.Status_Code) 
		{
			local.result.success = true;
			local.result.content = local.response.FileContent;
		}
		return local.result;
	}	

	/**
	* @hint I redirect the user to Pocket to complete authorisation.
	* @output false
	**/
	void function redirectToAuth() {
		location("https://getpocket.com/auth/authorize?request_token=#getRequestToken()#&redirect_uri=#getRedirectURI()#", false);
	}

	/**
	* @hint I make a request to retrieve an access token.
	* @output false
	**/
	struct function retrieveAccessToken() {
		local.result.success = false;
		httpService = new http();
		httpService.setMethod("post");
		httpService.setCharset("utf-8");
		httpService.setUrl("https://getpocket.com/v3/oauth/authorize");
		httpService.addParam(type="formfield", name="consumer_key", value=getConsumerKey());
		httpService.addParam(type="formfield", name="code", value=getRequestToken());
		local.response = httpService.send().getPrefix();
		if (200 == local.response.Responseheader.Status_Code) 
		{
			local.result.success = true;
			setAccessToken(extractToken(local.response.FileContent.toString()));
		}
		return local.result;
	}

	/**
	* @hint I make a request to retrieve a request token.
	* @output false
	**/
	struct function retrieveRequestToken() {
		local.result.success = false;
		httpService = new http();
		httpService.setMethod("post");
		httpService.setCharset("utf-8");
		httpService.setUrl("https://getpocket.com/v3/oauth/request");
		httpService.addParam(type="formfield", name="consumer_key", value=getConsumerKey());
		httpService.addParam(type="formfield", name="redirect_uri", value=getRedirectURI());
		local.response = httpService.send().getPrefix();
		if (200 == local.response.Responseheader.Status_Code) 
		{
			local.result.success = true;
			setRequestToken(extractToken(local.response.FileContent));
		}
		return local.result;
	}
	
	/** PRIVATE METHODS **/	

	/**
	* @hint I extract a token from a string.
	* @output false
	* @str The string containing the token.
	**/
	private string function extractToken(
		required string str
	) 
	{
		return 
			ListGetAt(
				ReplaceList(
					Trim(arguments.str)
				, "&", "="), 
			2, "=");
	}
}
</cfscript>
