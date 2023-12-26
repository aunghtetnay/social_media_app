#!/bin/bash
echo "Run Migration"
php artisan migrate --force 
echo "Run Cache and config clear" 
php artisan cache:clear  && php artisan config:clear && php artisan config:cache

exec "$@"
