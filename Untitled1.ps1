function Show-Notification {
    [cmdletbinding()]
    Param (
        [string]
        $ToastTitle,
        [string]
        [parameter(ValueFromPipeline)]
        $ToastText,
        [string]
        $ToastHeader,
        [string]
        $AppName
    )

    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
    $Template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText04)

    $RawXml = [xml] $Template.GetXml()
    ($RawXml.toast.visual.binding.text|where {$_.id -eq "1"}).AppendChild($RawXml.CreateTextNode($ToastHeader)) > $null
    ($RawXml.toast.visual.binding.text|where {$_.id -eq "2"}).AppendChild($RawXml.CreateTextNode($ToastTitle)) > $null
    ($RawXml.toast.visual.binding.text|where {$_.id -eq "3"}).AppendChild($RawXml.CreateTextNode($ToastText)) > $null

    $SerializedXml = New-Object Windows.Data.Xml.Dom.XmlDocument
    $SerializedXml.LoadXml($RawXml.OuterXml)

    $Toast = [Windows.UI.Notifications.ToastNotification]::new($SerializedXml)
    $Toast.Tag = $AppName
    $Toast.Group = $AppName
    $Toast.ExpirationTime = [DateTimeOffset]::Now.AddMinutes(1)

    $Notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppName)
    $Notifier.Show($Toast);
}

Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Toast Notification Generator"
$form.Size = New-Object System.Drawing.Size(400, 250)
$form.StartPosition = "CenterScreen"

# Create the app name label
$lblAppName = New-Object System.Windows.Forms.Label
$lblAppName.Location = New-Object System.Drawing.Point(10, 20)
$lblAppName.Size = New-Object System.Drawing.Size(100, 20)
$lblAppName.Text = "App Name:"
$form.Controls.Add($lblAppName)

# Create the app name textbox
$txtAppName = New-Object System.Windows.Forms.TextBox
$txtAppName.Location = New-Object System.Drawing.Point(120, 20)
$txtAppName.Size = New-Object System.Drawing.Size(250, 20)
$form.Controls.Add($txtAppName)

# Create the header label
$lblHeader = New-Object System.Windows.Forms.Label
$lblHeader.Location = New-Object System.Drawing.Point(10, 50)
$lblHeader.Size = New-Object System.Drawing.Size(100, 20)
$lblHeader.Text = "Title:"
$form.Controls.Add($lblHeader)

# Create the header textbox
$txtHeader = New-Object System.Windows.Forms.TextBox
$txtHeader.Location = New-Object System.Drawing.Point(120, 50)
$txtHeader.Size = New-Object System.Drawing.Size(250, 20)
$form.Controls.Add($txtHeader)

# Create the title label
$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Location = New-Object System.Drawing.Point(10, 80)
$lblTitle.Size = New-Object System.Drawing.Size(100, 20)
$lblTitle.Text = "Line 1:"
$form.Controls.Add($lblTitle)

# Create the title textbox
$txtTitle = New-Object System.Windows.Forms.TextBox
$txtTitle.Location = New-Object System.Drawing.Point(120, 80)
$txtTitle.Size = New-Object System.Drawing.Size(250, 20)
$form.Controls.Add($txtTitle)

# Create the body label
$lblBody = New-Object System.Windows.Forms.Label
$lblBody.Location = New-Object System.Drawing.Point(10, 110)
$lblBody.Size = New-Object System.Drawing.Size(100, 20)
$lblBody.Text = "Line 2:"
$form.Controls.Add($lblBody)

# Create the body textbox
$txtBody = New-Object System.Windows.Forms.TextBox
$txtBody.Location = New-Object System.Drawing.Point(120, 110)
$txtBody.Size = New-Object System.Drawing.Size(250, 20)
$form.Controls.Add($txtBody)

# Create the generate button
$btnGenerate = New-Object System.Windows.Forms.Button
$btnGenerate.Location = New-Object System.Drawing.Point(10, 140)
$btnGenerate.Size = New-Object System.Drawing.Size(360, 30)
$btnGenerate.Text = "Generate Toast Notification"
$btnGenerate.Add_Click({
    $appName = $txtAppName.Text
    $header = $txtHeader.Text
    $title = $txtTitle.Text
    $body = $txtBody.Text
    Show-Notification -ToastTitle $title -ToastText $body -ToastHeader $header -AppName $appName
})
$form.Controls.Add($btnGenerate)

# Display the form
$form.ShowDialog() | Out-Null
