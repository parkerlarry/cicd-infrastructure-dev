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

nexus-up:
	if [ -e "nexus" ]; then \
		cd nexus; vagrant reload; \
	else \
		git clone git@github.com:parkerlarry/nexus; \
		cd nexus; vagrant up; \
	fi

nexus-down:
	cd nexus; vagrant halt

nexus-destroy:
	cd nexus; vagrant destroy -f;
	rm -rf nexus

vagrant-up: jenkins-up nexus-up
vagrant-down: jenkins-down nexus-down
vagrant-destroy: jenkins-destroy nexus-destroy
