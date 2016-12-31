<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Updated Handbag Record</title>
    <cfinclude template = "css/general.css">
  </head>

  <body>

    <cfinclude template = "css/header.cfm">

    <cfparam name="URL.handbagId" default="AAA" type="string">

    <cfif URL.handbagId NEQ "AAA">

    <!--- ### Report Code Starts Here --->

        <cfquery name="getHandbag"
             datasource="#Request.DSN#"
             username="#Request.username#"
             password="#Request.password#">
          select * from tbHandbagItem
            where handbagId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.handbagId#"> 
    	</cfquery>
    	
    	<h2>Handbag Record Updated</h2>
    	<table>
             <tr>
               <td>Handbag Name</td>
               <td><cfoutput> #getHandbag.handbagName#</cfoutput></td>
            </tr>
                          
            <tr>
               <td>Handbag Brand</td>
               <td><cfoutput> #getHandbag.handbagBrand#</cfoutput></td>
            </tr>
            
            <tr>
               <td>Handbag Color</td>
               <td><cfoutput> #getHandbag.handbagColor#</cfoutput></td>
            </tr>
    
            <tr>
               <td>Handbag Image</td>
               <td> 
					<cfoutput><img src="#getHandbag.handbagURL#" height="150" width="150"></cfoutput>
			  </td>
            </tr>
            
		</table>
            

    </cfif> <!--- ### URL.handbagId NEQ "AAA" --->

    <cfinclude template = "css/footer.cfm">

    </body>
</html>
