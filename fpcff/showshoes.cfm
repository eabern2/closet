<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
			<title>Search Shoes by Brand</title>
			<cfinclude template = "css/general.css">
		</head>

		<body>
				
		<cfinclude template = "css/header.cfm">
		<cfparam name="Form.shoeBrand" default="AAA" type="string">
		
		<cfif Form.shoeBrand NEQ "AAA">
         
			<!--- ### Report Code Starts Here --->
		
			 <cfquery name="getBrands"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 SELECT * FROM tbShoeItem a, tbUserShoes b
					 WHERE shoeBrand = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.shoeBrand#"> AND
					 uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.shoeId = b.shoeId
					 ORDER BY 1        
			</cfquery> 
		
			<cfif getBrands.RecordCount IS 0> <!--- ### the user has no shoes matching this particular brand --->
			   You currently have no shoes that are <cfoutput>#form.shoeBrand#</cfoutput>.
			   <a href="showshoes.cfm">Search Again</a>
		   
			<cfelse> <!--- ### There were shoes found display the report --->
		   
			  <h1><cfoutput>#form.shoeBrand# </cfoutput>Shoes</h1>
			  <table id="t01"  width="70%">
				 <tr>
				  <th>Shoe Name</th>
				  <th>Color</th>
				  <th>Type</th>
				  <th>Image</th>
				  <th>Update</th>
				 </tr>
			  <cfoutput query="getBrands">
			  <cfform action="updateshoe.cfm" method="post">
				 <tr>
				  <td>#getBrands.shoeName#</td>
				  <td>#getBrands.shoeColor#</td>
				  <td>#getBrands.shoeType#</td>
				  <td> 
					<img src="#getBrands.shoeURL#" height="150" width="150">
				  </td>
				  <td>
					<input type="hidden" name="shoeId" value="#shoeId#" />
					<input type="submit" value="Update" />
				  </td>
				 </tr>
			</cfform>
			</cfoutput>
			</table>
		   </cfif> <!--- ### getBrands.RecordCount IS 0 --->
		   <h4>
          <a href="showshoes.cfm">Choose another shoe brand</a>
          
        </h4>
		<cfelse> 

		<!--- ### Form Code Starts Here --->
		
		<cfquery name="getShoeBrand"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 <!--- SELECT shoeBrand FROM tbShoeItem GROUP BY shoeBrand --->
					 select shoeBrand from tbShoeItem a, tbUserShoes b
					 where uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.shoeId = b.shoeId
					 GROUP BY shoeBrand
		</cfquery>
		
		<cfif getShoeBrand.RecordCount IS 0> <!--- ### the user has no shoes in the database --->
		 You currently have no shoes in your closet.  Please add shoes.
			   <a href="addshoe.cfm">Add Shoes</a>
		   
		<cfelse> <!--- ### There were shoes found display the report --->
        <form action="showshoes.cfm" method="post">
           <h1> Select a Shoe Brand </h1>
			<table>
				<tr>
					<th>Shoe Brand</th>
					<td>
						<select name="shoeBrand">
				          <cfoutput query="getShoeBrand">
				             <option value="#shoeBrand#">#shoeBrand#</option>	
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
		</cfif> <!--- ### Form.shoeBrand NEQ "AAA" --->
		
		<cfinclude template = "css/footer.cfm">
		</body>
	</html>
