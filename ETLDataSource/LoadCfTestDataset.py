import pandas as pd
import pyodbc
import logging

table_name = "CfTestDataset"

data = pd.read_csv (r'E:\UFO\Selectel\TestSelectel\DataSource\cf_test_dataset.csv',sep='\t')   
df = pd.DataFrame(data, columns= ['user_id' 
                    ,'server_order_id'
                    ,'service_id'
                    ,'server_configuration'
                    ,'service_start_date'
                    ,'service_end_date'
                    ,'user_id'
                    ,'user_name'
                    ,'user_surname'
                    ,'price'])
df = df.fillna(0.0)
print(df)


conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=localhost;'
                      'Database=StagingArea;'
                      'Trusted_Connection=yes;')
cursor = conn.cursor()
cursor.execute("TRUNCATE TABLE CfTestDataset")
   
for row in df.itertuples():
    cursor.execute('''
                INSERT INTO CfTestDataset (
                    [user_id] 
                    ,[server_order_id]
                    ,[service_id]
                    ,[server_configuration]
                    ,[service_start_date]
                    ,[service_end_date]
                    ,[user_id_1]
                    ,[user_name]
                    ,[user_surname]
                    ,[price])
                VALUES (?,?,?,?,?,?,?,?,?,?)
                ''',
                     row.user_id 
                    ,row.server_order_id
                    ,row.service_id
                    ,row.server_configuration
                    ,row.service_start_date
                    ,row.service_end_date
                    ,row.user_id
                    ,row.user_name
                    ,row.user_surname
                    ,row.price
                )
conn.commit()

logging.warning('Watch out!')