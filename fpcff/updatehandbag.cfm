<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Update Handbag</title>
    <cfinclude template = "css/general.css">
  </head>

  <body>
    
    <cfinclude template = "css/header.cfm">
     
    <cfparam name="Form.handbagId" default="AAA" type="string">
    <cfparam name="Form.handbagName" default="AAA" type="string">
    <cfparam name="Form.handbagBrand" default ="AA" type="string">
    <cfparam name="Form.handbagColor" default ="AAA" type="string">
    <cfparam name="Form.handbagURL" default ="AAA" type="string">

    <cfif IsDefined("Form.update")>

    <!--- ### Action Code Starts Here --->
    
	<cfquery name="updateHandbag"
             datasource="#Request.DSN#"
             username="#Request.username#"
             password="#Request.password#">
          update tbHandbagItem
             set
               handbagName = '#Form.handbagName#',
               handbagBrand = '#Form.handbagBrand#',
               handbagColor = '#Form.handbagColor#',
               handbagURL = '#Form.handbagURL#'
               where handbagId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.handbagId#"> 
    </cfquery>

    <cflocation url="showupdatedhandbag.cfm?handbagId=#Form.handbagId#" addToken="no">

    <cfelseif IsDefined("Form.delete")>
	
	<!--- ### Delete Action Code Starts Here --->

      <cftry>
        <cfquery name="deleteHandbag"
             datasource="#Request.DSN#"
             username="#Request.username#"
             password="#Request.password#">
          delete from tbUserHandbags
               where handbagid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.handbagId#"> AND
               uname = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#GetAuthUser()#"> 
        </cfquery>

       <cfcatch type = "Database">
		<cfoutput>
		  <p>
		     There has been a type = #CFCATCH.TYPE# Error.<br />
		     Please report to the following information to your System Administrator:  #cfcatch.message#
		  </p>
		</cfoutput>
          <h4>
            <a href="index.cfm">
               Back to Main Page</a>
          </h4>

		</cfcatch>
      </cftry>
      	
      	<p>Handbag Deleted</p>
      
    <cfelse>

    <!--- ### Form Code Starts Here --->

        <cfquery name="getHandbag"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          	 select *
             from tbHandbagItem
             where handbagId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.handbagId#"> 
        </cfquery>
        <cfquery name="getColors"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          	 select colors
             from tbColors
        </cfquery>
        	
        <h1>
          Update Handbag Details
        </h1>
        <cfif getHandbag.RecordCount IS 1>
          <cfform action="updatehandbag.cfm" method="post">
           <table>
             <tr>
               <td>Handbag Name</td>
               <td><cfinput name="handbagName" type="text" 
               				value="#getHandbag.handbagName#" maxlength="50"
               				required="yes"
               				message="A name is required for the handbag name."></td>
            </tr>
                          
            <tr>
               <td>Handbag Brand</td>
               <td><cfinput name="handbagBrand" type="text" 
               				value="#getHandbag.handbagBrand#" maxlength="50"
               				required="yes"
               				message="A brand is required.  Enter 'Other' if none."></td>
            </tr>
            
            <tr>
               <td>Handbag Color</td>
               <td><select name="handbagColor">
               		<cfoutput query="getColors">
               			<option value="#colors#"
               				<cfif #colors# IS #getHandbag.handbagColor#> selected
               				</cfif> />
               				#getColors.colors#
               		</cfoutput>
               	   </select>
               </td>
            </tr>
            
            <tr>
               <td>Handbag Image</td>
               <td><cfinput name="handbagURL" type="text" value="#getHandbag.handbagURL#"></td>
            </tr>
            
            <tr>
             <td>
                 <cfoutput>
                    <input type="hidden" name="handbagId" value="#Form.handbagId#">
                 </cfoutput>
                   <input name="update" type="submit"
                          value="Update Handbag"> 
                   <br>
                    <input name="delete" type="submit"
                          value="Delete Handbag">
               </td>
               <td>
                 <input name="reset" type="reset"
                        value="Reset Values">
               </td>
              </tr>
            </table>
           </cfform>
         </cfif>
             	

    </cfif> <!--- ### IsDefined("Form.update") --->

    <cfinclude template = "css/footer.cfm">

    </body>
</html>

