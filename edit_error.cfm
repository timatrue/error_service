<cfinclude template="includes/header.cfm" >
<cfif isUserLoggedIn()>
	<cfif structKeyExists(url,'error')>
		
		
		<cfif structKeyExists(form,'fld_submitError')>
			<cfset variables.errorFormEditComplete = false>
			<cfset errorMsg = arrayNew(1)>
			<cfif form.fld_short_desc EQ ''>
				<cfset arrayAppend(errorMsg,'Please provide a short description')>
			</cfif>
			<cfif form.fld_short_desc EQ ''>
				<cfset arrayAppend(errorMsg,'Please provide a full description')>
			</cfif>
			<cfif arrayIsEmpty(errorMsg)>
				<cfquery datasource="error_service" >
					UPDATE errors
					SET
					date_created = NOW(),
					desc_short = '#form.fld_short_desc#',
					desc_long = '#form.fld_full_desc#',
					status = '#form.fld_status#',
					urgency = '#form.fld_urgency#',
					criticality = '#form.fld_criticality#'
					WHERE error_id = #url.error#
				</cfquery>
				<cfquery datasource="error_service" >
					INSERT INTO errors_history
					(error_id, date_created, desc_short, desc_long, user_id, status, urgency, criticality)
					VALUES
					('#url.error#', '#session.saved_error.date_created#',
					'#session.saved_error.desc_short#', '#session.saved_error.desc_long#',
					'#session.loggedUser.userID#', '#session.saved_error.status#',
					'#session.saved_error.urgency#', '#session.saved_error.criticality#')
				</cfquery>
				<cfset structClear(session.saved_error)>
				<cfset variables.errorFormEditComplete = true>
				<cflocation url="/error_service/error_list.cfm" >
			</cfif>
		</cfif>
		
		
		<cfset errorNumber="#url.error#">
		<cfquery datasource="error_service" name="error_details">
			SELECT * FROM errors WHERE error_id = #errorNumber#;
		</cfquery>
		<cfquery datasource="error_service" name="error_history">
			SELECT * FROM errors_history WHERE error_id = #errorNumber#;
		</cfquery>
		<cfquery datasource="error_service" name="status_list">
			SELECT status
			FROM status_list
			WHERE
			<cfif error_details.status EQ 'New'>
				st_new = 1;
 			<cfelseif error_details.status EQ 'Opened'>
 				st_opened = 1;
 			<cfelseif error_details.status EQ 'Solved'>
 				st_solved = 1;
 			<cfelseif error_details.status EQ 'Closed'>
 				st_closed = 1;
			</cfif>
		</cfquery>
	
		<cfset session.saved_error = {
			date_created = error_details.date_created,
			desc_short = error_details.desc_short,
			desc_long = error_details.desc_long,
			user_id =  error_details.user_id,
			status = error_details.status,
			urgency = error_details.urgency,
			criticality = error_details.criticality
		} >

		<cfquery datasource="error_service" name="urgency_list">
			SELECT urgency FROM urgency_list;
		</cfquery>
		<cfquery datasource="error_service" name="critical_list">
			SELECT criticality FROM critical_list;
		</cfquery>
		<div id="error-container">
	    	<h3><cfoutput >Editing error #errorNumber#:</cfoutput></h3>
			<cfform id="error-form">
				<div>
					<label for="fld_short_desc">Short description:&nbsp</label>
					<cfinput name="fld_short_desc" value="#error_details.desc_short#" message="Please provide the error's brief" required>
				</div>
				<div>
					<label for="fld_full_desc">Full description:&nbsp</label>
					<cftextarea name="fld_full_desc" message="Please provide the error's description" required>
						<cfoutput >#error_details.desc_long#</cfoutput>
					</cftextarea>
				</div>
				<div>
					<label for="fld_status">Status:&nbsp</label>
					<cfselect name="fld_status" query="status_list" display="status" selected="#error_details.status#" required></cfselect>
				</div>
				<div>
					<label for="fld_urgency">Urgency:&nbsp</label>
					<cfselect name="fld_urgency" query="urgency_list" display="urgency" selected="#error_details.urgency#" required></cfselect>
				</div>
				<div>
					<label for="fld_criticality">Criticality:&nbsp</label>
					<cfselect name="fld_criticality" query="critical_list" display="criticality" selected="#error_details.criticality#" required></cfselect>
				</div>
				<div>
		        	<cfinput type="submit" name="fld_submitError" id="fld_submitError" />
		    	</div>
			</cfform>
		</div>
	</cfif>
	<cfif error_history.RecordCount EQ 0>
     	<p style="text-align:center;"> Error doesn't have history</p>
 	<cfelse>
     	<h4>Error's history':</h4>
		<cfinclude template="includes/error_table_history.cfm" >
    </cfif>
	<cfset variables.errorFormEditComplete = false>  
<cfelse>
	<cflocation url="/error_service/index.cfm?noaccess" >
</cfif>