import mysql.connector

def create_databse():
    conn=mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456"
    )
    c=conn.cursor()
    c.execute("CREATE DATABASE IF NOT EXISTS budgetify")
    print("Database created successfully")



def create_user_records_table():
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    print("connection established")
    c=conn.cursor()
    c.execute('''CREATE TABLE  IF NOT EXISTS USER_RECORD
         (User_ID int PRIMARY KEY AUTO_INCREMENT,
         First_name VARCHAR(50),
         Last_name  VARCHAR(50),
         Email      VARCHAR(50),
         Password   VARCHAR(50),
         Gender     VARCHAR(50),
         DOB        DATE,
         Job_title  VARCHAR(30),
         City       VARCHAR(35))''')
    print("Table created successfully")
    conn.commit()
    conn.close()




def insert_value(firstname, lastname, email, password, gender,dob, jobtitle, city):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    print("connection established")
    c=conn.cursor()
    c.execute("INSERT INTO USER_RECORD (First_name,Last_name,Email,Password,Gender,DOB,Job_title,City) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",(firstname, lastname, email, password, gender,dob, jobtitle, city))
    print("inserted succefully")
    conn.commit()
    conn.close()


def check_password(email):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    print("connection established")
    c=conn.cursor()
    c.execute("SELECT Password from USER_RECORD WHERE Email=(%s)",(email,))
    item=c.fetchone()
    conn.commit
    conn.close()
    return(item[0])




def create_user_expense_table(email):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    print("connection established")
    c=conn.cursor()
    c.execute("SELECT User_ID,Last_name from USER_RECORD WHERE Email=(%s) LIMIT 0,1",(email,))
    item=c.fetchone()
    usertablename=str(item[1])+"_"+str(item[0])
    print(usertablename)
    query = "CREATE TABLE {} (Trans_ID INT,Date DATETIME,Catagory VARCHAR(50),Amount INT)".format(usertablename)
    c.execute(query)
    print("transaction table created for "+usertablename)
    conn.commit
    conn.close()

