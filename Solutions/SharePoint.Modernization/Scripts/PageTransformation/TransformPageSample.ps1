
function Use-PnPModernizationFramework
{
    param(
        [string] $PathToModernizationBinaries
    )

    begin
    {
    }

    process
    {
        Add-Type -Path "$PathToModernizationBinaries\SharePointPnP.Modernization.Framework.dll"
    }

    end
    {
        return $PathToModernizationBinaries
    }
}

function Invoke-PnPModernizationPageTransformation
{
    param(
        [string] $PathToModernizationBinaries,
        [string] $WebPartMappingFile = $null,
        $Page,
        [bool] $Overwrite = $false,
        [bool] $UsePageAcceptBanner = $false,
        [bool] $HandleWikiImagesAndVideos = $true,
        [bool] $ReplaceHomePageWithDefaultHomePage = $false,
        [bool] $TargetPageTakesSourcePageName = $false
    )

    begin
    {

    }

    process
    {
        [bool] $transformOK = $true
        try 
        {            
            # Create the PageTransformationInformation object and populate it
            $pageTransformationInformation = New-Object -TypeName SharePointPnP.Modernization.Framework.Transform.PageTransformationInformation -ArgumentList $Page
            $pageTransformationInformation.Overwrite = $Overwrite
            $pageTransformationInformation.HandleWikiImagesAndVideos = $HandleWikiImagesAndVideos
            $pageTransformationInformation.ReplaceHomePageWithDefaultHomePage = $ReplaceHomePageWithDefaultHomePage
            $pageTransformationInformation.TargetPageTakesSourcePageName = $TargetPageTakesSourcePageName

            # setup pageacceptbanner

            if ($UsePageAcceptBanner)
            {
                $modernizationCenterInformation = New-Object -TypeName SharePointPnP.Modernization.Framework.Transform.ModernizationCenterInformation
                $modernizationCenterInformation.AddPageAcceptBanner = $true;
                $pageTransformationInformation.ModernizationCenterInformation = $modernizationCenterInformation;
            }

            # Instantiate the page transformator
            $pageTransformator = $null
            if ($WebPartMappingFile -ne "")
            {
                $pageTransformator = New-Object -TypeName SharePointPnP.Modernization.Framework.Transform.PageTransformator -ArgumentList $Page.Context, "$WebPartMappingFile"
            }
            else 
            {
                $pageTransformator = New-Object -TypeName SharePointPnP.Modernization.Framework.Transform.PageTransformator -ArgumentList $Page.Context, "$PathToModernizationBinaries\webpartmapping.xml"
            }

            # Transform
            $pageTransformator.Transform($pageTransformationInformation)  
        }
        catch [Exception]
        {
            Write-Host $_.Exception.Message -ForegroundColor Red
            $transformOK = $false
        }

    }

    end
    {
        return $transformOK
    }
    
}

#######################################################
# MAIN section                                        #
#######################################################
# variables
$CAMLQueryByExtension = "<View Scope='Recursive'><Query><Where><Contains><FieldRef Name='File_x0020_Type'/><Value Type='text'>aspx</Value></Contains></Where></Query></View>"
$CAMLQueryByExtensionAndName = "<View Scope='Recursive'><Query><Where><And><Contains><FieldRef Name='File_x0020_Type'/><Value Type='text'>aspx</Value></Contains><BeginsWith><FieldRef Name='FileLeafRef'/><Value Type='text'>{0}</Value></BeginsWith></And></Where></Query></View>"

# !!!!!!!!!!!!
# Update below variable to point to the location that holds SharePointPnP.Modernization.Framework.dll and all depending dll's plus the webpartmapping.xml file
$binaryFolder = "C:\github\BertPnPTools\Solutions\SharePoint.Modernization\SharePointPnP.Modernization.Framework\bin\Debug"

# Load the SharePoint Modernization framework
Use-PnPModernizationFramework -PathToModernizationBinaries $binaryFolder

# Connect to site
Connect-PnPOnline -Url https://bertonline.sharepoint.com/sites/modernizationtest -Verbose

# Get all pages
# [string] $query = $CAMLQueryByExtension

# Get specific aspx page(s)
[string] $query = [string]::Format($CAMLQueryByExtensionAndName, "wiki1.aspx")

# Load the pages
$pages = Get-PnPListItem -List SitePages -Query $query 

# Modernize the found pages
foreach($page in $pages)
{
    Write-Host "Modernizing " $page.FieldValues["FileLeafRef"] "..."    
    if (Invoke-PnPModernizationPageTransformation -Page $page -WebPartMappingFile "$binaryFolder\webpartmapping.xml" -Overwrite $true -UsePageAcceptBanner $false)
    {
        Write-Host "Done!" -ForegroundColor Green
    }
}
