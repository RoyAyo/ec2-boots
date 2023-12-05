### REQUIREMENTS

You should have aws installed on your device, so you can use the aws cli, you can request access to an iam user with the appropriate role to carry out the operations.
Configure the user with `sh aws configure`

### CREATING THE INSTANCE

- You should have a security group, one has already been created for the sake of this
- You should find a subnet-id in the region you will be using, simply running ``
- Edit the values in the start.sh and run `sh ./start.sh`
- Ensure you have permissions to run the file, otherwise `sh chmod 700 ./`
- This will start and bootstrap with `start.sh` running as root
- Copy the details of the instance created and start server

## ALTERNATIVE TO boostraping script

- After logging in, you can install git
- Run `sh git clone https://github.com/RoyAyo/ec2-boots.git .`
- Run `sh ./start.sh`

### Login to instance

- You should have a "mym.pem" key in the current folder
- You can ssh to server using `ssh -i mym.pem ec2-user@${public-dns}`

### Fetch customer credentials for login

- `./customer customer1@gmail.com`
- The script will include the logic for social media login after collecting credentials depending on platform