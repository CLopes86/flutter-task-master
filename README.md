# 📱 Task Master

<div align="center">
  
  ![Flutter](https://img.shields.io/badge/Flutter-3.24-02569B?logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-3.5-0175C2?logo=dart&logoColor=white)
  ![License](https://img.shields.io/badge/License-MIT-green.svg)
  ![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey)
  ![Version](https://img.shields.io/badge/Version-1.0.0-blue)
  
  <h3>📝 Aplicação completa de gestão de tarefas com interface moderna</h3>
  
  <p>
    <a href="#sobre">Sobre</a> •
    <a href="#funcionalidades">Funcionalidades</a> •
    <a href="#screenshots">Screenshots</a> •
    <a href="#tecnologias">Tecnologias</a> •
    <a href="#arquitetura">Arquitetura</a> •
    <a href="#instalação">Instalação</a> •
    <a href="#como-usar">Como Usar</a> •
    <a href="#autor">Autor</a>
  </p>
  
</div>

---

## 📖 Sobre

**Task Master** é uma aplicação completa de gestão de tarefas desenvolvida em Flutter, focada em simplicidade, eficiência e boa experiência do utilizador. O projeto demonstra implementação de CRUD completo, persistência de dados, filtros dinâmicos e estatísticas em tempo real.

### 🎯 Objetivos do Projeto

- ✅ Praticar desenvolvimento Flutter com boas práticas
- ✅ Implementar CRUD completo com persistência de dados
- ✅ Aplicar princípios de Clean Code e arquitetura limpa
- ✅ Criar interface moderna com Material Design 3
- ✅ Desenvolver portfolio profissional

---

## ✨ Funcionalidades

### 🎉 Versão Atual (v1.0.0 - Completa)

#### 📝 Gestão de Tarefas (CRUD)
- [x] ➕ **Adicionar tarefas** - Dialog com validação de campos
- [x] 📋 **Listar tarefas** - ListView dinâmico com scroll
- [x] ✅ **Marcar como completa** - Toque simples para alternar estado
- [x] ✏️ **Editar tarefas** - Toque longo abre dialog de edição
- [x] 🗑️ **Apagar tarefas** - Swipe to delete com confirmação

#### 💾 Persistência de Dados
- [x] **SharedPreferences** - Dados salvos localmente
- [x] **Serialização JSON** - Conversão automática de objetos
- [x] **Carregamento automático** - Dados carregados ao abrir app

#### 🔍 Filtros e Visualização
- [x] **Filtro "Todas"** - Mostra todas as tarefas
- [x] **Filtro "Completas"** - Apenas tarefas concluídas
- [x] **Filtro "Incompletas"** - Apenas tarefas pendentes
- [x] **Visual feedback** - Botões com estado selecionado

#### 📊 Estatísticas em Tempo Real
- [x] **Contador de tarefas** - Total, completas e incompletas
- [x] **Percentagem de conclusão** - Cálculo automático
- [x] **Barra de progresso** - Visualização gráfica do progresso
- [x] **Atualização dinâmica** - Muda conforme interações

#### 🎨 Interface e UX
- [x] **Material Design 3** - Design moderno e consistente
- [x] **Feedback visual** - Ícones de estado (✅/⭕)
- [x] **Texto riscado** - Tarefas completas ficam riscadas
- [x] **Animações suaves** - Transições ao adicionar/remover
- [x] **Dialog de confirmação** - Previne exclusões acidentais
- [x] **Campos pré-preenchidos** - Ao editar, mostra dados atuais



---

## 🛠️ Tecnologias

### Frameworks e Linguagens

- **Flutter** 3.24 - Framework multiplataforma
- **Dart** 3.5 - Linguagem de programação

### Packages Utilizados
```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.3.3  # Persistência local
```

### Arquitetura e Padrões

- **Model-View** - Separação de responsabilidades
- **StatefulWidget** - Gerenciamento de estado local
- **Builder Pattern** - Construção de widgets dinâmicos
- **Factory Constructor** - Deserialização de objetos

### Conceitos Aplicados

- ✅ **CRUD completo** (Create, Read, Update, Delete)
- ✅ **Persistência de dados** com SharedPreferences
- ✅ **Serialização/Deserialização** JSON
- ✅ **Callbacks** para comunicação entre widgets
- ✅ **Filtros dinâmicos** com lógica condicional
- ✅ **Estatísticas calculadas** em tempo real
- ✅ **Validação de formulários**
- ✅ **Gestures** (tap, long press, swipe)

---

## 🏗️ Arquitetura

### Estrutura de Pastas
```
flutter_task_master/
├── lib/
│   ├── models/
│   │   └── task.dart              # Modelo de dados Task
│   ├── views/
│   │   └── pages/
│   │       └── tasks_page.dart    # Página principal
│   └── main.dart                  # Entry point
│
├── screenshots/                    # Screenshots da aplicação
├── .gitignore                     # Arquivos ignorados
├── LICENSE                        # Licença MIT
├── README.md                      # Este arquivo
└── pubspec.yaml                   # Dependências
```

### Fluxo de Dados
```
┌─────────────────────────────────────────────┐
│           TasksPage (State)                 │
│  ┌───────────────────────────────────────┐  │
│  │  List<Task> _tasks = []               │  │
│  │  String _filtroAtual = 'todas'        │  │
│  └───────────────────────────────────────┘  │
│                    │                         │
│          ┌─────────┼─────────┐              │
│          ▼         ▼         ▼               │
│    _saveTasks  _loadTasks  Filtros          │
│          │         │         │               │
│          ▼         ▼         ▼               │
│   SharedPreferences  JSON  ListView.builder │
└─────────────────────────────────────────────┘
```

---

## 🚀 Instalação

### Pré-requisitos

- **Flutter SDK** 3.24 ou superior
- **Dart SDK** 3.5 ou superior
- **Android Studio** ou **Xcode** (para emuladores)
- **VS Code** ou **Android Studio** (IDEs recomendadas)

### Verificar instalação
```bash
flutter doctor
```

### Passos para Instalação
```bash
# 1. Clone o repositório
git clone https://github.com/CLopes86/flutter-task-master.git

# 2. Entre no diretório
cd flutter-task-master

# 3. Instale as dependências
flutter pub get

# 4. Execute a aplicação
flutter run
```

### Plataformas Suportadas

- ✅ **Android** - API 21+
- ✅ **iOS** - iOS 12+
- ⚠️ **Web** - Não otimizado
- ⚠️ **Desktop** - Não testado

---

## 💡 Como Usar

### Adicionar Tarefa
1. Toque no botão **"+"** (canto inferior direito)
2. Preencha o **título** (obrigatório)
3. Preencha a **descrição** (opcional)
4. Toque em **"Adicionar"**

### Marcar como Completa
- **Toque simples** na tarefa para alternar entre completa/incompleta
- O ícone muda de ⭕ (cinza) para ✅ (verde)
- O texto fica riscado quando completa

### Editar Tarefa
1. **Toque longo** (pressione e segure) na tarefa
2. Altere o **título** e/ou **descrição**
3. Toque em **"Salvar"**

### Apagar Tarefa
1. **Deslize** a tarefa para a esquerda
2. Confirme a exclusão no dialog

### Filtrar Tarefas
- Toque em **"Todas"** - mostra todas as tarefas
- Toque em **"Completas"** - mostra só as concluídas
- Toque em **"Incompletas"** - mostra só as pendentes

### Visualizar Estatísticas
- Card no topo mostra:
  - Total de tarefas
  - Tarefas completas e incompletas
  - Percentagem de conclusão
  - Barra de progresso visual

---

## 📈 Roadmap e Melhorias Futuras

### 🎨 Interface
- [ ] Tema escuro (Dark Mode)
- [ ] Animações avançadas
- [ ] Feedback háptico
- [ ] Ícones personalizados

### 🚀 Funcionalidades
- [ ] Categorias/Tags para tarefas
- [ ] Prioridades (Alta, Média, Baixa)
- [ ] Data de vencimento (Deadline)
- [ ] Notificações
- [ ] Pesquisa de tarefas
- [ ] Ordenação customizada

### 🗄️ Dados
- [ ] Migrar para SQLite/Hive
- [ ] Backup em nuvem
- [ ] Sincronização multi-dispositivo
- [ ] Export/Import de dados

### 🧪 Qualidade
- [ ] Testes unitários
- [ ] Testes de integração
- [ ] CI/CD com GitHub Actions
- [ ] Análise de código (linting)

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Para contribuir:

1. Faça **fork** do projeto
2. Crie uma **branch** para sua feature (`git checkout -b feature/NovaFuncionalidade`)
3. **Commit** suas mudanças (`git commit -m 'feat: adiciona nova funcionalidade'`)
4. Faça **push** para a branch (`git push origin feature/NovaFuncionalidade`)
5. Abra um **Pull Request**

### Padrão de Commits

Seguimos o padrão [Conventional Commits](https://www.conventionalcommits.org/):

- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Documentação
- `style`: Formatação de código
- `refactor`: Refatoração de código
- `test`: Testes
- `chore`: Tarefas de build/configuração

---

## 👨‍💻 Autor

<div align="center">
  
  <img src="https://github.com/CLopes86.png" alt="Cesaltino Lopes" width="150" style="border-radius: 50%;">
  
  ### Cesaltino Lopes
  
  Estudante de **Ciências Informáticas e Multimédia**  
  Instituto Politécnico de Castelo Branco | Portugal
  
  Apaixonado por desenvolvimento mobile e tecnologias Flutter
  
  <br>
  
  [![GitHub](https://img.shields.io/badge/GitHub-CLopes86-181717?logo=github&style=for-the-badge)](https://github.com/CLopes86)
  [![LinkedIn](https://img.shields.io/badge/LinkedIn-Cesaltino%20Lopes-0077B5?logo=linkedin&style=for-the-badge)](https://www.linkedin.com/in/cesaltino-lopes)
  [![Email](https://img.shields.io/badge/Email-c.lopes46cv@gmail.com-D14836?logo=gmail&logoColor=white&style=for-the-badge)](mailto:c.lopes46cv@gmail.com)
  
</div>

---

## 📊 Estatísticas do Projeto

- **Linhas de código**: ~800 linhas
- **Tempo de desenvolvimento**: ~15 horas
- **Commits**: 5+
- **Funcionalidades**: 15+
- **Packages externos**: 1 (shared_preferences)

---

## 📄 Licença

Este projeto está sob a licença **MIT**. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

### Resumo da Licença

✅ Uso comercial  
✅ Modificação  
✅ Distribuição  
✅ Uso privado  

❌ Responsabilidade  
❌ Garantia  

---

## 🙏 Agradecimentos

- **Comunidade Flutter** - Pela documentação e suporte
- **Instituto Politécnico de Castelo Branco** - Pela formação
- **Você** - Por visitar este projeto!

---

## 📚 Recursos e Referências

### Documentação
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design 3](https://m3.material.io/)

### Tutoriais e Cursos
- [Flutter Codelabs](https://docs.flutter.dev/codelabs)
- [Dart Pad](https://dartpad.dev/)

### Comunidades
- [Flutter Community](https://flutter.dev/community)
- [r/FlutterDev](https://reddit.com/r/FlutterDev)

---

<div align="center">
  
  ### ⭐ Se este projeto te ajudou, considera dar uma estrela!
  
  **Feito com ❤️ e Flutter por Cesaltino Lopes**
  
  © 2025 - Task Master - Todos os direitos reservados
  
</div>