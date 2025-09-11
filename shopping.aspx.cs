using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace JenStore
{
    public partial class shopping1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Init(object sender, EventArgs e)
        {

            rptProducts.EnableViewState = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ProductRepeater();
        }

        private void ProductRepeater()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(connect))
            {

                const string query = @"
                    SELECT
                        p.product_id, p.product_name, p.description, p.price, p.old_price,
                        p.stock_quantity, p.image_url, p.badge, p.rating_count,
                        CASE WHEN w.user_id IS NOT NULL THEN 1 ELSE 0 END AS IsInWishlist
                    FROM
                        Products p
                    LEFT JOIN
                        Wishlist w ON p.product_id = w.product_id AND w.user_id = @userId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@userId", userId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        rptProducts.DataSource = dt;
                        rptProducts.DataBind();
                    }
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            AddItemToCart(userId, productId);
        }

        protected void btnAddToWishlist_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            AddItemToWishlist(userId, productId);

            // Re-bind the data to show the updated heart icon
            ProductRepeater();
        }

        //cart query
        private void AddItemToCart(int userId, int productId)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                con.Open();
                SqlCommand stockCmd = new SqlCommand("select stock_quantity from Products where product_id = @product_id", con);
                stockCmd.Parameters.AddWithValue("@product_id", productId);
                if ((int)stockCmd.ExecuteScalar() <= 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sorry, this product is out of stock!');", true);
                    return;
                }
                SqlCommand checkCmd = new SqlCommand("select 1 from Cart where user_id = @user_id and product_id = @product_id", con);
                checkCmd.Parameters.AddWithValue("@user_id", userId);
                checkCmd.Parameters.AddWithValue("@product_id", productId);
                if (checkCmd.ExecuteScalar() != null)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product is already in your cart.');", true);
                }
                else
                {
                    SqlCommand insertCmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (@user_id, @product_id, 1)", con);
                    insertCmd.Parameters.AddWithValue("@user_id", userId);
                    insertCmd.Parameters.AddWithValue("@product_id", productId);
                    insertCmd.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product added to cart!');", true);
                }
            }
        }


        //wishlist query
        private void AddItemToWishlist(int userId, int productId)
        {
            using (SqlConnection con = new SqlConnection(connect))
            {
                con.Open();
                SqlCommand checkCmd = new SqlCommand("SELECT 1 FROM Wishlist WHERE user_id = @user_id AND product_id = @product_id", con);
                checkCmd.Parameters.AddWithValue("@user_id", userId);
                checkCmd.Parameters.AddWithValue("@product_id", productId);

                object result = checkCmd.ExecuteScalar();

                if (result != null)
                {
                    SqlCommand deleteCmd = new SqlCommand("delete from wishlist where user_id = @user_id and product_id = @product_id", con);
                    deleteCmd.Parameters.AddWithValue("@user_id", userId);
                    deleteCmd.Parameters.AddWithValue("@product_id", productId);
                    deleteCmd.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product removed from wishlist!');", true);
                }
                else
                {
                    SqlCommand insertCmd = new SqlCommand("insert into wishlist (user_id, product_id) values (@user_id, @product_id)", con);
                    insertCmd.Parameters.AddWithValue("@user_id", userId);
                    insertCmd.Parameters.AddWithValue("@product_id", productId);
                    insertCmd.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product added to wishlist!');", true);
                }
            }
        }
    }
}

