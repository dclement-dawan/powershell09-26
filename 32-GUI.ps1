#Requires -PSEdition Desktop


# WinForm

[System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')


$f = New-Object System.Windows.Forms.Form
$f.Text = "Hello world!"
$f.Height = 350

$click_handler = {
    Write-Host "Hello world!"
}

$b = New-Object System.Windows.Forms.Button
$b.Text = 'OK'
$b.Add_Click($click_handler)
$f.Controls.Add($b)

$f.ShowDialog()


# WPF 
Add-Type -AssemblyName PresentationFramework

[xml]$xml = Get-Content .\gui.xaml
$FormXML = New-Object System.Xml.XmlNodeReader $xml
$form = [System.Windows.Markup.XamlReader]::load($FormXML)

$Form.FindName('button_Connect').Add_Click({
    $form.Close()
})

$form.ShowDialog()

$Form.FindName('TextBox_Email').Text














