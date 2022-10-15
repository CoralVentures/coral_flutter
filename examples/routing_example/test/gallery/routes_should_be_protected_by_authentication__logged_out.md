# As a user, if I am not logged in, I would like to be able to login

### If this is my first time opening the app, I should start on the login page
<table>
  <tbody>
   <tr>
      <td>
<b>Expect:</b>
<ul>
  <li>I should be on the login page</li>
  <li>I should not be on the home page.</li>
</ul>
<b>Events:</b>
<ul>
  <li>AuthenticationEvent_Initialize</li>
</ul>
<br>
<img src="./routes_should_be_protected_by_authentication__logged_out/0.png", width=400>
<br>
      </td>
      <td>
      <img src="../user_stories/goldens/routes_should_be_protected_by_authentication__logged_out/0.iphone11.png">
      </td>
   </tr>
  </tbody>
</table>

### If I attempt to log in, and I am authenticated, I should go to the home page
<table>
  <tbody>
   <tr>
      <td>
<b>Expect:</b>
<ul>
  <li>I should now be on the home page.</li>
  <li>I should not be on the login page</li>
</ul>
<b>Actions:</b>
<ul>
  <li>TAP: type "LoginC_LoginSuccessButton"</li>
</ul>
<b>Events:</b>
<ul>
  <li>AuthenticationEvent_Login</li>
  <li>AuthenticationEvent_LoginSucceeded</li>
</ul>
<br>
<img src="./routes_should_be_protected_by_authentication__logged_out/1.png", width=400>
<br>
<b>Analytics:</b>
<ul>
  <li>Track: Login Attempted</li>
  <li>Track: Login Succeeded</li>
</ul>
      </td>
      <td>
      <img src="../user_stories/goldens/routes_should_be_protected_by_authentication__logged_out/1.iphone11.png">
      </td>
   </tr>
  </tbody>
</table>
