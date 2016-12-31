<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
			<title>Search Shoes by Name</title>
			<cfinclude template = "css/general.css">
		</head>

		<body>
        
		<cfinclude template = "css/header.cfm">
		
		<cfparam name="Form.shoeName" default="Enter name of shoe" type="string">
		
		<cfif Form.shoeName NEQ "Enter name of shoe">
			<!--- ### Report Code Starts Here --->
		
			 <cfquery name="getShoes"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 SELECT * FROM tbShoeItem a, tbUserShoes b
					 WHERE shoename LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#Form.shoeName#%"> AND
					 uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.shoeid = b.shoeid
					 ORDER BY a.shoeid      
			</cfquery> 
		
			<cfif getShoes.RecordCount IS 0> <!--- ### the user has no shoes matching this particular name --->
			   There are no shoes with the name <cfoutput>#Form.shoeName#</cfoutput>.
			   <a href="showshoename.cfm">Search Again</a>
		   
			<cfelse> <!--- ### There were shoes found display the report --->
		   
			  <h1>Results</h1>
			  <table id="t01"  width="70%">
				 <tr>
				  <th>Shoe Name</th>
				  <th>Shoe Brand</th>
				  <th>Type</th>
				  <th>Image</th>
				  <th>Update</th>
				 </tr>
			  <cfoutput query="getShoes">
			  <cfform action="updateshoe.cfm" method="post">
				 <tr>
				  <td>#getShoes.shoeName#</td>
				  <td>#getShoes.shoeBrand#</td>
				  <td>#getShoes.shoeType#</td>
				  <td> 
					<img src="#getShoes.shoeURL#" height="150" width="150">
				  </td>
				  <td>
					<input type="hidden" name="shoeId" value="#shoeId#" />
					<input type="submit" value="Update" />
				  </td>
				 </tr>
			</cfform>
			</cfoutput>
			</table>
		   </cfif> <!--- ### getShoes.RecordCount IS 0 --->
		  <h4>
          <a href="showshoename.cfm">Choose another shoe name</a>
          
        </h4> 
		<cfelse> 
		
		<!--- ### Form Code Starts Here --->
		
        <form action="showshoename.cfm" method="post">
           <h1> Enter Shoe Name </h1>
			<table>
				<tr>
					<th>Shoe Name</th>
					<td>
					<cfform>
               		<cfinput name="shoeName" type="text" 
               				value="#shoeName#" maxlength="50"
               				required="yes"
               				message="A name is required for the shoe name.">
               		
               		</cfform>
               		</td>
			    </tr>
			    <tr>
					<td>&nbsp;</td>
					<td>
						<cfoutput>
							<input name="submit" type="submit" Value="Submit" />
						</cfoutput>
					</td>
				</tr>
			</table>
			
		</cfif> <!--- ### Form.shoeName NEQ "AAA" --->
		
		<cfinclude template = "css/footer.cfm">
		</body>
	</html>
