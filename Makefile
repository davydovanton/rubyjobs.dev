.PHONY: help dockerize shell

help:
	@echo 'Available targets:'
	@echo '  make dockerize'
	@echo '  make shell'

dockerize:
	docker-compose -f docker-compose.development.yml up --build

shell:
	docker-compose -f docker-compose.development.yml exec web sh
