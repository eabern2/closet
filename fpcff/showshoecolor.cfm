<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
			<title>Search Shoes by Color</title>
			<cfinclude template = "css/general.css">
		</head>

		<body>
    
		<cfinclude template = "css/header.cfm">
		
		<cfparam name="Form.colors" default="AAA" type="string">
		
		<cfif Form.colors NEQ "AAA">
			<!--- ### Report Code Starts Here --->
		
			 <cfquery name="getShoes"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 SELECT * FROM tbShoeItem a, tbUserShoes b
					 WHERE shoeColor = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.colors#"> AND
					 uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.shoeId = b.shoeId
					 ORDER BY 1    
			</cfquery> 
		
			<cfif getShoes.RecordCount IS 0> <!--- ### the user has no shoes matching this particular color --->
			   There are no <cfoutput>#Form.colors#</cfoutput> shoes.
			   <a href="showshoecolor.cfm">Search Again</a>
		   
			<cfelse> <!--- ### There were shoes found display the report --->
		   
			  <h1><cfoutput>#form.colors# </cfoutput>Shoes</h1>
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
          <a href="showshoecolor.cfm">Choose another shoe color</a>
          
        </h4>
		<cfelse> 
		
		<!--- ### Form Code Starts Here --->
		
		<cfquery name="getColors"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 SELECT c.colors FROM tbShoeItem a, tbUserShoes b, tbColors c
					 where uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.shoeId = b.shoeId AND
					 c.colors = a.shoeColor
					 group by c.colors
		</cfquery>
		
		<cfif getColors.RecordCount IS 0> <!--- ### the user has no shoes in the database --->
		 You currently have no shoes in your closet.  Please add shoes.
			   <a href="addshoe.cfm">Add Shoes</a>
		   
		<cfelse> <!--- ### There were shoes found display the report --->
        <form action="showshoecolor.cfm" method="post">
           <h1> Select a Shoe Color </h1>
			<table>
				<tr>
					<th>Shoe Colors</th>
					<td>
						<select name="colors">
				          <cfoutput query="getColors">
				             <option value="#colors#">#colors#</option>	
			              </cfoutput>
			            </select>
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
			
		</cfif> <!--- ### the user has no shoes in the database --->
		</cfif> <!--- ### Form.colors NEQ "AAA" --->
		
		<cfinclude template = "css/footer.cfm">
		</body>
	</html>
