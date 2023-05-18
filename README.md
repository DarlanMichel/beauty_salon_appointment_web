# Beauty Salon Appointment Web
Este projeto é uma aplicação web para manutenção de um salão de beleza.

#

<img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=GREEN&style=for-the-badge"/>

#

## Tecnologias usadas
- Dart, Flutter
- Bloc - é um dos gerenciadores de estado que cumpre muito bem com o seu propósito, apesar de ser um pouco mais complexo que os demais ele mantém o código mais organizado, manutenível e limpo.
- Modular - é um gerencidor de rotas que também faz injeção de dependencias o que ajuda na manutenibilidade do código. Além de ser mantido pela comunidade da Flutterando, o que poderia manter a frequência de atualizações da biblioteca.
- Hasura - é uma engine de GraphQL que faz comunicação direta com um banco de dados Postgress, essa ferramenta possui uma boa segurança na autenticação e gerenciamento de regras dos usuários. Porém utlizaria um backend próprio o que traria maior segurança no tráfego de dados e regras de negócio.
- Dartz - é uma biblioteca para tratamento de erros. Com a atualização para o Dart 3, agora isso é possivel fazer nativamente. 
- Clean Arch - é uma arquitetura mais complexa que as demais, mas o deixa o código muito mais manutenível e fácil de encontrar erros. Para projetos menores como este um MVC seria suficiente, mas apliquei para questões de estudo e pensando na escalabilidade do mesmo.
- Cloudinary - é um storage de imagens, ele tem um tamanho limitado por isso utilizaria um banco de dados próprio pois a longo prazo seria necessario mais armazenamento.
- Responsividade - como é um projeto web, ele precisa ser adaptável a todos os tamanhos de tela.

## Como usar a aplicação
A aplicação web contém uma tela para cadastro e manutenção de categorias de serviços.

Após a criação das categorias é possivel cadastrar ou editar os serviços que serão elaborados pelos colaboradores do salão.

Quando tiver os serviços cadastrados é possivel cadastrar o colaborador com quais serviços ele presta e quais os horários disponíveis.

Outras funcionalidades a ser implementadas...

## Prints de algumas telas

[<img src="images/tela_categoria.jpg" width="800"/>](images/tela_categoria.jpg)
[<img src="images/tela_servico.jpg" width="800"/>](images/tela_servico.jpg)
[<img src="images/tela_colaborador.jpg" width="800"/>](images/tela_colaborador.jpg)
