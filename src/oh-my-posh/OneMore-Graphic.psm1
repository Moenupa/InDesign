#requires -Version 2 -Modules posh-git
# warning: this profile depends on a Nerd font to display

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )

    for ($i = 0; $i -lt 3; $i++) {
        $prompt += Write-Prompt -Object $sl.PromptSymbols.StartSymbol -ForegroundColor $sl.Colors.PromptHighlightColor -BackgroundColor $sl.Colors.PromptStartIndicatorColors[$i]
    }

    $prompt += Write-Prompt -Object " " -BackgroundColor $sl.Colors.AdminIconBackgroundColor[[int](Test-Administrator)]
    $prompt += Write-Prompt -Object $sl.PromptSymbols.ElevatedSymbol -ForegroundColor $sl.Colors.AdminIconForegroundColor -BackgroundColor $sl.Colors.AdminIconBackgroundColor[[int](Test-Administrator)]
    $prompt += Write-Prompt -Object " " -BackgroundColor $sl.Colors.AdminIconBackgroundColor[[int](Test-Administrator)]

    # user@computer prompt
    $user = [System.Environment]::UserName
    $computer = [System.Environment]::MachineName
    if (Test-NotDefaultUser($user)) {
        $prompt += Write-Prompt -Object " $user@$computer " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
    }
    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.VirtualEnvSymbol) $(Get-VirtualEnvName) " -ForegroundColor $sl.Colors.VirtualEnvForegroundColor -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
    }

    $prompt += Write-Prompt -Object " $($sl.PromptSymbols.FolderSymbol)" -ForegroundColor $sl.Colors.PromptHighlightColor -BackgroundColor $sl.Colors.PathBackgroundColor
    $path = Get-FullPath -dir $pwd
    if ($path.length -gt 40) {
        $prompt += Write-Prompt -Object " $($path.Substring(0,18))$($sl.PromptSymbols.TruncatedFolderSymbol)$($path.Substring([int]($path.length-17))) " -ForegroundColor $sl.Colors.PromptHighlightColor -BackgroundColor $sl.Colors.PathBackgroundColor
    } else {
        $prompt += Write-Prompt -Object " $path " -ForegroundColor $sl.Colors.PromptHighlightColor -BackgroundColor $sl.Colors.PathBackgroundColor
    }
    
    # Git status prompt
    $status = Get-VCSStatus
    if ($status) {
        $themeInfo = Get-VcsInfo -status ($status)
        $prompt += Write-Prompt -Object " $($themeInfo.VcInfo) " -BackgroundColor $themeInfo.BackgroundColor -ForegroundColor $sl.Colors.GitForegroundColor
    }

    if ($lastCommandFailed) {
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.FailedCommandSymbol) " -ForegroundColor $sl.Colors.CommandFailedIconForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
    } else {
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.SuccessCommandSymbol) " -ForegroundColor $sl.Colors.CommandSuccessIconForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
    }

    # time prompt
    $timeStamp = Get-Date -UFormat %R
    $prompt += Set-CursorForRightBlockWrite -textLength ($timeStamp.Length + 3)
    $prompt += Write-Prompt -Object $sl.PromptSymbols.HourSymbol[(Get-Date).hour%12]
    $prompt += Write-Prompt -Object " $($timeStamp)" -ForegroundColor $sl.Colors.TimeStampForegroundColor
    $prompt += Set-Newline

    if ($with) {
        $prompt += Write-Prompt -Object "$($with.ToUpper()) " -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.PromptForegroundColor
    }
    
    for ($i = 0; $i -lt 3; $i++) {
        $prompt += Write-Prompt -Object $sl.PromptSymbols.PromptIndicator -ForegroundColor $sl.Colors.PromptIndicatorColors[$i]
    }
    $prompt += ' '
    $prompt
}

$sl = $global:ThemeSettings #local settings

$sl.PromptSymbols.ElevatedSymbol                    = [char]::ConvertFromUtf32(0xe752)
$sl.PromptSymbols.FailedCommandSymbol               = [char]::ConvertFromUtf32(0xf658)
$sl.PromptSymbols.HomeSymbol                        = [char]::ConvertFromUtf32(0x2053) # "~"
$sl.PromptSymbols.PathSeparator                     = [char]::ConvertFromUtf32(0x005C) # "\"
$sl.PromptSymbols.PromptIndicator                   = [char]::ConvertFromUtf32(0xf0da) # "❯"
$sl.PromptSymbols.SegmentForwardSymbol              = [char]::ConvertFromUtf32(0xE0B0) # ""
$sl.PromptSymbols.SegmentBackwardSymbol             = [char]::ConvertFromUtf32(0xE0B2) # ""
$sl.PromptSymbols.SegmentSeparatorForwardSymbol     = [char]::ConvertFromUtf32(0xE0B1) # ""
$sl.PromptSymbols.SegmentSeparatorBackwardSymbol    = [char]::ConvertFromUtf32(0xE0B3) # ""
$sl.PromptSymbols.StartSymbol                       = [char]::ConvertFromUtf32(0xf0d9)
$sl.PromptSymbols.SuccessCommandSymbol              = [char]::ConvertFromUtf32(0xf632)
$sl.PromptSymbols.TruncatedFolderSymbol             = ".."
$sl.PromptSymbols.UNCSymbol                         = "§"
$sl.PromptSymbols.VirtualEnvSymbol                  = [char]::ConvertFromUtf32(0xfc15) # "⭓"
$sl.PromptSymbols.FolderSymbol                      = [char]::ConvertFromUtf32(0xe5ff)
$sl.PromptSymbols.HourSymbol                        = "🕛","🕐","🕑","🕒","🕓","🕔","🕕","🕖","🕗","🕘","🕙","🕚"

$sl.GitSymbols.BranchSymbol                         = [char]::ConvertFromUtf32(0xE725)

$sl.Colors.AdminIconBackgroundColor                     = [ConsoleColor]::DarkBlue, [ConsoleColor]::DarkRed
$sl.Colors.AdminIconForegroundColor                     = [ConsoleColor]::Black
$sl.Colors.CommandFailedIconForegroundColor             = [ConsoleColor]::Red
$sl.Colors.CommandSuccessIconForegroundColor            = [ConsoleColor]::Green
$sl.Colors.DriveForegroundColor                         = [ConsoleColor]::DarkBlue
$sl.Colors.GitDefaultColor                              = [ConsoleColor]::DarkGreen
$sl.Colors.GitForegroundColor                           = [ConsoleColor]::Black
$sl.Colors.GitLocalChangesColor                         = [ConsoleColor]::DarkYellow
$sl.Colors.GitNoLocalChangesAndAheadAndBehindColor      = [ConsoleColor]::DarkRed
$sl.Colors.GitNoLocalChangesAndAheadColor               = [ConsoleColor]::DarkMagenta
$sl.Colors.GitNoLocalChangesAndBehindColor              = [ConsoleColor]::DarkRed
$sl.Colors.PathBackgroundColor                          = [ConsoleColor]::DarkCyan
$sl.Colors.PromptBackgroundColor                        = [ConsoleColor]::DarkGray
$sl.Colors.PromptForegroundColor                        = [ConsoleColor]::White
$sl.Colors.PromptHighlightColor                         = [ConsoleColor]::Black
$sl.Colors.PromptSymbolColor                            = [ConsoleColor]::White
$sl.Colors.SessionInfoBackgroundColor                   = [ConsoleColor]::Blue
$sl.Colors.SessionInfoForegroundColor                   = [ConsoleColor]::Black
$sl.Colors.TimeStampForegroundColor                     = [ConsoleColor]::Magenta
$sl.Colors.VirtualEnvBackgroundColor                    = [ConsoleColor]::DarkRed
$sl.Colors.VirtualEnvForegroundColor                    = [ConsoleColor]::Black
$sl.Colors.WithBackgroundColor                          = [ConsoleColor]::DarkRed
$sl.Colors.WithForegroundColor                          = [ConsoleColor]::White

$sl.Colors.PromptIndicatorColors                        = [ConsoleColor]::Yellow,[ConsoleColor]::Green,[ConsoleColor]::Cyan
$sl.Colors.PromptStartIndicatorColors                   = [ConsoleColor]::DarkYellow,[ConsoleColor]::DarkGreen,[ConsoleColor]::DarkCyan