using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class contact1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();

            if (Session["userid"] == null)
            {
                Response.Redirect("login_register.aspx?ReturnUrl=" + Server.UrlEncode(Request.Url.AbsolutePath));
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadUserData();
                }
            }
        }

        void getcon()
        {
            if (con == null || con.State == ConnectionState.Closed)
            {
                con = new SqlConnection(con_str);
                con.Open();
            }
        }

        void LoadUserData()
        {
            string userId = Session["userid"].ToString();
            da = new SqlDataAdapter("select uname, email from users where id = " + userId, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtName.Text = ds.Tables[0].Rows[0]["uname"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["email"].ToString();
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            string userId = Session["userid"].ToString();
            string message = txtMessage.Text.Replace("'", "''"); 

            string query = "insert into feedback (user_id, message) values (" + userId + ", '" + message + "')";
            cmd = new SqlCommand(query, con);

            try
            {
                cmd.ExecuteNonQuery();
                lblMessage.Text = "your message has been sent successfully!";
                lblMessage.ForeColor = System.Drawing.Color.Green; 
                lblMessage.Visible = true;
                txtMessage.Text = "";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "an error occurred. please try again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
            }
        }
    }
}