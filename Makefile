# note: call scripts from /scripts
SHELL := /bin/bash

.PHONY: plan apply destroy output

plan:
	pwsh ./scripts/tg.ps1 plan

apply:
	pwsh ./scripts/tg.ps1 apply

destroy:
	pwsh ./scripts/tg.ps1 destroy

output:
	pwsh ./scripts/tg.ps1 output

