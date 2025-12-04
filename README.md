# 💻 Cantina Tia Laís: Sistema de Gestão Administrativa

## ✨ Visão Geral do Projeto (TCC)

Este sistema foi desenvolvido como **Trabalho de Conclusão de Curso (TCC) do Curso Técnico em Informática** na Escola Técnica de Brasília.

O objetivo foi modernizar os processos de gestão administrativa de uma cantina escolar que operava de forma totalmente manual, resultando em **lentidão e imprecisão nas vendas**. A solução digitalizou o fluxo de vendas, a gestão de estoque e o cadastro de usuários e clientes, alcançando os objetivos propostos.

---

## 🎯 Módulo Principal: Gestão de Vendas e Estoque

O coração do projeto é o módulo de Vendas, que demonstra a complexidade da lógica de negócio implementada:

* **Controle de Estoque em Tempo Real:** A cada venda finalizada, o sistema realiza a baixa automática no estoque (`quantidade` da tabela `Produto`), mantendo o saldo atualizado e gerando o **Relatório de Saldo em Estoque**.
* **Rastreamento de Movimento:** O sistema registra o `Vendedor` (usuário logado) e o `Cliente` em cada transação, garantindo a rastreabilidade e o controle de acesso.
* **Segurança e Perfis de Acesso:** Implementação de um sistema de Login e perfis de usuário (`admin`, `gerente`, `funcionario`), controlando o acesso às diferentes funcionalidades (menus) através da tabela associativa `Menu_Perfil`.

## ⚙️ Habilidades de Engenharia de Software Demonstradas

Este projeto, embora construído sobre Java EE/JSP, é uma prova de minha base em Engenharia de Software e Design de Sistemas:

* **Modelagem de Dados Complexa:** Criação e implementação de um **Modelo Entidade-Relacionamento (MER)** robusto com relacionamentos *muitos-para-muitos* (`Vendas_Produto` e `Menu_Perfil`). O modelo foi projetado usando **ASTAH Community**.
* **Arquitetura de Software:** Implementação do padrão de design **MVC (Model-View-Controller)** em Java/JSP, garantindo a separação clara entre a lógica de negócio, acesso a dados (DAO) e interface do usuário.
* **UX/UI Design:** Utilização do **Figma** para a criação de protótipos de *design* e experiência do usuário (UX), garantindo uma interface funcional.

## 🛠️ Tecnologias Utilizadas

| Categoria | Tecnologia | Detalhe |
| :--- | :--- | :--- |
| **Back-End / Lógica** | **Java** e **JSP** (Java EE) | Lógica de negócio e implementação da arquitetura MVC. |
| **Banco de Dados** | **MySQL** + MySQL Workbench | Utilizado para persistência de dados. O *script* de criação está disponível no arquivo `bancofinal.sql`. |
| **Modelagem** | **ASTAH Community** | Ferramenta utilizada para desenhar o Modelo Entidade-Relacionamento (MER). |
| **Servidor / Ambiente** | **GlassFish Server 4.1.1** e **NetBeans IDE 8.2** | Servidor de aplicação e Ambiente de Desenvolvimento Integrado. |

## 🚀 Próximo Passo (Evolução)

O projeto será objeto de modernização para demonstrar proficiência em tecnologias de mercado:
* Refatoração do *Back-End* para **Spring Boot (API REST)**.
