using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Net.Mail;
using System.Net;

namespace FirstWebSite
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HelloWorldLabel.Text = "Hello, World";

            ArrayList datestamps;

            UserInfoBoxControl userInfoBoxControl = 
                (UserInfoBoxControl)LoadControl("~/UserInfoBoxControl.ascx");
            userInfoBoxControl.UserName = "John Doe";
            userInfoBoxControl.UserAge = 78;
            userInfoBoxControl.UserCountry = "Spain";
            phUserInfoBox.Controls.Add(userInfoBoxControl);

            if (Cache["datestamps"] == null)
            {
                datestamps = new ArrayList();
                datestamps.Add(DateTime.Now);
                datestamps.Add(DateTime.Now);
                datestamps.Add(DateTime.Now);

                Cache.Add("datestamps", datestamps, null,
                    System.Web.Caching.Cache.NoAbsoluteExpiration,
                    new TimeSpan(0, 0, 60),
                    System.Web.Caching.CacheItemPriority.Default, null);
            }
            else
                datestamps = (ArrayList)Cache["datestamps"];

            foreach (DateTime dt in datestamps)
                Response.Write(dt.ToString() + "<br />");

            
            if (Session["BackgroundColor"] != null && !this.IsPostBack)
            {
                ColorSelector.SelectedValue = Session["BackgroundColor"].ToString();
                div3.Style["background-color"] = ColorSelector.SelectedValue;
            }
            
            if (ViewState["NameOfUser"] != null)
            {
                NameLabel.Text = ViewState["NameOfUser"].ToString();
            }
            else
            {
                NameLabel.Text = "Not set yet...";
            }
        }

        protected void GreetButton_Click(object sender, EventArgs e)
        {
            HelloWorldLabel.Text = "Hello, " + TextInput.Text;
        }

        protected void GreetList_SelectedIndexChanged(object sender, EventArgs e)
        {
            HelloWorldLabel.Text = "Hello, " + GreetList.SelectedValue;
        }

        protected void MyEventUserControl_PageTitleUpdated(object sender, EventArgs e)
        {
            this.Title = this.MyEventUserControl.PageTitle;
        }

        protected void btnSubmitForm_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                btnSubmitForm.Text = "My form is valid!";
            }
        }

        protected void lenCustom_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (args.Value.Length == 8)
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected static string GetFreshDateTime(HttpContext context)
        {
            return DateTime.Now.ToString();
        }

        protected void ColorSelector_SelectedIndexChanged(object sender, EventArgs e)
        {
            div3.Style["background-color"] = ColorSelector.SelectedValue;
            Session["BackgroundColor"] = ColorSelector.SelectedValue;
        }

        protected void SubmitForm_Click(object sender, EventArgs e)
        {
            ViewState["NameOfUser"] = NameField.Text;
            NameLabel.Text = NameField.Text;
        }

        protected void MailButton_Click(object sender, EventArgs e)
        {
            try
            {
                var basicCredential =
                    //Lookup password. Do not commit.
                    new NetworkCredential("zack_austin@comcast.net", "");
                var mailMessage = new MailMessage();
                mailMessage.To.Add("zacksaustin@gmail.com");
                mailMessage.From = new MailAddress("zack_austin@comcast.net");
                mailMessage.Subject = "ASP.NET e-mail test";
                mailMessage.Body = "Hello world,\n\nThis is an ASP.NET test email!";

                var smtpClient = new SmtpClient("smtp.comcast.net");
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = basicCredential;
                smtpClient.Port = 587;
                smtpClient.Send(mailMessage);
                Response.Write("Email Sent.");
            }
            catch (Exception ex)
            {
                Response.Write("Could not send the email - error"
                    + ex.Message);
            }
        }
    }
}

