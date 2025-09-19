#!/bin/bash

# Скрипт для создания .ipa файла для учебного проекта
# Использование: ./scripts/build-ipa-simulator.sh
# Результат: iosApp/iosApp-simulator.ipa готов для BrowserStack
# Требования: macOS с Xcode

set -e

PROJECT_ROOT=$(cd "$(dirname "$0")/.." && pwd)
BUILD_TYPE="Debug"
SIMULATOR_NAME="iPhone 15"

echo "🚀 Создание .ipa файла для iOS симулятора..."
echo "📁 Корень проекта: $PROJECT_ROOT"
echo "📱 Симулятор: $SIMULATOR_NAME"

# Проверяем, что мы на macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ Ошибка: iOS можно собирать только на macOS"
    exit 1
fi

# Проверяем наличие Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Ошибка: Xcode не установлен"
    exit 1
fi

# Переходим в корень проекта
cd "$PROJECT_ROOT"

# Делаем gradlew исполняемым
chmod +x ./gradlew

echo "📦 Собираем shared framework для iOS..."
# Используем старый способ сборки для совместимости с существующим Xcode проектом
export CONFIGURATION=$BUILD_TYPE
export SDK_NAME=iphonesimulator
export ARCHS=arm64

./gradlew :shared:embedAndSignAppleFrameworkForXcode

echo "🔨 Собираем iOS приложение для симулятора..."
cd iosApp

# Очищаем предыдущие сборки
rm -rf build/
rm -f iosApp-simulator.ipa

# Собираем приложение
xcodebuild -project iosApp.xcodeproj \
           -scheme iosApp \
           -destination "platform=iOS Simulator,name=$SIMULATOR_NAME" \
           -configuration $BUILD_TYPE \
           -derivedDataPath ./build \
           clean build

echo "📦 Создаем .ipa файл..."

# Находим собранное приложение
APP_PATH=$(find ./build -name "*.app" -type d | head -1)

if [ -z "$APP_PATH" ]; then
    echo "❌ Ошибка: Не найдено собранное приложение (.app)"
    exit 1
fi

echo "✅ Найдено приложение: $APP_PATH"

# Создаем структуру для .ipa
rm -rf Payload
mkdir -p Payload

# Копируем .app в Payload
cp -R "$APP_PATH" Payload/

# Создаем .ipa файл
zip -r iosApp-simulator.ipa Payload/ > /dev/null

# Очищаем временные файлы
rm -rf Payload

# Проверяем результат
if [ -f "iosApp-simulator.ipa" ]; then
    FILE_SIZE=$(ls -lh iosApp-simulator.ipa | awk '{print $5}')
    echo "✅ .ipa файл создан успешно!"
    echo "📄 Файл: $(pwd)/iosApp-simulator.ipa"
    echo "📏 Размер: $FILE_SIZE"
    echo ""
    echo "🌐 Готов для загрузки в BrowserStack iOS Simulator"
    echo "📋 Инструкция:"
    echo "   1. Откройте BrowserStack Live"
    echo "   2. Выберите iOS Simulator"
    echo "   3. Загрузите файл iosApp-simulator.ipa"
    echo "   4. Начните тестирование!"
else
    echo "❌ Ошибка: Не удалось создать .ipa файл"
    exit 1
fi
