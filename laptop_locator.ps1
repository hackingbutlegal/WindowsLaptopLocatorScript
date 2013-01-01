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

# The url variable can be set to whatever site you like
#
$url = "http://checkip.dyndns.org"

$col = new-object System.Collections.Specialized.NameValueCollection
$col.Add("a","stats")
$col.Add("s","s451qaz2WSX")

$wc = new-object system.net.WebClient
$wc.proxy = $proxy
$wc.QueryString = $col
$webpage = $wc.DownloadData($url)
$ipaddress1 = [System.Text.Encoding]::ASCII.GetString($webpage)

# You can uncomment this if you want to run this script from the command line for testing a modification to the URL
#
# echo "$ipaddress1"

# Modify the values here. You'll need to store credentials in plaintext, so don't use an important one, capiche?
#
Send-EMail1 -EmailTo "youremail@gmail.com" -EmailFrom "youremail@gmail.com" -Body "$ipaddress1" -Subject "IP Address" -password "plaintextpw"

