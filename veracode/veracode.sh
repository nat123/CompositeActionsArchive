#!/bin/sh -l
VERACODE_API_ID=$(aws secretsmanager get-secret-value --secret-id AE/EDL/VERACODE_API_KEYS --region us-east-1 | jq -r .SecretString | jq -r .APPID_VERACODE_API_ID)
VERACODE_API_KEY=$(aws secretsmanager get-secret-value --secret-id AE/EDL/VERACODE_API_KEYS --region us-east-1 | jq -r .SecretString | jq -r .APPID_VERACODE_API_KEY)
zip -r veracode.zip .
curl -O https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip
unzip -o pipeline-scan-LATEST.zip pipeline-scan.jar
java -jar pipeline-scan.jar \
--veracode_api_id $VERACODE_API_ID \
--veracode_api_key $VERACODE_API_KEY \
--file veracode.zip \
--summary_display true \
--issue_details true \
--fail_on_severity="Very High, High" \
--timeout 10               
© 2022 GitHub, Inc.
Help
