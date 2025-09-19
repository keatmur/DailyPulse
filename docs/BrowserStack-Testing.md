# Тестирование iOS приложения в BrowserStack (Учебный проект)

## 🎯 Обзор

Простая инструкция для создания .ipa файла и тестирования iOS приложения в BrowserStack Simulator для учебных целей.

## 🚀 Автоматическая сборка через GitHub Actions

### 1. Запуск workflow

**Ручной запуск (рекомендуется для тестирования):**
1. Перейдите в GitHub → Actions
2. Выберите "Build iOS IPA for BrowserStack"
3. Нажмите "Run workflow" → "Run workflow"

**Автоматический запуск:**
- При push в ветку `1_initial`
- Только если изменились файлы в `iosApp/` или `shared/`

**Отладочный workflow:**
- "Test iOS Build (Debug)" - для проверки сборки без создания .ipa

### 2. Скачивание .ipa файла

После успешной сборки:

1. **Из Artifacts:**
   - Перейдите в завершенный workflow
   - Скачайте `ios-simulator-ipa`
   - Распакуйте архив

2. **Из Releases (для main ветки):**
   - Перейдите в Releases
   - Найдите последний `ios-build-XXX`
   - Скачайте `iosApp-simulator.ipa`

## 🖥️ Локальная сборка

### Требования
- macOS с Xcode
- Java 17+

### Команды

```bash
# Быстрая сборка
./scripts/build-ipa-simulator.sh

# Или пошагово:
./gradlew :shared:assembleSharedDebugXCFramework
cd iosApp
xcodebuild -project iosApp.xcodeproj \
           -scheme iosApp \
           -destination 'platform=iOS Simulator,name=iPhone 15' \
           -configuration Debug \
           CODE_SIGN_IDENTITY="" \
           CODE_SIGNING_REQUIRED=NO \
           build

# Создание .ipa
APP_PATH=$(find ./build -name "*.app" -type d | head -1)
mkdir Payload
cp -R "$APP_PATH" Payload/
zip -r iosApp-simulator.ipa Payload/
rm -rf Payload
```

## 📱 Тестирование в BrowserStack

### 1. Подготовка

1. Зарегистрируйтесь на [BrowserStack](https://www.browserstack.com/)
2. Получите бесплатный аккаунт для open source проектов
3. Откройте [BrowserStack Live](https://live.browserstack.com/)

### 2. Загрузка приложения

1. **Выберите iOS Simulator:**
   - Platform: iOS
   - Device: любой iPhone/iPad
   - Version: iOS 15+ (рекомендуется)

2. **Загрузите .ipa файл:**
   - Нажмите "Upload App"
   - Выберите `iosApp-simulator.ipa`
   - Дождитесь загрузки

3. **Запустите тестирование:**
   - Нажмите "Start"
   - Приложение откроется в симуляторе

### 3. Возможности тестирования

✅ **Что работает:**
- Навигация по приложению
- Тестирование UI/UX
- Проверка функциональности
- Скриншоты и видеозапись
- Отладка через DevTools

❌ **Ограничения симулятора:**
- Нет доступа к камере
- Нет push-уведомлений
- Нет GPS/геолокации
- Нет Touch ID/Face ID

## 🔧 Настройка проекта

### Конфигурация для симулятора

В `iosApp.xcodeproj` уже настроено:

```xml
<!-- Info.plist -->
<key>CFBundleIdentifier</key>
<string>com.yourcompany.dailypulse</string>

<key>LSRequiresIPhoneOS</key>
<true/>

<key>UIRequiredDeviceCapabilities</key>
<array>
    <string>armv7</string>
</array>
```

### Отключение подписания

Для симулятора подписание не требуется:

```bash
CODE_SIGN_IDENTITY=""
CODE_SIGNING_REQUIRED=NO
```

## 🐛 Troubleshooting

### Проблема: "iOS targets cannot be built on this machine"

**Причина:** iOS можно собирать только на macOS, на Windows/Linux это невозможно.

**Решение:** Используйте GitHub Actions с macOS runner или локальную сборку на Mac.

### Проблема: "No such file or directory" (shared framework)

```bash
# Проверьте, что shared framework собран в правильном месте
ls -la shared/build/xcode-frameworks/

# Пересоберите используя правильную задачу
export CONFIGURATION=Debug
export SDK_NAME=iphonesimulator
./gradlew :shared:embedAndSignAppleFrameworkForXcode
```

### Проблема: "Build failed"

```bash
# Очистите кэш
./gradlew clean
rm -rf iosApp/build/

# Пересоберите
./scripts/build-ipa-simulator.sh
```

### Проблема: "App crashes in BrowserStack"

1. Проверьте логи в Xcode
2. Убедитесь, что используете Debug конфигурацию
3. Проверьте совместимость iOS версии

### Проблема: "Large .ipa file"

```bash
# Проверьте размер
ls -lh iosApp-simulator.ipa

# Обычно: 10-50 MB для простого приложения
# Если больше 100 MB - проверьте ресурсы
```

## 📊 Мониторинг сборки

### GitHub Actions

Следите за статусом в:
- GitHub Actions tab
- PR checks
- Email уведомления

### Логи сборки

Полезные команды для отладки:

```bash
# Проверка Xcode версии
xcodebuild -version

# Список симуляторов
xcrun simctl list devices

# Проверка схем проекта
xcodebuild -project iosApp.xcodeproj -list
```

## 🎓 Для учебных проектов

### Бесплатные ресурсы

1. **BrowserStack for Open Source:**
   - Бесплатно для публичных репозиториев
   - Заявка через GitHub Student Pack

2. **GitHub Actions:**
   - 2000 минут/месяц бесплатно
   - macOS: 200 минут/месяц (10x множитель)

3. **Альтернативы:**
   - Xcode Simulator (локально)
   - TestFlight (требует Apple Developer)
   - Firebase Test Lab (ограниченно бесплатно)

### Оптимизация для обучения

```yaml
# Запуск только при изменениях
on:
  push:
    paths: ['iosApp/**', 'shared/**']

# Кэширование для экономии времени
```

## 📚 Дополнительные ресурсы

- [BrowserStack Documentation](https://www.browserstack.com/docs)
- [Xcode Build Settings](https://developer.apple.com/documentation/xcode)
- [Kotlin Multiplatform Mobile](https://kotlinlang.org/docs/multiplatform-mobile-getting-started.html)
- [GitHub Actions for iOS](https://docs.github.com/en/actions/guides/building-and-testing-swift)
