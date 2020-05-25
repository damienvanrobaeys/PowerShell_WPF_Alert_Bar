#========================================================================
#
# Author 	: systanddeploy (Damien VAN ROBAEYS)
# Date 		: 12/11/2018
# Website	: http://www.systanddeploy.com/
#
#========================================================================

[System.Reflection.Assembly]::LoadWithPartialName('presentationframework') | out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.dll') | out-null  
[System.Reflection.Assembly]::LoadFrom('System.Windows.Interactivity.dll') | out-null
[System.Reflection.Assembly]::LoadFrom('assembly\MahApps.Metro.IconPacks.dll') | out-null  
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Reflection.Assembly]::LoadFrom('assembly\AlertBarWpf.dll')       				| out-null


[System.Windows.Forms.Application]::EnableVisualStyles()

#########################################################################
#                        Load Main Panel                                #
#########################################################################

$Global:pathPanel= split-path -parent $MyInvocation.MyCommand.Definition

function LoadXaml ($filename){
    $XamlLoader=(New-Object System.Xml.XmlDocument)
    $XamlLoader.Load($filename)
    return $XamlLoader
}


$XamlMainWindow=LoadXaml($pathPanel+"\WPF_Alert.xaml")
$reader = (New-Object System.Xml.XmlNodeReader $XamlMainWindow)
$Form = [Windows.Markup.XamlReader]::Load($reader)

$Dialog_Info = $Form.FindName("Dialog_Info") 
$Dialog_Success = $Form.FindName("Dialog_Success") 
$Dialog_Warning = $Form.FindName("Dialog_Warning") 
$Dialog_Danger = $Form.FindName("Dialog_Danger") 
$msgbar = $Form.FindName("msgbar") 





$Dialog_Info.Add_Click({
	$msgbar.Clear();	
	$msgbar.IconVisibility=$true
	$msgbar.SetInformationAlert("I am an information alert. I will disappear after 3 seconds", 3);		
})

$Dialog_Success.Add_Click({
	$msgbar.Clear();
	$msgbar.SetSuccessAlert("I am a success alert. I will disappear after 3 seconds", 3); 
})

$Dialog_Warning.Add_Click({
	$msgbar.Clear();
	$msgbar.SetWarningAlert("I am a warning alert. I will disappear after 3 seconds", 3);
})


$Dialog_Danger.Add_Click({
	$msgbar.Clear();
	$msgbar.SetDangerAlert("I am a danger alert. I will disappear after 3 seconds", 3);
})







# $Dialog_Custo.Add_Click({
# $Create_Content = [Notifications.wpf.NotificationContent]::new()				
# $Create_Content.Title = "I am the title"			
# $Create_Content.Message = "I am the message"			

	
# $Manager = [Notifications.wpf.notificationManager]::new()	

# NotificationManager.Areas.Add(area);


# $myarea = [Notifications.Wpf.Controls.NotificationArea]::new()

# $Manager.Show($Create_Content, $myarea);


# notificationManager.Show(
                # new NotificationContent {Title = "Notification", Message = "Notification in window!"},
                # areaName: "WindowArea");
	
# })




	
$Form.ShowDialog() | Out-Null