curl 'https://locations.wafflehouse.com/api/587d236eeb89fb17504336db/locations-details?locale=en_US&ids=57129dbbc49072572ed4ab15%2C571429266d0acf1a2d60eb13%2C5714292fc49072572ed4ab86%2C571504900b912de13ea624da%2C571504a40b912de13ea624dc%2C571504ec56b3a02b5eec82e0%2C571504ec56b3a02b5eec82e7%2C571504ec56b3a02b5eec82f2%2C571504ec56b3a02b5eec82f8%2C571504ed56b3a02b5eec8300%2C571504ed56b3a02b5eec8306%2C571504ed0b912de13ea62506%2C571504ee0b912de13ea62511%2C571504ee56b3a02b5eec8316%2C571504ee56b3a02b5eec831c%2C571504ee56b3a02b5eec8327%2C571504ef0b912de13ea6252a%2C571504ef56b3a02b5eec8335%2C571504ef56b3a02b5eec833c%2C571504f00b912de13ea62538%2C571504f056b3a02b5eec834e%2C571504f056b3a02b5eec8358%2C571504f156b3a02b5eec835e&clientId=56fd9c824a88871f1d26062a' \
  -H 'authority: locations.wafflehouse.com' \
  -H 'pragma: no-cache' \
  -H 'cache-control: no-cache' \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36' \
  -H 'dnt: 1' \
  -H 'accept: */*' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-dest: empty' \
  -H 'referer: https://locations.wafflehouse.com/' \
  -H 'accept-language: en-US,en;q=0.9,de;q=0.8' \
  -H 'cookie: __cfduid=d53f2b8b20428d86e9087985d60150ea11588278002' \
  --compressed | jq

