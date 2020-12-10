#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )

    # StartSymbol
    $prompt += Write-Prompt -Object $sl.PromptSymbols.StartSymbol -ForegroundColor $sl.Colors.PromptHighlightColor -BackgroundColor $sl.Colors.PromptStartIndicatorColor1
    $prompt += Write-Prompt -Object $sl.PromptSymbols.StartSymbol -ForegroundColor $sl.Colors.PromptHighlightColor -BackgroundColor $sl.Colors.PromptStartIndicatorColor2
    $prompt += Write-Prompt -Object $sl.PromptSymbols.StartSymbol -ForegroundColor $sl.Colors.PromptHighlightColor -BackgroundColor $sl.Colors.PromptStartIndicatorColor3

    # Admin Prompt
    if (Test-Administrator) {
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.ElevatedSymbol) " -ForegroundColor $sl.Colors.AdminIconForegroundColor -BackgroundColor $sl.Colors.AdminIconBackgroundColor
    } else {
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.ElevatedSymbol) " -ForegroundColor $sl.Colors.PromptHighlightColor -BackgroundColor $sl.Colors.AdminIconBackgroundColor
    }

    # user@computer prompt
    $user = [System.Environment]::UserName
    $computer = [System.Environment]::MachineName
    $path = Get-FullPath -dir $pwd
    if (Test-NotDefaultUser($user)) {
        $prompt += Write-Prompt -Object " $user@$computer " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.PromptBackgroundColor
    }
    if (Test-VirtualEnv) {
        $prompt += Write-Prompt -Object " $($sl.PromptSymbols.VirtualEnvSymbol) $(Get-VirtualEnvName) " -ForegroundColor $sl.Colors.PromptForegroundColor -BackgroundColor $sl.Colors.VirtualEnvBackgroundColor
    }
    $prompt += Write-Prompt -Object " $path " -ForegroundColor $sl.Colors.PromptHighlightColor -BackgroundColor $sl.Colors.PathBackgroundColor
    
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
    $timeStamp = Get-Date -UFormat %T
    $prompt += Set-CursorForRightBlockWrite -textLength ($timeStamp.Length+6)
    $prompt += Write-Prompt -Object " ◔ $($timeStamp) " -ForegroundColor $sl.Colors.TimeStampForegroundColor
    $prompt += Set-Newline

    if ($with) {
        $prompt += Write-Prompt -Object "$($with.ToUpper()) " -BackgroundColor $sl.Colors.WithBackgroundColor -ForegroundColor $sl.Colors.PromptForegroundColor
    }
    
    $prompt += Write-Prompt -Object $sl.PromptSymbols.PromptIndicator -ForegroundColor $sl.Colors.PromptIndicatorColor1
    $prompt += Write-Prompt -Object $sl.PromptSymbols.PromptIndicator -ForegroundColor $sl.Colors.PromptIndicatorColor2
    $prompt += Write-Prompt -Object $sl.PromptSymbols.PromptIndicator -ForegroundColor $sl.Colors.PromptIndicatorColor3
    $prompt += ' '
    $prompt
}

$sl = $global:ThemeSettings #local settings

$sl.PromptSymbols.ElevatedSymbol                    = "⍬"
$sl.PromptSymbols.FailedCommandSymbol               = "✘"
$sl.PromptSymbols.HomeSymbol                        = "~"
$sl.PromptSymbols.PathSeparator                     = "\"
$sl.PromptSymbols.PromptIndicator                   = "❯"
$sl.PromptSymbols.RootSymbol                        = "#"
$sl.PromptSymbols.SegmentBackwardSymbol             = ""
$sl.PromptSymbols.SegmentForwardSymbol              = ""
$sl.PromptSymbols.SegmentSeparatorForwardSymbol     = ""
$sl.PromptSymbols.SegmentSeparatorBackwardSymbol    = ""
$sl.PromptSymbols.StartSymbol                       = "❮"
$sl.PromptSymbols.SuccessCommandSymbol              = "✔"
$sl.PromptSymbols.TruncatedFolderSymbol             = ".."
$sl.PromptSymbols.UNCSymbol                         = "§"
$sl.PromptSymbols.VirtualEnvSymbol                  = "⭓"

$sl.Colors.AdminIconBackgroundColor                     = [ConsoleColor]::DarkBlue
$sl.Colors.AdminIconForegroundColor                     = [ConsoleColor]::Red
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
$sl.Colors.SessionInfoBackgroundColor                   = [ConsoleColor]::Black
$sl.Colors.SessionInfoForegroundColor                   = [ConsoleColor]::Blue
$sl.Colors.TimeStampForegroundColor                     = [ConsoleColor]::Magenta
$sl.Colors.VirtualEnvBackgroundColor                    = [ConsoleColor]::Red
$sl.Colors.VirtualEnvForegroundColor                    = [ConsoleColor]::White
$sl.Colors.WithBackgroundColor                          = [ConsoleColor]::DarkRed
$sl.Colors.WithForegroundColor                          = [ConsoleColor]::White

$sl.Colors.PromptIndicatorColor1                        = [ConsoleColor]::Yellow
$sl.Colors.PromptIndicatorColor2                        = [ConsoleColor]::Green
$sl.Colors.PromptIndicatorColor3                        = [ConsoleColor]::Cyan
$sl.Colors.PromptStartIndicatorColor1                   = [ConsoleColor]::DarkYellow
$sl.Colors.PromptStartIndicatorColor2                   = [ConsoleColor]::DarkGreen
$sl.Colors.PromptStartIndicatorColor3                   = [ConsoleColor]::DarkCyan