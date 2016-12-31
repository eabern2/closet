<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
			<title>Search Handbags by Color</title>
			<cfinclude template = "css/general.css">
		</head>

		<body>
    
		<cfinclude template = "css/header.cfm">
		
		<cfparam name="Form.colors" default="AAA" type="string">
		
		<cfif Form.colors NEQ "AAA">
			<!--- ### Report Code Starts Here --->
		
			 <cfquery name="getHandbags"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 SELECT * FROM tbHandbagItem a, tbUserHandbags b
					 WHERE handbagColor = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.colors#"> AND
					 uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.handbagId = b.handbagId
					 ORDER BY 1      
			</cfquery> 
		
			<cfif getHandbags.RecordCount IS 0> <!--- ### the user has no handbags matching this particular color --->
			   There are no <cfoutput>#Form.colors#</cfoutput> handbags.
			   <a href="showpursecolor.cfm">Search Again</a>
		   
			<cfelse> <!--- ### There were handbags found display the report --->
		   
			  <h1><cfoutput>#form.colors# </cfoutput>Handbags</h1>
			  <table id="t01"  width="70%">
				 <tr>
				  <th>Handbag Name</th>
				  <th>Handbag Brand</th>
				  <th>Image</th>
				  <th>Update</th>
				 </tr>
			  <cfoutput query="getHandbags">
			  <cfform action="updatehandbag.cfm" method="post">
				 <tr>
				  <td>#getHandbags.handbagName#</td>
				  <td>#getHandbags.handbagBrand#</td>
				  <td> 
					<img src="#getHandbags.handbagURL#" height="150" width="150">
				  </td>
				  <td>
					<input type="hidden" name="handbagId" value="#handbagId#" />
					<input type="submit" value="Update" />
				  </td>
				 </tr>
			</cfform>
			</cfoutput>
			</table>
		   </cfif> <!--- ### getHandbags.RecordCount IS 0 --->
		   
		    <h4>
          <a href="showpursecolor.cfm">Choose another purse color</a>
          
        </h4>
		<cfelse> 
		
		<!--- ### Form Code Starts Here --->
		
		<cfquery name="getColors"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 SELECT c.colors FROM tbHandbagItem a, tbUserHandbags b, tbColors c
					 where uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.handbagId = b.handbagId AND
					 c.colors = a.handbagColor
					 order by c.colors
		</cfquery>
		
		<cfif getColors.RecordCount IS 0> <!--- ### the user has no handbags in the database --->
		 You currently have no handbags in your closet.  Please add handbags.
			   <a href="addpurse.cfm">Add Handbags</a>
		   
		<cfelse> <!--- ### There were shoes found display the report --->
		
        <form action="showpursecolor.cfm" method="post">
           <h1> Select a Handbag Color </h1>
			<table>
				<tr>
					<th>Handbag Colors</th>
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
			
		</cfif> <!--- ### the user has no handbags in the database --->
		</cfif> <!--- ### Form.colors NEQ "AAA" --->

		<cfinclude template = "css/footer.cfm">
		</body>
	</html>
