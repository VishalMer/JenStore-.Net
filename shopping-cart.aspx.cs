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

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartItemId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Cart SET quantity = quantity + 1 WHERE cart_item_id = @cart_item_id", con);
                cmd.Parameters.AddWithValue("@cart_item_id", cartItemId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindCartRepeater(); // Refresh the cart
        }

        /// <summary>
        /// Decreases the quantity of a cart item, or removes it if the quantity is 1.
        /// </summary>
        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int cartItemId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(connect))
            {
                con.Open();
                SqlCommand checkCmd = new SqlCommand("SELECT quantity FROM Cart WHERE cart_item_id = @cart_item_id", con);
                checkCmd.Parameters.AddWithValue("@cart_item_id", cartItemId);
                int currentQuantity = (int)checkCmd.ExecuteScalar();

                if (currentQuantity > 1)
                {
                    SqlCommand updateCmd = new SqlCommand("UPDATE Cart SET quantity = quantity - 1 WHERE cart_item_id = @cart_item_id", con);
                    updateCmd.Parameters.AddWithValue("@cart_item_id", cartItemId);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    SqlCommand deleteCmd = new SqlCommand("DELETE FROM Cart WHERE cart_item_id = @cart_item_id", con);
                    deleteCmd.Parameters.AddWithValue("@cart_item_id", cartItemId);
                    deleteCmd.ExecuteNonQuery();
                }
            }
            BindCartRepeater(); // Refresh the cart
        }

        /// <summary>
        /// Removes an item from the cart, regardless of quantity.
        /// </summary>
        protected void btnRemove_Click(object sender, EventArgs e)
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
            BindCartRepeater(); // Refresh the cart
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
            BindCartRepeater();
        }
    }
}