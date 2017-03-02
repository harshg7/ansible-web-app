eval `ssh-agent -s`
set -u # Variables must be explicit
set -e # If any command fails, fail the whole thing
set -o pipefail
# Make sure SSH knows to use the correct pem
ssh-add ansible/myapp.pem
#ssh-add -l
# Load the AWS keys
export AWS_ACCESS_KEY="AKIAIT7CUHQ2VKK72HGQ"
export AWS_SECRET_KEY="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"

export AWS_ACCESS_KEY_ID='AKIAIT7CUHQ2VKK72HGQ'
export AWS_SECRET_ACCESS_KEY='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'
export EC2_INI_PATH=/home/ubuntu/inventory/ec2.ini
# Start a new instance
ansible-playbook  ansible/instance_creation.yml -vvvv

