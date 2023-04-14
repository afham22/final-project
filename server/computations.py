import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import OneHotEncoder

# Loading the data into a pandas dataframe
# df = pd.read_csv('/kaggle/input/income-expenditure-demography-of-cities-in-india/Income expenditure demography.csv')
df=pd.read_csv('dataset.csv')
# Encoding the categorical variables using one-hot encoding
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


def PPP():
    # Load the dataset into a Pandas DataFrame
    df = pd.read_csv('dataset.csv')

    city2 = 'Bangalore'
    city3 = input('Enter city: ')

    category_list = [('Housing', 17371), ('Entertainment', 5000)]

    # Calculate the average expenses for each category for the two cities
    result = df.groupby(['City'])[['Housing', 'Leisure', 'Entertainment', 'Insurance', 'Medical','Transportation','Groceries','Utilities']].mean().loc[[city2]]
    result_dest = df.groupby(['City'])[['Housing', 'Leisure', 'Entertainment', 'Insurance', 'Medical','Transportation','Groceries','Utilities']].mean().loc[[city3]]

    # Calculate the ratio for each category based on the provided list
    ratio_list = [(category, value / result.loc[city2][category]) for category, value in category_list]

    # Calculate the expenses for each category in the destination city based on the ratio list
    expenses_city = pd.DataFrame([value * result_dest.loc[city3][category] for category, value in ratio_list], index=[category for category, value in ratio_list], columns=['Expenses'])

    # Print the results
    print(f'\nAverage expenses for {city2}: \n{result.loc[city2]}')
    print(f'\nAverage expenses for {city3}: \n{result_dest.loc[city3]}')
    print(f'\nExpenses for {city3} based on the provided category list: \n{expenses_city}')
    # Convert expenses_city to a dictionary
    expenses_dict = expenses_city.to_dict()

    # Convert the dictionary to a JSON string
    expenses_json = json.dumps(expenses_dict)

    # Print the JSON string
    print(expenses_json)