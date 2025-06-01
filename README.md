# DataPlatformExercise

---

## 🧰 Project Goal

**Build a real-world, modular data platform using Docker** to learn:

* Core Docker concepts (images, volumes, networks)
* Multi-container orchestration with `docker-compose`
* Persistent storage & inter-service communication
* Realistic data engineering setup for hands-on learning

---

## 📦 Services Used

| Service              | Description                        | Tech                                            |
| -------------------- | ---------------------------------- | ----------------------------------------------- |
| **MySQL**            | Relational database                | mysql:8.0                                       |
| **Adminer**          | Lightweight DB web interface (GUI) | adminer                                         |
| **Jupyter Notebook** | Data analysis, visualization       | Custom Dockerfile using `jupyter/base-notebook` |

---

## 🗂️ Project Folder Structure

```
mini-data-platform/
├── .env                       # Environment configs for all services
├── docker-compose.yml         # Orchestrates all containers
├── .gitignore                 # Ignores local/OS/docker artifacts
├── mysql/
│   └── init.sql               # SQL script for DB setup and seed data
└── jupyter/
    └── Dockerfile             # Custom image for Jupyter with Python packages
```

---

## 🔐 .env File

Contains all sensitive and configurable variables:

```env
# MySQL credentials
MYSQL_ROOT_PASSWORD=rootpass
MYSQL_DATABASE=projectdb
MYSQL_USER=projectuser
MYSQL_PASSWORD=projectpass

# Jupyter
JUPYTER_PORT=8888
```

---

## 🧱 docker-compose.yml File

Defines the entire multi-service stack:

```yaml

services:
  mysql:
    image: mysql:8.0
    container_name: mysql_container
    restart: unless-stopped
    env_file: .env
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
      - ./mysql/init.sql:/docker-entrypoint-initdb.d/init.sql

  adminer:
    image: adminer
    container_name: adminer
    restart: unless-stopped
    ports:
      - "8080:8080"

  jupyter:
    build: ./jupyter
    container_name: jupyter_notebook
    restart: unless-stopped
    ports:
      - "${JUPYTER_PORT}:8888"
    volumes:
      - ./jupyter:/home/jovyan/work
    depends_on:
      - mysql

volumes:
  mysql_data:
```

---

## 📁 `mysql/init.sql`

Auto-runs when MySQL starts:

```sql
CREATE TABLE IF NOT EXISTS customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customers (name, email)
VALUES ('Alice', 'alice@example.com'), ('Bob', 'bob@example.com');
```

---

## 🐍 jupyter/Dockerfile

Builds a custom Jupyter Notebook image with SQL + Data tools:

```Dockerfile
FROM jupyter/base-notebook

RUN pip install pandas sqlalchemy mysql-connector-python
```

---

## 🔧 Run the Project

```bash
cd mini-data-platform
docker compose up -d
```

Check logs if you want to see what's happening:

```bash
docker compose logs -f
```

---

## 🌐 Access Services

| Tool                  | URL / Host                                     | Notes                                  |
| --------------------- | ---------------------------------------------- | -------------------------------------- |
| Adminer GUI           | [http://localhost:8080](http://localhost:8080) | Server: `mysql`, User/pass from `.env` |
| Jupyter Notebook      | [http://localhost:8888](http://localhost:8888) | Token in logs or browser auth          |
| MySQL (CLI/Workbench) | `localhost:3306`                               | Use root or user credentials           |

---

## 🧑‍💻 Connect to MySQL via CLI

```bash
docker exec -it mysql_container mysql -u root -p
```

Enter the root password defined in `.env`.

---

## 🧠 What You’ll Learn in This Setup

| Docker Skill      | Example                                                        |
| ----------------- | -------------------------------------------------------------- |
| Volumes           | Persistent MySQL data via `mysql_data` named volume            |
| Networking        | Containers talk using service names (`mysql`, `jupyter`)       |
| Custom Images     | Build your own Jupyter image with required packages            |
| Compose Lifecycle | `docker compose up -d`, `down`, `logs`, `ps`, etc.             |
| Auto-init scripts | Load SQL on container start with `/docker-entrypoint-initdb.d` |

---

## ✅ Next Steps

You can extend this project with:

* 🔄 Apache Airflow to schedule ETL tasks
* ⚙️ Apache Spark for big data processing
* 🧪 Jupyter integration with SQLAlchemy to query MySQL
* ☁️ Docker Compose override files for production vs dev

---

