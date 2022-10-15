# As a user, if I am already logged in, I would like to be able to log out

### If this is my first time opening the app, and I am still authenticated, I should start on the home page
<table>
  <tbody>
   <tr>
      <td>
<b>Expect:</b>
<ul>
  <li>I should be on the home page</li>
  <li>I should not be on the login page.</li>
</ul>
<b>Events:</b>
<ul>
  <li>AuthenticationEvent_Initialize</li>
</ul>
<br>
<img src="./routes_should_be_protected_by_authentication__logged_in/0.png", width=400>
<br>
      </td>
      <td>
      <img src="../user_stories/goldens/routes_should_be_protected_by_authentication__logged_in/0.iphone11.png">
      </td>
   </tr>
  </tbody>
</table>

### If I attempt to log out, I should go to the login page
<table>
  <tbody>
   <tr>
      <td>
<b>Expect:</b>
<ul>
  <li>I should now be on the login page.</li>
  <li>I should not be on the home page</li>
</ul>
<b>Actions:</b>
<ul>
  <li>TAP: type "HomeC_LogoutButton"</li>
</ul>
<b>Events:</b>
<ul>
  <li>AuthenticationEvent_Logout</li>
</ul>
<br>
<img src="./routes_should_be_protected_by_authentication__logged_in/1.png", width=400>
<br>
<b>Analytics:</b>
<ul>
  <li>Track: Logout</li>
</ul>
      </td>
      <td>
      <img src="../user_stories/goldens/routes_should_be_protected_by_authentication__logged_in/1.iphone11.png">
      </td>
   </tr>
  </tbody>
</table>
