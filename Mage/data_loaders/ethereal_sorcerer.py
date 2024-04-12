from mage_ai.io.file import FileIO
if 'data_loader' not in globals():
   from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
   from mage_ai.data_preparation.decorators import test
import pandas as pd
import polars as pl



@data_loader
def load_data_from_file(*args, **kwargs):
   """
   Template for loading data from filesystem.
   Load data from 1 file or multiple file directories.


   For multiple directories, use the following:
       FileIO().load(file_directories=['dir_1', 'dir_2'])


   Docs: https://docs.mage.ai/design/data-loading#fileio
   """
   filepath = '/home/src/US_Accidents_March23_sampled_500k.csv'
       # DEFINE A DICTIONARY OF DATA TYPES FOR THE NON DATETIME COLUMNS
   dtypes = {
   'ID': str,
   'Source': str,
   'Severity': float,


   'Start_Lat': float,
   'Start_Lng': float,
   'End_Lat': float,
   'End_Lng': float,
   'Distance(mi)': float,
   'Description': str,
   'Street': str,
   'City': str,
   'County': str,
   'State': str,
   'Zipcode': str,
   'Country': str,
   'Timezone': str,
   'Airport_Code': str,
   'Weather_Timestamp': str,
   'Temperature(F)': float,
   'Wind_Chill(F)': float,
   'Humidity(%)': float,
   'Pressure(in)': float,
   'Visibility(mi)': float,
   'Wind_Direction': str,
   'Wind_Speed(mph)': float,
   'Precipitation(in)': float,
   'Weather_Condition': str, }


   # CREATE A LIST OF DATETIME COLUMNS.
   # The list will be passed to the read_csv function and pandas will parse the columns as dates with the appropriate time stamps. 
   parse_dates = ['Start_Time','End_Time']
#return pd.read_csv(url, sep=',', compression="gzip", dtype=taxi_dtypes, parse_dates=parse_dates)
   return pd.read_csv(filepath,dtype=dtypes, parse_dates=parse_dates)




@test
def test_output(output, *args) -> None:
   """
   Template code for testing the output of the block.
   """
   assert output is not None, 'The output is undefined'
