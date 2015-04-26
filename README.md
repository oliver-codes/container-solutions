Container Solutions Assignment
------------------------------

### Goals / step plan

- [ ] Make a simple_rails_app with a login screen
- [ ] Give it a Dockerfile make sure it builds and that people can log in
- [ ] Using docker_compose to scale the rails app up to 3 containers
- [ ] Make sure SSO works.
- [ ] Add a frontend loadbalancer so I can demo without port number switching

**Stretch goals**

- [ ] Add a totally different containerized rails app (discourse)
- [ ] Make SSO work in that case too

### Research / Resources used:

Things I read and used while working on this assignment:

* https://robots.thoughtbot.com/rails-on-docker
* http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
* http://www.centurylinklabs.com/auto-loadbalancing-with-fig-haproxy-and-serf/

### Technologies chosen and reasoning

* **docker-compose:**

  I want to be able to quickly stop and start the whole thing and to share this
  project easily. Configuration as code.

* **rails:**

  It's in my comfort zone, so for the purposes of this assignment it will let me
  focus on implementing the SSO aspect and not troubleshooting the framework too
  much.

* **postgres:**

  Just my favorite database to use with rails.

* **redis:**

  Fast, easy to set up, also have some experience with this so seemed like a good
  choice as a session sharing backend

* **hipache:**

  I needed a frontend if I'm going to have multiple containers serving one app.
  I wanted the demo to work seemlessly, and not have to show that SSO works by
  switching between url's with different port numbers.
  Hipache seemed like a natural choice since I also already have redis in my stack

* **Not CoreOS or Kubernetes:**

  I have played around with CoreOS, and also messed around with Google Container
  engine, but I felt it would be outside the scope of this assignment. I like
  to have as much of the configuration / setup as just runable code, that also
  works locally for development, and that would mean adding a Vagrant to the mix
  so I can up/down a CoreOS cluster.