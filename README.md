# oci-custom-oke

Repositório com código de exemplo: Criando um cluster Kubernetes (OKE) com discos personalizados e ingress controller na OCI apenas com o Terraform

Recursos a serem criados:

Cluster: oke-cluster-01, este será o o Control Plane.

- Node Pool: oke-node-pools-01, este node pool virá com chaves SSH e discos customizados para atender às necessidades específicas do nosso projeto.
- .kube/config: Criado de forma automatizada pelo Terraform, este arquivo será fundamental para o provedor "kubernete" interagir com nosso cluster.
- Namespace: Para uma organização mais eficiente, vamos criar o namespace ingress-controller, gerenciado diretamente pelo Terraform.
- Ingress Controller: Implementaremos dois ingress controllers, um privado e outro público, denominados nginx-ext-ingress-ctrl-1, ambos provisionados via Terraform.

Arquivos que devem ser obrigatoriamente configurados:

- modules/oke/data.tf -> Inserir ID do Tenancy.
- modules/oke/variables.tf -> Inserir ID do compartment, vcn e subnet.
- modules/oke_ingress_controller/external-ingress-controller.yaml -> Inserir ID da subnet.
- modules/oke_ingress_controller/internal-ingress-controller.yaml -> Inserir ID da subnet.
- modules/oke/ssh-public-key.pub -> Deve ser gerado a chave SSH para os nós.

Estrutura: 

oci-custom-oke/.kube ### Diretório de config do kubectl.

oci-custom-oke/.kube/config ### Arquivo com o config que é gerado para o terraform conectar ao cluster.

oci-custom-oke/backend.tf ### Local do tfstate.

oci-custom-oke/main.tf ### Definição de providers e modulos.

oci-custom-oke/outputs.tf ### Nesse output é declarado o output de todos os modulos.

oci-custom-oke/variables.tf ### Variáveis declaradas e usadas no main.tf principal.

oci-custom-oke/versions.tf ### Define as versões dos providers.

oci-custom-oke/modules ### Diretório com os módulos.

modules/oke ### Modulo que cria o OKE (Cluster e Node Pool).

modules/oke/bootstrap ### Script de inicialização. Expande o boot volume.

modules/oke/data.tf ### Arquivo com datasources.

modules/oke/oke-cluster-01.tf ### Arquivo com a declaração do cluster.

modules/oke/oke-node-pool-01.tf ### Arquivo com a declaração do cluster.

modules/oke/outputs.tf ### Dados do cluster que serão exportados.

modules/oke/ssh-public-key.pub ### Chave SSH pública dos nós.

modules/oke/variables.tf ### Variáveis declaradas.

modules/oke_genconfig ### Modulo que gera o config para o kubectl.

modules/oke_genconfig/main.tf ### Script que gera o config.

modules/oke_ingress_controller ### Modulo que cria os ingress controllers via helm.

modules/oke_ingress_controllerdata.tf ### Arquivo com datasources.

modules/oke_ingress_controllerexternal-ingress-controller.yaml ### Yaml do LB externo.

modules/oke_ingress_controllerhelm.tf ### Declaração para execução do helm.

modules/oke_ingress_controllerinternal-ingress-controller.yaml ### Yaml do LB interno.

modules/oke_namespace ### Modulo que cria o namespace.

modules/oke_namespace/data.tf ### Arquivo com datasources.

modules/oke_namespace/oke-namespace.tf ### Declaração dos namespace

modules/oke_namespace/outputs.tf # Dados do namespace que serão exportados.