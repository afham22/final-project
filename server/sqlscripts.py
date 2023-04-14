import mysql.connector
import datetime

def create_database():
    conn=mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456"
    )
    c=conn.cursor()
    c.execute("CREATE DATABASE IF NOT EXISTS budgetify")



def create_user_records_table():
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
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
         Income     INT,
         City       VARCHAR(35))''')
    conn.commit()
    conn.close()




def createAccount(firstname, lastname, email, password, gender,dob, jobtitle, city):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c=conn.cursor()
    c.execute("INSERT INTO USER_RECORD (First_name,Last_name,Email,Password,Gender,DOB,Job_title,City) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",(firstname, lastname, email, password, gender,dob, jobtitle, city))
    c.execute("SELECT User_ID,Last_name from USER_RECORD WHERE Email=(%s) LIMIT 0,1",(email,))
    item=c.fetchone()
    uid=str(item[1])
    lname=str(item[0])
    conn.commit()
    conn.close()
    return uid,lname


def check_password(email):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c=conn.cursor()
    c.execute("SELECT Password,User_ID,Last_name from USER_RECORD WHERE Email=(%s)",(email,))
    item=c.fetchone()
    conn.commit
    conn.close()
    if item ==None:
        return None
    else:
        return(item)
    

def check_email(email):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c= conn.cursor()
    sql = "SELECT * FROM USER_RECORD WHERE email = %s"
    c.execute(sql, (email,))
    result = c.fetchall()
    conn.close()
    if len(result) > 0:
        return True
    else:
        return False




def create_user_expense_table(uid,lname):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c=conn.cursor()
    usertablename=lname+"_"+uid
    print(usertablename)
    query = "CREATE TABLE {} (Trans_ID INT,Date DATETIME,Category VARCHAR(50),Amount INT)".format(usertablename)
    c.execute(query)
    conn.commit
    conn.close()

def sumOfExpenseFor30(UserId,lastname):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c=conn.cursor()
    current_date = datetime.date.today()
    new_date = current_date - datetime.timedelta(days=30)
    usertablename=str(UserId)+"_"+lastname
    sql="SELECT Category,SUM(Amount) FROM {} WHERE Date BETWEEN (%s) AND (%s) GROUP BY Category;".format(usertablename)
    c.execute(sql,(new_date,current_date))
    item=c.fetchall()
    print(item)
    conn.commit
    conn.close()


def insert_value_trans(transid,date,cat,amo,lastname,userid):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c=conn.cursor()
    usertablename=str(userid)+"_"+lastname
    sql=("INSERT INTO {} (Trans_ID,Date,Category,Amount) VALUES (%s,%s,%s,%s)".format(usertablename))
    c.execute(sql,(transid,date,cat,amo))
    conn.commit()
    conn.close()


def test():
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c=conn.cursor()
    c.execute("SELECT user_id, Last_name FROM user_record;")
    item=c.fetchall()
    first,last=previousDates()
    for i in range(len(item)):
        tablename=str(item[i][0])+'_'+str(item[i][1])
        print(tablename)
        sql="SELECT Category,SUM(Amount) FROM {} WHERE Date BETWEEN (%s) AND (%s) GROUP BY Category;".format(tablename)
        c.execute(sql,(first,last))
        dar=c.fetchall()
        print(dar)
    conn.commit
    conn.close()


def delete_value_trans(transid,lastname,userid):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c=conn.cursor()
    usertablename=str(userid)+"_"+lastname
    sql=("DELETE FROM {} WHERE Trans_ID = (%s)".format(usertablename))
    c.execute(sql,(str(transid),))
    conn.commit()
    conn.close()


def previousDates():

    today = datetime.date.today()
    if today.month == 1:
        first_day_of_month = datetime.date(today.year - 1, 12, 1)
    else:
        first_day_of_month = datetime.date(today.year, today.month - 1, 1)

    last_day_of_month = first_day_of_month.replace(day=28) + datetime.timedelta(days=4)
    last_day_of_month = last_day_of_month - datetime.timedelta(days=last_day_of_month.day)

    return first_day_of_month,last_day_of_month


def getExpense(UserId,lastname):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c= conn.cursor()
    usertablename=str(UserId)+"_"+lastname
    first,last=previousDates()
    sql="SELECT Category,SUM(Amount) FROM {} WHERE Date BETWEEN (%s) AND (%s) GROUP BY Category;".format(usertablename)
    c.execute(sql,(first,last))
    dar=c.fetchall()
    conn.commit
    conn.close()
    return dar

def demo(UserId):
    conn =mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="123456",
        database="budgetify"
    )
    c=conn.cursor()
    c.execute("SELECT Gender,Job_title,City,Income,DOB from USER_RECORD WHERE User_ID = %s",([UserId]))
    item=c.fetchall()
    birthdate_str = str(item[0][4])
    birthdate = datetime.datetime.strptime(birthdate_str, "%Y-%m-%d").date()
    today = datetime.date.today()
    age_in_years = today.year - birthdate.year - ((today.month, today.day) < (birthdate.month, birthdate.day))
    my_list=list((item[0]))
    my_list.pop()
    my_list.append(age_in_years)
    return my_list
    conn.commit
    conn.close()

def get_previous_n_months(n):
     today = datetime.date.today()
     previous_months = []
     for i in range(n):
        last_day_of_previous_month = today.replace(day=1) - datetime.timedelta(days=1)
        first_day_of_previous_month = last_day_of_previous_month.replace(day=1)
        previous_months.append((first_day_of_previous_month.strftime("%Y-%m-%d"), last_day_of_previous_month.strftime("%Y-%m-%d")))
        today = first_day_of_previous_month
     print(previous_months)