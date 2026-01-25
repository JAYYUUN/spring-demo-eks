# ---- 1) Build stage ---- 
FROM gradle:8.7-jdk17 AS builder 
WORKDIR /app

# 도커가 gradle:8.7-jdk17 이미지를 기반으로 “builder라고 이름 붙인 임시 컨테이너”를 실행하고, 그 컨테이너 안에서 작업 디렉토리를 /app으로 두고 작업한다. (builder라고 이름을 붙인것은 뒤에서 builder에서 생성된 실행파일을 참조하기 위함.)



# 소스 복사 후 빌드
COPY . /app # 현재 Dockerfile이 있는 폴더의 모든 파일을 컨테이너(빌드 단계) 내부의 /app 디렉토리로 복사하라
RUN ./gradlew --no-daemon clean bootJar -x test

# ---- 2) Runtime stage ----
FROM eclipse-temurin:17-jre
WORKDIR /app

# 도커가 eclipse-temurin:17-jre 이미지를 기반으로 “임시 컨테이너”를 실행하고, 그 컨테이너 안에서 작업 디렉토리를 /app으로 두고 작업한다.

# 보안상 non-root 권장 : 이 설정은 컨테이너 내부에 일반 사용자 계정을 생성하고, 애플리케이션을 해당 사용자 권한으로 실행함으로써 root 권한 실행으로 인한 보안 위험을 줄이기 위한 조치이다.
RUN useradd -m appuser
USER appuser

 


# builder 이미지로부터 빌드 결과 JAR을 현재 이미지로 복사 (bootJar 기준)
COPY --from=builder /app/build/libs/*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]