
```
brew install awscli
aws configure

# Terraform isn't OSI-compliant as of Apr 2025?
# brew install terraform
# We'll use https://opentofu.org/ as a drop-in replacement instead? 
brew install opentofu
tofu init
tofu plan -out tf.out
tofu apply tf.out

aws s3 ls s3://cp-s3-bucket-fy02qh9e
aws sts get-caller-identity --no-cli-pager

aws glue start-crawler --name csv-data-crawler --region us-east-1
python3 query.py
```
