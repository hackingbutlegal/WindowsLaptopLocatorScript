# Laptop IP locator script
# Jackie Singh, 1/1/2013
#

Function Send-EMail1 {
    Param (
        [Parameter(`
            Mandatory=$true)]
        [String]$EmailTo,
        [Parameter(`
            Mandatory=$true)]
        [String]$Subject,
        [Parameter(`
            Mandatory=$true)]
        [String]$Body,
        [Parameter(`
            Mandatory=$true)]
        [String]$EmailFrom="youremail@gmail.com",  # This could give a default value to the $EmailFrom command, but we're specifying below
        [Parameter(`
            mandatory=$false)]
        [String]$attachment,
        [Parameter(`
            mandatory=$false)]
        [String]$Password
    )
        $SMTPServer = "smtp.gmail.com" 
        $SMTPMessage = New-Object System.Net.Mail.MailMessage($EmailFrom,$EmailTo,$Subject,$Body)

# This is what you use for attachments. If so, call it like [-attachment "c:\path\to\file.name"] in the below invocation
#
#        if ($attachment -ne $null) {
#            $SMTPattachment = New-Object System.Net.Mail.Attachment($attachment)
#            $SMTPMessage.Attachments.Add($STMPattachment)
#        }

        $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587) 
        $SMTPClient.EnableSsl = $true 
        $SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom.Split("@")[0], $Password); 
        $SMTPClient.Send($SMTPMessage)
        Remove-Variable -Name SMTPClient
        Remove-Variable -Name Password
} 

# The url variable can be set to whatever site you like.
# You can also set a proxy by setting the 'proxy' variable
#
$ipInfoUrl = "http://bot.whatismyipaddress.com"
$col = new-object System.Collections.Specialized.NameValueCollection
$col.Add("a","stats")
$col.Add("s","s451qaz2WSX")
$wc = new-object system.net.WebClient
$wc.proxy = $proxy
$wc.QueryString = $col
$webpage = $wc.DownloadData($ipInfoUrl)
$ipAddress1 = [System.Text.Encoding]::ASCII.GetString($webpage)

# Let's get some location information.
# Make sure you get an API key here (http://ipinfodb.com/register.php) and set it without brackets below.
#
$ipGeoInfoUrl = "http://api.ipinfodb.com/v3/ip-city/?key=<yourAPIkey>&format=raw&ip=$ipAddress1"
$ipAddressGeoInfo = (new-object System.Net.WebClient).DownloadString($ipGeoInfoUrl)

# Let's get some reverse DNS on that IP.
#
$ipAddressrDNS = [System.Net.Dns]::GetHostByAddress($ipAddress1) | Add-Member -Name IP -Value $_ -MemberType NoteProperty -PassThru| Select HostName

# Modify the values here. You'll need to store credentials in plaintext, so don't use an important one, capiche?
# You may also wish to hide this script somewhere in the filesystem.
#
Send-EMail1 -EmailTo "youremail@gmail.com" -EmailFrom "youremail@gmail.com" -Body "WhatIsMyIPAddress.com thinks the IP is: $ipAddress1 `nThe presumed hostname (reverse DNS) is: $ipAddressrDNS `nIPInfoDB.com lists this location: $ipAddressGeoInfo" -Subject "Laptop Locator Script" -password "yourpasswordhere"

#