if [ $# -lt 1 ];
then
    echo "Please specify a customer email to login"
    echo "Example: ./customer.sh roylayindeay0@gmail.com"
fi

customer=$1

#Fetching the secret values of customers saved in aws secrets manager
CUSTOMERS = `aws secretsmanager get-secret-value \
    --secret-id mym/sociamedia \
    --query "SecretString" \
    --output text`

# RETRIEVE ALL REQUIRED VARIABLES FROM THIS, password or secretkeys
$password=`"$CUSTOMERS" | jq -r ".password"`
$account=`"$CUSTOMERS" | jq -r ".account"`

# login to appropriate platforms using the secretkeys