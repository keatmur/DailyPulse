# DailyPulse - Учебный KMP проект

🍎 **iOS .ipa builds available via GitHub Actions for BrowserStack testing!**

## 🚀 Быстрый старт для тестирования iOS

### Автоматическая сборка .ipa файла:
1. Перейдите в **Actions** → **"Build iOS IPA for BrowserStack"**
2. Нажмите **"Run workflow"** → **"Run workflow"**
3. Дождитесь завершения (5-10 минут)
4. Скачайте **"ios-simulator-ipa"** из Artifacts

### Локальная сборка (только macOS):
```bash
./scripts/build-ipa-simulator.sh
```

### Тестирование в BrowserStack:
1. Откройте [BrowserStack Live](https://live.browserstack.com/)
2. Выберите iOS Simulator
3. Загрузите `iosApp-simulator.ipa`
4. Начните тестирование!

📖 **Подробная инструкция:** [docs/BrowserStack-Testing.md](docs/BrowserStack-Testing.md)

---

## 🔧 Исправленные проблемы

### ✅ Gradle конфигурация исправлена:
- Убрано неправильное использование `libs.kotlinx.datetime`
- Исправлен deprecated метод `targetHierarchy.default()`
- Добавлено `kotlin.native.ignoreDisabledTargets=true` для скрытия предупреждений

### ✅ iOS сборка настроена:
- Используется `embedAndSignAppleFrameworkForXcode` для совместимости
- Workflow настроен для macOS runners
- Локальный скрипт работает на macOS

### 🚀 Готово к использованию!
Проект готов для создания .ipa файлов и тестирования в BrowserStack.
Educational repo offered as material in the course Kotlin Multiplatform Masterclass.
The course aims to teach the state-of-art KMP development. 

Daily Pulse includes a native Android and a native iOS apps, where the business logic and inftrastructure is shared in a KMP module.

Daily Pulse is using the news API to fetch, cache and display the top US business articles. It also contains a screen to diaply the list of news sources we use to fetch the articles from.
Finally, it contains third screen to display informartion regarding the user's device.

## Tech Stack
It is a prototype app based on the following technologies and patterns:

1. Clean Architecture
2. MVI
3. Ktor
4. SQL Delight
5. Koin
6. Jetpack Compose
7. Swift UI

## How to use
Switch between the branches 1 to 7 to checkout from a more initial to a more advanced state of the application.

## Architectural diagram

The UI/Framework layers reside in the native apps, while everything from the View Model up to Data layer is in the common KMP module.


![Untitled Diagram drawio](https://github.com/petros-efthymiou/DailyPulse/assets/98778003/a1a465db-1484-4eb8-ab3c-1d43b457d7c2)

## Architectural Layers

<img width="531" alt="Screenshot 2023-12-04 at 18 19 53" src="https://github.com/petros-efthymiou/DailyPulse/assets/98778003/620fb7ca-68cb-428c-b134-4a012a8836eb">


License
--------
```
  Copyright (C) 2023 Petros Efthymiou Open Source Project

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  ```

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/petrosefth)

