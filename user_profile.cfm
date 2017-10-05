<script src="/error_service/scripts/helper.js"></script>
<cfinclude template="includes/header.cfm" >
<!---isUserLoggedIn Linked with native cflogin function--->
<cfif isUserLoggedIn()>
	<div id="user-container">
		<h3>
			<cfoutput>
				Welcome on Board #session.loggedUser.lastName# #session.loggedUser.firstName#
			</cfoutput>
			<button class="edit-button" id="edit-button">Edit profile</button>
		</h3>
		<cfif structKeyExists(form,'fld_submitUser')>
			<cfset variables.userFormSubmitComplete = false>
			<cfset errorMsg = arrayNew(1)>
			<cfif form.fld_first_name EQ ''>
				<cfset arrayAppend(errorMsg,'Please provide a first name')>
			</cfif>
			<cfif form.fld_last_name EQ ''>
				<cfset arrayAppend(errorMsg,'Please provide a last name')>
			</cfif>
			<cfif arrayIsEmpty(errorMsg)>
				<cfquery datasource="error_service" >
					UPDATE users
					SET first_name = "#form.fld_first_name#", last_name = "#form.fld_last_name#"
					WHERE id = #session.loggedUser.userID#;
				</cfquery>
				<cfset variables.userFormSubmitComplete = true>
			</cfif>
		</cfif>
		<cfif structKeyExists(variables,'userFormSubmitComplete') AND variables.userFormSubmitComplete>
			<cfset session.loggedUser.firstName = #form.fld_first_name#>
			<cfset session.loggedUser.lastName = #form.fld_last_name#>
			<cflocation url="/error_service/user_profile.cfm" >	
		</cfif>
		<cfform id="user-form" name="userForm">

			<div>
				<label for="fld_first_name">First name:&nbsp</label>
				<cfinput name="fld_first_name" value="#session.loggedUser.firstName#" message="Please provide your first name" required>
			</div>
			<div>
				<label for="fld_last_name">Last name:&nbsp</label>
				<cfinput name="fld_last_name" value="#session.loggedUser.lastName#" message="Please provide your last name" required>
			</div>
			<div>
		        <cfinput type="submit" name="fld_submitUser" id="fld_submitUser" />
		    </div>
		</cfform>
	</div>
	<cfquery datasource="error_service" name="error_list">
		SELECT error_id, date_created, desc_short, status, urgency, criticality
		FROM errors
		WHERE user_id = #session.loggedUser.userID#
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
     	<h4>You registred next errors in the system :</h4>
		<cfinclude template="includes/error_table_main.cfm" >
     </cfif>
     <script >
     	this.errorService.initListeners(document.getElementById('edit-button'), this.userForm);
     </script>
<cfelse>
	<cflocation url="/error_service/index.cfm?noaccess" >
</cfif>