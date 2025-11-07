param (
    [Parameter(Mandatory=$true)]
    [string]$MacListPath,

    [string]$BroadcastAddress = "255.255.255.255",
    [int]$Port = 9
)

function Send-WakeOnLan {
    param (
        [string]$MacAddress,
        [string]$BroadcastAddress,
        [int]$Port
    )

    $macBytes = ($MacAddress -split '[:-]') | ForEach-Object { [byte]("0x$_") }
    $packet = [byte[]](,0xFF * 6 + ($macBytes * 16))

    $udpClient = New-Object System.Net.Sockets.UdpClient
    $udpClient.Connect($BroadcastAddress, $Port)
    $udpClient.Send($packet, $packet.Length)
    $udpClient.Close()

    Write-Host "Magic packet sent to $MacAddress"
}

# Read MAC addresses from file
if (Test-Path $MacListPath) {
    $macAddresses = Get-Content $MacListPath | Where-Object { $_ -match '([0-9A-Fa-f]{2}[:-]){5}[0-9A-Fa-f]{2}' }

    foreach ($mac in $macAddresses) {
        Send-WakeOnLan -MacAddress $mac.Trim() -BroadcastAddress $BroadcastAddress -Port $Port
    }
} else {
    Write-Host "MAC list file not found: $MacListPath"
}
