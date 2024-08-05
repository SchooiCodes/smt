@if (@a==@b) @end /* -- batch / JScript hybrid line to begin JScript comment

:: --------------------
:: ini.bat
:: ini.bat /? for usage
:: --------------------

@echo off
setlocal enabledelayedexpansion

goto begin

:: color code by jeb -- https://stackoverflow.com/a/5344911/1683264
:c
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b
:: but it doesn't handle slashes.  :(
:s
<NUL set /p "=/"&exit /b

:usage
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "DEL=%%a"
<nul > X set /p ".=."

echo Usage:
call :c 07 "   query:"
call :c 0F " %~nx0 "&call :s&call :c 0F "i item ["&call :s&call :c 0F "s section] inifile"&echo;
call :c 07 "   create or modify:"
call :c 0F " %~nx0 "&call :s&call :c 0F "i item "&call :s&call :c 0F "v value ["&call :s&call :c 0F "s section] inifile"&echo;
call :c 07 "   delete:"
call :c 0F " %~nx0 "&call :s&call :c 0F "d item ["&call :s&call :c 0F "s section] inifile"&echo;
echo;
echo Take the following ini file for example:
echo;
echo    [Config]
echo    password=1234
echo    usertries=0
echo    allowterminate=0
echo;
echo To read the "password" value:
call :c 0F "   %~nx0 "&call :s&call :c 0F "s Config "&call :s&call :c 0F "i password inifile"&echo;
echo;
echo To modify the "usertries" value to 5:
call :c 0F "   %~nx0 "&call :s&call :c 0F "s Config "&call :s&call :c 0F "i usertries "&call :s&call :c 0F "v 5 inifile"&echo;
echo;
echo To add a "timestamp" key with a value of the current date and time:
call :c 0F "   %~nx0 "&call :s&call :c 0F "s Config "&call :s&call :c 0F "i timestamp "&call :s&call :c 0F "v ""%DEL%%%%%date%%%% %%%%time%%%%""%DEL% inifile"&echo;
echo;
echo To delete the "allowterminate" key:
call :c 0F "   %~nx0 "&call :s&call :c 0F "s Config "&call :s&call :c 0F "d allowterminate inifile"&echo;
echo;
call :c 07 "In the above examples, "&call :s
call :c 0F "s Config "
echo is optional, but will allow the selection of
echo a specific item where the ini file contains similar items in multiple sections.
del X
goto :EOF

:begin
if "%~1"=="" goto usage
for %%I in (item value section found) do set %%I=
for %%I in (%*) do (
    if defined next (
        if !next!==/i set "item=%%~I"
        if !next!==/v (
            set modify=true
            set "value=%%~I"
        )
        if !next!==/d (
            set "item=%%~I"
            set modify=true
            set delete=true
        )
        if !next!==/s set "section=%%~I"
        set next=
    ) else (
        for %%x in (/i /v /s /d) do if "%%~I"=="%%x" set "next=%%~I"
        if not defined next (
            set "arg=%%~I"
            if "!arg:~0,1!"=="/" (
                1>&2 echo Error: Unrecognized option "%%~I"
                1>&2 echo;
                1>&2 call :usage
                exit /b 1
            ) else set "inifile=%%~I"
        )
    )
)
for %%I in (item inifile) do if not defined %%I goto usage
if not exist "%inifile%" (
    1>&2 echo Error: %inifile% not found.
    exit /b 1
)

cscript /nologo /e:jscript "%~f0" "%inifile%" "!section!" "!item!" "!value!" "%modify%" "%delete%"

exit /b %ERRORLEVEL%

:: Begin JScript portion */
var inifile = WSH.Arguments(0),
section = WSH.Arguments(1),
item = WSH.Arguments(2),
value = WSH.Arguments(3),
modify = WSH.Arguments(4),
del = WSH.Arguments(5),
fso = new ActiveXObject("Scripting.FileSystemObject"),
stream = fso.OpenTextFile(inifile, 1),

// (stream.ReadAll() will not preserve blank lines.)
data = [];
while (!stream.atEndOfStream) { data.push(stream.ReadLine()); }
stream.Close();

// trims whitespace from edges
String.prototype.trim = function() { return this.replace(/^\s+|\s+$/,'') }

// trim + toLowerCase
String.prototype.unify = function() { return this.trim().toLowerCase(); };

// unquotes each side of "var"="value"
String.prototype.splitEx = function(x) {
    for (var i=0, ret = this.split(x) || []; i<ret.length; i++) {
        ret[i] = ret[i].replace(/^['"](.*)['"]$/, function(m,$1){return $1});
    };
    return ret;
}

// splices a new element into an array just after the last non-empty element.  If first arg is a number, start at that position and look backwards.
Array.prototype.cram = function() {
    for (var args=[], i=0; i<arguments.length; i++) { args.push(arguments[i]); }
    var i = (typeof args[0] == "number" && Math.floor(args[0]) == args[0]) ? args.shift() : this.length;
    while (i>0 && !this[--i].length) {};
    for (var j=0; j<args.length; j++) this.splice(++i, 0, args[j]);
}

function saveAndQuit() {
    while (data && !data[data.length - 1].length) data.pop();
    var stream = fso.OpenTextFile(inifile, 2, true);
    stream.Write(data.join('\r\n') + '\r\n');
    stream.Close();
    WSH.Quit(0);
}

function fatal(err) {
    WSH.StdErr.WriteLine(err);
    WSH.Quit(1);
}

if (section && !/^\[.+\]$/.test(section)) section = '[' + section + ']';

if (modify) {
    if (section) {
        for (var i=0; i<data.length; i++) {
            if (data[i].unify() == section.unify()) {
                for (var j=i + 1; j<data.length; j++) {
                    if (/^\s*\[.+\]\s*$/.test(data[j])) break;
                    var keyval = data[j].splitEx('=');
                    if (keyval.length < 2) continue;
                    var key = keyval.shift(), val = keyval.join('=');
                    if (key.unify() == item.unify()) {
                        if (del) data.splice(j, 1);
                        else {
                            data[j] = item + '=' + value;
                            WSH.Echo(value.trim());
                        }
                        saveAndQuit();
                    }
                }
                if (del) fatal(item + ' not found in ' + section + ' in ' + inifile);
                data.cram(j ,item + '=' + value);
                WSH.Echo(value.trim());
                saveAndQuit();
            }
        }
        if (del) fatal(section + ' not found in ' + inifile);
        data.cram('\r\n' + section, item + '=' + value);
        WSH.Echo(value.trim());
        saveAndQuit();
    }
    else { // if (!section)
        for (var i=0; i<data.length; i++) {
            var keyval = data[i].splitEx('=');
            if (keyval.length < 2) continue;
            var key = keyval.shift(), val = keyval.join('=');
            if (key.unify() == item.unify()) {
                if (del) data.splice(i, 1);
                else {
                    data[i] = item + '=' + value;
                    WSH.Echo(value.trim());
                }
                saveAndQuit();
            }
        }
        if (del) fatal(item + ' not found in ' + inifile);
        data.cram(item + '=' + value);
        WSH.Echo(value.trim());
        saveAndQuit();
    }
}
else if (section) { // and if (!modify)
    for (var i=0; i<data.length; i++) {
        if (data[i].unify() == section.unify()) {
            for (var j=i + 1; j<data.length; j++) {
                if (/^\s*\[.+\]\s*$/.test(data[j])) fatal(item + ' not found in ' + section + ' in ' + inifile);
                var keyval = data[j].splitEx('=');
                if (keyval.length < 2) continue;
                var key = keyval.shift(), val = keyval.join('=');
                if (key.unify() == item.unify()) {
                    WSH.Echo(val.trim());
                    WSH.Quit(0);
                }
            }
        }
    }
    fatal(section + ' not found in ' + inifile);
}
else { // if (item) and nothing else
    for (var i=0; i<data.length; i++) {
        var keyval = data[i].splitEx('=');
        if (keyval.length < 2) continue;
        var key = keyval.shift(), val = keyval.join('=');
        if (key.unify() == item.unify()) {
            WSH.Echo(val.trim());
            WSH.Quit(0);
        }
    }
    fatal(item + ' not found in ' + inifile);
}