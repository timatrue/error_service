<cfinclude template="includes/header.cfm" >
<cfif isUserLoggedIn()>
	<cfquery datasource="error_service" name="status_list">
		SELECT status FROM status_list;
	</cfquery>
	<cfquery datasource="error_service" name="urgency_list">
		SELECT urgency FROM urgency_list;
	</cfquery>
	<cfquery datasource="error_service" name="critical_list">
		SELECT criticality FROM critical_list;
	</cfquery>
    <div id="error-container">
    	<h3>Please, add new error:</h3>
		<cfform id="error-form">
			<div>
				<label for="fld_short_desc">Short description:&nbsp</label>
				<cfinput name="fld_short_desc" message="Please provide the error's brief" required>
			</div>
			<div>
				<label for="fld_full_desc">Full description:&nbsp</label>
				<cfinput name="fld_full_desc" message="Please provide the error's description" required>
			</div>
			<div>
				<label for="fld_status">Status:&nbsp</label>
				<cfselect name="fld_status" query="status_list" display="status" required></cfselect>
			</div>
			<div>
				<label for="fld_urgency">Urgency:&nbsp</label>
				<cfselect name="fld_urgency" query="urgency_list" display="urgency" required></cfselect>
			</div>
			<div>
				<label for="fld_criticality">Criticality:&nbsp</label>
				<cfselect name="fld_criticality" query="critical_list" display="criticality" required></cfselect>
			</div>
			<div>
	        	<cfinput type="submit" name="fld_submitError" id="fld_submitError" />
	    	</div>
		</cfform>
	</div>   
<cfelse>
	<cflocation url="/error_service/index.cfm?noaccess" >
</cfif>
