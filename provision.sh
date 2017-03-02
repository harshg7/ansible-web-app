eval `ssh-agent -s`
set -u # Variables must be explicit
set -e # If any command fails, fail the whole thing
set -o pipefail
# Make sure SSH knows to use the correct pem
ssh-add ansible/harshg7_ubuntu.pem
#ssh-add -l
# Load the AWS keys
export AWS_ACCESS_KEY="ABC"
export AWS_SECRET_KEY="ABC"

export AWS_ACCESS_KEY_ID='abc'
export AWS_SECRET_ACCESS_KEY='abc'
export EC2_INI_PATH=/home/ubuntu/inventory/ec2.ini
# Start a new instance
ansible-playbook  ansible/instance_creation.yml -vvvv
