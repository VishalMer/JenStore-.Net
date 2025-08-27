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
            rdGen.SelectedValue = null;

            inputemail.Text = "";
            inputpass.Text = "";

            emailErr.Text = "";
            passErr.Text = "";
            userError.Text = "";
            emailError.Text = "";
            passError.Text = "";
            genError.Text = "";
        }

        //Register button
        protected void submit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(inputusernameres.Text))
            {
                userError.Text = "Username is required!";
                emailError.Text = "";
                passError.Text = "";
                genError.Text = "";
            }
            else if (string.IsNullOrWhiteSpace(inputemailres.Text))
            {
                userError.Text = "";
                emailError.Text = "Email is required!";
                passError.Text = "";
                genError.Text = "";
            }
            else if (string.IsNullOrEmpty(inputpassres.Text))
            {
                userError.Text = "";
                emailError.Text = "";
                passError.Text = "Password is required!";
                genError.Text = "";
            }
            else if (string.IsNullOrEmpty(rdGen.Text))
            {
                userError.Text = "";
                emailError.Text = "";
                passError.Text = "";
                genError.Text = "Gender is required!";
            }
            else
            {
                getcon();
                SqlCommand checkUser = new SqlCommand("SELECT COUNT(*) FROM users WHERE uname = '" + inputusernameres.Text + "' ", con);
                int uCount = (int)checkUser.ExecuteScalar();

                SqlCommand checkEm = new SqlCommand("SELECT COUNT(*) FROM users WHERE email = '" + inputemailres.Text + "'", con);
                int eCount = (int)checkEm.ExecuteScalar();

                if (uCount > 0)
                {
                    userError.Text = "Username already exists!";
                    emailError.Text = "";
                    passError.Text = "";
                    genError.Text = "";
                }
                else if (eCount > 0)
                {
                    emailError.Text = "Email already exists!";
                    userError.Text = "";
                    passError.Text = "";
                    genError.Text = "";
                }
                else
                {
                    cmd = new SqlCommand("insert into users (uname,email,password,gender) values ('" + inputusernameres.Text + "','" + inputemailres.Text + "','" + inputpassres.Text + "','" + rdGen.SelectedValue + "')", con);

                    cmd.ExecuteNonQuery();
                    con.Close();

                    Session["identifier"] = inputusernameres.Text;
                    Response.Redirect("user-dashboard.aspx");
                    clear();
                }
            }
        }

        //login button
        protected void loginBTN_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(inputemail.Text))
            {
                emailErr.Text = "Username/Email is required!";
                passErr.Text = "";

            }
            else if (string.IsNullOrEmpty(inputpass.Text))
            {
                passErr.Text = "password is required!! ";
                emailErr.Text = "";
            }
            else
            {
                getcon();

                SqlCommand checkUserLog = new SqlCommand("SELECT COUNT(*) FROM users WHERE (email = '" + inputemail.Text + "' OR uname = '" + inputemail.Text + "') AND password = '" + inputpass.Text + "'", con);

                int usercount = (int)checkUserLog.ExecuteScalar();
                con.Close();

                if (usercount > 0)
                {
                    Session["identifier"] = inputemail.Text;
                    clear();
                    Response.Redirect("home.aspx");
                }
                else
                {

                    passErr.Text = "Invalid credentials.";
                    emailErr.Text = "";
                }
                
                
            }
        }
    }
}