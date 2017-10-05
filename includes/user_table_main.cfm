<table>
    <tr>
        <th>User id</th>
        <th>Last name</th>
        <th>First name</th>
        <th>Role</th>
        <th>Email</th>            
    </tr>
    <cfoutput query="user_list">
    <tr>
        <td >#id#</td>
        <td >#last_name#</td>
        <td >#first_name#</td>
        <td >#role#</td>
        <td >#email#</td>
    </tr>
    </cfoutput>
</table>