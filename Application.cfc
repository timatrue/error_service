<cfcomponent output="false">
    <cfset this.name = 'error_service' />
    <cfset this.applicationTimeout = createtimespan(0,2,0,0) />
    <cfset this.sessionManagement = true />
    <cfset this.sessionTimeout = createTimespan(0,0,30,0) />
</cfcomponent>