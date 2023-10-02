import pandas as pd
from sqlalchemy import create_engine

# Specify the Excel file path
excel_file = "/D:/mcb_test/Corruption_Perception_Index_Data_Set.xlsx"

# Specify the database connection parameters
db_params = {
    "host": "localhost",
    "port": "5432",
    "user": "postgres",
    "password": "test",
    "dbname": "mcb_test",
}

csv_folder = "/D:/mcb_test/converted"  # Replace with the folder where CSV files will be saved

# Read the Excel file into a Pandas ExcelFile object
xls = pd.ExcelFile(excel_file)

# Initialize a database connection
db_url = f"postgresql://{db_params['user']}:{db_params['password']}@{db_params['host']}:{db_params['port']}/{db_params['dbname']}"
engine = create_engine(db_url)

# Loop through each sheet in the Excel file and convert it to CSV
for sheet_name in xls.sheet_names:
    # Read the sheet into a DataFrame
    df = pd.read_excel(xls, sheet_name=sheet_name)

    # Define the CSV file path for each sheet
    csv_file = f"{csv_folder}/{sheet_name}.csv"

    # Save the DataFrame as a CSV file
    df.to_csv(csv_file, index=False)

    # Import the CSV data into the database
    df.to_sql(sheet_name, engine, if_exists="replace", index=False)

# Run the stored procedure
with engine.connect() as connection:
    connection.execute("EXECUTE proc_load_corruption_perception_index()")

print("Conversion to CSV and database import completed.")
