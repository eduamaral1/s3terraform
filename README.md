# S3 bucket com Terraform

Automatizando a criação de S3 Bucket com Terraform:

O código acima começa com a definição do provedor AWS e, em seguida, define o recurso aws_s3_bucket para criar um bucket S3 na região us-east-1 com a ACL privada e tags nomeando o bucket.

A seguir definimos o recurso aws_s3_bucket_lifecycle_configurationque é usado para definir um conjunto de regras para gerenciar objetos no bucket S3 ao longo do tempo.

A regra inclui a definição de um prefixo, que especifica o objeto ao qual a regra se aplica, e as ações a serem executadas após um determinado período. No exemplo, o conjunto de regras inclui duas transições: uma transição para o armazenamento do tipo STANDARD_IA após 30 dias e uma transição para o armazenamento do tipo GLACIER após 60 dias. O conjunto de regras também inclui uma ação de expiração para remover o objeto após 90 dias.

Além disso, o recurso aws_s3_bucket_object é usado para enviar um objeto para o bucket S3. Quando o objeto é enviado, o conjunto de regras definido em aws_s3_bucket_lifecycle_configuration será aplicado e o objeto será gerenciado de acordo com as regras.

Por fim, o recurso aws_s3_bucket_policy define uma política de acesso ao bucket que nega todas as ações no bucket S3, exceto aquelas que são realizadas em conexões seguras (HTTPS). Isso ajuda a proteger o bucket S3 contra acesso não autorizado e possíveis violações de segurança.

Segue o artigo no medium com mais explicações: 
