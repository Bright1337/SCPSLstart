#!/bin/bash
/home/container/steamcmd/steamcmd.sh +login anonymous +force_install_dir /mnt/server +app_update 996560 +quit
NewVer=$(curl https://api.github.com/repos/galaxy119/EXILED/tags?per_page=1 | grep -n "name"|cut -c2-| grep -o '[0-9].[0-9].[0-9][0-9]')
ThisVerFile=cur.ver
ThisVer=$(cat $ThisVerFile)
if test -f "$ThisVerFile"; then
        if [[ "$ThisVer" == "$NewVer" ]]; then
                echo "Gucci"
        else
                cd /home/container/.config/EXILED
                rm Exiled.Loader.dll
                cd Plugins
                rm Exiled.Events.dll
                rm Exiled.Permissions.dll
                rm Exiled.Updater.dll
                mkdir /exiled
                cd /exiled
                tmp="curl -L -O https://github.com/galaxy119/EXILED/releases/download/$NewVer/Exiled.tar.gz"
                $tmp
                tar -zvxf Exiled.tar.gz
                mkdir /home/container/.config/EXILED/
                mv /exiled/EXILED/* /home/container/.config/EXILED/
                if test -f /home/container/SCPSL_Data/Managed/Assembly-CSharp.dll.old; then
                       rm  /home/container/SCPSL_Data/Managed/Assembly-CSharp.dll.old
                fi
                mv /home/container/SCPSL_Data/Managed/Assembly-CSharp.dll /home/container/SCPSL_Data/Managed/Assembly-CSharp.dll.old
                mv /exiled/Assembly-CSharp.dll /home/container/SCPSL_Data/Managed
                cd /
                rm -r /exiled
                cd
                echo "$NewVer" > $ThisVerFile
        fi
else
        mkdir /exiled
        cd /exiled
        tmp="curl -L -O https://github.com/galaxy119/EXILED/releases/download/$NewVer/Exiled.tar.gz"
        $tmp
        tar -zvxf Exiled.tar.gz
        mkdir /home/container/.config/EXILED/
        mv /exiled/EXILED/* /home/container/.config/EXILED/
        if test -f /home/container/SCPSL_Data/Managed/Assembly-CSharp.dll.old; then
                rm  /home/container/SCPSL_Data/Managed/Assembly-CSharp.dll.old
        fi
        mv /home/container/SCPSL_Data/Managed/Assembly-CSharp.dll /home/container/SCPSL_Data/Managed/Assembly-CSharp.dll.old
        mv /exiled/Assembly-CSharp.dll /home/container/SCPSL_Data/Managed
        cd /
        rm -r /exiled
        cd
        echo "$NewVer" > $ThisVerFile
fi
cd
$1

