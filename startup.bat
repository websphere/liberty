@echo off

rem ---------------------------------------------------------------------------
rem Start script to setup environment variable
rem ---------------------------------------------------------------------------

setlocal

rem Guess BASEDIR if not defined
@set "CURRENT_DIR=%cd%"
echo This environment CURRENT_DIR "%CURRENT_DIR%"
if not "%BASEDIR%" == "" goto gotHome
@set "BASEDIR=%CURRENT_DIR%"
if exist "%BASEDIR%\setenv.bat" goto findBase
if exist "%BASEDIR%\scripts\setenv.bat" goto okHome

:findBase
cd ..
@set "BASEDIR=%cd%"
cd "%CURRENT_DIR%"
if exist "%BASEDIR%\scripts\setenv.bat" goto okHome

:noBaseDir
echo Unable to determine BASEDIR environment variable OR not defined correctly
echo This environment variable is needed to run this program
goto end

:okHome

@set "PGSQL=%BASEDIR%\pgsql"
@set "PGDATA="%BASEDIR%\pgdata"
@set "PGLOGS=%PGDATA%\pg.log"
@set "TOMCAT=%BASEDIR%\tomcat"
@set "LIBERTY=%BASEDIR%\wlp"
@set "JBOSS=%BASEDIR%\jboss"
@set "JAVA_HOME=%BASEDIR%\jdk8"

echo BASEDIR  : "%BASEDIR%"
echo JAVA_HOME: "%JAVA_HOME%"
rem set "EXECUTABLE=%BASEDIR%\bin\catalina.bat"

rem rem Check that target executable exists
rem if exist "%EXECUTABLE%" goto okExec
rem echo Cannot find "%EXECUTABLE%"
rem echo This file is needed to run this program
goto end
:okExec

rem Get remaining unshifted command line arguments and save them in the
@set CMD_LINE_ARGS=
:setArgs
if ""%1""=="""" goto doneSetArgs
@set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto setArgs
:doneSetArgs

rem call "%EXECUTABLE%" start %CMD_LINE_ARGS%
echo "BASEDIR: " %BASEDIR%
:end
