#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )
    $prompt += Write-Prompt -Object "╭┨" -ForegroundColor $sl.Colors.GitForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
	$prompt += Write-Prompt -Object "❮" -ForegroundColor $sl.Colors.GitForegroundColor -BackgroundColor $sl.Colors.PromptIndicatorColor1
	$prompt += Write-Prompt -Object "❮" -ForegroundColor $sl.Colors.GitForegroundColor -BackgroundColor $sl.Colors.PromptIndicatorColor2
	$prompt += Write-Prompt -Object "❮" -ForegroundColor $sl.Colors.GitForegroundColor -BackgroundColor $sl.Colors.PromptIndicatorColor3
    If (Test-Administrator) {
        $prompt += Write-Prompt -Object " ⍬ " -ForegroundColor $sl.Colors.AdminIconForegroundColor -BackgroundColor $sl.Colors.AdminIconBackgroundColor
    } else {
        $prompt += Write-Prompt -Object " ⍬ " -ForegroundColor $sl.Colors.GitForegroundColor -BackgroundColor $sl.Colors.AdminIconBackgroundColor
    }
    $user = [System.Environment]::UserName
    $computer = [System.Environment]::MachineName
    $path = Get-FullPath -dir $pwd
    if (Test-NotDefaultUser($user)) {
        $prompt += Write-Prompt -Object " $user@$computer " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
    }
    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object " ⭓ $(Get-VirtualEnvName) " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
    }
    $prompt += Write-Prompt -Object " $path " -ForegroundColor $sl.Colors.GitForegroundColor -BackgroundColor $sl.Colors.PathBackgroundColor
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
    $prompt += Write-Prompt -Object "❯" -ForegroundColor $sl.Colors.PromptIndicatorColor1
    $prompt += Write-Prompt -Object "❯" -ForegroundColor $sl.Colors.PromptIndicatorColor2
    $prompt += Write-Prompt -Object "❯" -ForegroundColor $sl.Colors.PromptIndicatorColor3
    $prompt += ' '
    $prompt
}
$sl = $global:ThemeSettings #local settings

$sl.PromptSymbols.FailedCommandSymbol        = [char]::ConvertFromUtf32(0x2718)
$sl.PromptSymbols.SuccessCommandSymbol       = [char]::ConvertFromUtf32(0x2714)

$sl.Colors.PromptBackgroundColor             = [ConsoleColor]::DarkGray
$sl.Colors.PathBackgroundColor               = [ConsoleColor]::DarkCyan
$sl.Colors.AdminIconForegroundColor          = [ConsoleColor]::Red
$sl.Colors.AdminIconBackgroundColor          = [ConsoleColor]::DarkGreen
$sl.Colors.VirtualEnvBackgroundColor         = [ConsoleColor]::DarkMagenta
$sl.Colors.CommandFailedIconForegroundColor  = [ConsoleColor]::Red
$sl.Colors.CommandSuccessIconForegroundColor = [ConsoleColor]::Green
$sl.Colors.PromptIndicatorColor1             = [ConsoleColor]::Yellow
$sl.Colors.PromptIndicatorColor2             = [ConsoleColor]::Green
$sl.Colors.PromptIndicatorColor3             = [ConsoleColor]::Cyan
$sl.Colors.TimeStampForegroundColor          = [ConsoleColor]::Magenta