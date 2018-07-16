Docker for Yona
---

# Description

Yona 용 도커 컨테이너입니다. 기존에 bin 타입 대신 소스를 직접 빌드해 사용할 수 있게 패키징 했습니다.
개발용으로 사용하실 분들이나 이미 별도의 fork 로 작업 중이신 분들은 간단히 submodule 변경으로 사용가능하십니다.

# 1. 서브 모듈 추가 

* 설치 방법
```
$ git clone https://github.com/alzkdpf/docker-yona.git docker-yona

$ cd docker-yona

$ git submodule init

$ git submodule update
```
or user custom

```
$ git clone https://github.com/alzkdpf/docker-yona.git docker-yona

$ cd docker-yona

$ rm -rf yona

$ rm .gitmodules

$ git submodule init

$ git submodule add https://<your yona repo> ./yona
```

* 

# 2. CLI install

* node.js 를 인스톨 후 실행해주세요. 
[다운로드 |downaload|](https://nodejs.org/ko/download/current/)
```
$ cd ycli

$ npm install -g

```
* (E-ACCESS 오류시 sudo npm install -g 로 실행해 주세요.)

# 3. 실행

```
$ yona-cli docker
```
- container_name (default: yona): 컨테이너명 
- port (default:9000): 사용할 서비스 포트
- *YONA_DATA_PATH (required): conf 및 repo 저장 경로

[screen shot](https://youtu.be/sXz55TCA9vs)

# 4. docker 실행 
```
$ dokcer-compose up -d --build
```

