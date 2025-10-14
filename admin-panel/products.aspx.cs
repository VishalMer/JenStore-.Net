using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore.admin_panel
{
    public partial class products1 : System.Web.UI.Page
    {
        string connect = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Open connection and leave it open as requested
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
            }

            if (!IsPostBack)
            {
                ViewState["PageIndex"] = 0;
                BindProducts();
            }
        }

        void getcon()
        {
                con = new SqlConnection(connect);
                con.Open();
            
        }

        private void BindProducts()
        {
            // Using non-parameterized query and SqlDataAdapter as requested
            string query = "select p.product_id, p.product_name, p.description, p.price, p.old_price, p.image_url, p.stock_quantity, stuff((select top 2 ', ' + c.category_name from categories c inner join product_categories pc on c.category_id = pc.category_id where pc.product_id = p.product_id order by c.category_name for xml path('')), 1, 2, '') as category_names from products p order by p.product_id desc";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            PagedDataSource pg = new PagedDataSource();
            pg.DataSource = ds.Tables[0].DefaultView;
            pg.AllowPaging = true;
            pg.PageSize = 5; // 5 rows per page as requested
            pg.CurrentPageIndex = (int)ViewState["PageIndex"];

            // Enable/disable previous and next buttons
            lnkPrev.Enabled = !pg.IsFirstPage;
            lnkNext.Enabled = !pg.IsLastPage;

            // Bind the page numbers to the repeater
            var pages = new List<ListItem>();
            for (int i = 0; i < pg.PageCount; i++)
            {
                pages.Add(new ListItem((i + 1).ToString(), i.ToString(), i == pg.CurrentPageIndex));
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();

            // Bind the paged data to the GridView
            gvProducts.DataSource = pg;
            gvProducts.DataBind();
        }

        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            int currentPage = (int)ViewState["PageIndex"];
            if (currentPage > 0)
            {
                ViewState["PageIndex"] = currentPage - 1;
                BindProducts();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int currentPage = (int)ViewState["PageIndex"];
            // We can add a check here, but PagedDataSource handles the last page
            ViewState["PageIndex"] = currentPage + 1;
            BindProducts();
        }

        protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                ViewState["PageIndex"] = Convert.ToInt32(e.CommandArgument);
                BindProducts();
            }
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string productId = e.CommandArgument.ToString();

            if (e.CommandName == "EditProduct")
            {
                Response.Redirect("add-edit-product.aspx?id=" + productId);
            }
            else if (e.CommandName == "DeleteProduct")
            {
                // Using non-parameterized query as requested
                SqlCommand cmd = new SqlCommand("delete from products where product_id = " + productId, con);
                cmd.ExecuteNonQuery();
                BindProducts(); // Refresh the grid
            }
        }

        // Helper method for status badge CSS
        public string GetStockStatusClass(object stockObj)
        {
            if (stockObj == DBNull.Value) return "stock-out-of-stock";

            int stock = Convert.ToInt32(stockObj);
            if (stock <= 0)
            {
                return "stock-out-of-stock";
            }
            if (stock <= 10) // Set your low-stock threshold here
            {
                return "stock-low";
            }
            return "stock-ok";
        }
    }
}