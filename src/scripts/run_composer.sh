  cp .env.ci.example .env
  composer install -n --prefer-dist
  composer run key:generate
  php artisan vue-i18n:generate
  php artisan migrate --seed
  composer run jwt:generate
  echo "Composer commands is already executed."