<cfinclude template="includes/header.cfm" >
<!---isUserLoggedIn Linked with native cflogin function--->
<cfif isUserLoggedIn()>
	<cfset session>
	<h3>
		<cfoutput>
			Welcome on Board #session.loggedUser.lastName# #session.loggedUser.firstName#
		</cfoutput>
	</h3>
	<cfquery datasource="error_service" name="error_list">
		SELECT error_id,date_created, desc_short, status
		FROM errors
		WHERE user_id = #session.loggedUser.userID#
		ORDER BY date_created DESC;
	</cfquery>
	     <cfif error_list.RecordCount EQ 0>
	     	<p> Nothing to display </p>
	     <cfelse>
	     	<h4>You registred in the system next errors:</h4>
		     <table>
				<tr>
					<th>Error ID</th>
					<th>Created</th>
					<th>Short Description</th>
					<th>Status</th>
				</tr>
	     		<cfoutput query="error_list">
			     	<tr>
			     		<td >#error_id#</td>
			     		<td >#dateFormat(date_created, 'mmm dd yyyy')#</td>
			     		<td >#desc_short#</td>
			     		<td >#status#</td>
			     	</tr>
		     	</cfoutput>
		     </table>
	     </cfif>
<cfelse>
	<cflocation url="/error_service/index.cfm?noaccess" >
</cfif>