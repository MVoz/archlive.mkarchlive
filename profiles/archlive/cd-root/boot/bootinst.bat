@echo off
cls
set DISK=none
set BOOTFLAG=boot666s.tmp

echo ���ļ�������⵱ǰ�̷�. >\%BOOTFLAG%
if not exist \%BOOTFLAG% goto readOnly

echo ���Ժ�������Ŀǰ�̷�...
for %%d in ( C D E F G H I J K L M N O P Q R S T U V W X Y Z ) do if exist %%d:\%BOOTFLAG% set DISK=%%d
cls
del \%BOOTFLAG%
if %DISK% == none goto DiskNotFound

echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo                          ��ӭʹ��Carbon��Archlive��װϵͳ
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
echo ��װϵͳ��%DISK%��: ֻ������Archlive.
echo.
echo ���棡%DISK%����������������д.
echo ���%DISK%��Ҳ��������windows���˲��轫ʹ���windows�޷�������
echo.
echo ��������������رմ˴��ڷ�����
pause > nul

cls
echo д��������¼��%DISK%�̣����Ժ�...

if %OS% == Windows_NT goto setupNT
goto setup95

:setupNT
\boot\syslinux\syslinux.exe -ma -d \boot\syslinux %DISK%:
goto setupDone

:setup95
\boot\syslinux\syslinux.com -ma -d \boot\syslinux %DISK%:

:setupDone
echo %DISK%������Ӧ�ÿ��������ˣ���װ�ɹ���
goto pauseit

:readOnly
echo %DISK%�̱�д�������޷�������
goto pauseit

:DiskNotFound
echo �����޷����Ҹ��̡�

:pauseit
echo.
echo �鿴������Ϣ��������������ء�
pause > nul

:end
