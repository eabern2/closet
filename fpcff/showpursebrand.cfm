<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
			<title>Search Handbags by Brand</title>
			<cfinclude template = "css/general.css">
		</head>

		<body>
		<cfinclude template = "css/header.cfm">
		
		<cfparam name="Form.handbagBrand" default="AAA" type="string">

		<cfif Form.handbagBrand NEQ "AAA">
         
			<!--- ### Report Code Starts Here --->
		
			 <cfquery name="getBrands"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 SELECT * FROM tbHandbagItem a, tbUserHandbags b
					 WHERE handbagBrand = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.handbagBrand#"> AND
					 uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.handbagId = b.handbagId
					 ORDER BY 1         
			</cfquery> 
		
			<cfif getBrands.RecordCount IS 0> <!--- ### the user has no handbags matching this particular brand --->
			   You currently have no handbags that are <cfoutput>#form.handbagBrand#</cfoutput>.
			   <a href="showpursebrand.cfm">Search Again</a>
		   
			<cfelse> <!--- ### There were handbags found display the report --->
		   
			  <h1><cfoutput>#form.handbagBrand# </cfoutput>Handbags</h1>
			  <table id="t01"  width="70%">
				 <tr>
				  <th>Handbag Name</th>
				  <th>Color</th>
				  <th>Image</th>
				  <th>Update</th>
				 </tr>
			  <cfoutput query="getBrands">
			  <cfform action="updatehandbag.cfm" method="post">
				 <tr>
				  <td>#getBrands.handbagName#</td>
				  <td>#getBrands.handbagColor#</td>
				  <td> 
					<img src="#getBrands.handbagURL#" height="150" width="150">
				  </td>
				  <td>
					<input type="hidden" name="handbagId" value="#handbagId#" />
					<input type="submit" value="Update" />
				  </td>
				 </tr>
			</cfform>
			</cfoutput>
			</table>
		   </cfif> <!--- ### getBrands.RecordCount IS 0 --->
		   
		    <h4>
          <a href="showpursebrand.cfm">Choose another purse brand</a>
          
        </h4>
		<cfelse> 
		
		<!--- ### Form Code Starts Here --->
		
		<cfquery name="getPurseBrand"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 select handbagBrand from tbHandBagItem a, tbUserHandbags b
					 where uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.handbagId = b.handbagId
					 group by handbagBrand
		</cfquery>
		
		<cfif getPurseBrand.RecordCount IS 0> <!--- ### the user has no handbags in the database --->
		 You currently have no handbags in your closet.  Please add handbags.
			   <a href="addpurse.cfm">Add Handbags</a>
		   
		<cfelse> <!--- ### There were handbags found display the report --->
		
        <form action="showpursebrand.cfm" method="post">
           <h1> Select a Purse Brand </h1>
			<table>
				<tr>
					<th>Purse Brand</th>
					<td>
						<select name="handbagBrand">
				          <cfoutput query="getPurseBrand">
				             <option value="#handbagBrand#">#handbagBrand#</option>	
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
		</cfif> <!--- ### the user has no handbags in the database --->

		</cfif> <!--- ### Form.handbagBrand NEQ "AAA" --->
		
		<cfinclude template = "css/footer.cfm">
		</body>
	</html>
