<cfinclude template="includes/header.cfm" >
<cfif isUserLoggedIn()>
    <cfquery datasource="error_service" name="user_list">
        SELECT id, last_name, first_name, role, email
        FROM users
    </cfquery>
    <cfif user_list.RecordCount EQ 0>
        <p style="text-align:center;">No users registered</p>
    <cfelse>
        <h4>Users' list:</h4>
        <cfinclude template="includes/user_table_main.cfm" >
    </cfif>
</cfif>
