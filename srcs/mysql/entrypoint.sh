#!/bin/ash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

display_error(){
    >&2 printf "\n${RED}Error: $1${NC}\n"
}

display_info(){
    >&1 printf "\n${GREEN}$1${NC}\n"
}

check_null(){
    if [[ -z $1 ]]
    then
        display_error "$2"
        exit 1
    fi
}

check_env(){
    display_info "Checking env variables ..."
    check_null "$DB_NAME" "DB_NAME env is not set"
    check_null "$DB_USER" "DB_USER env is not set"
    check_null "$DB_PASSWORD" "DB_PASSWORD env is not set"
    check_null "$ROOT_PASSWORD" "ROOT_PASSWORD env is not set"
}


replace_template() {
    sed -i "s|{DB_USER}|$DB_USER|g" ./init.sql
    sed -i "s|{DB_PASSWORD}|$DB_PASSWORD|g" ./init.sql
    sed -i "s|{DB_NAME}|$DB_NAME|g" ./init.sql
    cat ./init.sql
    mysql -u root < ./init.sql
}

install_db() {
    mysqladmin proc stat
    while [[ $? == 1 ]]; do sleep 1 && mysqladmin proc stat; done

    pgrep -f "mysqld_safe"

    mysqladmin -u root password $ROOT_PASSWORD && \
    mysqladmin -u root create $DB_NAME && \
    replace_template
}


main() {

    check_env
    
    if [[ ! -d /var/lib/mysql/mysql ]]
    then
        display_info "No database detected. Proceed to installation..."
        mysql_install_db --user=root --datadir=/var/lib/mysql
        install_db &
    fi

    mysqld_safe --defaults-file=/etc/mysql/my.cnf
}

main
