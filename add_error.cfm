<cfinclude template="includes/header.cfm" >
<cfif isUserLoggedIn()>
	<cfif structKeyExists(form,'fld_submitError')>
		<cfset variables.errorFormSubmitComplete = false>
		<cfset errorMsg = arrayNew(1)>
		<cfif form.fld_short_desc EQ ''>
			<cfset arrayAppend(errorMsg,'Please provide a short description')>
		</cfif>
		<cfif form.fld_short_desc EQ ''>
			<cfset arrayAppend(errorMsg,'Please provide a full description')>
		</cfif>
		<cfif arrayIsEmpty(errorMsg)>
			<cfquery datasource="error_service" >
				INSERT INTO errors
				(date_created, desc_short, desc_long, user_id, status, urgency, criticality)
				VALUES
				(NOW(), '#form.fld_short_desc#', '#form.fld_full_desc#', '#session.loggedUser.userID#',
				'#form.fld_status#', '#form.fld_urgency#', '#form.fld_criticality#')
			</cfquery>
			<cfset variables.errorFormSubmitComplete = true>
		</cfif>
	</cfif>
	<cfquery datasource="error_service" name="status_list">
		SELECT status
		FROM status_list
		WHERE st_new = 1		
	</cfquery>
	<cfquery datasource="error_service" name="urgency_list">
		SELECT urgency FROM urgency_list;
	</cfquery>
	<cfquery datasource="error_service" name="critical_list">
		SELECT criticality FROM critical_list;
	</cfquery>
    <div id="error-container">
    	<h3>Please, provide new error:</h3>
    	<cfif isDefined('errorMsg') AND NOT arrayIsEmpty(errorMsg)>
    		<cfoutput >
	    		<cfloop array="#errorMsg#" index="msg">
	    			<p>#msg#</p>
	    		</cfloop>
    		</cfoutput>
    	</cfif>

		<cfform id="error-form">
			<cfif structKeyExists(variables,'errorFormSubmitComplete') AND variables.errorFormSubmitComplete>
				<div><span class="success">Error succesfully recorded!</span></div>
			</cfif>
			<div>
				<label for="fld_short_desc">Short description:&nbsp</label>
				<cfinput name="fld_short_desc" message="Please provide the error's brief" required>
			</div>
			<div>
				<label for="fld_full_desc">Full description:&nbsp</label>
				<cftextarea name="fld_full_desc" message="Please provide the error's description" required></cftextarea>
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
	<cfset variables.errorFormSubmitComplete = false>   
<cfelse>
	<cflocation url="/error_service/index.cfm?noaccess" >
</cfif>
