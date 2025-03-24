# SQL-PracticeProject

## Overview

In this project, I followed [Alex The Analyst's YouTube tutorial](https://www.youtube.com/watch?v=OT1RErkfLNQ) to clean and prepare the [Layoffs 2022 dataset from Kaggle](https://www.kaggle.com/datasets/swaptr/layoffs-2022) for exploratory analysis. Using SQL, I performed comprehensive data cleaning including removing duplicate records, standardizing data, handling missing values, modifying column data types and eliminating unnecessary columns.

This was made using MySQL in VsCode with the [SQLTools extension](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools) .

---

## Getting Started

### Prerequisites

- **Docker**: Ensure Docker is installed on your machine.
- **Docker Compose**: Docker Compose is usually included with Docker Desktop.

### Running the Project with Docker

1. Clone the repository:

```bash
git clone https://github.com/AaronOrtega1/SQL-PracticeProject
cd SQL-PracticeProject
```

2. Build and start the Docker container:

```bash
docker compose up -d --build
```

3. Copy the CSV to the docker container

```bash
docker cp ./db/layoffs.csv mysql_dev:/tmp/layoffs.csv
```

4. Use [the create table SQL file.](./1.CreateTable.sql)

5. Use the following command to enter the terminal of the container

```bash
docker exec -it mysql_dev mysql -u root -p
```

It's going to ask you the password and it is **root**

6. Set global local_infile to 1 so you can load the CSV file to the table

```bash
SET GLOBAL local_infile = 1;
```

7. With the following command it shows you the local_infile variable state it should be **ON**

```bash
SHOW GLOBAL VARIABLES LIKE 'local_infile';
```

8. If the state of the variable its ON you are good to run the followings commands to populate the table we create in step 4.

```bash
USE my_database;
```

```bash
LOAD DATA LOCAL INFILE '/tmp/layoffs.csv'
INTO TABLE layoffs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

It will display a message link this one:

```
LOAD DATA LOCAL INFILE '/tmp/layoffs.csv'
INTO TABLE layoffs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

9. Once all the previous steps are done we can continue with the project in [the data preprocessing file](./2.DataPreprocessing.sql).

10. To remove the container you run:

```bash
docker compose down
```
