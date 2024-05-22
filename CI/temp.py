def even_more_temp():
    import pandas as pd
    from sqlalchemy import create_engine

    # Replace the following with your database connection info
    db_username = 'postgres'
    db_password = 'postgres'
    db_host = 'localhost'
    db_port = '5437'
    db_name = 'postgres'
    table_name = 'transactions_4'
    n_rows = 100
    schema = 'transformed_elementary'

    # Setup the database connection
    engine = create_engine(f'postgresql://{db_username}:{db_password}@{db_host}:{db_port}/{db_name}')

    # SQL query to select the last 20 rows from your table
    # Replace 'your_ordering_column' with the column you want to use for ordering
    sql_query = f'''
    SELECT * FROM {schema}.{table_name};
    '''

    # Execute the query and read the result into a DataFrame
    df = pd.read_sql_query(sql_query, engine)

    # Reverse the order to have it in ascending order, if needed
    df = df.iloc[::-1]

    # Save the DataFrame to a CSV file
    # Replace 'last_20_rows.csv' with your desired output file name
    df.to_csv(f'{table_name}.csv', index=False)


if __name__ == '__main__':
    even_more_temp()
