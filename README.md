# EasyBay


## Headers

**Authorization**
Bearer v^1.1#i^1#r^0#p^1#f^0#I^3#t^H4sIAAAAAAAAAOVXf2wTVRxf95MfK/gHzLlArIcaldz17tpeewetdBtkVWBznXPMwHy9e7cdXO+ae6+MhiyUBTBiYmKixhg0ZEaFhEQ2JBCnkQAxMSCCEE00akiIgWgIMJBISPDdrYxuEtigAonNJc193/d93/fz+X6+791js+WTn9nUsOmy21VRvDXLZotdLm4qO7m8bO60kuKasiI2z8G1Nft4trS35PR8BJJ6SmqGKGUaCHrWJHUDSY4xTKUtQzIB0pBkgCREEpaleHTJYolnWCllmdiUTZ3yxOrDVEJkg0EWKEEVqnKIh8RqXI/ZYoYpjgyFEiGfPxgIJvhQkIwjlIYxA2Fg4DDFs5xIsz6a5Vs4UQoEJU5kBB/bTnlaoYU00yAuDEtFnHQlZ66Vl+utUwUIQQuTIFQkFl0Ub4zG6hcubZnvzYsVyfEQxwCn0ei3OlOBnlagp+Gtl0GOtxRPyzJEiPJGhlcYHVSKXk/mDtJ3qPYn/LIg+vyqj4OKLKsFoXKRaSUBvnUetkVTaNVxlaCBNZy5HaOEjcRKKOPc21ISIlbvsf9eSANdUzVohamFtdFl0aYmKhK1MsCIWia9EKBMLcjQTc31tMAJCgwIikz7FKj6goKSW2c4WI7lMQvVmYai2Zwhz1IT10KSNBxLjT+PGuLUaDRaURXbCeX58dx1Cnm+3a7pcBHTuMuwywqThAeP83r7AozMxtjSEmkMRyKMHXAYClMgldIUauygI8WcetagMNWFcUryeru7u5luH2NanV6eZTlv25LFcbkLJgFl+9q97vhrt59Aaw4UmXQx8ZdwJkVyWUOkShIwOqmILxTguWCO99FpRcZa/2XIw+wd3RCFahBF5UFQEBOiKvAACEIhGiSS06jXzgMmiDSTwFoFcUoHMqRlorN0ElqaIvkCKu8LqZBWBFGl/aKq0omAItCcCiELYSIhi6H/UZ+MV+lx2UzBJlPX5Exh9F4wrVtKE7BwJg51nRjGK/qbgkQ2yHsAz+71CUC0YyASBKQ0xpY2I5tJrwnInmabOpys7wp3NJWKJZNpDBI6jBVoP7s/e9lN4WnksH+gMJH6DRdSU4ZPacapJoNWy4wFkZm2yAcK02ifWi3mKmiQTQBbpq5Dq5W760I/YPWd2FZ5Z7ALeExPGDbpdea/k7asa0RBHfcN3X0sqgbwgwWaCwTIIwg+8a5w1Tklbcnck5NoAvAaTIThuEs2gY9K7+gbbqTI+XG9rt1sr6ufXJJZL/sEN4d9rLzkxdKSyhqkYchoQGWQ1mmQi5sFmVUwkwKaVVzuennWzu0deXfqrcvZ6pFb9eQSbmreFZuddWOkjJv+sJsTWR/Lc2IgyInt7Jwbo6VcVemM7f7ptcdmHmytPnvho5d2nPq+YUHoTdY94uRylRWV9rqKtMGBdMu0T/aqlw4cav75wrNt7yq/Xo7v7a8ZQDua3xGerK7aIP7et/aRk699sP700NVd3f6Svz4/O0+pDJo9vSszv7RNuTr3yz/5hpmDFwX360v6Bo/iw90hfeWBuSt6Tm5bUJ0trTzhPlZR+dbQlcDGZQ1vDGb767YcA3DtrCn08ehTW/ZP2j7p49mg3zo+9Wmp76svLu0+eu385u/WHRr4bc9DHx7R9lWw593tG356tPHtvvc7VXXPvD+qYoz70vor6pGKvy/+8PWMnqGNhw8f/PHIvuOvJmq6nuvZPHTq+ROXO84MnJu2+rN1K86cvvbNfvqEta1Ne88wX/n06K4r51Ys3/nt7KgWr15cPly+fwBZssAI7RAAAA==

**Content-Type** 
application/json

**X-EBAY-C-ENDUSERCTX** affiliateCampaignId=<ePNCampaignId>,affiliateReferenceId=<referenceId>

## GET Request for querying by keyword
```GET https://api.ebay.com/buy/browse/v1/item_summary/search?q=nike```

Key q=                
*(Add keyword search)*

Key filter= price:[..69],priceCurrency:USD,conditions:{NEW},deliveryPostalCode:90024,deliveryCountry:US,returnsAccepted:true,excludeSellers:{solesurrender}                                           

*( price:[..maxAmt], conditions:{NEW or USED}, deliveryPostalCode: postal code, returnsAccepted:(true or empty), excludeSellers:{ebay ID number} )*

## POST Request for image search
```POST https://api.ebay.com/buy/browse/v1/item_summary/search_by_image?limit=20```

Key limit =                 
*( enter number of results required)*

Key filter= price:[..69],priceCurrency:USD,conditions:{NEW},deliveryPostalCode:90024,deliveryCountry:US,returnsAccepted:true,excludeSellers:{solesurrender}

*( price:[..maxAmt], conditions:{NEW or USED}, deliveryPostalCode: postal code, returnsAccepted:(true or empty), excludeSellers:{ebay ID number} )*

{
  "image": " " // Base64 string
}
