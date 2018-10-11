#
# Module manifest for module 'PSGet_PSSQT'
#
# Generated by: frode.sivertsen@outlook.com. Search Query Tool code developed by: https://github.com/SharePoint/PnP-Tools/tree/master/Solutions/SharePoint.Search.QueryTool 
#
# Generated on: 6/30/2016
#

@{

# Script module or binary module file associated with this manifest.
# RootModule = ''

# Version number of this module.
ModuleVersion = '2.8.2'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '05b0d289-e02e-4071-b77e-8fb62485894d'

# Author of this module
Author = 'frode.sivertsen@outlook.com. Search Query Tool code developed by: https://github.com/SharePoint/PnP-Tools/tree/master/Solutions/SharePoint.Search.QueryTool'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) 2017 frodes. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Search SharePoint index (on-prem or online) using PowerShell. Part of the Search Query Tool (https://github.com/SharePoint/PnP-Tools/tree/master/Solutions/SharePoint.Search.QueryTool).'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '4.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @('PSSQT.format.ps1xml')

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
NestedModules = @('PSSQT.dll')

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = @()

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @('Search-SPIndex', 'Search-SPSuggestions', 'Format-SPSuggestions', 'Format-SPResults', 'New-MultiGeoSearchConfiguration')

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()

        # A URL to the license for this module.
        # LicenseUri = ''

        # A URL to the main website for this project.
        # ProjectUri = ''

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = @'
		Updates in this release:
		
		* Changed the module version numbering to align better with the SearchQueryTool. 
		* Updated with latest ADAL authentication code. 
		* -AuthenticationMethod SPO has been removed. You should use -AuthenticationMethod SPOManagement instead.
		* -SPO switch has been removed. You should use -AuthenticationMethod SPOManagement instead.

		You can use Connect-Msolservice to login before executing a query. You must still use -AuthenticationMethod SPOManagement, 
		but you will not be prompted to login again.
		
		New features in this release:

		* New ResultProcessor AllProperties. 
		It will do a secondary search for each result retrieving all properties for that item. They are returned as a dictionary
		in the AllProperties property

		* New ResultProcessor AllPropertiesInline.
		Same as above, but will only retrieve all properties for the first result and return them "inline" in a custom object. Try it, and you will see the difference.
		You would typically use this with a query like 'workid:12345'

		* Specify -Properties :default: 
		It will return what SharePoint decides is the default set of properties from SharePoint. Keep in mind that if you don't specify -Properties, PSSQT defaults to title, path, workid.

		* Specify default properties by defining the environment variable PSSQT_DefaultSelectProperties
		E.g. PSSQT_DefaultSElectProperties = title, author
		This is what PSSQT will use if you don't specify -Properties.
		Please note that specifying -Properties :default: is different. In that case PSSQT will not specify which properties to retrieve and you get what SharePoint gives you.

		* Specify where to look for preset files by specifying the path in the environment variable PSSQT_PresetsPath. You can specify multiple directories separated by ;
		E.g. PSSQT_PresetsPath = C:\SearchQueryTool2.8\Presets
		You can do this from any folder: Search-SPIndex -Preset mypreset 
'@

        # External dependent modules of this module
        # ExternalModuleDependencies = ''

    } # End of PSData hashtable
    
 } # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

