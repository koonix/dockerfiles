# TODO: add a library for MongoDB
FROM imolein/luarocks:5.4-fat
RUN luarocks install luafilesystem
RUN luarocks install penlight
RUN luarocks install luasocket
RUN luarocks install luasec
RUN luarocks install luaposix
RUN luarocks install argparse
RUN luarocks install fifo
RUN luarocks install dkjson
RUN luarocks install inotify
RUN luarocks install cqueues
RUN luarocks install lua-term
RUN luarocks install luautf8
RUN luarocks install amqp-client-52plus
RUN luarocks install telegram-bot-lua
RUN luarocks install luatbot
RUN luarocks install http
RUN apt-get update && apt-get install -y libyaml sqlite3 && rm -rf /var/lib/apt/lists/*
RUN luarocks install lyaml
RUN luarocks install lsqlite3
