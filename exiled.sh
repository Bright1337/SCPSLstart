#!/bin/bash
steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update 996560 +quit
NewVer=$(curl https://api.github.com/repos/galaxy119/EXILED/tags?per_page=1 | grep -n "name"|cut -c2-| grep -o '[0-9].[0-9].[0-9][0-9]')
NewVer="2.1.28"
ThisVerFile=cur.ver
ThisVer=$(cat $ThisVerFile)
if test -f "$ThisVerFile"; then
        if [[ "$ThisVer" == "$NewVer" ]]; then
                echo "Gucci"
        else
                cd .config/EXILED
                rm Exiled.Loader.dll
                cd Plugins
                rm Exiled.Events.dll
                rm Exiled.Permissions.dll
                rm Exiled.Updater.dll
                cd
                mkdir exiled
                cd exiled
                tmp="curl -L -O https://github.com/galaxy119/EXILED/releases/download/$NewVer/Exiled.tar.gz"
                $tmp
                tar -zvxf Exiled.tar.gz
                cd
                mv exiled/EXILED/* .config/EXILED/
                rsync - a exiled/EXILED/Plugins/ .config/EXILED/Plugins/
                
                if test -f SCPSL_Data/Managed/Assembly-CSharp.dll.old; then
                       rm  SCPSL_Data/Managed/Assembly-CSharp.dll.old
                fi
                mv SCPSL_Data/Managed/Assembly-CSharp.dll SCPSL_Data/Managed/Assembly-CSharp.dll.old
                mv exiled/Assembly-CSharp.dll SCPSL_Data/Managed
                rm -r exiled/
                
                echo "$NewVer" > $ThisVerFile
        fi
else
        cd
        mkdir exiled
        cd exiled
        tmp="curl -L -O https://github.com/galaxy119/EXILED/releases/download/$NewVer/Exiled.tar.gz"
        $tmp
        tar -zvxf Exiled.tar.gz
        cd
        mkdir .config
        mkdir .config/EXILED

        mv exiled/EXILED/* .config/EXILED/
        if test -f SCPSL_Data/Managed/Assembly-CSharp.dll.old; then
                rm  SCPSL_Data/Managed/Assembly-CSharp.dll.old
        fi
        mv SCPSL_Data/Managed/Assembly-CSharp.dll SCPSL_Data/Managed/Assembly-CSharp.dll.old
        mv exiled/Assembly-CSharp.dll SCPSL_Data/Managed
        rm -r exiled/
        echo "$NewVer" > $ThisVerFile
fi
cd
$1

