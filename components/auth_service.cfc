<cfcomponent output="false">
	<!---validateUser() method --->
	<cffunction name="validateUser" access="public" output="false" returntype="array">
		<cfargument name="userEmail" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		
		<cfset var aErrorMessages = ArrayNew(1) />
		<!---validate email --->
		<cfif NOT isValid('email', arguments.userEmail)>
			<cfset arrayAppend(aErrorMessages,'Please, provide a valid email')>
		</cfif>
		<!---validate password--->
		<cfif arguments.userPassword EQ ''>
			<cfset arrayAppend(aErrorMessages,'Please, provide a password')>
		</cfif>
		<cfreturn aErrorMessages>
	</cffunction>

	<!---doLogin() method --->
	<cffunction name="doLogin" access="public" output="false" returntype="boolean">
		<cfargument name="userEmail" type="string" required="true" />
		<cfargument name="userPassword" type="string" required="true" />
		
		<cfset var isUserLoggedIn = false>
		<cfquery datasource="error_service" name="loginUser" >
			SELECT * FROM users WHERE email = "#arguments.userEmail#" AND password = "#arguments.userPassword#";
		</cfquery>
		<cfif loginUser.recordCount EQ 1>
			<cflogin>
				<cfloginuser name="#loginUser.email#" password="#loginUser.password#" roles="#loginUser.role#" >
			</cflogin>
			<!---Save user's data into ssesion scope --->
			<cfset session.loggedUser = {
				'userEmail' = loginUser.email,
				'userID' = loginUser.id,
				'firstName' = loginUser.first_name,
				'lastName' = loginUser.last_name
				}>
			<cfset var isUserLoggedIn = true>
		</cfif>
		<cfreturn isUserLoggedIn>
	</cffunction>
	
	<!---doLogout() method --->
	<cffunction name="doLogout" access="public" output="false" returntype="void">
		<cfset structDelete(session,'loggedUser')>
		<cflogout >
	</cffunction>

</cfcomponent>