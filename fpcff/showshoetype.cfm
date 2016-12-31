<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
			<title>Search Shoes by Type</title>
			<cfinclude template = "css/general.css">
		</head>

		<body>
    
		<cfinclude template = "css/header.cfm">
		
		<cfparam name="Form.descr" default="AAA" type="string">
		
		<cfif Form.descr NEQ "AAA">
			<!--- ### Report Code Starts Here --->
		
			 <cfquery name="getShoes"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 SELECT * FROM tbShoeItem a, tbUserShoes b 
					 WHERE shoeType = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.descr#"> AND
					 uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.shoeId = b.shoeId
					 ORDER BY 1           
			</cfquery> 
		
			<cfif getShoes.RecordCount IS 0> <!--- ### the user has no shoes matching this particular type --->
			   There are no <cfoutput>#Form.descr#</cfoutput> shoes.
			   <a href="showshoetype.cfm">Search Again</a>
		   
			<cfelse> <!--- ### There were shoes found display the report --->
		   
			  <h1><cfoutput>#form.descr# </cfoutput>Shoes</h1>
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
          <a href="showshoetype.cfm">Choose another shoe type</a>
          
        </h4>
		<cfelse> 
		
		<!--- ### Form Code Starts Here --->
		
		<cfquery name="getType"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 <!--- SELECT descr FROM tbShoeType ORDER BY descr --->
					 select c.descr from tbShoeItem a, tbUserShoes b, tbShoeType c
					 where uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.shoeId = b.shoeId AND
					 c.descr = a.shoeType
					 GROUP BY descr
		</cfquery>
		
		<cfif getType.RecordCount IS 0> <!--- ### the user has no shoes in the database --->
		 You currently have no shoes in your closet.  Please add shoes.
			   <a href="addshoe.cfm">Add Shoes</a>
		   
		<cfelse> <!--- ### There were shoes found display the report --->
        <form action="showshoetype.cfm" method="post">
           <h1> Select a Shoe Type </h1>
			<table>
				<tr>
					<th>Shoe Types</th>
					<td>
						<select name="descr">
				          <cfoutput query="getType">
				             <option value="#descr#">#descr#</option>	
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
