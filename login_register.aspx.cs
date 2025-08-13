using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace JenStore
{
    public partial class login_register : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
        }
        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }

        void clear()
        {
            inputusernameres.Text = "";
            inputemailres.Text = "";
            inputpassres.Text = "";
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            getcon();
            SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM users WHERE uname = '" + inputusernameres.Text + "' OR email = '" + inputemailres.Text + "'", con);
            int count = (int)checkCmd.ExecuteScalar();

            if (count > 0)
            {
                Response.Write("Username or email already exists!");
            }
            else
            {
                cmd = new SqlCommand("insert into users (uname,email,password,gender) values ('" + inputusernameres.Text + "','" + inputemailres.Text + "','" + inputpassres.Text + "','" + rdGen.SelectedValue + "')", con);

                cmd.ExecuteNonQuery();
                clear();
                con.Close();
            }
        }

        protected void loginBTN_Click(object sender, EventArgs e)
        {
            getcon(); 

            SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM users WHERE (email = '" + inputemail.Text + "' OR uname = '" + inputemail.Text + "') AND password = '" + inputpass.Text + "'", con);

            try
            {
                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    Response.Write("Login successful!");
                }
                else
                {

                    Response.Write("Invalid email/username or password.");
                }
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
            finally
            {
                con.Close();
            }
        }
    }
}