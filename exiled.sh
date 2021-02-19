#!/bin/bash
steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update 996560 +quit
NewVer=$(curl https://api.github.com/repositories/231269519/tags?per_page=1 | grep -n "name"|cut -c2-| grep -o '[0-9].[0-9].[0-9]')
NewVer="2.2.4"
mono = "bab758d1eb35ccaf68bf599a471fe58379a3e627  Mono.Posix.dll"
multi = "fd51a13dcc129d720ba23f9c8f693b25d4f5c9eb  MultiAdmin.exe"
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
                tmp="curl -L -O https://github.com/Exiled-Team/EXILED/releases/download/$NewVer/Exiled.tar.gz"
                $tmp
                tar -zvxf Exiled.tar.gz
                cd
                mkdir .config/EXILED/Plugins
                mv exiled/EXILED/Exiled.Loader.dll .config/EXILED
                mv exiled/EXILED/Plugins/Exiled.Events.dll .config/EXILED/Plugins
                mv exiled/EXILED/Plugins/Exiled.Permissions.dll .config/EXILED/Plugins
                mv exiled/EXILED/Plugins/Exiled.Updater.dll .config/EXILED/Plugins

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
        tmp="curl -L -O https://github.com/Exiled-Team/EXILED/releases/download/$NewVer/Exiled.tar.gz"
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
if shasum Mono.Posix.dll == $mono; then
        echo "Gucci"
else
        curl -L -O https://github.com/Bright1337/SCPSLstart/releases/download/1.1.1/Mono.Posix.dll
fi
if shasum MultiAdmin.exe == $multi; then
        echo "Gucci"
else
        curl -L -O https://github.com/Bright1337/SCPSLstart/releases/download/1.1.1/MultiAdmin.exe
fi
cd

