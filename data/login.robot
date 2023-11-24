*** Variables ***

${login_request}   {"email": "justsanchez@qa1.com.br","password": "teste-login"}
${email}    justsanchez@qa1.com.br
${password}     teste-login
${token}    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imp1c3RzYW5jaGV6QHFhMS5jb20uYnIiLCJwYXNzd29yZCI6InRlc3RlLWxvZ2luIiwiaWF0IjoxNjg4MzEyNzgzLCJleHAiOjE2ODgzMTMzODN9.FBnS5c5zHkRxjF9jr7A1Ab0z4Ebk2GtbDF7fVTPL9_I"



# PUXADO DO USUARIOS
${body_request}     {"nome": "David Sanchez","email": "justsanchez@qa1.com.br","password": "teste-login","administrador": "true"}
