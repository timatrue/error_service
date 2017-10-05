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
		<table>
			<tr>
				<th>
					<span>Settings</span>
				</th>
				<th>
					<div class="align-v">
						<span>Error ID</span>
						<a href="/error_service/error_list.cfm?sort=error_id&"><img class="sort-img" src="images/sort_small.jpg" ></img></a>
					</div>
				</th>
				<th>
					<div class="align-v">
						<span>Created</span>
						<a href="/error_service/error_list.cfm?sort=date_created"><img class="sort-img" src="images/sort_small.jpg" ></img></a>
						</div>
				</th>
				<th>
					<div class="align-v">
						<span>Short Description</span>
						<a href="/error_service/error_list.cfm?sort=desc_short"><img class="sort-img" src="images/sort_small.jpg" ></img></a>
					</div>
				</th>
				<th>
					<div class="align-v">
						<span>Status</span>
						<a href="/error_service/error_list.cfm?sort=status"><img class="sort-img" src="images/sort_small.jpg" ></img></a>
					</div>
				</th>
				<th>
					<div class="align-v">
						<span>Urgency</span>
						<a href="/error_service/error_list.cfm?sort=urgency"><img class="sort-img" src="images/sort_small.jpg" ></img></a>
					</div>
				</th>
				<th>
					<div class="align-v">
						<span>Criticality</span>
						<a href="/error_service/error_list.cfm?sort=criticality"><img class="sort-img" src="images/sort_small.jpg" ></img></a>
					</div>
				</th>			
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