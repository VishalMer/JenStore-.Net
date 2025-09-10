using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Linq;

namespace JenStore
{
    public partial class home1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Init(object sender, EventArgs e)
        {
            // Disable ViewState on all repeaters to ensure they refresh correctly after a postback.
            rptCollection.EnableViewState = false;
            rptWedding.EnableViewState = false;
            rptHoliday.EnableViewState = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // On the initial page visit, fetch new random products and cache them in the Session.
            if (!IsPostBack)
            {
                BindAndCacheNewProducts();
            }
            // On every load (initial and postback), build the repeater controls from the cached data.
            // This is necessary to rebuild the controls since their ViewState is disabled.
            BindRepeatersFromCache();
        }

        /// <summary>
        /// Fetches new random products from the database and stores them in Session state.
        /// This is only called on the initial page load.
        /// </summary>
        private void BindAndCacheNewProducts()
        {
            int userId = (Session["UserID"] != null) ? Convert.ToInt32(Session["UserID"]) : -1;
            Session["CollectionData"] = GetRandomProducts(4, userId);
            Session["WeddingData"] = GetRandomProducts(4, userId);
            Session["HolidayData"] = GetRandomProducts(4, userId);
        }

        /// <summary>
        /// Binds all repeaters using the data stored in the Session. This ensures the same
        /// products are displayed during postbacks.
        /// </summary>
        private void BindRepeatersFromCache()
        {
            if (Session["CollectionData"] != null)
            {
                rptCollection.DataSource = (DataTable)Session["CollectionData"];
                rptCollection.DataBind();
            }
            if (Session["WeddingData"] != null)
            {
                rptWedding.DataSource = (DataTable)Session["WeddingData"];
                rptWedding.DataBind();
            }
            if (Session["HolidayData"] != null)
            {
                rptHoliday.DataSource = (DataTable)Session["HolidayData"];
                rptHoliday.DataBind();
            }
        }

        /// <summary>
        /// Refreshes the product data in the Session cache to reflect updated wishlist statuses
        /// without changing which products are displayed.
        /// </summary>
        private void RefreshCachedProducts(int userId)
        {
            if (Session["CollectionData"] != null)
            {
                var ids = ((DataTable)Session["CollectionData"]).AsEnumerable().Select(r => r.Field<int>("product_id")).ToList();
                Session["CollectionData"] = GetProductsByIds(ids, userId);
            }
            if (Session["WeddingData"] != null)
            {
                var ids = ((DataTable)Session["WeddingData"]).AsEnumerable().Select(r => r.Field<int>("product_id")).ToList();
                Session["WeddingData"] = GetProductsByIds(ids, userId);
            }
            if (Session["HolidayData"] != null)
            {
                var ids = ((DataTable)Session["HolidayData"]).AsEnumerable().Select(r => r.Field<int>("product_id")).ToList();
                Session["HolidayData"] = GetProductsByIds(ids, userId);
            }
        }

        private DataTable GetRandomProducts(int count, int userId)
        {
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(connect))
            {
                const string query = @"
                    SELECT TOP (@count)
                        p.product_id, p.product_name, p.description, p.price, p.old_price,
                        p.stock_quantity, p.image_url, p.badge, p.rating_count,
                        CASE WHEN w.user_id IS NOT NULL THEN 1 ELSE 0 END AS IsInWishlist
                    FROM
                        Products p
                    LEFT JOIN
                        Wishlist w ON p.product_id = w.product_id AND w.user_id = @userId
                    ORDER BY NEWID()";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@count", count);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        sda.Fill(dt);
                    }
                }
            }
            return dt;
        }

        /// <summary>
        /// Fetches product details for a specific list of product IDs, preserving their order.
        /// </summary>
        private DataTable GetProductsByIds(List<int> productIds, int userId)
        {
            var dt = new DataTable();
            if (productIds == null || !productIds.Any()) return dt;

            string idList = string.Join(",", productIds);

            using (var con = new SqlConnection(connect))
            {
                string query = $@"
                    SELECT
                        p.product_id, p.product_name, p.description, p.price, p.old_price,
                        p.stock_quantity, p.image_url, p.badge, p.rating_count,
                        CASE WHEN w.user_id IS NOT NULL THEN 1 ELSE 0 END AS IsInWishlist
                    FROM Products p
                    LEFT JOIN Wishlist w ON p.product_id = w.product_id AND w.user_id = @userId
                    WHERE p.product_id IN ({idList})";

                using (var cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@userId", userId);
                    using (var sda = new SqlDataAdapter(cmd)) sda.Fill(dt);
                }
            }

            // Re-order the results to match the original display order.
            return dt.AsEnumerable()
                     .OrderBy(row => productIds.IndexOf(row.Field<int>("product_id")))
                     .CopyToDataTable();
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

            // First, update the item's status in the database.
            ToggleWishlistItem(userId, productId);

            // Next, refresh the data in the Session cache to get the updated wishlist status.
            RefreshCachedProducts(userId);

            // Finally, re-bind the repeaters from the cache to update the UI instantly.
            BindRepeatersFromCache();
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
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('This product is already in your cart.');", true);
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
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Error: " + ex.Message.Replace("'", "\\'") + "');", true);
            }
        }

        private void ToggleWishlistItem(int userId, int productId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connect))
                {
                    con.Open();
                    SqlCommand checkCmd = new SqlCommand("select 1 from Wishlist where user_id = @user_id and product_id = @product_id", con);
                    checkCmd.Parameters.AddWithValue("@user_id", userId);
                    checkCmd.Parameters.AddWithValue("@product_id", productId);

                    if (checkCmd.ExecuteScalar() != null)
                    {
                        SqlCommand deleteCmd = new SqlCommand("delete from Wishlist where user_id = @user_id and product_id = @product_id", con);
                        deleteCmd.Parameters.AddWithValue("@user_id", userId);
                        deleteCmd.Parameters.AddWithValue("@product_id", productId);
                        deleteCmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product removed from wishlist.');", true);
                    }
                    else
                    {
                        SqlCommand insertCmd = new SqlCommand("insert into Wishlist (user_id, product_id) values (@user_id, @product_id)", con);
                        insertCmd.Parameters.AddWithValue("@user_id", userId);
                        insertCmd.Parameters.AddWithValue("@product_id", productId);
                        insertCmd.ExecuteNonQuery();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Product added to wishlist!');", true);
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

