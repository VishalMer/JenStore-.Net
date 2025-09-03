using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class shopping_cart1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCartRepeater();
            }
        }

        private void BindCartRepeater()
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(connect))
            {
                const string query = @"
                    SELECT 
                        C.cart_item_id, 
                        C.product_id, 
                        C.quantity, 
                        P.product_name, 
                        P.price, 
                        P.image_url 
                    FROM 
                        Cart C
                    INNER JOIN 
                        Products P ON C.product_id = P.product_id
                    WHERE 
                        C.user_id = @user_id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@user_id", userId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        rptCartProducts.DataSource = dt;
                        rptCartProducts.DataBind();
                    }
                }
            }
        }

        protected void btnRemoveFromCart_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartItemId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Cart WHERE cart_item_id = @cart_item_id", con);
                cmd.Parameters.AddWithValue("@cart_item_id", cartItemId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindCartRepeater();
        }


        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            using (SqlConnection con = new SqlConnection(connect))
            {
                con.Open();
                SqlCommand deleteCmd = new SqlCommand("delete from cart where user_id = @user_id ", con);
                deleteCmd.Parameters.AddWithValue("@user_id", userId);
                deleteCmd.ExecuteNonQuery();
            }
        }
    }
}