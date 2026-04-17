#!binbash

SCRIPT_NAME=$(basename $0)
NEW_PASSWORD=$(date +%s  sha256sum  base64  head -c 16 ; echo)

find . -type f -name wp-config.php  grep -v $SCRIPT_NAME while read file; do
    db_name=$(grep DB_NAME $file  cut -d' -f4)
    db_user=$(grep DB_USER $file  cut -d' -f4)
    db_pswd=$(grep DB_PASSWORD $file  cut -d' -f4)
#    echo -e Конфиг $filenИмя БД $db_namenИмя пользователя $db_usernПароль $db_pswdn  all_config.txt
#    echo Данные БД $db_name записаны в all_config.txt
    mysql -u$db_user -p$db_pswd $db_name -e SELECT user_pass FROM wp_users WHERE ID=1;  old.txt
    db_admin_name=$(mysql -u$db_user -p$db_pswd $db_name -e SELECT user_login FROM wp_users WHERE ID=1;)
    echo Новый пароль пользователя $db_admin_name $NEW_PASSWORD
    mysql -u$db_user -p$db_pswd $db_name -e UPDATE wp_users SET user_pass=MD5('$NEW_PASSWORD');
    echo Пароли изменены
done
