.PHONY: setup
setup:
	@./scripts/setup.sh

.PHONY: az_setup
az_setup:
	@./scripts/az_setup.sh

.PHONY: teardown
teardown:
	@./scripts/teardown.sh

.PHONY: az_teardown
az_teardown:
	@./scripts/az_teardown.sh

.PHONY: codefresh-save-tfstate
codefresh-save-tfstate:
	@./scripts/codefresh-save-tfstate.sh

.PHONY: codefresh-load-tfstate
codefresh-load-tfstate:
	@./scripts/codefresh-load-tfstate.sh

.PHONY: codefresh-remove-tfstate
codefresh-remove-tfstate:
	@./scripts/codefresh-remove-tfstate.sh

.PHONY: codefresh-add-cluster
codefresh-add-cluster:
	@./scripts/codefresh-add-cluster.sh

.PHONY: setup-helm
setup-helm:
	@./scripts_helm/setup.sh

.PHONY: codefresh-save-tfstate-helm
codefresh-save-tfstate-helm:
	@./scripts_helm/codefresh-save-tfstate.sh

.PHONY: codefresh-load-tfstate-helm
codefresh-load-tfstate-helm:
	@./scripts_helm/codefresh-load-tfstate.sh

.PHONY: clean
clean:
	@git status --ignored --short | grep '^!! ' | sed 's/!! //' | xargs rm -rf