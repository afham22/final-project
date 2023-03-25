import sqlite3

#--To create databse--
# conn = sqlite3.connect('budgetify.db')
# print('Database created')

# conn = sqlite3.connect('budgetify.db')
# conn = sqlite3.connect('budgetify.db')


def create_user_records_table():
     conn = sqlite3.connect('budgetify.db')
     c=conn.cursor()
     c.execute('''CREATE TABLE  IF NOT EXISTS USER_RECORD
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
     conn.commit()
     conn.close()



def insert_value(firstname, lastname, email, password, gender,dob, jobtitle, city):
     conn = sqlite3.connect('budgetify.db')
     c=conn.cursor()
     c.execute("INSERT INTO USER_RECORD (First_name,Last_name,Email,Password,Gender,DOB,Job_title,City) VALUES (?,?,?,?,?,?,?,?)",(firstname, lastname, email, password, gender,dob, jobtitle, city))
     print("inserted succefully")
     conn.commit()
     conn.close()

def create_user_expense_table(email):
     conn = sqlite3.connect('budgetify.db')
     c=conn.cursor()
     c.execute("SELECT User_ID,Last_name from USER_RECORD WHERE Email=(?)",(email,))
     item=c.fetchone()
     usertablename=str(item[1])+"_"+str(item[0])
     print(usertablename)
     c.execute("CREATE TABLE %s (Trans_ID INTEGER,Date VARCHAR(10),Catogory VARCHAR(50),Amount VARCHAR(50));"%(usertablename))
     print("transaction table created for "+usertablename)
     conn.commit
     conn.close()

def check_password(email):
     conn = sqlite3.connect('budgetify.db')
     c=conn.cursor()
     c.execute("SELECT Password from USER_RECORD WHERE Email=(?)",(email,))
     item=c.fetchone()
     conn.commit
     conn.close()
     return(item[0])
# csreate_user_expense_table('shahrukh@gmail.com')
