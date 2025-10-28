using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JenStore.admin_panel
{
    public partial class feedback1 : System.Web.UI.Page
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
            if (Session["UserID"] == null)
            {
                Response.Redirect("../login_register.aspx");
                return;
            }

            if (Session["UserRole"].ToString().ToLower() != "admin")
            {
                Response.Redirect("../home.aspx");
            }

            if (!IsPostBack)
            {
                ViewState["Id"] = 0;
                LoadStats();
                fillGVProducts();
            }
        }

        void getcon()
        {
            con = new SqlConnection(con_str);
            con.Open();
        }

        void LoadStats()
        {
            // Total Feedback
            cmd = new SqlCommand("select count(*) from feedback", con);
            lblTotalFeedback.Text = cmd.ExecuteScalar().ToString();

            // New 
            cmd = new SqlCommand("select count(f.feedback_id) from feedback f left join feedback_management fm on f.feedback_id = fm.feedback_id where fm.feedback_id is null", con);
            lblNewFeedback.Text = cmd.ExecuteScalar().ToString();

            // Replied 
            cmd = new SqlCommand("select count(*) from feedback_management where status = 'replied'", con);
            lblRepliedFeedback.Text = cmd.ExecuteScalar().ToString();

            // Read 
            cmd = new SqlCommand("select count(*) from feedback_management where status = 'read' or status = 'replied'", con);
            lblReadFeedback.Text = cmd.ExecuteScalar().ToString();
        }

        void fillGVProducts()
        {
            string query = "select f.feedback_id, f.message, f.feedback_date, u.uname, u.email, coalesce(fm.status, 'new') as status from feedback f inner join " +
                "users u on f.user_id = u.id left join feedback_management fm on f.feedback_id = fm.feedback_id order by f.feedback_date desc";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            pg = new PagedDataSource();
            pg.DataSource = ds.Tables[0].DefaultView;
            pg.AllowPaging = true;
            pg.PageSize = 4; 
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

            dlFeedback.DataSource = pg;
            dlFeedback.DataBind();
        }

        protected void dlFeedback_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string feedbackId = e.CommandArgument.ToString();
            string adminId = Session["admin_id"]?.ToString() ?? "null";

            if (e.CommandName == "MarkRead")
            {
                // Update status to 'read' or insert if not exists 
                string updateQuery = @"
                    if exists (select 1 from feedback_management where feedback_id = " + feedbackId + @")
                        update feedback_management set status = 'read', last_updated = getdate() where feedback_id = " + feedbackId + @"
                    else
                        insert into feedback_management (feedback_id, admin_id, status) values (" + feedbackId + ", " + adminId + ", 'read')";

                cmd = new SqlCommand(updateQuery, con);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "DeleteFeedback")
            {
                cmd = new SqlCommand("delete from feedback_management where feedback_id = " + feedbackId, con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("delete from feedback where feedback_id = " + feedbackId, con);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "MarkResolved")
            {
                // Update status to 'resolved' or insert if not exists
                string updateQuery = @"
            if exists (select 1 from feedback_management where feedback_id = " + feedbackId + @")
                update feedback_management set status = 'resolved', last_updated = getdate() where feedback_id = " + feedbackId + @"
            else
                insert into feedback_management (feedback_id, admin_id, status) values (" + feedbackId + ", " + adminId + ", 'resolved')";

                cmd = new SqlCommand(updateQuery, con);
                cmd.ExecuteNonQuery();
            }

            LoadStats();
            fillGVProducts();
        }


        protected void btnSendReply_Click(object sender, EventArgs e)
        {
            string feedbackId = hdnReplyFeedbackId.Value;
            string replyMessage = txtReplyMessage.Text.Replace("'", "''"); 
            string adminId = Session["UserID"]?.ToString() ?? "null";

            if (string.IsNullOrEmpty(feedbackId) || string.IsNullOrEmpty(replyMessage))
            {
               // Something Went Wrong!
                return;
            }

            // Update or insert into feedback_management table
            string updateQuery = @"
                if exists (select 1 from feedback_management where feedback_id = " + feedbackId + @")
                    update feedback_management set status = 'replied', reply_message = '" + replyMessage + @"', admin_id = " + adminId + @", last_updated = getdate() where feedback_id = " + feedbackId + @"
                else
                    insert into feedback_management (feedback_id, admin_id, status, reply_message) values (" + feedbackId + ", " + adminId + ", 'replied', '" + replyMessage + @"')";

            cmd = new SqlCommand(updateQuery, con);
            cmd.ExecuteNonQuery();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseReplyModal", "$('#replyModal').modal('hide');", true);

            LoadStats();
            fillGVProducts();
        }

        protected void lnkPrev_Click(object sender, EventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["Id"]);
            if (currentPage > 0)
            {
                currentPage--;
                ViewState["Id"] = currentPage;
                fillGVProducts();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int currentPage = Convert.ToInt32(ViewState["Id"]);
            currentPage++;
            ViewState["Id"] = currentPage;
            fillGVProducts();
        }

        protected void rptPager_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                ViewState["Id"] = Convert.ToInt32(e.CommandArgument);
                fillGVProducts();
            }
        }

        public string GetStatusClass(object status)
        {
            string statusClass = "feedback-status ";
            switch (status.ToString().ToLower())
            {
                case "new": statusClass += "status-new"; break;
                case "read": statusClass += "status-read"; break;
                case "replied": statusClass += "status-replied"; break;
                case "resolved": statusClass += "status-resolved"; break; 
                default: statusClass += "status-new"; break;
            }
            return statusClass;
        }
    }
}