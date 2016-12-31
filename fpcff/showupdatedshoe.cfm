<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Updated Shoe Record</title>
    <cfinclude template = "css/general.css">
  </head>

  <body>

    <cfinclude template = "css/header.cfm">

    <cfparam name="URL.shoeId" default="AAA" type="string">

    <cfif URL.shoeId NEQ "AAA">

    <!--- ### Report Code Starts Here --->

        <cfquery name="getShoe"
             datasource="#Request.DSN#"
             username="#Request.username#"
             password="#Request.password#">
          select * from tbShoeItem
            where shoeId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#URL.shoeId#"> 
    	</cfquery>
    	<h2>Shoe Record Updated</h2>
    	<table>
             <tr>
               <td>Shoe Name</td>
               <td><cfoutput> #getShoe.shoeName#</cfoutput></td>
            </tr>
                          
            <tr>
               <td>Shoe Brand</td>
               <td><cfoutput> #getShoe.shoeBrand#</cfoutput></td>
            </tr>
            
            <tr>
               <td>Shoe Color</td>
               <td><cfoutput> #getShoe.shoeColor#</cfoutput></td>
            </tr>
            
            <tr>
               <td>Shoe Type</td>
               <td><cfoutput> #getShoe.shoeType#</cfoutput></td>
            </tr>
            <tr>
               <td>Shoe Image</td>
               <td> 
					<cfoutput><img src="#getShoe.shoeURL#" height="150" width="150"></cfoutput>
			  </td>
            </tr>
            
		</table>
            
    </cfif> <!--- ### URL.projectno NEQ "AAA" --->

    <cfinclude template = "css/footer.cfm">

    </body>
</html>
