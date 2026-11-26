# 템플릿 생성 후 서비스 이름·기본 설정 변경

Spring 서비스 템플릿으로 생성한 레포를 담당 서비스에 맞게 변경한다.

## AI 작업 시 주의사항

- README.md, CONTRIBUTING.md와 관련 팀 컨벤션을 먼저 읽는다.
- 변경 계획과 서비스별 이름·패키지·포트를 사용자에게 보여주고 확인 후 수정한다.
- 기존 사용자 변경과 프로필·Config Server·Swagger 설정을 유지한다.
- 아래 Auth 예시를 다른 서비스에 그대로 적용하지 않는다.
- 변경 결과를 보여주고 GitHub에 올리기 전에 사용자 확인을 받는다.

## 1. 변경할 값 확인

| 항목 | 템플릿 값 | Auth 변경 예시 |
| --- | --- | --- |
| Gradle 프로젝트 이름 | nirvana-spring-service-template | nirvana-auth-service |
| Java 패키지 | com.nirvana.template | com.nirvana.auth |
| 시작 클래스 | ServiceApplication | AuthServiceApplication |
| 애플리케이션 이름 | spring-service-template | auth-service |
| 실행 포트 | 별도 설정 없으면 8080 | 8081 — 임시 예시 |

각 서비스의 이름과 포트는 팀 합의값을 우선한다.
미정이면 사용자와 임시값을 정하고 README에 표시한다.

## 2. Gradle 프로젝트 이름 변경

settings.gradle:

```groovy
rootProject.name = 'nirvana-auth-service'
```

변경 후 IntelliJ에서 Gradle 프로젝트를 새로고침한다.

## 3. Java 패키지 변경

```text
com.nirvana.template → com.nirvana.auth
```

IntelliJ에서는 패키지를 선택한 뒤 Shift + F6으로 변경한다.
파일의 package 선언과 실제 디렉터리 위치를 함께 변경한다.

## 4. 시작 클래스 변경

```text
ServiceApplication → AuthServiceApplication
```

파일명과 클래스명을 함께 변경한다.
기존 테스트·실행 설정에서 이전 이름을 참조한다면 함께 수정한다.

최종 위치:

```text
src/main/java/com/nirvana/auth/AuthServiceApplication.java
```

최종 코드:

```java
package com.nirvana.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class AuthServiceApplication {
	public static void main(String[] args) {
		SpringApplication.run(AuthServiceApplication.class, args);
	}
}
```

## 5. 애플리케이션 이름·포트 변경

src/main/resources/application.yml의 공통 구간을 수정한다.

```yaml
server:
  port: ${SERVER_PORT:8081}

spring:
  application:
    name: auth-service
```

위 코드는 수정할 부분의 예시이며 파일 전체를 덮어쓰지 않는다.

- 기존 profiles, cloud, springdoc 설정과 --- 구분을 유지한다.
- 같은 YAML 문서 안에 spring:을 중복 선언하지 않는다.
- spring.application.name은 Config Repo의 서비스별 파일명과 맞춘다.
  - 예: auth-service → auth-service.yml
- SERVER_PORT가 있으면 해당 값을, 없으면 지정한 기본 포트를 사용한다.
- 같은 PC에서 함께 실행하는 서비스는 포트가 겹치지 않도록 한다.
- 8081은 Auth의 임시 예시이며 전체 서비스 공통값이 아니다.

## 6. README 수정

다음 항목을 담당 서비스의 실제 정보로 변경한다.

- 서비스 이름과 목적
- 담당자·백업 리뷰어
- 소유 데이터와 운영 책임
- 실행 포트와 임시·확정 여부
- Swagger·헬스 체크 주소
- 추가로 필요한 실행 조건

## 7. 검증

- Project SDK와 Gradle JVM이 JDK 21인지 확인한다.
- 변경한 시작 클래스로 서버를 실행한다.
- 설정한 포트의 /actuator/health 응답을 확인한다.
- Gradle 빌드와 관련 테스트를 실행한다.
- 프로젝트 전체에서 기존 템플릿 이름·패키지 참조가 남았는지 확인한다.
  이 문서처럼 변경 전 값을 설명하는 예시는 유지할 수 있다.
- 실행한 검증과 실행하지 못한 검증을 구분하여 기록한다.

Git Bash 빌드 명령:

```bash
./gradlew build
```

Auth 예시의 헬스 체크:

```text
GET http://localhost:8081/actuator/health
```

정상 응답:

```json
{"status":"UP"}
```

## 참고

- 이 문서는 템플릿 원본을 특정 서비스 이름으로 변경하라는 의미가 아니다.
- 템플릿 업데이트는 이미 생성된 서비스 레포에 자동 반영되지 않는다.
  기존 레포에서는 이 가이드를 별도로 가져오거나 참조해야 한다.
