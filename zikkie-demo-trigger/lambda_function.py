import json
import urllib.parse


def lambda_handler(event, context):
    print(f"executing lambda for payload: {event} and context {context}")
    bucket = event["Records"][0]["s3"]["bucket"]["name"]
    key = urllib.parse.unquote_plus(event["Records"][0]["s3"]["object"]["key"], encoding="utf-8")
    print(f"Make API call to orchestrator asking it to process file {key} from bucket {bucket}")
    return {"statusCode": 200, "body": json.dumps("Successfully submitted job to Orchestrator!!")}
