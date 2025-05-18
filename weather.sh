#!/bin/bash

# Weather Configuration
API_KEY="f733140b40968a5ed521627fcd7f1b51"  # Your API Key
CITY_ID="2506999"                           # Algiers, Algeria
UNITS="metric"                              # Celsius (°C)
LANG="en"                                   # English (use "fr" for French)

# Fetch Weather Data
WEATHER_DATA=$(curl -s "http://api.openweathermap.org/data/2.5/weather?id=${CITY_ID}&appid=${API_KEY}&units=${UNITS}&lang=${LANG}")

# Parse Data
TEMP=$(echo "$WEATHER_DATA" | jq -r '.main.temp')
FEELS_LIKE=$(echo "$WEATHER_DATA" | jq -r '.main.feels_like')
CONDITION=$(echo "$WEATHER_DATA" | jq -r '.weather[0].description')
HUMIDITY=$(echo "$WEATHER_DATA" | jq -r '.main.humidity')
WIND=$(echo "$WEATHER_DATA" | jq -r '.wind.speed')
ICON_CODE=$(echo "$WEATHER_DATA" | jq -r '.weather[0].icon')

# Weather Icons (Emoji for simplicity)
case "$ICON_CODE" in
    "01d") ICON="☀️";;  # Clear sky (day)
    "01n") ICON="🌙";;  # Clear sky (night)
    "02d") ICON="⛅";;  # Few clouds (day)
    "02n") ICON="☁️";;  # Few clouds (night)
    "03d"|"03n") ICON="☁️";;  # Scattered clouds
    "04d"|"04n") ICON="🌫️";;  # Broken clouds
    "09d"|"09n") ICON="🌧️";;  # Shower rain
    "10d"|"10n") ICON="🌦️";;  # Rain
    "11d"|"11n") ICON="⛈️";;  # Thunderstorm
    "13d"|"13n") ICON="❄️";;  # Snow
    "50d"|"50n") ICON="🌫️";;  # Mist
    *) ICON="🌀";;  # Unknown
esac

# Display Output
echo "${ICON}  ${TEMP}°C (Feels: ${FEELS_LIKE}°C)"
echo "Condition: ${CONDITION^}"
echo "Humidity: 💧 ${HUMIDITY}% | Wind: 🌬️ ${WIND} m/s"
