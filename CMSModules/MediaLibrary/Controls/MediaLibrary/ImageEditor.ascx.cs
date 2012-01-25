using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

using CMS.CMSHelper;
using CMS.DataEngine;
using CMS.GlobalHelper;
using CMS.SiteProvider;
using CMS.Synchronization;
using CMS.TreeEngine;
using CMS.UIControls;
using CMS.WorkflowEngine;
using CMS.MediaLibrary;
using CMS.IO;
using CMS.EventLog;
using CMS.SettingsProvider;

using IOExceptions = System.IO;
using TreeNode = CMS.TreeEngine.TreeNode;

/// <summary>
/// Image editor for media files.
/// </summary>
public partial class CMSModules_MediaLibrary_Controls_MediaLibrary_ImageEditor_Control : CMSUserControl
{
    #region "Variables"

    private Guid mediafileGuid = Guid.Empty;
    private MediaFileInfo mfi = null;
    private string mCurrentSiteName = null;
    private int siteId = 0;
    private bool isPreview = false;
    private byte[] previewFile = null;
    private bool mEnabled = true;

    #endregion


    #region "Properties"

    /// <summary>
    /// Gets the GUID of the instance of the ImageEditor.
    /// </summary>
    public Guid InstanceGUID
    {
        get
        {
            return baseImageEditor.InstanceGUID;
        }
    }


    /// <summary>
    /// Returns the site name from query string 'sitename' or 'siteid' if present, otherwise CMSContext.CurrentSiteName.
    /// </summary>
    private string CurrentSiteName
    {
        get
        {
            if (mCurrentSiteName == null)
            {
                mCurrentSiteName = QueryHelper.GetString("sitename", CMSContext.CurrentSiteName);

                siteId = QueryHelper.GetInteger("siteid", 0);

                SiteInfo site = SiteInfoProvider.GetSiteInfo(siteId);
                if (site != null)
                {
                    mCurrentSiteName = site.SiteName;
                }
            }
            return mCurrentSiteName;
        }
    }


    /// <summary>
    /// Preview file path.
    /// </summary>
    private string PreviewPath
    {
        get
        {
            return ViewState["PreviewPath"] as String;
        }
        set
        {
            ViewState["PreviewPath"] = value;
        }
    }


    /// <summary>
    /// Preview file path.
    /// </summary>
    private string OldPreviewExt
    {
        get
        {
            return ViewState["OldPreviewExt"] as String;
        }
        set
        {
            ViewState["OldPreviewExt"] = value;
        }
    }


    /// <summary>
    /// Indicates if saving failed.
    /// </summary>
    public bool SavingFailed
    {
        get
        {
            return this.baseImageEditor.SavingFailed;
        }
        set
        {
            this.baseImageEditor.SavingFailed = value;
        }
    }


    /// <summary>
    /// Indicates if control is enabled.
    /// </summary>
    public bool Enabled
    {
        get
        {
            return this.mEnabled;
        }
        set
        {
            this.mEnabled = value;
        }
    }

    #endregion


    #region "Events"

    /// <summary>
    /// Loads image type from querystring.
    /// </summary>
    void baseImageEditor_LoadImageType()
    {
        if (mediafileGuid != Guid.Empty)
        {
            // Load preview image if preview is edited
            if (isPreview)
            {
                baseImageEditor.IsPreview = true;
            }
            baseImageEditor.ImageType = ImageHelper.ImageTypeEnum.MediaFile;
        }
    }


    /// <summary>
    /// Initializes common properties used for processing image.
    /// </summary>
    void baseImageEditor_InitializeProperties()
    {
        // Process media file
        if (baseImageEditor.ImageType == ImageHelper.ImageTypeEnum.MediaFile)
        {

            // Get mediafile
            mfi = MediaFileInfoProvider.GetMediaFileInfo(mediafileGuid, this.CurrentSiteName);
            // If file is not null 
            if (mfi != null)
            {
                MediaLibraryInfo mli = MediaLibraryInfoProvider.GetMediaLibraryInfo(mfi.FileLibraryID);

                if ((mli != null) && (MediaLibraryInfoProvider.IsUserAuthorizedPerLibrary(mli, "filemodify")))
                {
                    // Load media file thumbnail
                    if (isPreview)
                    {
                        PreviewPath = MediaFileInfoProvider.GetPreviewFilePath(mfi);
                        if (PreviewPath != null)
                        {
                            OldPreviewExt = Path.GetExtension(PreviewPath);
                            try
                            {
                                // Get file contents from file system
                                previewFile = File.ReadAllBytes(PreviewPath);
                            }
                            catch (Exception ex)
                            {
                                EventLogProvider ev = new EventLogProvider();
                                ev.LogEvent("ImageEditor", "GetPreviewFile", ex);
                            }
                            if (previewFile != null)
                            {
                                baseImageEditor.ImgHelper = new ImageHelper(previewFile);
                            }
                            else
                            {
                                baseImageEditor.LoadingFailed = true;
                                baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
                            }
                        }
                        else
                        {
                            baseImageEditor.LoadingFailed = true;
                            baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
                        }
                    }
                    // Load media file
                    else
                    {
                        mfi.FileBinary = MediaFileInfoProvider.GetFile(mfi, mli.LibraryFolder, this.CurrentSiteName);
                        // Ensure metafile binary data
                        if (mfi.FileBinary != null)
                        {
                            baseImageEditor.ImgHelper = new ImageHelper(mfi.FileBinary);
                        }
                        else
                        {
                            baseImageEditor.LoadingFailed = true;
                            baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
                        }
                    }
                }
                else
                {
                    baseImageEditor.LoadingFailed = true;
                    baseImageEditor.LblLoadFailed.ResourceString = "img.errors.filemodify";
                }
            }
            else
            {
                baseImageEditor.LoadingFailed = true;
                baseImageEditor.LblLoadFailed.ResourceString = "img.errors.loading";
            }
        }

        // Check that image is in supported formats
        if ((!baseImageEditor.LoadingFailed) && (baseImageEditor.ImgHelper.ImageFormatToString() == null))
        {
            baseImageEditor.LoadingFailed = true;
            baseImageEditor.LblLoadFailed.ResourceString = "img.errors.format";
        }
    }


    /// <summary>
    /// Initialize labels according to current image type.
    /// </summary>
    void baseImageEditor_InitializeLabels(bool reloadName)
    {
        //Initialize strings depending on image type
        if (baseImageEditor.ImageType == ImageHelper.ImageTypeEnum.MediaFile)
        {
            // Initialize media file thumbnail
            if (isPreview && (previewFile != null) && !String.IsNullOrEmpty(PreviewPath))
            {
                baseImageEditor.TxtFileName.Text = Path.GetFileName(PreviewPath);
                baseImageEditor.LblExtensionValue.Text = Path.GetExtension(PreviewPath);
                baseImageEditor.LblImageSizeValue.Text = DataHelper.GetSizeString(previewFile.Length);
                baseImageEditor.LblWidthValue.Text = baseImageEditor.ImgHelper.ImageWidth.ToString();
                baseImageEditor.LblHeightValue.Text = baseImageEditor.ImgHelper.ImageHeight.ToString();
            }
            // Initialize regular media file
            else if ((mfi != null) && (mfi.FileBinary != null))
            {
                if (!RequestHelper.IsPostBack() || reloadName)
                {
                    baseImageEditor.TxtFileName.Text = mfi.FileName;
                }
                baseImageEditor.LblExtensionValue.Text = mfi.FileExtension;
                baseImageEditor.LblImageSizeValue.Text = DataHelper.GetSizeString(mfi.FileSize);
                baseImageEditor.LblWidthValue.Text = mfi.FileImageWidth.ToString();
                baseImageEditor.LblHeightValue.Text = mfi.FileImageHeight.ToString();
                baseImageEditor.SetTitleAndDescription(mfi.FileTitle, mfi.FileDescription);
                // Set media file info object
                baseImageEditor.SetMetaDataInfoObject(mfi);
            }
        }
    }


    /// <summary>
    /// Saves modified image data.
    /// </summary>
    /// <param name="name">Image name</param>
    /// <param name="extension">Image extension</param>
    /// <param name="mimetype">Image mimetype</param>
    /// <param name="title">Image title</param>
    /// <param name="description">Image description</param>
    /// <param name="binary">Image binary data</param>
    /// <param name="width">Image width</param>
    /// <param name="height">Image height</param>
    void baseImageEditor_SaveImage(string name, string extension, string mimetype, string title, string description, byte[] binary, int width, int height)
    {
        SaveImage(name, extension, mimetype, title, description, binary, width, height);
    }


    /// <summary>
    /// Returns image name, title and description according to image type.
    /// </summary>
    /// <returns>Image name, title and description</returns>
    void baseImageEditor_GetMetaData()
    {
        if (mfi == null)
        {
            mfi = MediaFileInfoProvider.GetMediaFileInfo(mediafileGuid, this.CurrentSiteName);
        }

        if (mfi != null)
        {
            string name = mfi.FileName;
            baseImageEditor.GetNameResult = name;
            baseImageEditor.GetTitleResult = mfi.FileTitle;
            baseImageEditor.GetDescriptionResult = mfi.FileDescription;
        }
    }


    void baseImageEditor_LoadImageUrl()
    {
        // Use appropriate parameter from URL
        string url = null;
        if (mediafileGuid != Guid.Empty)
        {
            url = "~/CMSPages/GetMediaFile.aspx?fileguid=" + mediafileGuid.ToString();
        }
        baseImageEditor.MediaUrl = URLHelper.UpdateParameterInUrl(url, "chset", Guid.NewGuid().ToString());
    }

    #endregion


    #region "Methods"

    protected void Page_Load(object sender, EventArgs e)
    {
        mediafileGuid = QueryHelper.GetGuid("mediafileguid", Guid.Empty);
        isPreview = QueryHelper.GetBoolean("isPreview", false);

        // Get media file information
        if (this.mfi == null)
        {
            mfi = MediaFileInfoProvider.GetMediaFileInfo(mediafileGuid, this.CurrentSiteName);
        }

        if (this.mfi != null)
        {
            // Get media library information
            MediaLibraryInfo mli = MediaLibraryInfoProvider.GetMediaLibraryInfo(mfi.FileLibraryID);

            if (mli != null)
            {
                // Get path to media file folder
                string path = Path.GetDirectoryName(DirectoryHelper.CombinePath(MediaLibraryInfoProvider.GetMediaLibraryFolderPath(mli.LibraryID), mfi.FilePath));

                // Enable control if permissions are sufficient to edit image
                this.Enabled = DirectoryHelper.CheckPermissions(path, false, true, true, true);

                if (!this.Enabled)
                {
                    // Set error message
                    this.baseImageEditor.LblLoadFailed.Visible = true;
                    this.baseImageEditor.LblLoadFailed.ResourceString = "img.errors.filesystempermissions";
                }
            }
        }

        // Enable or disable image editor
        this.baseImageEditor.Enabled = this.Enabled;

        baseImageEditor.LoadImageType += new CMSAdminControls_ImageEditor_BaseImageEditor.OnLoadImageType(baseImageEditor_LoadImageType);
        baseImageEditor.InitializeProperties += new CMSAdminControls_ImageEditor_BaseImageEditor.OnInitializeProperties(baseImageEditor_InitializeProperties);
        baseImageEditor.InitializeLabels += new CMSAdminControls_ImageEditor_BaseImageEditor.OnInitializeLabels(baseImageEditor_InitializeLabels);
        baseImageEditor.SaveImage += new CMSAdminControls_ImageEditor_BaseImageEditor.OnSaveImage(baseImageEditor_SaveImage);
        baseImageEditor.GetMetaData += new CMSAdminControls_ImageEditor_BaseImageEditor.OnGetMetaData(baseImageEditor_GetMetaData);
        baseImageEditor.LoadImageUrl += new CMSAdminControls_ImageEditor_BaseImageEditor.OnLoadImageUrl(baseImageEditor_LoadImageUrl);
    }


    /// <summary>
    /// Saves modified image data.
    /// </summary>
    /// <param name="name">Image name</param>
    /// <param name="extension">Image extension</param>
    /// <param name="mimetype">Image mimetype</param>
    /// <param name="title">Image title</param>
    /// <param name="description">Image description</param>
    /// <param name="binary">Image binary data</param>
    /// <param name="width">Image width</param>
    /// <param name="height">Image height</param>
    private void SaveImage(string name, string extension, string mimetype, string title, string description, byte[] binary, int width, int height)
    {
        // Process media file
        if (mfi == null)
        {
            mfi = MediaFileInfoProvider.GetMediaFileInfo(mediafileGuid, this.CurrentSiteName);
        }

        if (mfi != null)
        {
            MediaLibraryInfo mli = MediaLibraryInfoProvider.GetMediaLibraryInfo(mfi.FileLibraryID);
            if (mli != null)
            {
                string path = Path.GetDirectoryName(DirectoryHelper.CombinePath(MediaLibraryInfoProvider.GetMediaLibraryFolderPath(mli.LibraryID), mfi.FilePath));
                bool permissionsOK = DirectoryHelper.CheckPermissions(path, false, true, true, true);

                if (permissionsOK)
                {
                    MediaFileInfo originalMfi = mfi.Clone(true);

                    try
                    {
                        // Ensure object version
                        SynchronizationHelper.EnsureObjectVersion(mfi);

                        if (isPreview && !String.IsNullOrEmpty(PreviewPath))
                        {
                            SiteInfo si = SiteInfoProvider.GetSiteInfo(mfi.FileSiteID);
                            if (si != null)
                            {
                                string previewExt = (!String.IsNullOrEmpty(extension) && (extension != OldPreviewExt)) ? extension : OldPreviewExt;
                                string previewName = Path.GetFileNameWithoutExtension(PreviewPath);
                                string previewFolder = MediaLibraryHelper.EnsurePath(DirectoryHelper.CombinePath(Path.GetDirectoryName(mfi.FilePath).TrimEnd('/'), MediaLibraryHelper.GetMediaFileHiddenFolder(si.SiteName)));

                                // Delete old preview files with thumbnails
                                MediaFileInfoProvider.DeleteMediaFilePreview(CMSContext.CurrentSiteName, mli.LibraryID, mfi.FilePath, false);
                                MediaFileInfoProvider.DeleteMediaFilePreviewThumbnails(mfi);

                                // Save preview file
                                MediaFileInfoProvider.SaveFileToDisk(si.SiteName, mli.LibraryFolder, previewFolder, previewName, previewExt, mfi.FileGUID, binary, false, false);

                                // Log synchronization task
                                SynchronizationHelper.LogObjectChange(mfi, TaskTypeEnum.UpdateObject);
                            }
                        }
                        else
                        {
                            string newExt = null;
                            string newName = null;

                            if (!String.IsNullOrEmpty(extension))
                            {
                                newExt = extension;
                            }
                            if (!String.IsNullOrEmpty(mimetype))
                            {
                                mfi.FileMimeType = mimetype;
                            }

                            mfi.FileTitle = title;
                            mfi.FileDescription = description;

                            if (width > 0)
                            {
                                mfi.FileImageWidth = width;
                            }
                            if (height > 0)
                            {
                                mfi.FileImageHeight = height;
                            }
                            if (binary != null)
                            {
                                mfi.FileBinary = binary;
                                mfi.FileSize = binary.Length;
                            }
                            // Test all parameters to empty values and update new value if available
                            if (!String.IsNullOrEmpty(name))
                            {
                                newName = name;
                            }
                            // If filename changed move preview file and remove all ald thumbnails
                            if ((!String.IsNullOrEmpty(newName) && (mfi.FileName != newName)) || (!String.IsNullOrEmpty(newExt) && (mfi.FileExtension.ToLower() != newExt.ToLower())))
                            {
                                SiteInfo si = SiteInfoProvider.GetSiteInfo(mfi.FileSiteID);
                                if (si != null)
                                {
                                    string fileName = (newName != null ? newName : mfi.FileName);
                                    string fileExt = (newExt != null ? newExt : mfi.FileExtension);

                                    string newPath = MediaFileInfoProvider.GetMediaFilePath(mfi.FileLibraryID, DirectoryHelper.CombinePath(Path.GetDirectoryName(mfi.FilePath), fileName) + fileExt);
                                    string filePath = MediaFileInfoProvider.GetMediaFilePath(mfi.FileLibraryID, mfi.FilePath);

                                    // Rename file only if file with same name does not exsists
                                    if (!File.Exists(newPath))
                                    {
                                        // Ensure max length of file path
                                        if (newPath.Length < 260)
                                        {
                                            // Remove old thumbnails
                                            MediaFileInfoProvider.DeleteMediaFileThumbnails(mfi);
                                            MediaFileInfoProvider.DeleteMediaFilePreviewThumbnails(mfi);

                                            // Move media file
                                            MediaFileInfoProvider.MoveMediaFile(si.SiteName, mli.LibraryID, mfi.FilePath, DirectoryHelper.CombinePath(Path.GetDirectoryName(mfi.FilePath), fileName) + fileExt, false);

                                            // Set new file name or extension
                                            mfi.FileName = fileName;
                                            mfi.FileExtension = fileExt;

                                            // Ensure new binary
                                            if (binary != null)
                                            {
                                                mfi.FileBinary = binary;
                                                mfi.FileSize = binary.Length;
                                            }
                                        }
                                        else
                                        {
                                            throw new IOExceptions.PathTooLongException();
                                        }
                                    }
                                    else
                                    {
                                        baseImageEditor.LblLoadFailed.Visible = true;
                                        baseImageEditor.LblLoadFailed.ResourceString = "img.errors.fileexists";
                                        SavingFailed = true;
                                        return;
                                    }
                                }
                            }
                            else
                            {
                                // Remove old thumbnails
                                MediaFileInfoProvider.DeleteMediaFileThumbnails(mfi);

                                // Remove original media file before save
                                string filePath = MediaFileInfoProvider.GetMediaFilePath(mfi.FileLibraryID, mfi.FilePath);
                                if (File.Exists(filePath))
                                {
                                    File.Delete(filePath);
                                }
                            }

                            // Save new data
                            MediaFileInfoProvider.SetMediaFileInfo(mfi, false);
                        }
                    }
                    catch (Exception e)
                    {
                        // Log exception
                        EventLogProvider ev = new EventLogProvider();
                        ev.LogEvent("ImageEditor", "Save file", e);

                        baseImageEditor.LblLoadFailed.Visible = true;
                        baseImageEditor.LblLoadFailed.ResourceString = "img.errors.processing";
                        ScriptHelper.AppendTooltip(baseImageEditor.LblLoadFailed, e.Message, "help");
                        this.SavingFailed = true;
                        // Save original media file info
                        MediaFileInfoProvider.SetMediaFileInfo(originalMfi, false);
                    }
                }
            }
        }
    }

    #endregion


    #region "Undo redo functionality"

    /// <summary>
    /// Returns true if the files are stored only in DB or user has disk read/write permissions. Otherwise false.
    /// </summary>
    public bool IsUndoRedoPossible()
    {
        return baseImageEditor.IsUndoRedoPossible();
    }


    /// <summary>
    /// Returns true if there is a previous version of the file which is being modified.
    /// </summary>
    public bool IsUndoEnabled()
    {
        return baseImageEditor.IsUndoEnabled();
    }


    /// <summary>
    /// Returns true if there is a next version of the file which is being modified.
    /// </summary>
    public bool IsRedoEnabled()
    {
        return baseImageEditor.IsRedoEnabled();
    }


    /// <summary>
    /// Processes the undo action.
    /// </summary>
    public void ProcessUndo()
    {
        baseImageEditor.ProcessUndo();
    }


    /// <summary>
    /// Processes the redo action.
    /// </summary>
    public void ProcessRedo()
    {
        baseImageEditor.ProcessRedo();
    }


    /// <summary>
    /// Saves current version of image and discards all other versions.
    /// </summary>
    public void SaveCurrentVersion()
    {
        baseImageEditor.SaveCurrentVersion();
    }

    #endregion
}
