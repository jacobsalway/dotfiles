#!/bin/bash
city="Sydney"
api_key="39214b9803f123f428d81d0e38c1af9c"
lang="tr"
unit="metric"
api="http://api.openweathermap.org/data/2.5/weather"
url="$api?q=$city&lang=$lang&APPID=$api_key&units=$unit"

weather=$(curl -s $url | jq -r '. | "\(.weather[].main)"')
temp=$(curl -s $url | jq -r '. | "\(.main.temp)"')

echo  $weather $temp"°C"
