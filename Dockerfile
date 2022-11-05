FROM johnsonlee/gradle-7.4:latest

MAINTAINER Johnson g.johnsonlee@gmail.com

RUN cd /opt && echo $'                                                            \
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile\n                          \
import org.springframework.boot.gradle.tasks.bundling.BootJar\n                   \
\n                                                                                \
plugins {\n                                                                       \
    kotlin("jvm") version embeddedKotlinVersion\n                                 \
    kotlin("kapt") version embeddedKotlinVersion\n                                \
    kotlin("plugin.spring") version embeddedKotlinVersion\n                       \
    kotlin("plugin.jpa") version embeddedKotlinVersion\n                          \
    id("org.springframework.boot") version "2.5.0"\n                              \
    id("io.spring.dependency-management") version "1.0.11.RELEASE"\n              \
    id("me.champeau.gradle.jmh") version "0.5.0"\n                                \
}\n                                                                               \
\n                                                                                \
repositories {\n                                                                  \
    mavenCentral()\n                                                              \
}\n                                                                               \
\n                                                                                \
dependencies {\n                                                                  \
    implementation(kotlin("bom"))\n                                               \
    implementation(kotlin("stdlib"))\n                                            \
    implementation(kotlin("reflect"))\n                                           \
    implementation("org.springframework.boot:spring-boot-starter-actuator")\n     \
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")\n     \
    implementation("org.springframework.boot:spring-boot-starter-validation")\n   \
    implementation("org.springframework.boot:spring-boot-starter-web")\n          \
    implementation("org.springframework.cloud:spring-cloud-starter")\n            \
    implementation("io.micrometer:micrometer-registry-prometheus")\n              \
    implementation("io.springfox:springfox-boot-starter:3.0.0")\n                 \
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")\n        \
    testImplementation("org.springframework.boot:spring-boot-starter-test")\n     \
}\n                                                                               \
\n                                                                                \
dependencyManagement {\n                                                          \
    imports {\n                                                                   \
        mavenBom("org.springframework.cloud:spring-cloud-dependencies:2020.0.3")\n\
    }\n                                                                           \
}\n                                                                               \
\n                                                                                \
tasks.withType<KotlinCompile> {\n                                                 \
    kotlinOptions {\n                                                             \
        freeCompilerArgs = listOf("-Xjsr305=strict")\n                            \
        jvmTarget = "1.8"\n                                                       \
    }\n                                                                           \
}\n                                                                               \
val jar by tasks.getting(Jar::class) {\n                                          \
    enabled = false\n                                                             \
}\n                                                                               \
\n                                                                                \
val bootJar by tasks.getting(BootJar::class) {\n                                  \
    enabled = true\n                                                              \
    mainClass.set("io.johnsonlee.springboot.starter.StarterApplicationKt")\n      \
}\n                                                                               \
' > build.gradle.kts &&                                                           \
mkdir -p src/main/kotlin/io/johnsonlee/springboot/starter &&                      \
echo $'                                                                           \
import org.springframework.boot.autoconfigure.SpringBootApplication\n             \
import org.springframework.boot.runApplication\n                                  \
\n                                                                                \
@SpringBootApplication\n                                                          \
class StarterApplication\n                                                        \
\n                                                                                \
fun main(args: Array<String>) {\n                                                 \
    runApplication<StarterApplication>(*args)\n                                   \
}\n                                                                               \
' > src/main/kotlin/io/johnsonlee/springboot/starter/StarterApplication.kt &&     \
./gradlew build --no-daemon --no-build-cache &&                                   \
rm -rf .gradle build src build.gradle.kts

