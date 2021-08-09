#! /bin/ash

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
    check_null "$DB_USER" "DB_USER env is not set"
    check_null "$URL" "ADMIN_MAIL env is not set"
    check_null "$DB_NAME" "DB_NAME env is not set"
    check_null "$DB_HOST" "DB_HOST env is not set"
    check_null "$DB_PASSWORD" "DB_PASSWORD env is not set"
    check_null "$ADMIN_USER" "ADMIN_USER env is not set"
    check_null "$ADMIN_PASSWORD" "ADMIN_PASSWORD env is not set"
    check_null "$ADMIN_MAIL" "ADMIN_MAIL env is not set"
}

check_env
if [ ! -f /var/www/wordpress/wp-config.php ];
then
	wp core download    --path=/var/www/wordpress
	wp config create    --dbuser=$DB_USER \
		--dbname=$DB_NAME \
		--dbhost=$DB_HOST \
		--dbpass=$DB_PASSWORD \
		--path=/var/www/wordpress
	
	wp core install --path=/var/www/wordpress\
		--url=$URL\
		--title=Inception\
		--admin_user=$ADMIN_USER\
		--admin_password=$ADMIN_PASSWORD\
		--admin_email=$ADMIN_MAIL
	chown -R www:www /var/www/
	wp user create bob bob@example.com --role=author --user_pass=bob --path=/var/www/wordpress
fi

php-fpm7 -F
