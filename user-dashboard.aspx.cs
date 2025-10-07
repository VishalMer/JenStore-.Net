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
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            getcon();
            userDetails(userId);
            DisplayStats(userId);
        }

        void userDetails(int userId)
        {
            da = new SqlDataAdapter("select id, uname, email, gender, created_at from users where id = " + userId, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                userNameHeading.InnerText = row["uname"].ToString();
                genderVal.InnerText = row["gender"].ToString();
                emailVal.InnerText = row["email"].ToString();
                memberSinceVal.InnerText = ((DateTime)row["created_at"]).ToString("dd MMMM yyyy");
            }
            else
            {
                Response.Redirect("login_register.aspx");
            }
        }

        void DisplayStats(int userId)
        {
            SqlCommand totalOrders = new SqlCommand("select count(*) from Orders where user_id = " + userId, con);
            lblTotalOrders.Text = totalOrders.ExecuteScalar().ToString();

            SqlCommand wishlist = new SqlCommand("select count(*) from Wishlist where user_id = " + userId, con);
            lblWishlistItems.Text = wishlist.ExecuteScalar().ToString();

            SqlCommand totalSpent = new SqlCommand("select SUM(total_amount) from Orders where user_id = " + userId + " and order_status = 'Completed'", con);
            object totalSpentResult = totalSpent.ExecuteScalar();
            if (totalSpentResult != DBNull.Value && totalSpentResult != null)
            {
                lblTotalSpent.Text = "$"+(Convert.ToDecimal(totalSpentResult).ToString());
            }
            else
            {
                lblTotalSpent.Text = "$0.00";
            }

            SqlCommand pendingOrders = new SqlCommand("select count(*) from Orders where user_id = " + userId + " and order_status = 'Pending'", con);
            lblPendingOrders.Text = pendingOrders.ExecuteScalar().ToString();
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}