<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Add a New Shoe</title>
    <cfinclude template = "css/general.css">
  </head>

  <body>

    <cfinclude template = "css/header.cfm">

    <cfparam name="Form.shoeName" default=" " type="string">
    <cfparam name="Form.shoeBrand" default =" " type="string">
    <cfparam name="Form.shoeColor" default =" " type="string">
    <cfparam name="Form.shoeType" default =" " type="string">
    <cfparam name="Form.shoeURL" default =" " type="string">

    <cfif IsDefined("Form.add")>

    <!--- ### Action Code Starts Here --->

        <cfstoredproc
            datasource="#Request.DSN#"
            procedure="add_shoe"
            debug="yes"
            password="#Request.password#"
            username="#Request.username#">
            	
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#Form.shoeName#">
			
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#Form.shoeBrand#">
			
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#Form.shoeColor#">
			
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#Form.shoeType#">
			
			<cfprocparam
			cfsqltype="cf_sql_varchar"
			value="#Form.shoeURL#">
			
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
        <cfquery name="getType"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          	 select descr
             from tbShoeType
        </cfquery>
			
        <h1>
          Add a New Shoe 
        </h1>
        <!--- cfif getShoe.RecordCount IS 1 --->
          <cfform action="addshoe.cfm" method="post">
           <table>
             <tr>
               <td>Shoe Name</td>
               <td><cfinput name="shoeName" type="text" 
               				value="#shoeName#" maxlength="50"
               				required="yes"
               				message="A name is required for the shoe name."></td>
            </tr>
                          
            <tr>
               <td>Shoe Brand</td>
               <td><cfinput name="shoeBrand" type="text" 
               				value="#shoeBrand#" maxlength="50"
               				required="yes"
               				message="A brand is required.  Enter 'Other' if none."></td>
            </tr>
            
            <tr>
               <td>Shoe Color</td>
               <td><select name="shoeColor">
               		<cfoutput query="getColors">
               			<option value="#colors#"/>
               				#getColors.colors#
               		</cfoutput>
               	   </select>
               </td>
            </tr>
            
            <tr>
               <td>Shoe Type</td>
               <td><select name="shoeType">
               		<cfoutput query="getType">
               			<option value="#descr#"/>
               				#getType.descr#
               		</cfoutput>
               	   </select>
               </td>
            </tr>
            <tr>
               <td>Shoe Image</td>
               <td><cfinput name="shoeURL" type="text" value="#shoeURL#"></td>
            </tr>
            
            <tr>
             <td>
                   <input name="add" type="submit"
                          value="Add Shoe">
               </td>
               <td>
                 <input name="reset" type="reset"
                        value="Reset Values">
               </td>
              </tr>
            </table>
           </cfform>
         <!--- /cfif --->
             	

        <h4>
          <a href="index.cfm">Return to Main Page</a>
        </h4>

    </cfif> <!--- ### IsDefined("Form.update") --->

    <cfinclude template = "css/footer.cfm">

    </body>
</html>
