
# Provision instances and deploy applications.

This script allows you to launch an instance on Amazon-EC2.
Running the script automatically provisions machines and installs web application ( nginix used here )
It then changes nginx config to include maintenance mode and restart nginx service.
Before running the script , git clone and set the script paths in yml files respectively .

Before You Start
Create an Amazon EC2 keypair for yourself. Make sure that you set the permissions for the private key file to 600 (i.e. only you can read and write it) so that ssh will work.
Whenever you want to use this script , set the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to your Amazon EC2 access key ID and secret access key. These can be obtained from the AWS homepage by clicking Account > Security Credentials > Access Credentials.
Launching An Instance

Git clone https://github.com/harshg7/ansible-web-app.git into your local machine
Export the environment variables from your machine before you run the script.
For example:
export AWS_SECRET_ACCESS_KEY= AaBcDeFg
export AWS_ACCESS_KEY_ID= abcd123

Running the script
Make sure Ansible is installed in your system and initially git clone this repository.
Git clone gives you three different files:
1. ansible/instance_creation.yml 
- Ansible playbook which launches instance on AWS
2. provision.sh 
- Starts up ssh agent
- sets variables
- Adds pem key to ssh add
- Runs ansible playbook with instance_creation.yml

Making sure the above necessary steps are followed, begin the programming below :

Login process to my instance:
-----------------------
Run : 
ssh -i my_key.pem ubuntu@i.p.address

Deliverables:
# How to push new version of web-app
Replace the contents at /usr/share/nginx/html/ with the new version of application files by unzipping that archive in this directory.

# How we scale this solution out to multiple application servers in an automated fashion.
Edit ansible-web-app/ansible/instance_creation.yml
In order to scale the count values ; edit ansible-web-app/ansible/instance_creation.yml ( line 32:count : ) to your count .
This way ,we could get 2,3 or 5 web-apps running on different ec2 instances. 
Also you could use Auto-Scaling group on AWS alterantively.

# If this were a true production deployment.
For true deployment there is 99.9% availablity. So we can not put into maintenance mode directly. 
We need to setup a parallel instance with same web-app and connect this new and old web app to load balancer (Elastic load balancer in AWS ).
Then we could make one off-line ; work on it.

In depth :
#When you run playbook:
# Running custom playbook(sample running)
------------------------
ubuntu@ipaddress:~$ ./provision.sh
```
newec2ipaddress               : ok=6    changed=4    unreachable=0    failed=0
localhost                  : ok=5    changed=2    unreachable=0    failed=0
```
# How Maintenance works
if [/usr/share/nginx/html/maintenance_on.html] is present on the new instance its in maintenance mode ON
or else its maintenance mode OFF

# Maintenance Mode ON
```
sudo mv /usr/share/nginx/html/maintenance_off.html /usr/share/nginx/html/maintenance_on.html
```
# Maintenance Mode OFF
```
sudo mv /usr/share/nginx/html/maintenance_on.html /usr/share/nginx/html/maintenance_off.html
```
