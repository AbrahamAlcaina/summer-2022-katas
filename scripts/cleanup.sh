# Local .env
if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | sed 's/\r$//' | awk '/=/ {print $1}' )
fi

echo "Delete $ENVIRONMENT" 
az group delete --name "rg-$ENVIRONMENT"