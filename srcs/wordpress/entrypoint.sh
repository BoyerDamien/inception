#! /bin/ash

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
	chown -R www:www /var/www/wordpress
	wp user create bob bob@example.com --role=author --user_pass=bob --path=/var/www/wordpress
	wp user create tom tom@example.com --role=author --user_pass=tom --path=/var/www/wordpress
fi

php-fpm7 -F