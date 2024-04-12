import pyarrow as pa
import pyarrow.parquet as pq
import os

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/home/src/my-data-project-13837-ec24ebb154b1.json"

bucket_name = 'datatalkclub_tinchung_project'
project_id = 'my-data-project-13837'

table_name = "us_accidents"

root_path = f"{bucket_name}/{table_name}"
@data_exporter
def export_data(data, *args, **kwargs):
    data['Start_Time']= data['Start_Time'].dt.year

    table = pa.Table.from_pandas(data)
    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path,
        partition_cols = ['Start_Time'],
        filesystem = gcs
    )   

