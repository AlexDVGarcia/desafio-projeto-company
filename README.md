<h1>desafio-projeto-company<br>
Formação Power BI Company e Azure</h1>
<span>
Descrição do desafio módulo 3 – Processamento de Dados Simplificado com Power BI</span>

1.	Criação de uma instância na Azure para MySQL
mysql -h desafio-projeto-company.mysql.database.azure.com -u adm -p
Senha: Alg8212%
Show databases;
create database if not exists azure_company;

Usei os códigos passados no projeto, mas fiz algumas correções:
•	Adicionei o tamanho dos campos char para Minit, Sex e Mgr_ssn.
•	Corrigi o nome da tabela "departament" para "department" nas referências a chaves estrangeiras.
•	Corrigi o nome da tabela referenciada nas chaves estrangeiras para "department".
•	Substituí "desc" por "DESCRIBE" nas verificações de esquema.

2.	Criar o Banco de dados com base disponível no github
   
3.	Integração do Power BI com MySQL no Azure
   
4.	Verificar problemas na base a fim de realizar a transformação dos dados

  	<h2>Diretrizes para transformação dos dados</h2>

<b>Verifique os cabeçalhos e tipos de dados</b><br>

<b>Modifique os valores monetários para o tipo double preciso</b><br>
Alterei para “Número fixo decimal”

<b>Verifique a existência dos nulos e analise a remoção.</b><br>
Removi as colunas que estavam com todos os valores nas linhas como “Value” e “Table”.

<b>Os employees com nulos em Super_ssn podem ser os gerentes. Verifique se há algum colaborador sem gerente</b><br>
Existe apenas 1 colaborador “James E Borg”.

<b>Verifique se há algum departamento sem gerente</b><br>
Não Existe departamento sem gerente

<b>Se houver departamento sem gerente, suponha que você possui os dados e preencha as lacunas.</b><br>
Não se aplica

<b>Verifique o número de horas dos projetos</b><br>
Criei uma medida e transformei os números decimais em horas no formato HH:MM:SS.
Criei uma medida e trouxe as horas em um cartão no formato HH:MM:SS.
 
<b>Separar colunas complexas.</b><br>
Realizei a divisão da coluna Address na tabela em Employee.

<b>Mesclar consultas employee e departament para criar uma tabela employee com o nome dos departamentos associados aos colaboradores. A mescla terá como base a tabela employee. Fique atento, essa informação influencia no tipo de junção.</b><br>
Utilizei a função Mesclar Consultas Como Nova e peguei o nome do colaborador e o nome do departamento para realizar a junção.
Neste processo elimine as colunas desnecessárias. 
Exclui as colunas da tabela Employee, ficando apenas com Nome do colaborador. Ao expandir a planilha Department desmarquei as colunas desnecessárias, ficando apenas com nome do departamento.
 
<b>Realize a junção dos colaboradores e respectivos nomes dos gerentes . Isso pode ser feito com consulta SQL ou pela mescla de tabelas com Power BI. Caso utilize SQL, especifique no README a query utilizada no processo.</b><br>
Usei novamente Mesclar Consulta, através do Mgr.ssn encontrei o nome do gerente, trazendo da tabela Employee.
Alterei o nome de employee.Name para department.Mgr_Name.

<b>Mescle as colunas de Nome e Sobrenome para ter apenas uma coluna definindo os nomes dos colaboradores.</b><br>
Em Adicionar coluna mesclei o nome com espaço e criei o campo “Name”.

<b>Mescle os nomes de departamentos e localização. Isso fará que cada combinação departamento-local seja único. Isso irá auxiliar na criação do modelo estrela em um módulo futuro.</b><br>
 Realizei através do Power Query, podendo ser realizado através do SQL, o código seria:
SELECT d.Dnumber, d.Dname, dl.Dlocation
FROM department AS d
INNER JOIN dept_locations AS dl ON d.Dnumber = dl.Dnumber;

<b>Explique por que, neste caso supracitado, podemos apenas utilizar o mesclar e não o atribuir. </b><br>
A operação de mesclar permite combinar duas ou mais tabelas com base em colunas de identificação presente nas duas. Sendo semelhante ao JOIN, utiliza a tabela origem para puxar as informações adicionais de outra tabela relacionando a coluna em comum, conforme dito anteriormente.
O Acrescentar Consultas junta os dados de duas ou mais tabelas gerando apenas uma com todos os dados das duas tabelas.
Sendo assim, faz sentido mesclarmos, pois queremos acrescentar mais informações e temos a coluna Dnumb para relacionar entre as duas colunas.  

<b>Agrupe os dados a fim de saber quantos colaboradores existem por gerente.
Elimine as colunas desnecessárias, que não serão usadas no relatório, de cada tabela</b>

<b>BONUS</b><br>
Criei a relação entre Data.Essn da tabela dependent com Ssn da tabela employee.

Dividi a coluna Address na tabela em Employee.
