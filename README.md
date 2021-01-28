# samba-server1

This Alpine Linux container publish a samba server with an authentication mounted on another samba remote server


## Enviromment variables Groups:

**SMB_USER, SMB_PASS, SMB_SHARE** refers to the credentials and share name to expose, SMB_USER always must be root

**SMB_USER_REMOTE, SMB_PASS_REMOTE, DOMAIN, SERVER, SHARE_NAME** refers to the required information to connect the remote share within the container


## yml example:

    version: '3.6'
    services:
      smb_server1:
        image: tamuxx/samba-server1
        container_name: smb_server1
        restart: always
        hostname: smb_server1
        cap_add:
            - ALL
        environment:
            - SMB_USER=root
            - SMB_PASS=password
            - SMB_SHARE=share_name_to_publish
            - SMB_USER_REMOTE=remote_samba_user
            - SMB_PASS_REMOTE=remota_samba_password
            - DOMAIN=remote_domain
            - SERVER=remote_server_name_or_ip
            - SHARE_NAME=remote_share_name
        ports:
            - 139
            - 445
