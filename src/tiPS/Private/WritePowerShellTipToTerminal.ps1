function WritePowerShellTipToTerminal
{
	[CmdletBinding()]
	[OutputType([void])]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '')]
	Param
	(
		[Parameter(Mandatory = $true, HelpMessage = 'The PowerShell Tip to write to the terminal.')]
		[ValidateNotNullOrEmpty()]
		[tiPS.PowerShellTip] $Tip
	)

	[ConsoleColor] $headerColor = [ConsoleColor]::Cyan
	[ConsoleColor] $tipTextColor = [ConsoleColor]::White
	[ConsoleColor] $exampleColor = [ConsoleColor]::Yellow
	[ConsoleColor] $urlsColor = [ConsoleColor]::Green
	[ConsoleColor] $authorColor = [ConsoleColor]::Gray

	# Calculate how many header characters to put on each side of the title to make it look nice.
	[int] $numberOfCharactersInHeader = 90
	[int] $headerContentLength = $Tip.Title.Length + 2 + $Tip.Category.ToString().Length + 3
	[int] $numberOfHeaderCharactersOnEachSideOfTitle =
		[Math]::Floor(($numberOfCharactersInHeader - ($headerContentLength)) / 2)
	[int] $additionalHeaderCharacterNeeded = 0
	if ($headerContentLength % 2 -eq 1)
	{
		$additionalHeaderCharacterNeeded = 1
	}

	[string] $header =
		('-' * $numberOfHeaderCharactersOnEachSideOfTitle) +
		' ' + $Tip.Title + ' ' +
		'[' + $Tip.Category + '] ' +
		('-' * ($numberOfHeaderCharactersOnEachSideOfTitle + $additionalHeaderCharacterNeeded))
	Write-Host $header -ForegroundColor $headerColor

	Write-Host $Tip.TipText -ForegroundColor $tipTextColor

	if ($Tip.ExampleIsProvided)
	{
		Write-Host 'Example:' -ForegroundColor $exampleColor
		Write-Host $Tip.Example -ForegroundColor $exampleColor
	}

	if ($Tip.UrlsAreProvided)
	{
		Write-Host 'More information: ' -ForegroundColor $urlsColor
		Write-Host ($Tip.Urls -join [System.Environment]::NewLine) -ForegroundColor $urlsColor
	}

	if ($Tip.AuthorIsProvided)
	{
		Write-Host "Tip submitted by: $($Tip.Author)" -ForegroundColor $authorColor
	}

	Write-Host ('-' * $numberOfCharactersInHeader) -ForegroundColor $headerColor
}
