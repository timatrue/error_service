<cfinclude template="includes/header.cfm" >
<cfif isUserLoggedIn()>
	<cfquery datasource="error_service" name="error_list">
		SELECT error_id, date_created, desc_short, user_id, status, urgency, criticality
		FROM errors
		ORDER BY
		<cfif structKeyExists(url,'sort')>
			#url.sort#
		<cfelse>
			date_created
		</cfif>
	</cfquery>
	<cfif error_list.RecordCount EQ 0>
    	<p> Nothing to display </p>
    <cfelse>
     	<h4>Users registred next errors in the system:</h4>
	<cfinclude template="includes/error_table_main.cfm" >
	</cfif>
</cfif>