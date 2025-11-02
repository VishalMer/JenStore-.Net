using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore.admin_panel
{
    public partial class add_edit_product1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string img_name;
        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();

            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
                return;
            }

            if (Session["UserRole"].ToString().ToLower() != "admin")
            {
                Response.Redirect("../home.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillCategory();

                if (Request.QueryString["id"] != null)
                {
                    lblPageTitle.Text = "Edit Product";
                    lblPageSubtitle.Text = "Update the product information below";
                    hdnProductId.Value = Request.QueryString["id"];
                    fillProductData(hdnProductId.Value);
                }
                else
                {
                    lblPageTitle.Text = "Add Product";
                    lblPageSubtitle.Text = "Fill in the details below to create a new product";
                    hdnProductId.Value = "0";
                }
            }
        }
        void getcon()
        {
            con = new SqlConnection(con_str);
            con.Open();
        }

        void img_upload()
        {
            if (fileUploadImage.HasFile)
            {
                img_name = "img/product_img/" + fileUploadImage.FileName;

                fileUploadImage.SaveAs(Server.MapPath("~/" + img_name));
            }
            else
            {
                img_name = hdnExistingImage.Value;
            }
        }

        void clear()
        {
            txtProductName.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtOldPrice.Text = "";
            txtStock.Text = "";
            ddlBadge.SelectedIndex = 0;
            
        }
        void fillCategory()
        {
            da = new SqlDataAdapter("select category_id, category_name from categories order by category_name", con);
            ds = new DataSet();
            da.Fill(ds);
            cblCategories.DataSource = ds;
            cblCategories.DataTextField = "category_name";
            cblCategories.DataValueField = "category_id";
            cblCategories.DataBind();
        }

        void fillProductData(string productId)
        {
            da = new SqlDataAdapter("select * from products where product_id = " + productId, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                txtProductName.Text = row["product_name"].ToString();
                txtDescription.Text = row["description"].ToString();
                txtPrice.Text = row["price"].ToString();
                txtOldPrice.Text = row["old_price"].ToString();
                txtStock.Text = row["stock_quantity"].ToString();
                ddlBadge.SelectedValue = row["badge"].ToString();

                if (row["image_url"] != DBNull.Value)
                {
                    imgPreview.ImageUrl = "~/" + row["image_url"].ToString();
                    imgPreview.Visible = true;
                    hdnExistingImage.Value = row["image_url"].ToString();
                }

                da = new SqlDataAdapter("select category_id from product_categories where product_id = " + productId, con);
                DataSet dsCats = new DataSet();
                da.Fill(dsCats);

                foreach (DataRow catRow in dsCats.Tables[0].Rows)
                {
                    ListItem item = cblCategories.Items.FindByValue(catRow["category_id"].ToString());
                    if (item != null)
                    {
                        item.Selected = true;
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string productId = hdnProductId.Value;
            string prod_name = txtProductName.Text;
            string prod_desc = txtDescription.Text; 
            string price = txtPrice.Text;
            string old_price = string.IsNullOrEmpty(txtOldPrice.Text) ? "null" : txtOldPrice.Text;
            string stock = txtStock.Text;
            string badge = ddlBadge.SelectedValue;

            img_upload(); 

            if (productId == "0")
            {
                string query = "insert into products (product_name, description, price, old_price, stock_quantity, badge, image_url) values ('" + prod_name + "', '" + prod_desc + "', " + price + ", " + old_price + ", " + stock + ", '" + badge + "', '" + img_name + "'); select scope_identity();";
                cmd = new SqlCommand(query, con);
                productId = cmd.ExecuteScalar().ToString();
            }
            else
            {
                string query = "update products set product_name = '" + prod_name + "', description = '" + prod_desc + "', price = " + price + ", old_price = " + old_price + ", stock_quantity = " + stock + ", badge = '" + badge + "', image_url = '" + img_name + "' where product_id = " + productId;
                cmd = new SqlCommand(query, con);
                cmd.ExecuteNonQuery();
            }
            cmd = new SqlCommand("delete from product_categories where product_id = " + productId, con);
            cmd.ExecuteNonQuery();

            foreach (ListItem item in cblCategories.Items)
            {
                if (item.Selected)
                {
                    string insertCatQuery = "insert into product_categories (product_id, category_id) values (" + productId + ", " + item.Value + ")";
                    cmd = new SqlCommand(insertCatQuery, con);
                    cmd.ExecuteNonQuery();
                }
            }

            clear();
            Response.Redirect("products.aspx");
        }       
    }
}