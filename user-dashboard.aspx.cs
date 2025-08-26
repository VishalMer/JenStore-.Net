using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

// We need to bring in the namespace where UserProfile is defined
using JenStore;

namespace JenStore
{
    public partial class user_dashboard1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("login_register.aspx");
            }
            else
            {
                userNameHeading.InnerText = Session["Username"].ToString();
                usernameValue.InnerText = Session["Username"].ToString();
            }
        }
    }
}
