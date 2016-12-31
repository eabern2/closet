<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Add a New Handbag</title>
    <cfinclude template = "css/general.css">
  </head>

  <body>

    <cfinclude template = "css/header.cfm">

    <cfparam name="Form.handbagName" default=" " type="string">
    <cfparam name="Form.handbagBrand" default =" " type="string">
    <cfparam name="Form.handbagcolor" default =" " type="string">
    <cfparam name="Form.handbagURL" default =" " type="string">

    <cfif IsDefined("Form.add")>

    <!--- ### Action Code Starts Here --->

        <cfstoredproc
            datasource="#Request.DSN#"
            procedure="add_handbag"
            debug="yes"
            password="#Request.password#"
            username="#Request.username#">
            	
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#Form.handbagName#">
			
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#Form.handbagBrand#">
			
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#Form.handbagColor#">
			
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#Form.handbagURL#">
				
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#GetAuthUser()#">
			
		</cfstoredproc>
		
        <cflocation url="index.cfm">

    <cfelse>

    <!--- ### Form Code Starts Here --->
        <cfquery name="getColors"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          	 select colors
             from tbColors
             order by 1
        </cfquery>
        	
        <h1>
          Add a New Handbag 
        </h1>
        <!--- cfif getHandbag.RecordCount IS 1 --->
          <cfform action="addpurse.cfm" method="post">
           <table>
             <tr>
               <td>Handbag Name</td>
               <td><cfinput name="handbagName" type="text" 
               				value="#handbagName#" maxlength="50"
               				required="yes"
               				message="A name is required for the handbag name."></td>
            </tr>
                          
            <tr>
               <td>Handbag Brand</td>
               <td><cfinput name="handbagBrand" type="text" 
               				value="#handbagBrand#" maxlength="50"
               				required="yes"
               				message="A brand is required.  Enter 'Other' if none."></td>
            </tr>
            
            <tr>
               <td>Handbag Color</td>
               <td><select name="handbagcolor">
               		<cfoutput query="getColors">
               			<option value="#colors#"/>
               				#getColors.colors#
               		</cfoutput>
               	   </select>
               </td>
            </tr>
            
            <tr>
               <td>Handbag Image</td>
               <td><cfinput name="handbagURL" type="text" value="#handbagURL#"></td>
            </tr>
            
            <tr>
             <td>
                   <input name="add" type="submit"
                          value="Add Handbag">
               </td>
               <td>
                 <input name="reset" type="reset"
                        value="Reset Values">
               </td>
              </tr>
            </table>
           </cfform>
         <!--- /cfif --->
             	
    </cfif> <!--- ### IsDefined("Form.update") --->

    <cfinclude template = "css/footer.cfm">

    </body>
</html>
