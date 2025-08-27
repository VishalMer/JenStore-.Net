using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["identifier"] == null)
            {
                Response.Redirect("login_register.aspx");
            }
            else
            {
                string identifier = Session["identifier"].ToString();

                using (SqlConnection con = new SqlConnection(connect))
                {
                    string query = "SELECT id, uname, email, gender, created_at FROM users WHERE uname = @identifier OR email = @identifier";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@identifier", identifier);


                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int userId = Convert.ToInt32(reader["id"]);
                                string username = reader["uname"].ToString();
                                string email = reader["email"].ToString();
                                string gender = reader["gender"].ToString();
                                DateTime creationDate = (DateTime)reader["created_at"];
                                string dateFormat = creationDate.ToString("dd MMMM yyyy");

                                userNameHeading.InnerText = username;
                                genderVal.InnerText = gender;
                                emailVal.InnerText = email;
                                memberSinceVal.InnerText = dateFormat;
                            }
                            else
                            {
                                Response.Redirect("login_register.aspx");
                            }
                        }
                    }
                }
            }
        }
    }



}
