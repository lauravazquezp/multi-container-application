db-start:
	@echo "Starting MongoDB..."
	brew services start mongodb-community

db-stop:
	@echo "Stopping MongoDB..."
	brew services stop mongodb-community

db-status:
	brew services list | grep mongodb

install:
	npm install

run:
	@echo "Starting the Todo API with nodemon..."
	npm run dev

clean:
	rm -rf node_modules
	npm install
