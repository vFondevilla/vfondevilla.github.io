test:
	docker run -ti --rm -v $(shell pwd):/usr/src/app -p "4000:4000" starefossen/github-pages


stop:
	docker stop $(docker ps | grep github-pages | awk '{print $1}')
