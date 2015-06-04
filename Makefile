LANG=de

vagrant-halt:
	@vagrant halt

vagrant-suspend:
	@vagrant suspend

vagrant-destroy:
	@vagrant destroy -f

vagrant-up:
	@vagrant up

vagrant:
	@vagrant plugin install vagrant-hostsupdater
	@vagrant up
	@echo 'Please run "sudo make domains" in order to access db.freedomvote.vm'

vagrant-restart: vagrant-destroy vagrant-up

vagrant-restart-services:
	@vagrant ssh -c 'sudo service apache2 restart'
	@vagrant ssh -c 'sudo service postgresql restart'

vagrant-runserver:
	@vagrant ssh -c 'cd /vagrant/app && sudo python manage.py runserver 0.0.0.0:8000'

vagrant-makemessages:
	@vagrant ssh -c 'cd /vagrant/app && sudo python manage.py makemessages -l ${LANG}'

vagrant-migrate:
	@vagrant ssh -c 'cd /vagrant/app && sudo python manage.py migrate'

vagrant-compilemessages:
	@vagrant ssh -c 'cd /vagrant/app && sudo python manage.py compilemessages'

vagrant-collectstatic:
	@vagrant ssh -c 'cd /vagrant/app && sudo python manage.py collectstatic'
	@vagrant ssh -c 'cd /vagrant/app && sudo python manage.py collectstatic_js_reverse'

vagrant-collectstatic-dev:
	@vagrant ssh -c 'cd /vagrant/app && sudo python manage.py collectstatic_js_reverse'
	@vagrant ssh -c 'rm -rf /vagrant/app/core/static/django_js_reverse'
	@vagrant ssh -c 'mv /vagrant/app/static/django_js_reverse/ /vagrant/app/core/static/django_js_reverse'
