test-docker-ruby-2.6:
	docker build -f test/docker/ruby-2.6/Dockerfile -t rogue-craft-server-2.6  . \
	&& docker run --rm rogue-craft-server-2.6 bundle install && GENERATE_COVERAGE=1 bundle exec rake test
