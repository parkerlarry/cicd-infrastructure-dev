jenkins-up:
	if [ -e "jenkins" ]; then \
		cd jenkins; vagrant reload; \
	else \
		git clone git@github.com:parkerlarry/jenkins; \
		openssl req -x509 -newkey rsa:4096 \
		-sha256 -days 3650 -nodes \
		-subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
		-keyout jenkins/certs/privkey.pem -out jenkins/certs/fullchain.pem; \
		cd jenkins; vagrant up; \
	fi

jenkins-down:
	cd jenkins; vagrant halt

jenkins-destroy:
	cd jenkins; vagrant destroy -f;
	rm -rf jenkins

vagrant-up: jenkins-up
vagrant-down: jenkins-down
vagrant-destroy: jenkins-destroy
