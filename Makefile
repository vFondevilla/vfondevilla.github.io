test:
	docker run -t --rm -v "$PWD":/usr/src/app -p "4000:4000" starefossen/github-pages

stop:
	docker stop $(docker ps | grep github-pages | awk '{print $1}')
