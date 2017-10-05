<table>
    <tr>
        <th>Error ID</th>
        <th>Created</th>
        <th>Short Description</th>
        <th>Status</th>
        <th>Urgency</th>
        <th>Criticality</th>            
    </tr>
    <cfoutput query="error_history">
    <tr>
        <td >#error_id#</td>
        <td >#dateFormat(date_created, 'mmm dd yyyy')#</td>
        <td >#desc_short#</td>
        <td >#status#</td>
        <td >#urgency#</td>
        <td >#criticality#</td>
    </tr>
    </cfoutput>
</table>