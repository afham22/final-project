import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import OneHotEncoder

df=pd.read_csv("dataset.csv")

encoder = OneHotEncoder(sparse_output=False)
encoded_vars = encoder.fit_transform(df[['City', 'Gender', 'Job_Title']])
encoded_df = pd.DataFrame(encoded_vars, columns=encoder.get_feature_names_out(['City', 'Gender', 'Job_Title']))
df = pd.concat([df, encoded_df], axis=1)

df.drop(['City', 'Gender', 'Job_Title'], axis=1, inplace=True)

# Splitting the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(df.drop(['Housing', 'Groceries', 'Entertainment', 'Leisure', 'Transportation','Medical','Utilities','Insurance'], axis=1), df[['Housing', 'Groceries', 'Entertainment', 'Leisure', 'Transportation','Medical','Utilities','Insurance']], test_size=0.2, random_state=42)

# Creating an instance of the LinearRegression class
model = LinearRegression()

# Fitting the model to the training data
model.fit(X_train, y_train)
print('done')

# Evaluating the model on the testing data
    # score = model.score(X_test, y_test)
    # print('R^2 score:', score)
    


def evaluate(age,income,job_title,gender,city):
    new_input = pd.DataFrame({'Age': [age],
                          'Income': [income],
                          'Job_Title': [job_title],
                          'Gender': [gender],
                          'City': [city]})

# perform one-hot encoding on categorical columns
    encoded_vars = encoder.transform(new_input[['City', 'Gender', 'Job_Title']])
    encoded_df = pd.DataFrame(encoded_vars, columns=encoder.get_feature_names_out(['City', 'Gender', 'Job_Title']))
    new_input = pd.concat([new_input, encoded_df], axis=1)

# drop the original categorical columns
    new_input.drop(['City', 'Gender', 'Job_Title'], axis=1,inplace=True)
    # get predicted values for new input
    predictions = model.predict(new_input)
    print(predictions)
# print predicted values
    return predictions[0]
    
# train()
