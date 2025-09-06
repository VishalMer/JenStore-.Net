using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class home1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProductRepeaters();
            }
        }

        private void BindProductRepeaters()
        {
            rptCollection.DataSource = GetRandomProducts(4);
            rptCollection.DataBind();

            rptWedding.DataSource = GetRandomProducts(4);
            rptWedding.DataBind();

            rptHoliday.DataSource = GetRandomProducts(4);
            rptHoliday.DataBind();
        }

        private DataTable GetRandomProducts(int count)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connect))
            {
                string query = "SELECT TOP (@count) * FROM Products ORDER BY NEWID()";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@count", count);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }
            return dt;
        }

        // --- NEW METHODS ADDED BELOW ---

        /// <summary>
        /// Handles the click for the 'Add to Cart' icon.
        /// </summary>
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

        /// <summary>
        /// Handles the click for the 'Add to Wishlist' icon (toggle functionality).
        /// </summary>
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
            ToggleWishlistItem(userId, productId);
        }

        /// <summary>
        /// Adds an item to the cart, checking for stock and existing quantity.
        /// </summary>
        private void AddItemToCart(int userId, int productId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();
                    // Check stock
                    SqlCommand stockCmd = new SqlCommand("SELECT stock_quantity FROM Products WHERE product_id = @product_id", con);
                    stockCmd.Parameters.AddWithValue("@product_id", productId);
                    if ((int)stockCmd.ExecuteScalar() <= 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sorry, this item is out of stock!');", true);
                        return;
                    }
                    // Check if already in cart
                    SqlCommand checkCmd = new SqlCommand("SELECT 1 FROM Cart WHERE user_id = @user_id AND product_id = @product_id", con);
                    checkCmd.Parameters.AddWithValue("@user_id", userId);
                    checkCmd.Parameters.AddWithValue("@product_id", productId);
                    if (checkCmd.ExecuteScalar() != null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('This item is already in your cart.');", true);
                    }
                    else
                    {
                        SqlCommand insertCmd = new SqlCommand("INSERT INTO Cart (user_id, product_id, quantity) VALUES (@user_id, @product_id, 1)", con);
                        insertCmd.Parameters.AddWithValue("@user_id", userId);
                        insertCmd.Parameters.AddWithValue("@product_id", productId);
                        insertCmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product added to cart!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }

        /// <summary>
        /// Adds or removes an item from the wishlist.
        /// </summary>
        private void ToggleWishlistItem(int userId, int productId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();
                    SqlCommand checkCmd = new SqlCommand("SELECT 1 FROM Wishlist WHERE user_id = @user_id AND product_id = @product_id", con);
                    checkCmd.Parameters.AddWithValue("@user_id", userId);
                    checkCmd.Parameters.AddWithValue("@product_id", productId);

                    if (checkCmd.ExecuteScalar() != null)
                    {
                        // Item exists, so remove it
                        SqlCommand deleteCmd = new SqlCommand("DELETE FROM Wishlist WHERE user_id = @user_id AND product_id = @product_id", con);
                        deleteCmd.Parameters.AddWithValue("@user_id", userId);
                        deleteCmd.Parameters.AddWithValue("@product_id", productId);
                        deleteCmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Removed from wishlist.');", true);
                    }
                    else
                    {
                        // Item does not exist, so add it
                        SqlCommand insertCmd = new SqlCommand("INSERT INTO Wishlist (user_id, product_id) VALUES (@user_id, @product_id)", con);
                        insertCmd.Parameters.AddWithValue("@user_id", userId);
                        insertCmd.Parameters.AddWithValue("@product_id", productId);
                        insertCmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Added to wishlist!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }
    }
}

