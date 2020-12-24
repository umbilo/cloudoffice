output "cloudblock-output" {
  value = <<OUTPUT

  #############
  ## OUTPUTS ##
  #############

  ## SSH ##
  ssh ubuntu@${google_compute_address.nc-public-ip.address}

  ## WebUI ##
  https://${google_compute_address.nc-public-ip.address}

  ## Update Containers / Ansible Rerun Instructions ##
  ssh ubuntu@${google_compute_address.nc-public-ip.address}

  # If updating containers, remove the old containers - this brings down the service until ansible is re-applied.
  sudo docker rm -f nextcloud_application nextcloud_database nextcloud_webproxy

  # Update project
  cd /opt/nextcloud/
  sudo git pull

  # Re-apply Ansible playbook with custom variables
  cd playbooks/
  ansible-playbook nextcloud_gcp.yml --extra-vars 'docker_network=${var.docker_network} docker_gw=${var.docker_gw} docker_nextcloud=${var.docker_nextcloud} docker_db=${var.docker_db} docker_webproxy=${var.docker_webproxy} gcp_project_prefix=${var.nc_prefix} gcp_project_suffix=${random_string.nc-random.result} bucket_user_id=${google_storage_hmac_key.nc-service-account-hmac.access_id}'
  OUTPUT
}