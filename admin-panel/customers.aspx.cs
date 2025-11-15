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
    public partial class customers1 : System.Web.UI.Page
    {
        string con_str = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        PagedDataSource pg;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            // check for admin
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
                ViewState["Id"] = 0;
                BindCustomers();
            }
        }

        void getcon()
        {
            if (con == null || con.State == ConnectionState.Closed)
            {
                con = new SqlConnection(con_str);
                con.Open();
            }
        }

        void BindCustomers()
        {
            string searchTerm = txtSearch.Text.Replace("'", "''");

            // this query gets all users who are not admins
            // and also counts how many orders each user has placed.
            string query = @"
    select 
        u.id, u.uname, u.email, u.role, u.created_at, u.is_active,
        (select count(o.order_id) from orders o where o.user_id = u.id) as ordercount
    from users u
    where u.role != 'admin'";

            if (!string.IsNullOrEmpty(searchTerm))
            {
                query += " and (u.uname like '%" + searchTerm + "%' or u.email like '%" + searchTerm + "%')";
            }

            query += " order by u.created_at desc";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            pg = new PagedDataSource();
            pg.DataSource = ds.Tables[0].DefaultView;
            pg.AllowPaging = true;
            pg.PageSize = 5;
            pg.CurrentPageIndex = Convert.ToInt32(ViewState["Id"]);

            lnkPrev.Enabled = !pg.IsFirstPage;
            lnkNext.Enabled = !pg.IsLastPage;

            var pages = new List<ListItem>();
            for (int i = 0; i < pg.PageCount; i++)
            {
                pages.Add(new ListItem((i + 1).ToString(), i.ToString(), i == pg.CurrentPageIndex));
            }
            rptPager.DataSource = pages;
            rptPager.DataBind();

            gvCustomers.DataSource = pg;
            gvCustomers.DataBind();
        }

        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["Id"]);
            if (currentPage > 0)
            {
                currentPage--;
                ViewState["Id"] = currentPage;
                BindCustomers();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["Id"]);
            currentPage++;
            ViewState["Id"] = currentPage;
            BindCustomers();
        }

        protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                ViewState["Id"] = Convert.ToInt32(e.CommandArgument);
                BindCustomers();
            }
        }

        protected void gvCustomers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string userId = e.CommandArgument.ToString();

            if (e.CommandName == "EditUser")
            {
                // load user data into modal
                da = new SqlDataAdapter("select uname, email, role from users where id = " + userId, con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow row = ds.Tables[0].Rows[0];
                    hdnEditUserId.Value = userId;
                    txtEditUserName.Text = row["uname"].ToString();
                    txtEditUserEmail.Text = row["email"].ToString();
                    ddlEditUserRole.SelectedValue = row["role"].ToString().ToLower();
                }

                // show modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowEditModal", "$('#editUserModal').modal('show');", true);
            }
            else if (e.CommandName == "DeleteUser")
            {
                try
                {
                    cmd = new SqlCommand("delete from users where id = " + userId, con);
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    // catch error if user has existing orders (FK_orders_users)
                    if (ex.Number == 547)
                    {
                        lblError.Text = "error: you cannot delete this user as they are associated with existing orders.";
                        lblError.Visible = true;
                    }
                    else
                    {
                        lblError.Text = "an unknown database error occurred.";
                        lblError.Visible = true;
                    }
                }
                BindCustomers();
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            string userId = hdnEditUserId.Value;
            string userName = txtEditUserName.Text.Replace("'", "''");
            string userEmail = txtEditUserEmail.Text.Replace("'", "''");
            string userRole = ddlEditUserRole.SelectedValue;
            string userStatus = ddlEditUserStatus.SelectedValue;

            string query = "update users set uname = '" + userName + "', email = '" + userEmail + "', role = '" + userRole + "', is_active = " + userStatus + " where id = " + userId;

            cmd = new SqlCommand(query, con);
            cmd.ExecuteNonQuery();

            // hide the modal
            ScriptManager.RegisterStartupScript(this, this.GetType(), "HideEditModal", "$('#editUserModal').modal('hide');", true);

            BindCustomers();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindCustomers();
        }
    }
}