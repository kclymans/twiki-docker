# TWiki-Docker
A Dockerized TWiki

## Build
```bash
docker build . -t twiki
```

## USAGE
All Data will be stored under `/data`. You should attach some
external storage there ` -v /mnt/twiki:/data`

The following environment variables are parsed and used at the moment

|   VAR         |    default            | description            |
|---------------|-----------------------|------------------------|
| ADMIN\_PW     | changeme              | Administrator Password |
| URL\_HOST     | http://localhost:80   | Full URL ( as received by the webserver ) |
| SCRIPT\_PATH  | /bin                  | URI Path to "bin"      |
| PUP\_PATH     | /pub                  | URI Path to "pub"      |


## Example
```bash
docker run  -dt -p 8080:80 -v ~/CodePlace/mine/twiki/data/data:/data -e URL_HOST=http://127.0.0.1:8080/ -e ADMIN_PW=pass1234 twiki
```
