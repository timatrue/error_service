<cfinclude template="includes/header.cfm" >
<cfif isUserLoggedIn()>
    <cfif structKeyExists(form,'fld_submitAddUser')>
        <cfset errorMsg=arrayNew(1)>
        <cfif form.fld_first_name EQ ''>
            <cfset arrayAppend(errorMsg,'Please provide a first name')>
        </cfif>
        <cfif form.fld_last_name EQ ''>
            <cfset arrayAppend(errorMsg,'Please provide a last name')>
        </cfif>
        <cfif form.fld_email EQ '' OR NOT isValid("eMail", form.fld_email)>
            <cfset arrayAppend(errorMsg,'Please provide a email in the valid format')>
        </cfif>
        <cfif arrayIsEmpty(errorMsg)>
            <cfset form.fld_password = generateSecretKey("AES" )>
            <cfquery datasource="error_service" >
                INSERT INTO users
                (last_name, first_name, role, email, password)
                VALUES
                ('#form.fld_last_name#', '#form.fld_first_name#',
                '#form.fld_role#', '#form.fld_email#', '#form.fld_password#')
            </cfquery>
        </cfif>
    </cfif>
    <cfquery datasource="error_service" name="role_list">
        SELECT role
        FROM role_list
    </cfquery>
    <div id="user-container">
        <cfif isDefined('errorMsg') AND NOT arrayIsEmpty(errorMsg)>
            <cfoutput >
                <cfloop array="#errorMsg#" index="msg">
                    <p>#msg#</p>
                </cfloop>
            </cfoutput>
        </cfif>
        <h3>Add new user</h3>
        <cfform id="user-form" >
            <div>
                <label for="fld_first_name">First name:&nbsp</label>
                <cfinput name="fld_first_name" message="Please provide your first name" required>
            </div>
            <div>
                <label for="fld_last_name">Last name:&nbsp</label>
                <cfinput name="fld_last_name" message="Please provide your last name" required>
            </div>
            <div>
                <label for="fld_role">Role:&nbsp</label>
                <cfselect name="fld_role" query="role_list" display="role" required></cfselect>
            </div>
            <div>
                <label for="fld_email">Email:&nbsp</label>
                <cfinput name="fld_email" message="Please provide your email" validate="email" required></cfinput>
            </div>
            <div>
                <cfinput type="submit" name="fld_submitAddUser" id="fld_submitAddUser" />
            </div>
        </cfform>
    </div>
</cfif>
