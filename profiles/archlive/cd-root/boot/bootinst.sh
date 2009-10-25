#!/bin/bash

set -e
TARGET=""
MBR=""

# ��������ʹ�õķ�������U��
MYMNT=$(cd -P $(dirname $0) ; pwd)
while [ "$MYMNT" != "" -a "$MYMNT" != "." -a "$MYMNT" != "/" ]; do
   TARGET=$(egrep "[^[:space:]]+[[:space:]]+$MYMNT[[:space:]]+" /proc/mounts | cut -d " " -f 1)
   if [ "$TARGET" != "" ]; then break; fi
   MYMNT=$(dirname "$MYMNT")
done

if [ "$TARGET" = "" ]; then
   echo "�޷���������װ���豸."
   echo "��ȷ�����Ѿ������豸."
   exit 1
fi

MBR=$(echo "$TARGET" | sed -r "s/[0-9]+\$//g")
NUM=${TARGET:${#MBR}}
cd "$MYMNT"

clear
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo "                       ��ӭʹ��Carbon��Archlive��װϵͳ                        "
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
echo
echo "��װϵͳ�� $TARGET ֻ������Archlive."
if [ "$MBR" != "$TARGET" ]; then
   echo
   echo "���棡$MBR��������������д."
   echo "�������$MBR�����ִ�ϵͳ��ԭ������¼���޷���������."
   echo "ֻ��Archlive�ܱ����������������!"
fi
echo
echo "������������� Ctrl+C����..."
read junk
clear

echo "�����ļ�ϵͳ�������������ĵȴ�..."
sync

# ����豸��֧��superfloppy��ʽ(USB-ZIP)����װlilo
if [ "$MBR" != "$TARGET" ]; then
   echo "����������¼��$MBR..."
   ./boot/syslinux/lilo -S /dev/null -M $MBR ext # this must be here to support -A for extended partitions
   echo "�������$TARGET..."
   ./boot/syslinux/lilo -S /dev/null -A $MBR $NUM
   echo "����������¼$MBR..." # this must be here because LILO mbr is bad. mbr.bin is from syslinux
   cat ./boot/syslinux/mbr.bin > $MBR
fi

echo "����������¼��$TARGET..."
./boot/syslinux/syslinux -d boot/syslinux $TARGET

echo "$TARGET ���������ˣ���װ����."

echo
echo "�鿴������Ϣ���������������..."
read junk
