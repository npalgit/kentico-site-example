using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.GlobalHelper;
using CMS.UIControls;
using CMS.OnlineMarketing;
using CMS.SettingsProvider;
using CMS.ExtendedControls;

[EditedObject(OnlineMarketingObjectType.CONTACT, "contactID")]

public partial class CMSModules_ContactManagement_Pages_Tools_Contact_Tab_ContactGroups : CMSContactManagementContactGroupsPage
{
    #region "Variables"

    private ContactInfo editedContact;
    private CurrentUserInfo currentUser;
    private int siteID;
    private Permissions permissions = new Permissions();

    #endregion


    #region "Structs"

    /// <summary>
    /// Container of current user permissions related to this page.
    /// </summary>
    private struct Permissions
    {
        public bool ReadGroups;
        public bool ReadGlobalGroup;
        public bool ReadContact;
        public bool ReadGlobalContact;
        public bool ModifyGroup;
        public bool ModifyGlobalGroup;
        public bool ModifyContact;
        public bool ModifyGlobalContact;
        public bool ModifyGroupMembership(int groupID)
        {
            ContactGroupInfo group = ContactGroupInfoProvider.GetContactGroupInfo(groupID);
            if (group == null)
            {
                return false;
            }
            if (group.IsGlobal && !this.ModifyGlobalGroup)
            {
                return false;
            }
            if (!group.IsGlobal && !this.ModifyGroup && !this.ModifyContact)
            {
                return false;
            }
            return true;
        }
    }

    #endregion


    #region "Page Load Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        editedContact = (ContactInfo)CMSPage.EditedObject;
        currentUser = CMSContext.CurrentUser;
        siteID = ContactHelper.ObjectSiteID(EditedObject);

        LoadPermissions();
        CheckReadPermissions();
        LoadGroupSelector();
        LoadContactGroups();
    }


    /// <summary>
    /// Loads permissions for current user.
    /// </summary>
    void LoadPermissions()
    {
        permissions.ReadGroups = currentUser.IsAuthorizedPerResource("CMS.ContactManagement", "ReadContactGroups");
        permissions.ReadGlobalGroup = ContactGroupHelper.AuthorizedReadContactGroup(UniSelector.US_GLOBAL_RECORD, false);
        permissions.ReadContact = ContactHelper.AuthorizedReadContact(siteID, false);
        permissions.ReadGlobalContact = ContactHelper.AuthorizedReadContact(UniSelector.US_GLOBAL_RECORD, false);
        permissions.ModifyGroup = currentUser.IsAuthorizedPerResource("CMS.ContactManagement", "ModifyContactGroups");
        permissions.ModifyGlobalGroup = ContactGroupHelper.AuthorizedReadContactGroup(UniSelector.US_GLOBAL_RECORD, false);
        permissions.ModifyContact = ContactHelper.AuthorizedModifyContact(siteID, false);
        permissions.ModifyGlobalContact = ContactHelper.AuthorizedModifyContact(UniSelector.US_GLOBAL_RECORD, false);
    }


    /// <summary>
    /// Checks read permissions for current user. 
    /// Redirects to access denied page.
    /// </summary>
    void CheckReadPermissions()
    {
        if (!permissions.ReadContact && !permissions.ReadGroups && !permissions.ReadGlobalGroup)
        {
            RedirectToAccessDenied("CMS.ContactManagement", "ReadContacts or ReadContactGroups");
        }
    }


    /// <summary>
    /// Checks modify permissions for current user. 
    /// Redirects to access denied page.
    /// </summary>
    void CheckModifyPermissions()
    {
        if ((editedContact.ContactSiteID > 0) && !permissions.ModifyContact && !permissions.ModifyGroup && !permissions.ModifyGlobalGroup)
        {
            RedirectToAccessDenied("CMS.ContactManagement", "ModifyContacts or ModifyContactGroups");
        }
        else if ((editedContact.ContactSiteID == 0) && !permissions.ModifyGlobalContact && !permissions.ModifyGlobalGroup)
        {
            RedirectToAccessDenied("CMS.ContactManagement", "ModifyGlobalContacts or ModifyGlobalContactGroups");
        }
    }


    /// <summary>
    /// Loads group selector.
    /// </summary>
    void LoadGroupSelector()
    {
        selectGroup.UniSelector.OnItemsSelected += new EventHandler(UniSelector_OnItemsSelected);
        selectGroup.UniSelector.ButtonImage = GetImageUrl("Objects/CMS_User/add.png");
        selectGroup.ImageDialog.CssClass = "NewItemImage";
        selectGroup.LinkDialog.CssClass = "NewItemLink";
        selectGroup.UniSelector.ResourcePrefix = "contactgroupcontact";
        selectGroup.IsLiveSite = false;

        // Set GroupSelector values depending on current site.
        if (editedContact.ContactSiteID == 0)
        {
            selectGroup.SiteID = UniSelector.US_GLOBAL_RECORD;
        }
        else
        {
            if (this.permissions.ReadGlobalGroup)
            {
                selectGroup.SiteID = UniSelector.US_GLOBAL_OR_SITE_RECORD;
            }
            else
            {
                selectGroup.SiteID = editedContact.ContactSiteID;
            }
        }
    }


    /// <summary>
    /// Loads contact groups.
    /// </summary>
    void LoadContactGroups()
    {
        cContactGroups.UniGrid.ZeroRowsText = GetString("om.contactgroup.notfound");

        // Set confirmation dialog
        CMS.UIControls.UniGridConfig.Action removeAction = (CMS.UIControls.UniGridConfig.Action)cContactGroups.UniGrid.GridActions.Actions[0];
        removeAction.Confirmation = "$om.contactgroupmember.confirmremove$";

        // Set contact group filters ..
        cContactGroups.FilterByContacts.Add(editedContact.ContactID);
        cContactGroups.FilterBySites.Add(editedContact.ContactSiteID);
        if (this.permissions.ReadGlobalGroup)
        {
            cContactGroups.FilterBySites.Add(null);
        }

        // .. and event handlers for its remove button
        cContactGroups.OnRemoveGroup += new EventHandler(cContactGroups_OnRemoveFromGroup);
        cContactGroups.OnDrawRemoveButton += new EventHandler(cContactGroups_OnDrawRemoveButton);
    }

    #endregion


    #region "Event Handlers Methods"

    void cContactGroups_OnDrawRemoveButton(object sender, EventArgs e)
    {
        if (sender is CMSImageButton)
        {
            if (editedContact.ContactSiteID > 0 && !permissions.ModifyContact && !permissions.ModifyGroup)
            {
                ((CMSImageButton)sender).ImageUrl = GetImageUrl("Design/Controls/UniGrid/Actions/DeleteDisabled.png");
                ((CMSImageButton)sender).Enabled = false;
            }
            if (editedContact.ContactSiteID == 0 && !permissions.ModifyGlobalContact && !permissions.ModifyGlobalGroup)
            {
                ((CMSImageButton)sender).ImageUrl = GetImageUrl("Design/Controls/UniGrid/Actions/DeleteDisabled.png");
                ((CMSImageButton)sender).Enabled = false;
            }
        }
    }


    /// <summary>
    /// Attempt to remove user from group event handler.
    /// </summary>
    void cContactGroups_OnRemoveFromGroup(object sender, EventArgs e)
    {
        CheckModifyPermissions();

        int contactGroupID = ValidationHelper.GetInteger(sender, 0);
        if (contactGroupID != 0)
        {
            if (permissions.ModifyGroupMembership(contactGroupID))
            {
                // Get the relationship object
                ContactGroupMemberInfo mi = ContactGroupMemberInfoProvider.GetContactGroupMemberInfoByData(contactGroupID, editedContact.ContactID, ContactGroupMemberTypeEnum.Contact);
                if (mi != null)
                {
                    ContactGroupMemberInfoProvider.DeleteContactGroupMemberInfo(mi);
                }
            }
        }
    }


    /// <summary>
    /// New groups selected event handler.
    /// </summary>
    void UniSelector_OnItemsSelected(object sender, EventArgs e)
    {
        CheckModifyPermissions();

        // Get new items from selector
        string newValues = ValidationHelper.GetString(selectGroup.Value, null);
        string[] newGroupIDs = newValues.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

        if (newGroupIDs != null)
        {
            ContactGroupMemberInfo cgmi;
            int groupID;

            // Get all selected groups
            foreach (string newGroupID in newGroupIDs)
            {
                // Check if relation already exists
                groupID = ValidationHelper.GetInteger(newGroupID, 0);

                if (permissions.ModifyGroupMembership(groupID))
                {
                    cgmi = ContactGroupMemberInfoProvider.GetContactGroupMemberInfoByData(groupID, editedContact.ContactID, ContactGroupMemberTypeEnum.Contact);
                    if (cgmi == null)
                    {
                        ContactGroupMemberInfoProvider.SetContactGroupMemberInfo(groupID, editedContact.ContactID, ContactGroupMemberTypeEnum.Contact, MemberAddedHowEnum.Manual);
                    }
                    else if (!cgmi.ContactGroupMemberFromManual)
                    {
                        cgmi.ContactGroupMemberFromManual = true;
                        ContactGroupMemberInfoProvider.SetContactGroupMemberInfo(cgmi);
                    }
                }
            }

            // Reload unigrid
            LoadContactGroups();
            cContactGroups.ReloadData();
            pnlUpdate.Update();
            selectGroup.Value = null;
        }
    }

    #endregion
}