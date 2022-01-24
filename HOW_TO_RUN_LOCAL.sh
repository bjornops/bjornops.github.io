#!/bin/sh

docker run -p 8080:4000 \
    -v $(pwd):/site \
    bretfisher/jekyll-serve bundle exec jekyll serve \
    --force_polling \
    --config _config.yml,_config_dev.yml \
    -H 0.0.0.0 \
    -P 4000
