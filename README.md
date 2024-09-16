[![Docker Image CI](https://github.com/aroglahcim/vscode-web-dashboard/actions/workflows/docker-image.yml/badge.svg)](https://github.com/aroglahcim/vscode-web-dashboard/actions/workflows/docker-image.yml)

## Configuration

Server is inteded to be used inside a container since it looks for git repositories under `/search` directory.

### URL_PREFIX

```bash
URL_PREFIX=vscode-remote://ssh-remote+user@server
# or
URL_PREFIX=vscode://
```

depending on your configuration of `xdg-open` and files location.

## Compose example

```yaml
services:
  server:
    build:
      context: .
    environment:
      - URL_PREFIX=vscode-remote://ssh-remote+user@host
    ports:
      - 80:80
    volumes:
      - /home/user/repositories:/search/home/user/repositories/:ro
    restart: unless-stopped
```
