FROM johnsonlee/java15:latest

MAINTAINER Johnson g.johnsonlee@gmail.com

ADD ./gradle           /opt/gradle
ADD ./gradlew          /opt/gradlew
ADD ./gradlew.bat      /opt/gradlew.bat

RUN cd /opt && echo $'                                                        \
plugins {\n                                                                   \
    kotlin("jvm") version embeddedKotlinVersion\n                             \
    kotlin("kapt") version embeddedKotlinVersion\n                            \
}\n                                                                           \
repositories {\n                                                              \
    mavenCentral()\n                                                          \
}\n                                                                           \
dependencies {\n                                                              \
    implementation(gradleApi())\n                                             \
    implementation(kotlin("bom"))\n                                           \
    implementation(kotlin("stdlib"))\n                                        \
    testImplementation(kotlin("test"))\n                                      \
    testImplementation(kotlin("test-junit"))\n                                \
}\n                                                                           \
' > build.gradle.kts &&                                                       \
./gradlew build --no-daemon --no-build-cache &&                               \
rm -rf .gradle build build.gradle.kts

