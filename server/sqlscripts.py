import sqlite3

#--To create databse--
# conn = sqlite3.connect('budgetify.db')
# print('Database created')

# conn = sqlite3.connect('budgetify.db')
conn = sqlite3.connect('budgetify.db')

def create_user_records_table():
    conn.execute('''CREATE TABLE  IF NOT EXISTS USER_RECORD
         (User_ID INTEGER PRIMARY KEY AUTOINCREMENT,
         First_name VARCHAR(50),
         Last_name  VARCHAR(50),
         Email      VARCHAR(50),
         Password   VARCHAR(50),
         Gender     CHAR(1),
         DOB        VARCHAR(10),
         Job_title  VARCHAR(30),
         City       VARCHAR(35));''')
    print("Table created successfully")
