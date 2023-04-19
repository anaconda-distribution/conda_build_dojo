build:
	docker build --network=host -t dojo_anaconda-pkg-build .

run:
	docker run -it --mount 'src=${AGGREGATE_PATH},target=/home/,type=bind' dojo_anaconda-pkg-build
