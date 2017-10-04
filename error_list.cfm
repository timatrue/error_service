<cfinclude template="includes/header.cfm" >
<cfif isUserLoggedIn()>
	<cfquery datasource="error_service" name="error_list">
		SELECT error_id, date_created, desc_short, status, urgency, criticality
		FROM errors
		ORDER BY date_created DESC;
	</cfquery>
	<cfif error_list.RecordCount EQ 0>
    	<p> Nothing to display </p>
    <cfelse>
     	<h4>Users registred next errors in the system:</h4>
		<table>
			<tr>
				<th>Settings</th>
				<th>Error ID</th>
				<th>Created</th>
				<th>Short Description</th>
				<th>Status</th>
				<th>Urgency</th>
				<th>Criticality</th>			
			</tr>
			<cfoutput query="error_list">
			<tr>
				<td ><a href="/error_service/edit_error.cfm?error=#error_id#">Edit error</a></td>
				<td >#error_id#</td>
				<td >#dateFormat(date_created, 'mmm dd yyyy')#</td>
				<td >#desc_short#</td>
				<td >#status#</td>
				<td >#urgency#</td>
				<td >#criticality#</td>
			</tr>
			</cfoutput>
		</table>
	</cfif>
</cfif>