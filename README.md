# kokuraex

[![miolab](https://circleci.com/gh/miolab/kokuraex.svg?style=svg)](https://github.com/miolab/kokuraex)

# About

This is kokura.ex org site.

## Routes

```
$ docker-compose exec app mix phx.routes

          page_path  GET  /                                      KokuraExWeb.PageController :index
         about_path  GET  /about                                 KokuraExWeb.AboutController :index
live_dashboard_path  GET  /dashboard                             Phoenix.LiveView.Plug :home
live_dashboard_path  GET  /dashboard/:page                       Phoenix.LiveView.Plug :page
live_dashboard_path  GET  /dashboard/:node/:page                 Phoenix.LiveView.Plug :page
          websocket  WS   /live/websocket                        Phoenix.LiveView.Socket
           longpoll  GET  /live/longpoll                         Phoenix.LiveView.Socket
           longpoll  POST  /live/longpoll                         Phoenix.LiveView.Socket
          websocket  WS   /socket/websocket                      KokuraExWeb.UserSocket
```
