# 서비스 이름

## 서비스 개요

- 목적: <!-- 서비스 목적 -->
- 담당자 / 백업 리뷰어: <!-- GitHub 사용자 또는 팀 -->
- 소유 데이터와 운영 책임: <!-- 서비스 경계와 책임 -->
- API 문서: [Swagger UI](http://localhost:8080/swagger-ui/index.html)
- 기본 포트 / 헬스체크: `8080` / `GET /actuator/health`

위 서비스 정보와 주소는 템플릿 값입니다.
서비스 생성 후 실제 정보로 변경하세요.

## 서비스 레포 생성 후

[서비스 초기 설정 가이드](docs/INITIAL_SETUP.md)에 따라 다음 항목을 변경합니다.

- Gradle 프로젝트 이름
- Java 패키지
- 시작 클래스 이름
- 애플리케이션 이름
- 실행 포트
- README의 서비스 정보

애플리케이션 이름은 Config Repo의 서비스별 설정 파일 이름과 일치시킵니다.
예시값을 그대로 적용하지 말고 담당 서비스의 이름과 포트를 확인하세요.

## 로컬 실행

- 사전 요구사항은 JDK 21입니다.
- macOS와 Linux: `./gradlew bootRun`
- Windows PowerShell: `.\gradlew.bat bootRun`
- Windows Git Bash: `./gradlew bootRun`
- 기본 local 프로필은 Config Server 없이 시작하며 Swagger UI를 활성화합니다.
- 다른 프로필에서는 API 문서와 Swagger UI가 기본으로 비활성화됩니다.

### Config Server 사용

- `SPRING_PROFILES_ACTIVE=config-server`로 설정합니다.
- 로컬 Swagger UI도 함께 사용하려면 `local,config-server`로 설정합니다.
- `CONFIG_SERVER_URL` 기본값은 `http://localhost:8888`입니다.

## 빌드·테스트

macOS, Linux, Windows Git Bash:

```bash
./gradlew build
```

Windows PowerShell:

```powershell
.\gradlew.bat build
```

JAR만 빌드하려면 bootJar를 사용합니다.
현재 기본 CI는 develop·main 대상 PR에서 bootJar를 실행합니다.
build에 포함된 테스트 실행과 CI의 실제 검사 범위는 구분해서 확인하세요.

## 개발 규칙

개발과 기여 방법은 [CONTRIBUTING.md](CONTRIBUTING.md)를 참고하세요.
