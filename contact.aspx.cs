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

           
                if (!IsPostBack)
                {
                    fillUserData();
                }
            
        }

        void getcon()
        {
            con = new SqlConnection(con_str);
            con.Open();
        }

        void fillUserData()
        {
            if (Session["userid"] != null)
            {
                loginWarning.Visible = false;
                string userId = Session["userid"].ToString();
                da = new SqlDataAdapter("select uname, email from users where id = " + userId, con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtName.Text = ds.Tables[0].Rows[0][0].ToString();
                    txtEmail.Text = ds.Tables[0].Rows[0][1].ToString();
                }
            }
            else
            {
                loginWarning.Visible = true;
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
                lblSuc.Text = "your message has been sent successfully!";
                lblSuc.Visible = true;
                txtMessage.Text = "";
            }
            catch (Exception ex)
            {
                lblError.Text = "an error occurred. please try again.";
                lblError.Visible = true;
            }
        }
    }
}