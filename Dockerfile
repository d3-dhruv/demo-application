FROM lolhens/baseimage-openjre
ADD target/demo-application-0.0.1-SNAPSHOT.jar demo-application-0.0.1-SNAPSHOT.jar
EXPOSE 80
ENTRYPOINT ["java", "-jar", "demo-application.jar"]


# stage('Versioning') {
#     steps {
#         script {
#             sh 'mvn versions:set -DnewVersion=1.0.${BUILD_NUMBER}'
#         }
#     }
# }

# FROM adoptopenjdk/openjdk11
    
# EXPOSE 8080
 
# ENV APP_HOME /usr/src/app

# COPY target/*.jar $APP_HOME/app.jar

# WORKDIR $APP_HOME

# CMD ["java", "-jar", "app.jar"]