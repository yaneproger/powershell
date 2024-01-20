




vicenter


# Connect-VIserver 10.10.6.251 -User ehabibzade@infra.dc -Password A123456!


Get-VIPermission | Select-Object Principal,Role | Sort-Object -Property Principal | Export-csv -Path vcenter-perm.csv

------------------------------

AD userreport v1



$a=(Get-aduser -filter * -properties *).sAMAccountName   | Sort-Object -Property displayName

$e =
foreach($b in $a)
{
$c=(Get-aduser -identity $b -properties *).Whencreated
$d=((Get-aduser -identity $b -properties *).memberof|Get-Adgroup).Name -join ','
$f=(Get-aduser -identity $b -properties *).displayName


[PSCustomObject]@{
        DisplayName            =$f
        sAMAccountName         = $b
        "Creation date "        = $c
        "Group membership"       = $d
                  }
       
}

$e | Export-Csv -path C:\inactiveusers.csv -NoTypeInformation



# ---------------------------------------------

# Ad userreport v1.1


# last password change date added, sorted alphabetical

-------------------------------

# User's creation date, membership,display name, samname, last password change date


$a=(Get-aduser -filter * -properties *).sAMAccountName   

$e =
foreach($b in $a)
{
$c=(Get-aduser -identity $b -properties *).Whencreated
$d=((Get-aduser -identity $b -properties *).memberof|Get-Adgroup).Name -join ','
$f=(Get-aduser -identity $b -properties *).displayName
$pwdlast=(([datetime](Get-aduser -identity $b -properties *).pwdLastSet).AddYears(1600).ToLocalTime())


[PSCustomObject]@{
        DisplayName            =$f  
        sAMAccountName         = $b
        "Creation date "        = $c
          pwdlastset             = $pwdlast
         "Group membership"       = $d

                  }
       
}

$e | Sort-Object -Property sAMAccountName|Export-Csv -path C:\inactiveusers.csv -NoTypeInformation



----------------------------------------







