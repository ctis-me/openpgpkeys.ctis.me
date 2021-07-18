#!/usr/bin/env zsh

# Synchronize local directory contents with ctis.me s3 bucket
aws s3 sync --acl 'public-read' . s3://openpgpkey.ctis.me

# Update bucket website settings (including routing rules)
aws s3api put-bucket-website --bucket openpgpkey.ctis.me --website-configuration file://bucket_website.json

# Lazily invalidate all paths on the Cloudfront distribution for ctis.me
aws cloudfront create-invalidation --distribution-id 'EDQO3ZCCWRHN7' --paths '/*'
