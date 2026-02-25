# local development commands
db-start:
	brew services start mongodb-community

db-stop:
	brew services stop mongodb-community

db-status:
	brew services list | grep mongodb

install:
	npm install

run:
	@echo "starting the Todo API with nodemon..."
	npm run dev

clean:
	rm -rf node_modules
	npm install

# docker commands
docker-build:
	docker compose build

docker-up:
	docker compose up -d

docker-down:
	docker compose down

docker-clean:
	docker-compose down -v
