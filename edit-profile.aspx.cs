using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace JenStore
{
    public partial class edit_profile1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            da = new SqlDataAdapter("select uname, email, gender from users where Id = " + userId, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtUsername.Text = ds.Tables[0].Rows[0][0].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0][1].ToString();

                string gender = ds.Tables[0].Rows[0][2].ToString();
                if (ddlGender.Items.FindByValue(gender) != null)
                {
                    ddlGender.SelectedValue = gender;
                }
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string currentPassword = txtCurrentPassword.Text;

            cmd = new SqlCommand("select 1 from users where Id = " + userId + " and password = '" + currentPassword + "'", con);
            object result = cmd.ExecuteScalar();

            if (result == null)
            {
                successMsg.Visible = false;
                errorMsg.Text = "Your current password is incorrect.";
                errorMsg.Visible = true;
                btnCancel.Text = "Cancel";
                return;
            }

            string newUsername = txtUsername.Text;
            string newEmail = txtEmail.Text;
            string newGender = ddlGender.SelectedValue;

            cmd = new SqlCommand("update users set uname = '" + newUsername + "', email = '" + newEmail + "', gender = '" + newGender + "' where Id = " + userId, con);
            int rowsAffected = cmd.ExecuteNonQuery();

            if (rowsAffected > 0)
            {
                errorMsg.Visible = false;
                successMsg.Visible = true;
                Response.Write("<script>if(confirm('Profile updated successfully! Would you like to go to the dashboard?')) { window.location.href = 'user-dashboard.aspx'; }</script>");
            }
            else
            {
                successMsg.Visible = false;
                errorMsg.Visible = true;
                btnCancel.Text = "Cancel";
            }
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/user-dashboard.aspx");
        }
    }
}