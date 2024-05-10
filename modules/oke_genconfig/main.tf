resource "null_resource" "exec_create_kubeconfig" {
  # Gatilho para que o script seja executado sempre que alguma variável de entrada for alterada
  triggers = {
    timestamp = timestamp()
  }

  # Executa o script
  provisioner "local-exec" {
    command = <<-EOT
      if [ ! -d ".kube" ]; then
        mkdir .kube
      fi

      if [ ! -f ".kube/config" ]; then
        > .kube/config
      fi

      oci ce cluster create-kubeconfig \
      --cluster-id $(terraform output -json oke_cluster | jq -r '.id' | sed '/ˆ$/d') \
      --file "./.kube/config" \
      --region $(cat variables.tf | grep -A2 region | grep default | sed 's/\ \ default\ \=\ \"//g' | sed 's/"//g') \
      --token-version 2.0.0 \
      --kube-endpoint PUBLIC_ENDPOINT
    EOT
  }
}
