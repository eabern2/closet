<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Closet Companion</title>

    <cfinclude template = "css/general.css">
  </head>
  <body>
  	
  	 <cfquery name="getUser"
            datasource="#APPLICATION.dataSource#"
             password="#APPLICATION.password#"
             username="#APPLICATION.username#">
          select fname
             from tbUsers
			 where uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#">
   </cfquery>
   
    <cfinclude template = "css/header.cfm">

	<h2>Welcome <cfoutput>#getUser.fname#</cfoutput>, to the Closet Companion</h2>
    <h3>Here are your options to get started in Shoes</h3>
    <ul>
	<li><a href="showshoes.cfm">Search for shoes by Brand</a></li><br>
	<li><a href="showshoecolor.cfm">Search for shoes by Color</a></li><br>
	<li><a href="showshoetype.cfm">Search for shoes by Type</a></li><br>
	<li><a href="showshoename.cfm">Search for shoes by Name</a></li><br>
	<li><a href="addshoe.cfm">Add Shoes</a></li><br>
	<li><a href="showallshoes.cfm">Show all shoes</a></li>
	</ul>
	<h3>Here are your options to get started in Handbags</h3>
	<ul>
	<li><a href="showpursebrand.cfm">Search for handbags by Brand</a></li><br>
	<li><a href="showpursecolor.cfm">Search for handbags by Color</a></li><br>
	<li><a href="showpursename.cfm">Search for handbags by Name</a></li><br>
	<li><a href="addpurse.cfm">Add Handbag</a></li><br>
	<li><a href="showallhandbags.cfm">Show all handbags</a></li><br>
	</ul>

   
  </body>
</html>
