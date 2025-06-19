# python3 -m venv .
# source bin/activate
# python3 -m pip install pyathena pandas

from pyathena import connect
import pandas as pd

region_name = "us-east-1"
s3_output = "s3://cp-s3-bucket-fy02qh9e/athena_query_results/"

conn = connect(
    s3_staging_dir=s3_output,
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
    print(df[['user_id', 'event_type', 'event_time', 'lag_seconds']])
    # This is pretty handy: report mean lag per user_id
    print(df.groupby('user_id')['lag_seconds'].mean())
else:
    print(df)
