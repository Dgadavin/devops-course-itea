# Create VPN endpoint

## Generate certificates

To generate the server and client certificates and keys and upload them to ACM

Clone the OpenVPN easy-rsa repo to your local computer.

```
git clone https://github.com/OpenVPN/easy-rsa.git
```
Navigate into the easy-rsa/easyrsa3 folder in your local repo.

```
cd easy-rsa/easyrsa3
```

Initialize a new PKI environment.

```
./easyrsa init-pki
```

Build a new certificate authority (CA).

```
./easyrsa build-ca nopass
```
Follow the prompts to build the CA.

Generate the server certificate and key.

```
./easyrsa build-server-full server nopass
```
Generate the client certificate and key.

Make sure to save the client certificate and the client private key because you will need them when you configure the client.

```
./easyrsa build-client-full client1.domain.tld nopass
```

```bash
mkdir ~/my_keys/
cp pki/ca.crt ~/my_keys/
cp pki/issued/server.crt ~/my_keys/
cp pki/private/server.key ~/my_keys/
cp pki/issued/client1.domain.tld.crt ~/my_keys
cp pki/private/client1.domain.tld.key ~/my_keys/
cd ~/my_keys/
```

Upload the client certificate and key to ACM.

```
aws acm import-certificate --certificate file://server.crt --private-key file://server.key --certificate-chain file://ca.crt --region <YOUR_REGION>
aws acm import-certificate --certificate file://client1.domain.tld.crt --private-key file://client1.domain.tld.key --certificate-chain file://ca.crt --region <YOUR_REGION>
```

- Assosiate your VPC
- Add security group that allow UDP traffic
- Add Routes
- Add Authorizer

Download the OPVN config

```
aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id endpoint_id --output text>client-config.ovpn
```
