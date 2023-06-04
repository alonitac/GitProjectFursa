git checkout feature/myfeature

ENDPOINTS_ACTUAL=$(grep -oP '@app\.route\(\"\/\w*\"\)' ../app.py)

ENDPOINTS_EXPECTED='''@app.route("/")
@app.route("/status")
@app.route("/blog")
@app.route("/pricing")
@app.route("/contact")
@app.route("/chat")
@app.route("/services")
@app.route("/internal")'''


if ! diff <(echo "$ENDPOINTS_ACTUAL") <(echo "$ENDPOINTS_EXPECTED") &> /dev/null
then
  echo -e "Bad server endpoints or order. Expected:"
  echo "$ENDPOINTS_EXPECTED"
  echo -e "\n\nBut found:"
  echo "$ENDPOINTS_ACTUAL"

  exit 1
fi

# test port number
PORT_HASH=$(grep -oP 'port\s*\=\s*\d+' ../app.py | tr -d ' ' | md5sum)
if [ "$PORT_HASH" != "7cd92569a5359d40fcf3c16b501175e0  -" ]
then
  echo "Bad port"
  exit 1
fi


# test service price
SERVICE_PRICE=$(grep -oP '\$\d+' ../app.py | tr -d ' ' | md5sum)
if [ "$SERVICE_PRICE" != "6e4a214edd3dfd040326c78f3b559f6e  -" ]
then
  echo "Bad service price"
  exit 1
fi

echo -e "\n\nWell done! the conflict has been resolved correctly!"
