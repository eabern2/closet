<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Closet Companion Logout Page</title>

    <cfinclude template = "css/general.css">
  </head>

  <body>

    <cfinclude template = "css/header.cfm">

    <!--- Show user BEFORE logout --->

    <h3><cfoutput>Before Logout: #getAuthUser()#</cfoutput></h3>

       <cflogout>

       <cfcookie name="userview" expires="now">

    <!--- Show user AFTER logout --->

    <h3><cfoutput>After logout: #getAuthUser()#</cfoutput></h3>

    <h3><a href="login.cfm">Back to Login Page</a></h3>

    <cfinclude template = "css/footer.cfm">

  </body>
</html>