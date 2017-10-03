<cfinclude template="includes/header.cfm" >
<cfif isUserLoggedIn()>
    <div id="error-container">
    	<h3>Please, add new error:</h3>
		<cfform id="error-form">
			<div>
				<label for="fld_short_desc">Short descrption:&nbsp</label>
				<cfinput name="fld_short_desc" message="Please provide the error's brief" required>
			</div>
			<div>
				<label for="fld_full_desc">Full descrption:&nbsp</label>
				<cfinput name="fld_full_desc" message="Please provide the error's description" required>
			</div>
			<div>
				<label for="fld_status">Status:&nbsp</label>
				<cfselect name="fld_status" required>
					<option >New</option>
					<option >Opened</option>
					<option >Solved</option>
					<option >Closed</option>	
				</cfselect>
			</div>
			<div>
				<label for="fld_urgency">Urgency:&nbsp</label>
				<cfselect name="fld_urgency" required>
					<option >Very urgent</option>
					<option >Urgent</option>
					<option >Not urgent</option>
					<option >Easy pace</option>	
				</cfselect>
			</div>
			<div>
				<label for="fld_criticality">Criticality:&nbsp</label>
				<cfselect name="fld_criticality" required>
					<option >Emergency</option>
					<option >Crucial</option>
					<option >Not crucial</option>
					<option >Changes requested</option>	
				</cfselect>
			</div>
			<div>
	        	<cfinput type="submit" name="fld_submitError" id="fld_submitError" />
	    	</div>
		</cfform>
	</div>   
<cfelse>
	<cflocation url="/error_service/index.cfm?noaccess" >
</cfif>
