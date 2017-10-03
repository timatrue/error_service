<cfif structKeyExists(URL,'logout')>
	<cfset createObject("component",'error_service.components.auth_service').doLogout()>
</cfif>
<cfif structKeyExists(form, 'fld_submitLogin')>
	<cfset authService = createObject("component", 'error_service.components.auth_service')>
	<cfset errorMsg = authService.validateUser(form.fld_userEmail, form.fld_userPassword)>
	<cfif ArrayIsEmpty(errorMsg)>
		<cfset isUserLoggedIn = authService.doLogin(form.fld_userEmail, form.fld_userPassword)>
	</cfif>
</cfif>
<cfform class="login-form" preservedata="true">
	<fieldset class="login-form__fieldset">
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
    	<span><cfoutput > Logged as  #session.loggedUser.userEmail# </cfoutput></span>
    	<span><a href="user_profile.cfm">your profile</a> <a href="/error_service/index.cfm?logout">Logout</a></span>
    	<!---<cfif isUserInRole('admin')>
			<span><a href="">admin</a></span>
    	</cfif>--->
    <cfelse>
    <div class="login-form__container">
		<div>
			<label for="fld_userEmail">E-mail address:&nbsp</label>
	    	<cfinput type="text" name="fld_userEmail" id="fld_userEmail" required="true" validate="email" validateAt="onSubmit" message="Please enter a valid e-mail Address" />
	    </div>
		<div>
	    	<label for="fld_userPassword">Password:&nbsp</label>
	        <cfinput type="password" name="fld_userPassword" id="fld_userPassword" required="true" validateAt="onSubmit" message="Please provide a password" />
	    </div>
		<div>
	        <cfinput type="submit" name="fld_submitLogin" id="fld_submitLogin" value="Login" />
	    </div>
     </div>
     </cfif>
    </fieldset>
</cfform>