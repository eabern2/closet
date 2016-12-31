<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

  <head>
    <title>Update Shoe</title>
    <cfinclude template = "css/general.css">
  </head>

  <body>
    
    <cfinclude template = "css/header.cfm">
     
    <cfparam name="Form.shoeId" default="AAA" type="string">
    <cfparam name="Form.shoeName" default="AAA" type="string">
    <cfparam name="Form.shoeBrand" default ="AA" type="string">
    <cfparam name="Form.shoeColor" default ="AAA" type="string">
    <cfparam name="Form.shoeType" default ="AAA" type="string">
    <cfparam name="Form.shoeURL" default ="AAA" type="string">

    <cfif IsDefined("Form.update")>

    <!--- ### Action Code Starts Here --->
    
	<cfquery name="updateShoe"
             datasource="#Request.DSN#"
             username="#Request.username#"
             password="#Request.password#">
          update tbShoeItem
             set
               shoeName = '#Form.shoeName#',
               shoeBrand = '#Form.shoeBrand#',
               shoeColor = '#Form.shoeColor#',
               shoeType = '#Form.shoeType#',
               shoeURL = '#Form.shoeURL#'
               where shoeId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.shoeId#"> 
    </cfquery>

    <cflocation url="showupdatedshoe.cfm?shoeId=#Form.shoeId#" addToken="no">

	<cfelseif IsDefined("Form.delete")>
	
	<!--- ### Delete Action Code Starts Here --->

      <cftry>
        <cfquery name="deleteShoe"
             datasource="#Request.DSN#"
             username="#Request.username#"
             password="#Request.password#">
          delete from tbUserShoes
               where shoeid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.shoeId#"> AND
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
      	
	  <p>Shoe Deleted</p>
	 
    <cfelse>

    <!--- ### Form Code Starts Here --->

        <cfquery name="getShoe"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          	 select *
             from tbShoeItem
             where shoeId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Form.shoeId#"> 
        </cfquery>
        <cfquery name="getColors"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          	 select colors
             from tbColors
             where colors != 'ALL COLORS'
        </cfquery>
        <cfquery name="getType"
                 datasource="#Request.DSN#"
                 username="#Request.username#"
                 password="#Request.password#">
          	 select descr
             from tbShoeType
             where descr != 'ALL TYPES'
        </cfquery>
			
        <h1>
          Update Shoe Details
        </h1>
        <cfif getShoe.RecordCount IS 1>
          <cfform action="updateshoe.cfm" method="post">
           <table>
             <tr>
               <td>Shoe Name</td>
               <td><cfinput name="shoeName" type="text" 
               				value="#getShoe.shoeName#" maxlength="50"
               				required="yes"
               				message="A name is required for the shoe name."></td>
            </tr>
                          
            <tr>
               <td>Shoe Brand</td>
               <td><cfinput name="shoeBrand" type="text" 
               				value="#getShoe.shoeBrand#" maxlength="50"
               				required="yes"
               				message="A brand is required.  Enter 'Other' if none."></td>
            </tr>
            
            <tr>
               <td>Shoe Color</td>
               <td><select name="shoeColor">
               		<cfoutput query="getColors">
               			<option value="#colors#"
               				<cfif #colors# IS #getShoe.shoeColor#> selected
               				</cfif> />
               				#getColors.colors#
               		</cfoutput>
               	   </select>
               </td>
            </tr>
            
            <tr>
               <td>Shoe Type</td>
               <td><select name="shoeType">
               		<cfoutput query="getType">
               			<option value="#descr#"
               				<cfif #descr# IS #getShoe.shoeType#> selected
               				</cfif> />
               				#getType.descr#
               		</cfoutput>
               	   </select>
               </td>
            </tr>
            <tr>
               <td>Shoe Image</td>
               <td><cfinput name="shoeURL" type="text" value="#getShoe.shoeURL#"></td>
            </tr>
            
            <tr>
             <td>
                 <cfoutput>
                    <input type="hidden" name="shoeId" value="#Form.shoeId#">
                 </cfoutput>
                   <input name="update" type="submit"
                          value="Update Shoe">
                   <br>
                   <input name="delete" type="submit"
                          value="Delete Shoe">
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

