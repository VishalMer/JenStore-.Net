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
            // Open the connection once when the page loads
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

            // Using SqlDataAdapter as requested
            da = new SqlDataAdapter("SELECT uname, email, gender FROM users WHERE Id = " + userId, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                txtUsername.Text = row["uname"].ToString();
                txtEmail.Text = row["email"].ToString();

                string gender = row["gender"].ToString();
                if (ddlGender.Items.FindByValue(gender) != null)
                {
                    ddlGender.SelectedValue = gender;
                }
            }
            // The connection is intentionally left open as per your instruction.
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string currentPassword = txtCurrentPassword.Text;

            // Using string concatenation for the query as requested
            cmd = new SqlCommand("SELECT 1 FROM users WHERE Id = " + userId + " AND password = '" + currentPassword + "'", con);
            object result = cmd.ExecuteScalar();

            if (result == null)
            {
                successMsg.Visible = false;
                errorMsg.Text = "Your current password is incorrect.";
                errorMsg.Visible = true;
                btnCancel.Text = "Cancel";
                return; // Stop processing
            }

            string newUsername = txtUsername.Text;
            string newEmail = txtEmail.Text;
            string newGender = ddlGender.SelectedValue;

            // Using string concatenation for the update query as requested
            cmd = new SqlCommand("UPDATE users SET uname = '" + newUsername + "', email = '" + newEmail + "', gender = '" + newGender + "' WHERE Id = " + userId, con);
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
            // The connection is intentionally left open as per your instruction.
        }

        void getcon()
        {
            if (con == null || con.State == ConnectionState.Closed)
            {
                con = new SqlConnection(connect);
                con.Open();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/user-dashboard.aspx");
        }
    }
}