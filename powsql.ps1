# Based on this code: https://learn.microsoft.com/en-us/azure/hdinsight/interactive-query/apache-hive-query-odbc-driver-powershell

# Connect to database
if ($args != 2) {
  Write-Output "Usage: powsql.ps1 <connection string, including username and password> <query>"
  Exit 1  
}
$connectionString = $args[0]
$query = $args[1]

$conn = New-Object System.Data.Odbc.OdbcConnection($connectionString)
$conn.open()

# Perform query
$cmd = New-object System.Data.Odbc.OdbcCommand($query,$conn)

$ds = New-Object system.Data.DataSet

(New-Object system.Data.odbc.odbcDataAdapter($cmd)).fill($ds) #| out-null
$conn.close()
$ds.Tables
