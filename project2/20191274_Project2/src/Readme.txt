# Automobile Company Database Management System

## 1. Project Overview
본 프로그램은 자동차 회사의 영업, 재고, 공급업체 관리를 위한 데이터베이스 시스템으로, MySQL 환경에서 C 언어(MySQL C API)를 이용하여 개발되었습니다. 과거 판매 동향, 불량 부품 추적, 계절별 판매 패턴 등 7가지 핵심 분석 쿼리를 제공합니다.

## 2. Environment & Prerequisites
* **OS:** Windows / Linux 호환
* **DBMS:** MySQL 8.0 이상
* **Compiler:** GCC (MinGW / MSYS2 환경 권장)
* **Library:** MySQL C API (MariaDB Connector/C 호환)

## 3. Database Setup (데이터베이스 구축 방법)
프로그램을 실행하기 전, 반드시 다음 순서대로 SQL 스크립트를 실행하여 데이터베이스를 구축해야 합니다.
1. MySQL 환경(Workbench 또는 CLI)에 접속합니다.
2. `database/schema.sql` 파일을 실행하여 `auto_company` 데이터베이스와 테이블, 인덱스, 트리거를 생성합니다.
3. `database/sample_data.sql` 파일을 실행하여 각 테이블에 20개씩의 샘플 데이터를 삽입합니다.

## 4. Compilation & Execution (컴파일 및 실행 방법)

### ⚠️ [중요] 데이터베이스 접속 정보 수정
채점 전, 조교님의 MySQL 환경에 맞게 접속 비밀번호를 수정해야 합니다. 
`src/main.c` (또는 `database.h`) 소스 코드 상단의 `DB_PASS` 값을 조교님의 실제 MySQL root 비밀번호로 변경해 주세요.

```c
#define DB_HOST "localhost"
#define DB_USER "root"
#define DB_PASS "여기에_조교님_비밀번호_입력" // 기본값: "6339"
#define DB_NAME "auto_company"
#define DB_PORT 3306
```

src 폴더 위치에서 터미널을 열고 다음 명령어를 실행합니다.

gcc main.c -o main.exe -IC:/msys64/ucrt64/include/mysql -LC:/msys64/ucrt64/lib -lmariadb

다음과 같이 입력해도 될 것입니다.

gcc main.c -o main -lmysqlclient

(조교님의 채점 환경(예: Linux 등)에 따라 컴파일 시 -lmariadb 대신 -lmysqlclient 를 사용할 수 있습니다.)

컴파일이 완료되면, 생성된 실행 파일을 실행합니다.

./main.exe
