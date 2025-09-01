using System;
using System.Configuration;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;

namespace JenStore
{
    public partial class user_dashboard1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
            }
            else
            {
                int userId = Convert.ToInt32(Session["UserID"]);

                using (SqlConnection con = new SqlConnection(connect))
                {
                    string query = "select id, uname, email, gender, created_at from users where id = @userId";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@userId", userId);

                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string username = reader["uname"].ToString();
                                string email = reader["email"].ToString();
                                string gender = reader["gender"].ToString();
                                DateTime creationDate = (DateTime)reader["created_at"];
                                string dateFormat = creationDate.ToString("dd MMMM yyyy");

                                userNameHeading.InnerText = username;
                                genderVal.InnerText = gender;
                                emailVal.InnerText = email;
                                memberSinceVal.InnerText = memberSinceVal.InnerText = dateFormat;
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