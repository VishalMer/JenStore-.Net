using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore
{
    public partial class shopping1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();

            if (!IsPostBack)
            {
                rptProductShow();
            }
        }

        void rptProductShow()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string query = "select p.product_id, p.product_name, p.description, p.price, p.old_price, p.stock_quantity, p.image_url," +
                           " p.badge, p.rating_count, case when w.user_id is not null then 1 else 0 end as isinwishlist " +
                           "from Products p left join Wishlist w on p.product_id = w.product_id and w.user_id = " + userId;

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            rptProducts.DataSource = ds;
            rptProducts.DataBind();
        }

        protected void productCommand(object source, RepeaterCommandEventArgs e)
        {
            //view product
            int productId = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "ViewProduct")
            {
                Response.Redirect("product-details.aspx?id=" + productId);
            }

            //check for user id
            if (Session["UserID"] == null)
            {
                Response.Redirect("login_register.aspx");
                return;
            }
            else
            {
                //add to cart
                if (e.CommandName == "AddToCart")
                {
                   int userId = Convert.ToInt32(Session["UserID"]);

                    cmd = new SqlCommand("select stock_quantity from Products where product_id = " + productId, con);
                    if ((int)cmd.ExecuteScalar() <= 0)
                    {
                        Response.Write("<script>alert('Sorry, this product is out of stock!');</script>");
                        return;
                    }

                    cmd = new SqlCommand("select 1 from Cart where user_id = " + userId + " and product_id = " + productId, con);
                    if (cmd.ExecuteScalar() != null)
                    {
                        Response.Write("<script>alert('Product is already in your cart.');</script>");
                    }
                    else
                    {
                        int quantity = 1;
                        cmd = new SqlCommand("insert into Cart (user_id, product_id, quantity) values (" + userId + ", " + productId + ", " + quantity + ")", con);
                        cmd.ExecuteNonQuery();
                        Response.Write("<script>alert('Product added to cart!');</script>");
                    }
                }
                // wishlist
                else if (e.CommandName == "AddToWishlist")
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    cmd = new SqlCommand("select 1 from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                    if (cmd.ExecuteScalar() != null)
                    {
                        cmd = new SqlCommand("delete from Wishlist where user_id = " + userId + " and product_id = " + productId, con);
                        cmd.ExecuteNonQuery();
                        Response.Write("<script>alert('Product removed from wishlist!');</script>");
                    }
                    else
                    {
                        cmd = new SqlCommand("insert into Wishlist (user_id, product_id) values (" + userId + ", " + productId + ")", con);
                        cmd.ExecuteNonQuery();
                        Response.Write("<script>alert('Product added to wishlist!');</script>");
                    }
                    rptProductShow();
                }
            }
        }

        void getcon()
        {
            con = new SqlConnection(connect);
            con.Open();
        }
    }
}