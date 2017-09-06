# Yona Than you

# Description
Yona Docker 기존 사용자 업그레이드용 docker package 입니다.

# use

1. clone
git clone https://github.com/alzkdpf/docker-yona-upgrade-pack

2. config.sh 수정
```
cd ./config/
vi config.sh
```
YONA_HOME : yona Running id가 저장될 홈 디렉토리
YONA_DATA : conf, repo 가 저장된 디렉토리 경로
YONA_PORT : 서비스 포트
YONA_DB_CONTAINER_NAME : yona docker database container name
DB_DEFAULT_URL_DOMAIN : localhost or com.your.domain
```
ex>
jdbc:mysql://localhost:3306/yona?characterEncoding=utf-8
or
jdbc:mysql://com.your.domain:3306/yona?characterEncoding=utf-8
```

3. create image
./make_container.sh

4. 실행
./bin/run_docker.sh
