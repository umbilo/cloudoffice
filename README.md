# Overview
Nextcloud built in the cloud automatically using Terraform with Ansible. Now with optional duckdns.org/letsencrypt support!

Available for several major cloud providers, including: AWS (EC2 or Lightsail), Azure, Digital Ocean, GCP (Google), OCI (Oracle), Scaleway (scw) + standalone Raspberry Pi/Ubuntu Server deployment options.

![Diagram](cloudofficediagram.png)

# Instructions
Several deployment options are available, see the README of each subdirectory for platform-specific guides. For standalone deployments, see the playbooks/ directory.

Standalone:
- [Ubuntu](https://youtu.be/5uWyZl7ZpC4)

# Discussion
[Discord Room](https://discord.gg/TT8vrcnw6x)

# Changelog
- July 2021 - Please note, the duckdns domain feature was added (after videos were created). [duckdns.org](https://duckdns.org) is a free service to provide a domain name (that we sign with a [letsencrypt.org](https://letsencrypt.org) certificate with automatically). Though not required, duckdns is suggested for all new deployments. The certificate integrates better with Nextcloud and OnlyOffice apps and web browsers.
- October 2021 - Azure's security_group and security_group_rule resources conflict and overwrite eachother. The security_group_rule(s) have been put in security_group as inline.
