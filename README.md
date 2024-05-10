# oci-custom-oke
Repositório com código de exemplo para deploy do OKE.

Estrutura: 

oci-oke-01
├── .kube ### Diretório de config do kubectl.
│   └── config ### Arquivo com o config que é gerado para o terraform conectar ao cluster.
├── backend.tf ### Local do tfstate.
├── main.tf ### Definição de providers e modulos.
├── modules ### Diretório com os módulos.
│   ├── oke ### Modulo que cria o OKE (Cluster e Node Pool).
│   │   ├── bootstrap ### Script de inicialização. Expande o boot volume.
│   │   ├── data.tf ### Arquivo com datasources.
│   │   ├── oke-cluster-01.tf ### Arquivo com a declaração do cluster.
│   │   ├── oke-node-pool-01.tf ### Arquivo com a declaração do cluster.
│   │   ├── outputs.tf ### Dados do cluster que serão exportados.
│   │   ├── ssh-public-key.pub ### Chave SSH pública dos nós.
│   │   └── variables.tf ### Variáveis declaradas.
│   ├── oke_genconfig ### Modulo que gera o config para o kubectl.
│   │   └── main.tf ### Script que gera o config.
│   ├── oke_ingress_controller ### Modulo que cria os ingress controllers via helm.
│   │   ├── data.tf ### Arquivo com datasources.
│   │   ├── external-ingress-controller.yaml ### Yaml do LB externo.
│   │   ├── helm.tf ### Declaração para execução do helm.
│   │   └── internal-ingress-controller.yaml ### Yaml do LB interno.
│   └── oke_namespace ### Modulo que cria o namespace.
│       ├── data.tf ### Arquivo com datasources.
│       ├── oke-namespace.tf ### Declaração dos namespace
│       └── outputs.tf # Dados do namespace que serão exportados.
├── outputs.tf ### Nesse output é declarado o output de todos os modulos.
├── terraform.tfstate ### tfstate local
├── variables.tf ### Variáveis declaradas e usadas no main.tf principal.
└── versions.tf ### Define as versões dos providers.
