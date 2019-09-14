using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FirstWebSite
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HelloWorldLabel.Text = "Hello, World";

            UserInfoBoxControl userInfoBoxControl = 
                (UserInfoBoxControl)LoadControl("~/UserInfoBoxControl.ascx");
            userInfoBoxControl.UserName = "John Doe";
            userInfoBoxControl.UserAge = 78;
            userInfoBoxControl.UserCountry = "Spain";
            phUserInfoBox.Controls.Add(userInfoBoxControl);
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
    }
}

