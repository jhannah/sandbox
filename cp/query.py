# python3 -m venv .
# source bin/activate
# python3 -m pip install pyathena pandas

from pyathena import connect
import pandas as pd
import boto3
import os

region_name = "us-east-1"
s3_bucket = "cp-s3-bucket-fy02qh9e"
s3_athena_output = f"s3://{s3_bucket}/athena_query_results/"
s3_csv_output = "python_out"

conn = connect(
    s3_staging_dir=s3_athena_output,
    region_name=region_name,
    schema_name="cp_data_lake"
)

query = "SELECT * FROM user_events LIMIT 10"
df = pd.read_sql(query, conn)

if 'event_time' in df.columns:
    df['event_time'] = pd.to_datetime(df['event_time'])
    df = df.sort_values(['user_id', 'event_time'])
    # Add a lag_seconds column to the dataframe
    df['lag_seconds'] = df.groupby('user_id')['event_time'].diff().dt.total_seconds()
    # print(df[['user_id', 'event_type', 'event_time', 'lag_seconds']])
    # We might want this someday: mean lag per user_id
    # print(df.groupby('user_id')['lag_seconds'].mean())
else:
    print(df)

tmp_file = "user_events_with_lag.csv"
df.to_csv(tmp_file, index=False)
s3 = boto3.client('s3')
s3_key = f"{s3_csv_output}/{tmp_file}"
print(f"Uploading {s3_key} to S3")
s3.upload_file(tmp_file, s3_bucket, s3_key)
os.remove(tmp_file)
