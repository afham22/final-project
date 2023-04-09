private_key = '''-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgGG+Fr74dguj377DmNH5zrFBbayspsb1Vu/5Vo63ljRyemzuzMys
FV0MACdN3xiBm96RMjIVdnHf2XEUvQkhWKUB5CI0pjtXOGtwwofRE6660cONb4Ye
SbY54x6+PXY2dy1JXLpVkuJRMDRceFvFG4FDYi7cTLepQO2M9+4HOWKDAgMBAAEC
gYAkqjHOIVXmt+pOnQDOg27Nf0Ws6HcHWzDphBa8IpHtyqOyCUI55LN+2+mS1NtD
ThsyOjUiJHrx7I6cpLLkoeWmSPPkBoBKTj4x3krKg8OfwMVeh5aOvPmVlRwTNobp
Lso5+kOmqtUg1LKxLHwv3uLjZ3P4AhHq7wp41iRziulSgQJBAK63/VYCPAdLxwdD
iwR+tAHqUzlv3AF/wHfsplYjyDpSNu7Jke0mSrQswdpebjy8cbIBX1Y4knIHxRFo
XxTKG6sCQQCPNqwM/0ri3w/p59yTHrsyelCewTPH5YH5wrvbimVdqRP2zHZ7S5CY
umjvwn6JbPL4Lz/B9K/TyFzgORGpPbyJAkBN4A5X9rkA24LDtxRQlZTwQZyEvloG
hQWprl5ZiKtna1u2xTt4w5eKhWSGS47BHZFjsP7odGC52MK6xpWSs57vAkAbAd1q
Sg6OQDCZFL+VAvucZlKjzZ19OfvL5PxWR4AcLJF2PlKtp69qDeVSKaSBOAmN4iMs
6X7q+mMBaeG5v8m5AkEApE5n6m6bYMWqfxTH+2ZdZST5v6/p10C+kXmBtWXzotTw
nejI+0O4tQ2o0mGodRFXRFTbNrssbjixTO8kMb+3VA==
-----END RSA PRIVATE KEY-----'''
public_key = '''-----BEGIN PUBLIC KEY-----
MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgGG+Fr74dguj377DmNH5zrFBbays
psb1Vu/5Vo63ljRyemzuzMysFV0MACdN3xiBm96RMjIVdnHf2XEUvQkhWKUB5CI0
pjtXOGtwwofRE6660cONb4YeSbY54x6+PXY2dy1JXLpVkuJRMDRceFvFG4FDYi7c
TLepQO2M9+4HOWKDAgMBAAE=
-----END PUBLIC KEY-----'''

# private_key = config('PRIVATE_KEY')
# print(private_key)
# # public_key = config('public_key')
# # # print(public_key)
# a=jwt.encode({'user_id': '1234'},private_key, algorithm='RS256')
# # print(a)
# # b=decoded = jwt.decode(a, public_key, algorithms=["RS256"])
# # print(b)

# from decouple import config
# import jwt

# private_key = config('PRIVATE_KEY')
# public_key = config('PUBLIC_KEY')

# payload = {'data': 'example'}
# algorithm = 'RS256'
# # create JWT
# # jwt_token = jwt.encode(payload, private_key, algorithm=algorithm)

# # # verify JWT
# # decoded = jwt.decode(jwt_token, public_key, algorithms=[algorithm])
# # print(decoded)
