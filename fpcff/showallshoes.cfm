<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>All Shoes</title>
    <cfinclude template = "css/general.css">
  </head>

  <body>
    
    <cfinclude template = "css/header.cfm">
     
    <!--- ### Form Code Starts Here --->

        <cfquery name="getShoes"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          	 select *
             from tbShoeItem a, tbUserShoes b
             where a.shoeId = b.shoeId AND
             uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> 
             order by b.shoeId
        </cfquery>
        
        <cfif getShoes.RecordCount NEQ 0>
        
         <h1>Shoe Details</h1>
			  <table id="t01"  width="70%">
				 <tr>
				  <th>Shoe Name</th>
				  <th>Shoe Brand</th>
				  <th>Shoe Color</th>
				  <th>Type</th>
				  <th>Image</th>
				 </tr>
			  <cfoutput query="getShoes">
			  <!--- cfform action="updateshoe.cfm" method="post" --->
				 <tr>
				  <td>#getShoes.shoeName#</td>
				  <td>#getShoes.shoeBrand#</td>
				  <td>#getShoes.shoeColor#</td>
				  <td>#getShoes.shoeType#</td>
				  <td> 
					<img src="#getShoes.shoeURL#" height="150" width="150">
				  </td>
				 </tr>
			<!--- /cfform --->
			</cfoutput>
			</table>
		   

         <cfelse> <!--- user has no shoes in the database ---> 
         
          <p>You have no shoes in the database.  <a href="addshoe.cfm">Add shoes.</a></p>
         </cfif>

    <cfinclude template = "css/footer.cfm">

    </body>
</html>

