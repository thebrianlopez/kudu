@echo off
setlocal enabledelayedexpansion 

pushd %1

set attempts=5
set counter=0

:retry
set /a counter+=1
echo Attempt %counter% out of %attempts%
:: the latest version of NPM no longer accepts celf sighnedcerts
:: and thus errors out with: SSL Error: SELF_SIGNED_CERT_IN_CHAIN
:: the line below is a workaround to accept the cert
cmd /c npm config set ca ""
cmd /c npm install https://github.com/projectkudu/KuduScript/tarball/d3274bbb96fbe0272b5c55918c0365e7b961c577
IF %ERRORLEVEL% NEQ 0 goto error

goto end

:error
if %counter% GEQ %attempts% goto :lastError
goto retry

:lastError
popd
echo An error has occured during npm install.
exit /b 1

:end
popd
echo Finished successfully.
exit /b 0
