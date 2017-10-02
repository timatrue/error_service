<cfif structKeyExists(URL,'logout')>
	<cfset createObject("component",'error_service.components.authService').doLogout()>
</cfif>
<cfif structKeyExists(form, 'fld_submitLogin')>
	<cfset authService = createObject("component", 'error_service.components.authService')>
	<cfset errorMsg = authService.validateUser(form.fld_userEmail, form.fld_userPassword)>
	<cfif ArrayIsEmpty(errorMsg)>
		<cfset isUserLoggedIn = authService.doLogin(form.fld_userEmail, form.fld_userPassword)>
	</cfif>
</cfif>
<cfform id="frmConnexion" preservedata="true">
	<fieldset>
    <legend>Login</legend>
    <cfif structKeyExists(variables,'errorMsg') AND NOT arrayIsEmpty(errorMsg)>
    	<cfoutput >
    		<cfloop array="#errorMsg#" item="msg">
    			<p>#msg#</p>
    		</cfloop>
    	</cfoutput>
    </cfif>
    <cfif structKeyExists(variables,'isUserLoggedIn') AND isUserLoggedIn EQ false>
    	<p> Not found</p>
    </cfif>
    <cfif structKeyExists(session,'loggedUser')>
    	<p><cfoutput > Logged as  #session.loggedUser.userEmail# </cfoutput></p>
    	<p><a href="">your profile</a> <a href="/error_service/index.cfm?logout">Logout</a></p>
    	<cfif isUserInRole('admin')>
			<p><a href="">admin</a></p>
    	</cfif>
    <cfelse>
		<label for="fld_userEmail">E-mail address</label>
        <cfinput type="text" name="fld_userEmail" id="fld_userEmail" required="true" validate="email" validateAt="onSubmit" message="Please enter a valid e-mail Address" />
    	<label for="fld_userPassword">Password</label>
        <cfinput type="password" name="fld_userPassword" id="fld_userPassword" required="true" validateAt="onSubmit" message="Please provide a password" />
        <cfinput type="submit" name="fld_submitLogin" id="fld_submitLogin" value="Login" />
     </cfif>
    </fieldset>
</cfform>