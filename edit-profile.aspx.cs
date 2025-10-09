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
                DataRow row = ds.Tables[0].Rows[0];
                txtUsername.Text = row["uname"].ToString();
                txtEmail.Text = row["email"].ToString();

                string gender = row["gender"].ToString();

                if (ddlGender.Items.FindByValue(gender) != null)
                {
                    ddlGender.SelectedValue = gender;
                }
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string currentPassword = txtCurrentPassword.Text.Replace("'", "''"); // Basic sanitation
            string newUsername = txtUsername.Text.Replace("'", "''");
            string newEmail = txtEmail.Text.Replace("'", "''");
            string newGender = ddlGender.SelectedValue;

            getcon(); 

            cmd = new SqlCommand("select password from users where Id = " + userId, con);
            string storedPassword = cmd.ExecuteScalar() as string;

            if (storedPassword != currentPassword)
            {
                pnlSuccessMessage.Visible = false;
                litErrorText.Text = "Your current password is incorrect.";
                pnlErrorMessage.Visible = true;
                return;
            }

            cmd = new SqlCommand("update users set uname = '" + newUsername + "', email = '" + newEmail + "', gender = '" + newGender + "' where Id = " + userId, con);
            int rowsAffected = cmd.ExecuteNonQuery();


            if (rowsAffected > 0)
            {
                pnlErrorMessage.Visible = false;
                pnlSuccessMessage.Visible = true;
            }
            else
            {
                pnlSuccessMessage.Visible = false;
                litErrorText.Text = "An error occurred and the profile could not be updated.";
                pnlErrorMessage.Visible = true;
            }
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}