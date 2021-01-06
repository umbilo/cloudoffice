output "cloudblock-output" {
  value = <<OUTPUT

  #############
  ## OUTPUTS ##
  #############

  ## SSH ##
  ssh ubuntu@${digitalocean_floating_ip.nc-ip.ip_address}

  ## WebUI ##
  https://${digitalocean_floating_ip.nc-ip.ip_address}:${var.web_port}/

  ## Update Containers / Ansible Rerun Instructions ##
  ssh ubuntu@${digitalocean_floating_ip.nc-ip.ip_address}

  # If updating containers, remove the old containers - this brings down the service until ansible is re-applied.
  sudo docker rm -f nextcloud_application nextcloud_database nextcloud_webproxy nextcloud_storagegw

  # Update project
  cd /opt/git/nextcloud/
  sudo git pull

  # Re-apply Ansible playbook with custom variables
  cd playbooks/
  ansible-playbook nextcloud_do.yml --extra-vars 'docker_network=${var.docker_network} docker_gw=${var.docker_gw} docker_nextcloud=${var.docker_nextcloud} docker_db=${var.docker_db} docker_webproxy=${var.docker_webproxy} docker_storagegw=${var.docker_storagegw} nc_prefix=${var.nc_prefix} nc_suffix=${random_string.nc-random.result} do_storageaccessid=${var.do_storageaccessid} do_storagesecretkey=${var.do_storagesecretkey} do_region=${var.do_region} instance_public_ip=${digitalocean_floating_ip.nc-ip.ip_address} web_port=${var.web_port} project_directory=${var.project_directory} admin_password=${var.admin_password} db_password=${var.db_password}'
  OUTPUT
}