<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
			<title>Search Handbags by Name</title>
			<cfinclude template = "css/general.css">
		</head>

		<body>
    
		<cfinclude template = "css/header.cfm">
		
		<cfparam name="Form.handbagName" default="Enter name of handbag" type="string">
		
		<cfif Form.handbagName NEQ "Enter name of handbag">
			<!--- ### Report Code Starts Here --->
		
			 <cfquery name="getHandbags"
					 datasource="#Request.DSN#"
					 username="#Request.username#"
					 password="#Request.password#">
					 SELECT * FROM tbHandbagItem a, tbUserHandbags b 
					 WHERE handbagName LIKE <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="%#Form.handbagName#%"> AND 
					 uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> AND
					 a.handbagId = b.handbagId
					 ORDER BY a.handbagId      
			</cfquery> 
		
			<cfif getHandbags.RecordCount IS 0> <!--- ### the user has no handbags matching this particular color --->
			   There are no handbags with the name <cfoutput>#Form.handbagName#</cfoutput>.
			   <a href="showpursename.cfm">Search Again</a>
		   
			<cfelse> <!--- ### There were handbags found display the report --->
		   
			  <h1>Results</h1>
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
          <a href="showpursename.cfm">Choose another purse name</a>
          
        </h4>
		<cfelse> 
		
		<!--- ### Form Code Starts Here --->
		
        <form action="showpursename.cfm" method="post">
           <h1> Enter Handbag Name </h1>
			<table>
				<tr>
					<th>Handbag Name</th>
					<td>
					<cfform>
               		<cfinput name="handbagName" type="text" 
               				value="#handbagName#" maxlength="50"
               				required="yes"
               				message="A name is required for the handbag name.">
               		
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
			
		</cfif> <!--- ### Form.handbagName NEQ "AAA" --->
		
		<cfinclude template = "css/footer.cfm">
		</body>
	</html>
