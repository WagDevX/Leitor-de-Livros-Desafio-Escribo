# Desafio Escribo

Resolução do segundo desafio proposto para vaga na Escribo Inovação e Aprendizado.

Desenvolvimento de um aplicativo para leitura de eBooks que ofereça uma experiência interativa e fácil de usar para os usuários. O aplicativo é capaz de baixar uma lista de livros e suas capas, exibindo as capas em uma estante virtual, permitindo o download de livros e a leitura dos mesmos utilizando o Vocsy Epub Viewer.

## Aprendizados

Foi a primeira vez aplicando Clean Architecture em um projeto e apesar da falha tentativa de desenvolver seguindo TDD (Test Driven Development) pelo limite de tempo para entrega, pude aprimorar vários conceitos, sendo eles; Testes, Solid, TDD, etc;

Pude aprimoar também o entendimento e a importância de gerenciadores de estado juntamente com um projeto estruturado seguindo um padrão específico.

## Arquitetura

Aqui é onde foi o meu maior foco.

Seguindo os princípios SOLID, desenvolvi o aplicativo utilizando Clean Architecture. Do qual se divide em três principais layers, Domain, Data e Presentation.

Domain é onde se encontra as regras de negócio do aplicativo, ditando os contratos dos repositórios, entidades e casos de uso.

Seguido pelo Data Layer que onde se encontra a implementação dos repositórios definidos no Domain Layer, assim como a implementação de classes para efetivamente se conectar com fontes externas para obter os dados necessários seguindo a lógica definida acima.

Por último de não menos importante, o Presentation Layer onde se encontra as views(Telas de fato), alguns Widgets necessários e o BLOC - Utilizado para conectar todos os layers e prover eventos, estados e dados para as Views.

## Rodando localmente

Clone o projeto

```bash
  git clone https://github.com/WagDevX/Leitor-de-Livros-Desafio-Escribo
```

Entre no diretório do projeto

```bash
  cd Desafio-Escribo
```

Instale as dependências

```bash
  flutter pub get
```

Inicie o servidor

```bash
  flutter run
```

## Rodando os testes

Atualmente há 18 testes para os layers Data e Domain - e alguns para o Bloc

Para rodar os testes, rode o seguinte comando

```bash
  flutter run test
```
