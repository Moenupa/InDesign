#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )
    $prompt += Write-Prompt -Object "╭─" -ForegroundColor $sl.Colors.PromptForegroundColor
	$prompt += Write-Prompt -Object "╼" -ForegroundColor $sl.Colors.PromptIndicatorColor3
	$prompt += Write-Prompt -Object "━" -ForegroundColor $sl.Colors.PromptIndicatorColor1
	$prompt += Write-Prompt -Object "╾" -ForegroundColor $sl.Colors.PromptIndicatorColor2
    If (Test-Administrator) {
        $prompt += Write-Prompt -Object " ∧∧ " -ForegroundColor $sl.Colors.AdminIconForegroundColor -BackgroundColor $sl.Colors.AdminIconBackgroundColor
    } else {
        $prompt += Write-Prompt -Object " ∧∧ " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.AdminIconBackgroundColor
    }
    $user = [System.Environment]::UserName
    $computer = [System.Environment]::MachineName
    $path = Get-ShortPath -dir $pwd
    if (Test-NotDefaultUser($user)) {
        $prompt += Write-Prompt -Object " $user@$computer " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
    }
    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object " ⭓ $(Get-VirtualEnvName) " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
    }
    $prompt += Write-Prompt -Object " $path " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.PromptIndicatorColor2
    $status = Get-VCSStatus
    if ($status) {
        $themeInfo = Get-VcsInfo -status ($status)
        $prompt += Write-Prompt -Object " $($themeInfo.VcInfo) " -BackgroundColor $themeInfo.BackgroundColor -ForegroundColor $sl.Colors.GitForegroundColor
    }
    If ($lastCommandFailed) {
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.FailedCommandSymbol) " -ForegroundColor $sl.Colors.CommandFailedIconForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
    } else {
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.SuccessCommandSymbol) " -ForegroundColor $sl.Colors.CommandSuccessIconForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
    }
    $timeStamp = Get-Date -UFormat %T
    $prompt += Set-CursorForRightBlockWrite -textLength ($timeStamp.Length+6)
    $prompt += Write-Prompt -Object " ◔ $($timeStamp) " -ForegroundColor $sl.Colors.TimeStampForegroundColor
    $prompt += Set-Newline

    if ($with) {
        $prompt += Write-Prompt -Object "$($with.ToUpper()) " -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.PromptForegroundColor
    }
    $prompt += Write-Prompt -Object "╰┨" -ForegroundColor $sl.Colors.PromptForegroundColor
    $prompt += Write-Prompt -Object "❯" -ForegroundColor $sl.Colors.PromptIndicatorColor3
    $prompt += Write-Prompt -Object "❯" -ForegroundColor $sl.Colors.PromptIndicatorColor1
    $prompt += Write-Prompt -Object "❯" -ForegroundColor $sl.Colors.PromptIndicatorColor2
    $prompt += ' '
    $prompt
}
$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.FailedCommandSymbol = [char]::ConvertFromUtf32(0x2718) #2B22 2B53
$sl.PromptSymbols.SuccessCommandSymbol = [char]::ConvertFromUtf32(0x2714)
$sl.Colors.AdminIconForegroundColor = [ConsoleColor]::Red
$sl.Colors.AdminIconBackgroundColor = [ConsoleColor]::DarkGreen
$sl.Colors.PromptForegroundColor = [ConsoleColor]::White
$sl.Colors.PromptBackgroundColor = [ConsoleColor]::DarkGray
$sl.Colors.GitForegroundColor = [ConsoleColor]::Black
$sl.Colors.WithBackgroundColor = [ConsoleColor]::DarkMagenta
$sl.Colors.VirtualEnvBackgroundColor = [System.ConsoleColor]::DarkRed
$sl.Colors.CommandSuccessIconForegroundColor = [System.ConsoleColor]::Green
$sl.Colors.CommandFailedIconForegroundColor = [System.ConsoleColor]::Red
$sl.Colors.PromptIndicatorColor1 = [ConsoleColor]::Green
$sl.Colors.PromptIndicatorColor2 = [ConsoleColor]::DarkCyan
$sl.Colors.PromptIndicatorColor3 = [ConsoleColor]::Yellow
$sl.Colors.TimeStampForegroundColor = [ConsoleColor]::Magenta