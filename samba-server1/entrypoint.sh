#!/bin/bash

#Si existe borrar usuario de samba creado previamente
grep '/mnt' /etc/passwd | cut -d':' -f1 | xargs -n1 deluser

#Borrar el smb.conf Original o creado previamente
rm -f /etc/samba/smb.conf

#Crear el usuario de Samba
#Por parametros vienen $SMB_USER y $SMB_PASS
USER=$SMB_USER
PASS=$SMB_PASS

echo -e "$PASS\n$PASS" | adduser -h /mnt -s /sbin/nologin $USER
#chown $USER:$USER /mnt

#Montar el smb share
/sbin/mount.cifs //$SERVER/$SHARE_NAME /mnt/ -o username=$SMB_USER_REMOTE,password=$SMB_PASS_REMOTE,dom=$DOMAIN
  
#Generar smb.conf:
echo '
[global] 
       server string = "samba_server"
       server role = standalone server
       disable netbios = yes
       smb ports = 445
['$SMB_SHARE']
       path = /mnt
       browseable = yes
       read only = no
       force create mode = 0660
       force directory mode = 2770
       valid users = '$USER'
' > /etc/samba/smb.conf 

#Generar samba user:
echo -e "$PASS\n$PASS" | smbpasswd -a $USER

#Limpiar Variables
unset USER PASS

#Correr Samba con parámetros para que quede corriendo, sino el contenedor se apaga:
exec /usr/sbin/smbd -FS --no-process-group </dev/null
