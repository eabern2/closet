<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>All handbags</title>
    <cfinclude template = "css/general.css">
  </head>

  <body>
    
    <cfinclude template = "css/header.cfm">
     
    <!--- ### Form Code Starts Here --->

        <cfquery name="getHandbags"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          	 select *
             from tbHandbagItem a, tbUserHandbags b
             where a.handbagId = b.handbagId AND
             uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> 
             order by b.handbagId
        </cfquery>
        
        <cfif gethandbags.RecordCount NEQ 0>
        
         <h1>handbag Details</h1>
			  <table id="t01"  width="70%">
				 <tr>
				  <th>Handbag Name</th>
				  <th>Handbag Brand</th>
				  <th>Color</th>
				  <th>Image</th>
				 </tr>
			  <cfoutput query="gethandbags">
			  <!--- cfform action="updatehandbag.cfm" method="post" --->
				 <tr>
				  <td>#gethandbags.handbagName#</td>
				  <td>#gethandbags.handbagBrand#</td>
				  <td>#gethandbags.handbagColor#</td>
				  <td> 
					<img src="#gethandbags.handbagURL#" height="150" width="150">
				  </td>
				 </tr>
			<!--- /cfform --->
			</cfoutput>
			</table>
		   

         <cfelse> <!--- user has no handbags in the database ---> 
         
          <p>You have no handbags in the database.  <a href="addpurse.cfm">Add handbags.</a></p>
         </cfif>

    <cfinclude template = "css/footer.cfm">

    </body>
</html>

