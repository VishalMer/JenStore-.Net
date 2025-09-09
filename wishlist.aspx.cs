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
    public partial class wishlist1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }

             userId = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                BindWishlistRepeater();
            }
        }

        private void BindWishlistRepeater()
        {

            using (SqlConnection con = new SqlConnection(connect))
            {
                const string query = @" select W.wishlist_item_id, P.product_id, P.product_name, P.price, P.image_url, P.stock_quantity from Wishlist W 
                                        inner join Products P ON W.product_id = P.product_id where W.user_id = @user_id";

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
                SqlCommand cmd = new SqlCommand("delete from Wishlist where wishlist_item_id = @wishlist_item_id", con);
                cmd.Parameters.AddWithValue("@wishlist_item_id", wishlistItemId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindWishlistRepeater();
        }

        protected void btnRemoveAllFromWishlist_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(connect))
            {
                SqlCommand cmd = new SqlCommand("delete from Wishlist where user_id = @user_id", con);
                cmd.Parameters.AddWithValue("@user_id", userId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindWishlistRepeater();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {

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

                    SqlCommand stockCmd = new SqlCommand("select stock_quantity from Products where product_id = @product_id", con);
                    stockCmd.Parameters.AddWithValue("@product_id", productId);
                    int availableStock = (int)stockCmd.ExecuteScalar();

                    if (availableStock <= 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Sorry, this item is out of stock!');", true);
                        return;
                    }

                    SqlCommand checkCmd = new SqlCommand("select 1 from Cart where user_id = @user_id and product_id = @product_id", con);
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
                        SqlCommand insertCmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (@user_id, @product_id, 1)", con);
                        insertCmd.Parameters.AddWithValue("@user_id", userId);
                        insertCmd.Parameters.AddWithValue("@product_id", productId);
                        insertCmd.ExecuteNonQuery();

                        SqlCommand deleteWishlistItemCmd = new SqlCommand("delete from Wishlist where user_id = @user_id and product_id = @product_id", con);
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

        protected void btnAddAllToCart_Click(object sender, EventArgs e)
        {
            var productIdsToMove = new List<int>();

            try
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();

                    const string findEligibleItemsQuery = @" select P.product_id from Wishlist W inner join Products P ON W.product_id = P.product_id
                                                             where W.user_id = @user_id AND P.stock_quantity > 0 and
                                                             and P.product_id not in (select product_id from Cart where user_id = @user_id)";

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

                    foreach (int productId in productIdsToMove)
                    {
                        SqlCommand insertCmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (@user_id, @product_id, 1)", con);
                        insertCmd.Parameters.AddWithValue("@user_id", userId);
                        insertCmd.Parameters.AddWithValue("@product_id", productId);
                        insertCmd.ExecuteNonQuery();
                    }

                    string productIdsToRemove = string.Join(",", productIdsToMove);
                    SqlCommand deleteCmd = new SqlCommand($"delete from Wishlist where user_id = @user_id AND product_id IN ({productIdsToRemove})", con);
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
                BindWishlistRepeater();
            }
        }
    }
}

