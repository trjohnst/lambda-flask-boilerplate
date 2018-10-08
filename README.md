# Overview

This is a boilerplate repo to get started with [zappa](https://github.com/Miserlou/Zappa) and jump off from where [these instructions](https://hackernoon.com/deploy-a-serverless-flask-application-on-aws-lambda-d8ca58af42a4) land (plus a little bit of debugging done for you).

These files can be used to setup a basic docker image that can be used to create containers to deploy to

# Usage

## 1. AWS Configs

Add a `config` file and `credentials` file to the `aws` folder. You can refer to the [sample config](aws/sample_config) and the [sample credentials](aws/sample_credentials).

You can generate your own credentials after setting up an AWS account, going into your AWS console and following [these instructions](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys).

## 2. Zappa Settings

Modify the [zappa_settings.json](zappa_settings.json) file to include your region (matching the one from aws/config) and your profile (matching the one provided in aws/credentials).

## 3. Build the image

You can build the image simply with `docker build --rm -t lambda-flask .`

## 4. Deploying in a container

```bash
# Run a container from the image
docker run --rm -ti lambda-flask /bin/ash
# Activate the pre-made python virtual environment (it has everything you need installed)
source serverlessbot/bin/activate
# Deploy your dev instance
zappa deploy dev
```

The end of the deployment will say `Deployment complete!` followed by a URL. You can navigate to the URL and verify that it says "Hello World!"

## 5. Undeploying

Once you are done running your test, you should undeploy to clean up.

You can undeploy, while in the virtual environment, with `zappa undeploy` and hit `y` when prompted.

I've also found that the S3 buckets stick around so you may want to delete the bucket that you created. You can find this bucket in your AWS console and it will correspond to the `s3_bucket` setting in [zappa_settings.json](zappa_settings.json).

## 6. Exiting

```bash
# Get out of the python virtual environment
deactivate
# Exit the container
exit
```

# Troubleshooting

## Operation Not Found

If you encounter output like the following:
```bash
Traceback (most recent call last):
  File "/usr/local/lib/python3.6/site-packages/zappa/core.py", line 911, in upload_to_s3
    self.s3_client.head_bucket(Bucket=bucket_name)
  File "/usr/local/lib/python3.6/site-packages/botocore/client.py", line 320, in _api_call
    return self._make_api_call(operation_name, kwargs)
  File "/usr/local/lib/python3.6/site-packages/botocore/client.py", line 623, in _make_api_call
    raise error_class(parsed_response, operation_name)
botocore.exceptions.ClientError: An error occurred (404) when calling the HeadBucket operation: Not Found
```

Double check your credentials! It's likely the `aws/credential` credentials file that you created is not setup right.

