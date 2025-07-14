AZURE_MODULES_PATH=modules/azure

azure_modules=$(shell find $(AZURE_MODULES_PATH) -not -path '*/\.*' -name main.tf -exec dirname {} \;)

hclfmt: ## Format hcl files
	@terragrunt hclfmt

hclfmt-check: ## Check whether hcl files are formatted
	@printf "Performing hclfmt-check on %s...\n" $(@D)
	@terragrunt hclfmt --check

fmt: $(addsuffix /fmt,$(azure_modules)) ## Format all tf files

modules/azure/%/fmt: modules/azure/%/*.tf ## Format tf files for module
	@printf "Performing terraform fmt on %s...\n" $(@D)
	@cd $(@D); terraform fmt;

fmt-check: $(addsuffix /fmt-check,$(azure_modules)) ## Check if tf files are formatted

modules/azure/%/fmt-check: modules/azure/%/*.tf ## Check if tf files in a module are formatted
	@printf "Check if terraform files are formatted on %s...\n" $(@D)
	@cd $(@D); terraform fmt --check;

tflint: $(addsuffix /tflint,$(azure_modules)) ## Perform tflint for all modules

modules/azure/%/tflint: modules/azure/%/*.tf ## Perform tf files for module
	@printf "Performing tflint on %s...\n" $(@D)
	@cd $(@D); tflint

validate: $(addsuffix /validate,$(azure_modules)) ## Perform terraform validate for all modules

modules/azure/%/validate: modules/azure/%/*.tf ## Perform terraform validate for a module
	@printf "Performing terraform validation on %s...\n" $(@D)
	@cd $(@D); terraform init -backend=false; terraform validate;

tfdocs: $(addsuffix /tfdocs,$(azure_modules)) ## Create terraform docs for all modules

modules/azure/%/tfdocs: modules/azure/%/*.tf ## Create terraform docs for a module
	@printf "Adding tfdocs on %s...\n" $(@D)
	@cd $(@D); terraform-docs markdown table --output-file README.md --output-mode inject ./;

tfdocs-check: $(addsuffix /tfdocs-check,$(azure_modules)) ## Check if terraform docs are up-to-date

modules/azure/%/tfdocs-check: modules/azure/%/*.tf ## Check if terraform docs in a module are up-to-date
	@printf "Performing tfdocs checks on %s...\n" $(@D)
	@cd $(@D); terraform-docs markdown table --output-file README.md --output-mode inject ./ --output-check;

checkov: ## Run checkov tests
	checkov -d modules --skip-check CKV_AZURE_59,CKV_AZURE_190 --download-external-modules false

test: $(addsuffix /test,$(azure_modules)) ## Run tests for all modules

modules/azure/%/test: modules/azure/%/*.tf ## Run tests for a module
	@printf "Running terraform test for %s...\n" $(@D)
	@cd $(@D); terraform test;

go/get: ## Get all dependencies
	@cd terratest; go get ./...;

go/deps: go/get ## Install/Upgrade dependencies
	@cd terratest; go mod tidy;

go/fmt: ## Format go code
	@cd terratest; gofmt -s -w .;

%/init: ## Run terragrunt init
	@printf "Executing terragrunt %s...\n" $(@F)
	@cd $(@D); terragrunt $(@F) --non-interactive

%/plan: ## Run terragrunt plan
	@printf "Executing terragrunt %s...\n" $(@F)
	@cd $(@D); terragrunt $(@F) --non-interactive -refresh=true

%/apply: ## Run terragrunt apply
	@printf "Executing terragrunt %s...\n" $(@F)
	@cd $(@D); terragrunt $(@F) -auto-approve --non-interactive

terratest/sites/southindia/vm/pre:
	@cd terratest; go test -v ./sites/southindia/vm/pre -timeout 90m;

terratest/sites/southindia/vm/post:
	@cd terratest; go test -v ./sites/southindia/vm/post -timeout 90m;

%/output: ## Run terragrunt output
	@printf "Executing terragrunt %s...\n" $(@F)
	@cd $(@D); terragrunt output -json | jq -r 'to_entries | .[] | .key + "=" + (.value.value|tostring)' > /tmp/.env

precommit: hclfmt fmt tfdocs ## Run all formatting before committing
ci: hclfmt-check fmt-check tflint validate tfdocs-check checkov test ## Check if ci tasks are passing