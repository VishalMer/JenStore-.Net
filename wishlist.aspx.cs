using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    // Make sure the class name here matches the 'Inherits' attribute in your wishlist.aspx file
    public partial class wishlist1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindWishlistRepeater();
            }
        }

        private void BindWishlistRepeater()
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
                        W.wishlist_item_id, 
                        P.product_id, 
                        P.product_name, 
                        P.price, 
                        P.image_url,
                        P.stock_quantity
                    FROM Wishlist W
                    INNER JOIN Products P ON W.product_id = P.product_id
                    WHERE W.user_id = @user_id";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@user_id", userId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        rptWishlist.DataSource = dt;
                        rptWishlist.DataBind();
                    }
                }
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int wishlistItemId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Wishlist WHERE wishlist_item_id = @wishlist_item_id", con);
                cmd.Parameters.AddWithValue("@wishlist_item_id", wishlistItemId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindWishlistRepeater();
        }

        protected void btnRemoveAllFromWishlist_Click(object sender, EventArgs e)
        {
            //LinkButton btn = (LinkButton)sender;
            //int wishlistItemId = Convert.ToInt32(btn.CommandArgument);
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Wishlist WHERE user_id = @user_id", con);
                cmd.Parameters.AddWithValue("@user_id", userId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindWishlistRepeater();
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

            BindWishlistRepeater();
        }

        private void AddItemToCart(int userId, int productId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();

                    SqlCommand stockCmd = new SqlCommand("SELECT stock_quantity FROM Products WHERE product_id = @product_id", con);
                    stockCmd.Parameters.AddWithValue("@product_id", productId);
                    int availableStock = (int)stockCmd.ExecuteScalar();

                    if (availableStock <= 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sorry, this item is out of stock!');", true);
                        return;
                    }

                    SqlCommand checkCmd = new SqlCommand("SELECT 1 FROM Cart WHERE user_id = @user_id AND product_id = @product_id", con);
                    checkCmd.Parameters.AddWithValue("@user_id", userId);
                    checkCmd.Parameters.AddWithValue("@product_id", productId);
                    object result = checkCmd.ExecuteScalar();

                    if (result != null)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('This item is already in your cart.');", true);
                        return;
                    }
                    else
                    {
                        SqlCommand insertCmd = new SqlCommand("INSERT INTO Cart (user_id, product_id, quantity) VALUES (@user_id, @product_id, 1)", con);
                        insertCmd.Parameters.AddWithValue("@user_id", userId);
                        insertCmd.Parameters.AddWithValue("@product_id", productId);
                        insertCmd.ExecuteNonQuery();

                        SqlCommand deleteWishlistItemCmd = new SqlCommand("DELETE FROM Wishlist WHERE user_id = @user_id AND product_id = @product_id", con);
                        deleteWishlistItemCmd.Parameters.AddWithValue("@user_id", userId);
                        deleteWishlistItemCmd.Parameters.AddWithValue("@product_id", productId);
                        deleteWishlistItemCmd.ExecuteNonQuery();

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product moved to cart!');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('An error occurred: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }

        // --- SIMPLIFIED "ADD ALL TO CART" METHOD ---
        protected void btnAddAllToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }
            int userId = Convert.ToInt32(Session["UserID"]);
            var productIdsToMove = new List<int>();

            try
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();

                    // Step 1: Get a list of all products in the wishlist that are in stock and NOT already in the cart.
                    const string findEligibleItemsQuery = @"
                        SELECT P.product_id FROM Wishlist W
                        INNER JOIN Products P ON W.product_id = P.product_id
                        WHERE W.user_id = @user_id AND P.stock_quantity > 0
                        AND P.product_id NOT IN (SELECT product_id FROM Cart WHERE user_id = @user_id)";

                    SqlCommand getProductsCmd = new SqlCommand(findEligibleItemsQuery, con);
                    getProductsCmd.Parameters.AddWithValue("@user_id", userId);

                    using (var reader = getProductsCmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            productIdsToMove.Add(reader.GetInt32(0));
                        }
                    }

                    if (productIdsToMove.Count == 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('No eligible items to move to the cart.');", true);
                        return;
                    }

                    // Step 2: Loop through the eligible products and insert them into the cart.
                    foreach (int productId in productIdsToMove)
                    {
                        SqlCommand insertCmd = new SqlCommand("INSERT INTO Cart (user_id, product_id, quantity) VALUES (@user_id, @product_id, 1)", con);
                        insertCmd.Parameters.AddWithValue("@user_id", userId);
                        insertCmd.Parameters.AddWithValue("@product_id", productId);
                        insertCmd.ExecuteNonQuery();
                    }

                    // Step 3: Remove all the moved items from the wishlist in a single command.
                    string productIdsToRemove = string.Join(",", productIdsToMove);
                    SqlCommand deleteCmd = new SqlCommand($"DELETE FROM Wishlist WHERE user_id = @user_id AND product_id IN ({productIdsToRemove})", con);
                    deleteCmd.Parameters.AddWithValue("@user_id", userId);
                    deleteCmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('{productIdsToMove.Count} items were successfully moved to your cart.');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('An error occurred: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
            finally
            {
                // Refresh the wishlist to show that the items have been moved.
                BindWishlistRepeater();
            }
        }
    }
}

