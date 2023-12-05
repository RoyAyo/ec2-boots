aws ec2 create-key-pair --key-name newkey --query 'KeyMaterial' --output text > mym.pem

chmod 400 mym.pem

aws iam create-role --role-name secretsAccessRole --assume-role-policy-document file://Trust-Policy.json
aws iam attach-role-policy --role-name secretsAccessRole --policy-arn arn:aws:iam::aws:policy/SecretsManagerReadWrite
aws iam create-instance-profile --instance-profile-name secretsAccessInstanceProfile
aws iam add-role-to-instance-profile --role-name secretsAccessRole --instance-profile-name secretsAccessInstanceProfile

# You need at least a 2gb ram to run this GUI
aws ec2 run-instances \
    --image-id ami-0669b163befffbdfc \
    --count 1 \
    --instance-type t2.micro \
    --key-name newkey \
    --iam-instance-profile Name="secretsAccessInstanceProfile" \
    --security-group-ids sg-06c1482d1fd7a3801 \
    --subnet-id subnet-09545e82265148495 \
    --user-data file://start.sh