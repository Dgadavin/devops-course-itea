# Конфигурирование git

```bash
git config --list
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
git config --global core.editor vim
```

# Создание репозитария

```bash
git init
git remote add origin <origin-adress>
touch README.md
git status
git diff
git add .
git commit -m "Add Readme" # Закомитить изменения в локальную базу
git push origin <branch-name> # Отправить изменения на сервер
```

# Клонирование репозитария

```bash
git clone https://github.com/Dgadavin/devops-course-itea.git # по логину и паролю если приватный репо
git clone git@github.com:Dgadavin/devops-course-itea.git # с помощью ssh key
git fetch # Получить все ветки
git pull # Вытянуть все изменения по всем веткам
```

# Создание новой ветки

```bash
git branch <branch-name> # Создать ветку но не переходить в нее
git checkout -b <branch-name> # Создать ветку и сразу перейти в нее
```

# Добавление файлов в стейдж и коммиты

```bash
git add . # Добавить все файлы в стейдж
git add <file-names>
git commit # Будет открыто окно с вашим дефолтным редактором что б внести коммит месадж
git commit -m "Commit message" # Закомитить с комит мессаджем
git commit -m "Commit message" --amend # Оставить старый комит хеш но добавить новые файлы
```

# Слияние веток

```bash
git merge master # смерджит ветку master в вашу текушую ветку если нет конфликтов
```

# Вывод информации(лог)

```bash
git log -p -2
git log --stat
git log --pretty=oneline
git log --pretty=format:"%h - %an, %ar : %s"
```
