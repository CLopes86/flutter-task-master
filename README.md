# 📱 Task Master

<div align="center">
  
  ![Flutter](https://img.shields.io/badge/Flutter-3.24-02569B?logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-3.5-0175C2?logo=dart&logoColor=white)
  ![License](https://img.shields.io/badge/License-MIT-green.svg)
  ![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey)
  ![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)
  
  <h3>Um aplicativo moderno e minimalista para gerenciamento de tarefas</h3>
  
  [Features](#-features) •
  [Screenshots](#-screenshots) •
  [Instalação](#-instalação) •
  [Tecnologias](#-tecnologias) •
  [Contribuindo](#-contribuindo) •
  [Licença](#-licença)
  
</div>

---

## 📖 Sobre o Projeto

**Task Master** é um aplicativo de gerenciamento de tarefas desenvolvido com Flutter, focado em simplicidade e eficiência. Este projeto foi criado com o objetivo de demonstrar boas práticas de desenvolvimento mobile, arquitetura limpa e design de interface intuitivo.

### 🎯 Objetivos do Projeto

- Demonstrar proficiência em Flutter e Dart
- Implementar arquitetura limpa e escalável
- Aplicar princípios SOLID e boas práticas
- Criar uma UI/UX moderna e responsiva
- Documentar o processo de desenvolvimento

## ✨ Features

### 🚀 Implementadas
- ✅ **CRUD Completo** - Criar, ler, atualizar e deletar tarefas
- ✅ **Interface Responsiva** - Adaptada para diferentes tamanhos de tela
- ✅ **Persistência Local** - Dados salvos no dispositivo
- ✅ **Filtros Inteligentes** - Filtrar por status, prioridade e data
- ✅ **Busca Rápida** - Encontre tarefas instantaneamente
- ✅ **Swipe Actions** - Ações rápidas com gestos
- ✅ **Animações Suaves** - Transições fluidas e agradáveis

### 🔜 Próximas Features
- 🌙 Tema escuro/claro
- 🔔 Notificações e lembretes
- 📊 Dashboard com estatísticas
- ☁️ Sincronização com nuvem
- 🏷️ Tags e categorias personalizadas
- 📱 Widget para tela inicial
- 🌍 Internacionalização (i18n)

## 📸 Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="assets/screenshots/home_light.png" width="250" alt="Home Screen"/>
        <br />
        <sub><b>Tela Inicial</b></sub>
      </td>
      <td align="center">
        <img src="assets/screenshots/add_task.png" width="250" alt="Add Task"/>
        <br />
        <sub><b>Adicionar Tarefa</b></sub>
      </td>
      <td align="center">
        <img src="assets/screenshots/task_details.png" width="250" alt="Task Details"/>
        <br />
        <sub><b>Detalhes da Tarefa</b></sub>
      </td>
    </tr>
    <tr>
      <td align="center">
        <img src="assets/screenshots/filters.png" width="250" alt="Filters"/>
        <br />
        <sub><b>Filtros</b></sub>
      </td>
      <td align="center">
        <img src="assets/screenshots/statistics.png" width="250" alt="Statistics"/>
        <br />
        <sub><b>Estatísticas</b></sub>
      </td>
      <td align="center">
        <img src="assets/screenshots/settings.png" width="250" alt="Settings"/>
        <br />
        <sub><b>Configurações</b></sub>
      </td>
    </tr>
  </table>
</div>

## 🏗️ Arquitetura

O projeto segue os princípios da **Clean Architecture**, garantindo separação de responsabilidades e facilidade de manutenção:
```
lib/
├── core/                      # Núcleo da aplicação
│   ├── constants/            # Constantes e configurações
│   │   ├── app_colors.dart   # Paleta de cores
│   │   ├── app_strings.dart  # Strings da aplicação
│   │   └── app_themes.dart   # Temas do app
│   ├── errors/               # Tratamento de erros
│   │   └── failures.dart     # Classes de falha
│   └── utils/                # Utilitários
│       ├── date_formatter.dart
│       └── validators.dart
│
├── features/                  # Funcionalidades do app
│   └── tasks/                # Feature de tarefas
│       ├── data/             # Camada de dados
│       │   ├── datasources/  # Fontes de dados
│       │   ├── models/       # Modelos de dados
│       │   └── repositories/ # Implementação dos repositórios
│       ├── domain/           # Camada de domínio
│       │   ├── entities/     # Entidades de negócio
│       │   ├── repositories/ # Contratos dos repositórios
│       │   └── usecases/     # Casos de uso
│       └── presentation/     # Camada de apresentação
│           ├── pages/        # Telas do app
│           ├── widgets/      # Widgets customizados
│           └── providers/    # Gerenciamento de estado
│
├── shared/                    # Compartilhado
│   └── widgets/              # Widgets reutilizáveis
│
└── main.dart                  # Ponto de entrada
```

## 🛠️ Tecnologias

### Core
- **[Flutter](https://flutter.dev/)** - Framework de desenvolvimento multiplataforma
- **[Dart](https://dart.dev/)** - Linguagem de programação

### Gerenciamento de Estado
- **[Provider](https://pub.dev/packages/provider)** - Gerenciamento de estado reativo
- **[Flutter Hooks](https://pub.dev/packages/flutter_hooks)** - Hooks para Flutter (opcional)

### Armazenamento Local
- **[Shared Preferences](https://pub.dev/packages/shared_preferences)** - Persistência de dados simples
- **[Hive](https://pub.dev/packages/hive)** - Banco de dados NoSQL (alternativa)

### UI/UX
- **[Google Fonts](https://pub.dev/packages/google_fonts)** - Fontes personalizadas
- **[Flutter Slidable](https://pub.dev/packages/flutter_slidable)** - Ações deslizantes
- **[Lottie](https://pub.dev/packages/lottie)** - Animações complexas

### Ferramentas de Desenvolvimento
- **[Flutter Lints](https://pub.dev/packages/flutter_lints)** - Análise de código
- **[Mocktail](https://pub.dev/packages/mocktail)** - Mocks para testes

## 🚀 Instalação

### Pré-requisitos

Certifique-se de ter instalado:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.24.0 ou superior)
- [Dart SDK](https://dart.dev/get-dart) (3.5.0 ou superior)
- [Android Studio](https://developer.android.com/studio) ou [Xcode](https://developer.apple.com/xcode/) para emuladores
- [Git](https://git-scm.com/)

### Passo a Passo

1. **Clone o repositório**
```bash
git clone https://github.com/CLopes86/flutter-task-master.git
cd flutter-task-master
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o aplicativo**

Para modo debug:
```bash
flutter run
```

Para modo release:
```bash
flutter run --release
```

4. **Build do aplicativo**

Android:
```bash
flutter build apk --release
# ou para App Bundle
flutter build appbundle --release
```

iOS:
```bash
flutter build ios --release
```

## 🧪 Testes

O projeto inclui testes unitários, de widget e de integração:
```bash
# Executar todos os testes
flutter test

# Executar com coverage
flutter test --coverage

# Executar testes específicos
flutter test test/unit/
flutter test test/widget/
flutter test test/integration/
```

## 📈 Performance

O aplicativo foi otimizado para máxima performance:
- ⚡ Tempo de inicialização < 2 segundos
- 🎯 60 FPS em animações
- 💾 Uso de memória otimizado
- 🔋 Consumo eficiente de bateria

## 🤝 Contribuindo

Contribuições são sempre bem-vindas! Por favor, siga estas etapas:

1. Fork o projeto
2. Crie sua feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'feat: Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

### 📝 Convenção de Commits

Este projeto segue a convenção [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `docs:` Apenas documentação
- `style:` Formatação, ponto e vírgula, etc
- `refactor:` Refatoração de código
- `perf:` Melhoria de performance
- `test:` Adição de testes
- `chore:` Tarefas de manutenção

## 📄 Licença

Distribuído sob a licença MIT. Veja [LICENSE](LICENSE) para mais informações.

## 👨‍💻 Autor

<div align="center">
  <img src="https://github.com/CLopes86.png" width="100" style="border-radius: 50%;" alt="Cesaltino Lopes"/>
  <h3>Cesaltino Lopes</h3>
  <p>Estudante de Informática e Multimédia | Instituto Politécnico de Castelo Branco</p>
  <p>Desenvolvedor Flutter | Mobile Developer</p>
  
  [![LinkedIn](https://img.shields.io/badge/-LinkedIn-0077B5?logo=linkedin&logoColor=white)](https://www.linkedin.com/in/cesaltino-lopes)
  [![GitHub](https://img.shields.io/badge/-GitHub-181717?logo=github&logoColor=white)](https://github.com/CLopes86)
  [![Email](https://img.shields.io/badge/-Email-D14836?logo=gmail&logoColor=white)](mailto:c.lopes46cv@gmail.com)
</div>

## 🙏 Agradecimentos

- [Flutter Team](https://flutter.dev/team) pela incrível framework
- [Instituto Politécnico de Castelo Branco](https://www.ipcb.pt/) pelo suporte acadêmico
- [Pub.dev](https://pub.dev/) pelos packages incríveis
- Comunidade Flutter pelo suporte contínuo

---

<div align="center">
  <sub>Feito com ❤️ e muito ☕ por <a href="https://github.com/CLopes86">Cesaltino Lopes</a></sub>
</div>
```

## 📁 **2. LICENSE (MIT) Atualizada**
```
MIT License

Copyright (c) 2025 Cesaltino Lopes

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
