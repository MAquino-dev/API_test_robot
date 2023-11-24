*** Settings ***
Resource    ../requests/carrinhos.robot

*** Variables ***

${product_one}  {"nome": "Cadeira de Couro","preco": 500,"descricao": "Escritorio","quantidade": 100}

${product_two}  {"nome": "Mesa Escrivaninha ","preco": 150,"descricao": "Escritorio","quantidade": 100}




${founded_cart}  {"produtos": [[{"idProduto": "BeeJh5lz3k6kSIzA","quantidade": 2,"precoUnitario": 470},{"idProduto": "K6leHdftCeOJj8BJ","quantidade": 1,"precoUnitario": 5240}]],"precoTotal": 6180,"quantidadeTotal": 3,"idUsuario": "oUb7aGkMtSEPf6BZ","_id": "qbMqntef4iTOwWfg"}

${founded_cart_2}  {"precoTotal": 650,"quantidadeTotal": 200,"idUsuario": "oUb7aGkMtSEPf6BZ","_id": "${generated_cart_id}"}