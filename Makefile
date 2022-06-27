CONTAINER_NAME=debian
CONTAINER=debian
#REPOSITORY="deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

clean-container:
	@docker rm -f ${CONTAINER_NAME} || true

configure-container:
	@docker run -it --name ${CONTAINER_NAME} ${CONTAINER} /bin/bash -c \
		'apt update && \
		apt install -y curl gnupg2 lsb-release software-properties-common && \
		curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
		apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
		apt update; apt install terraform && \
		terraform --version'
deploy:
	@docker exec -it ${CONTAINER_NAME} /bin/bash -c \
	'cd /home && pwd && \
	terraform init && \
	terraform apply'
destroy:
	@docker exec -it ${CONTAINER_NAME} /bin/bash -c \
	'cd /home && pwd && \
	terraform destroy'