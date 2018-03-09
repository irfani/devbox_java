# Devbox Java

Dockerize your java application.

Project ini menggunakan docker-compose yang terdiri dari 2 container :
- devserver (OpenJDK + dcevm + maven + gradle + nodejs + git)
- database (postgresql)


# Requirements
- Install [Docker](https://docs.docker.com/engine/installation/)
- Install [Docker Compose](https://docs.docker.com/compose/install/) 
- Ports yang dibuka 8080, 8000 (utk aplikasi), 5005 (remote debugging), 5432 (postgresql)

# Launching
- Clone repo 

        git clone https://github.com/irfani/devbox_java.git
        cd devbox_java

- Jalankan docker compose

        docker-compose up -d
                
- Jika sudah selesai struktur project akan seperti ini

      devbox_java
      |-- src
      |-- postgres-data
      |-- gradle-repo
      |-- m2-repo
	  ..
	  src : sourcecode project copy disini
	  postgres-data : menyimpan database (agar data tersimpan persistent)
	  gradle-repo : menyimpan library dari gradle
	  m2-repo : menyimpan libary dari maven
	  
      
- Masuk ke docker container, start directory difolder 'src' 

      docker exec -it devbox /bin/bash
	  developer@27d13e014ec0:~/src$

- Setting database connection

      lakukan setup di source code anda misal sepert ini. username & pass = postgres (dapat diubah di docker-compose.yml)
	  db.url=jdbc:postgresql://postgres:5432/pg_db 
	  	 
- Shutdown devbox

      docker-compose down
	



