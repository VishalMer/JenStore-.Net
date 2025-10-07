using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;

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
                SqlCommand checkUser = new SqlCommand("select count(*) from users where uname = '" + inputusernameres.Text + "' ", con);
                int uCount = (int)checkUser.ExecuteScalar();

                SqlCommand checkEm = new SqlCommand("select count(*) from users where email = '" + inputemailres.Text + "'", con);
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
                    string query = "insert into users (uname,email,password,gender) values ('" + inputusernameres.Text + "','" + inputemailres.Text + "','" + inputpassres.Text + "','" + rdGen.SelectedValue + "'); SELECT SCOPE_IDENTITY();";
                    cmd = new SqlCommand(query, con);

                    object newUserId = cmd.ExecuteScalar();

                    Session["UserID"] = Convert.ToInt32(newUserId);

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
                SqlCommand checkUserLog = new SqlCommand("select id, role from users where (email = '" + inputemail.Text + "' or uname = '" + inputemail.Text + "') and password = '" + inputpass.Text + "'", con);

                SqlDataAdapter da = new SqlDataAdapter(checkUserLog);
                DataSet ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    int userId = Convert.ToInt32(ds.Tables[0].Rows[0]["id"]);
                    string userRole = ds.Tables[0].Rows[0][1].ToString().ToLower();
                    Session["UserID"] = userId;

                    clear();

                    if (userRole == "admin")
                    {
                        Response.Redirect("admin-panel/index.aspx");
                    }
                    else
                    {
                        Response.Redirect("home.aspx");
                    }
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