Container Solutions Assignment
------------------------------

### How to run / evaluate:

    If you'd like to see it running quickly, this project is running
    on digital ocean here: http://simpleapp.oliver.codes/

1. Install docker and docker-compose: http://docs.docker.com/compose/install/

2. Edit docker-compose.yml and set the DOMAIN environment variable to your docker
host's IP or a domain that resolves to that IP:

3. Then inside this directory run:

        docker-compose build   # this could a while take 10-15 minutes
        docker-compose up -d
        docker-compose scale backend=3

You will now have:
  * 3 containers running a simple rails application
  * 1 container running hipache & redis
  * 1 container running postgres

Try creating an account and logging in. You'll notice that the backend identifier
at the top right is changing. Refresh a few times to see it switch between the
backends. Even though the page is being served from different backends, you are
still logged in.

This works because the session is stored in an encrypted cookie.

### Goals / step plan

- [X] Make a simple_rails_app with a login screen
- [X] Give it a Dockerfile make sure it builds and that people can log in
- [X] Using docker_compose to scale the rails app up to 3 containers
- [X] Make sure SSO works.
- [X] Add a frontend loadbalancer so I can demo without port number switching

**Stretch goals**

- [ ] Add a totally different containerized rails app (discourse)
- [ ] Make SSO work in that case too

### Research / Resources used:

Things I read and used while working on this assignment:

* https://robots.thoughtbot.com/rails-on-docker
* http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
* http://www.centurylinklabs.com/auto-loadbalancing-with-fig-haproxy-and-serf/
* http://stackoverflow.com/questions/21783016/how-does-rails-devise-handle-cookie-sessions
* http://stackoverflow.com/questions/21491464/sessions-made-sense-to-me-before-i-started-reading-about-them-online/21491657#21491657
* https://github.com/Turistforeningen/hipache

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

  ~~Fast, easy to set up, also have some experience with this so seemed like a good
  choice as a session sharing backend~~

  Didn't need any session sharing in the end, relied on Rail's storing the
  session in a cookie.

* **hipache:**

  I needed a frontend if I'm going to have multiple containers serving one app.
  I wanted the demo to work seemlessly, and not have to show that SSO works by
  switching between url's with different port numbers.

* **Not CoreOS or Kubernetes:**

  I have played around with CoreOS, and also messed around with Google Container
  engine, but I felt it would be outside the scope of this assignment. I like
  to have as much of the configuration / setup as just runable code, that also
  works locally for development, and that would mean adding a Vagrant to the mix
  so I can up/down a CoreOS cluster.