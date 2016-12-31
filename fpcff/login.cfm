<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Closet Companion Login Page</title>

    <cfinclude template = "css/general.css">
  </head>

  <!--- Place cursor in "User Name" field when page loads--->

  <body onLoad="document.login.userLogin.focus();">

    <cfinclude template = "css/header.cfm">

    <cfset myaction="index.cfm">

    <cfform action="#myaction#" name="login"
            method="post" preservedata="yes">

    <table align="center">
       <tr><th colspan="2" class="highlight">Please Log In</th></tr>
       <tr>
         <td>Username:</td>
         <td>
           <cfinput type="text" name="userLogin" size="20" value=""
                    maxlength="100" required="yes"
                    message="Please enter your USERNAME">
           <input type="hidden" name="userLogin_required">
         </td>
       </tr>
	   <tr>
         <td>Password:</td>
         <td>
            <cfinput type="password" name="userPassword" size="20" value=""
                     maxlength="100" required="yes"
                     message="Please enter your PASSWORD">
            <input type="hidden" name="userPassword_required">
         </td>
       </tr>
       <tr>
         <td>&nbsp;</td>
         <td><input type="submit" name="login" value="Login" /></td>
       </tr>
    </table>
    </cfform>

  </body>
</html>
