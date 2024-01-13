build:
	docker-compose -f docker-compose.yml build

up:
	docker-compose -f docker-compose.yml up --remove-orphans

down:
	docker-compose -f docker-compose.yml down

lint:
	docker-compose -f docker-compose.yml run --rm app sh -c flake8 --remove-orphans

test:
	docker-compose -f docker-compose.yml run --rm app sh -c "python manage.py test" -v 3 --remove-orphans

dbup:
	docker-compose -f docker-compose.yml run --rm app sh -c "python manage.py wait_for_db"

dbupflake:
	docker-compose -f docker-compose.yml run --rm app sh -c "python manage.py wait_for_db && flake8"

startproject:
	docker-compose -f docker-compose.yml run --rm  app sh -c "django-admin startproject app ." --remove-orphans