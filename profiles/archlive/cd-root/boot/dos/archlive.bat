@ECHO OFF
REM #########################################################################
REM DOS batch file to boot Linux.

REM First, ensure any unwritten disk buffers are flushed:
@smartdrv /C

REM Start the LOADLIN process:
cls
loadlin @bootconfig %1 %2 %3 %4 %5 %6 %7 %8 %9 %10 %11 %12 %13 %14 %15 %16 %17 %18 %19 %20

REM #########################################################################
