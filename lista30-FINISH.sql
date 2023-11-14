-- Aula anterior

-- RETORNAR TODOS OS CLIENTES DA TABELA USERS
SELECT * FROM users;

-- RETORNAR O SUSUARIO CUJO ID É 4
SELECT name FROM users WHERE pk_userID = 4;


-- 1.Selecione todos os nomes e números de telefone dos usuários.

SELECT
	NAME AS nome, 
    phoneNumber AS telefone
FROM users;
 
 
-- 2.Liste os nomes dos compradores.

SELECT
	NAME AS nome
FROM users
WHERE pk_userid IN (SELECT * FROM buyer);
 
 
-- 3.Liste os nomes dos vendedores.

SELECT
	NAME AS nome 
    FROM users 
    WHERE pk_userid IN (SELECT pk_userid FROM seller);


-- 4.Encontre todas as informações de cartão de crédito dos usuários.

SELECT
	bank.pk_cardNumber,
    bank.expiryDate,
    bank.bank,
    credito.fk_userid
FROM
	bankcard AS bank
JOIN
	creditcard AS credito

ON bank.pk_cardNumber = credito.pk_cardNumber;
 
 
-- 4.2 Encontre todas as informações de cartão de debito dos usuários.

SELECT
	bank.pk_cardNumber,
    bank.expiryDate,
    bank.bank,
    debito.fk_userid
FROM
	bankcard AS bank
JOIN
	debitcard AS debito
ON bank.pk_cardNumber = debito.pk_cardNumber;
 
 
-- 5.Selecione os nomes dos produtos e seus preços

SELECT
	NAME AS nome,
    price AS valor_unitario 
FROM product;


-- 6. Liste  todos  os  produtos  de  uma  determinada  marca  (por  exemplo, "microsoft").

SELECT
	NAME AS nome,
    price AS valor_unitario,
    fk_brand AS marca
FROM product
WHERE fk_brand = "Microsoft";
 
 
-- 7.Encontre o número de itens em cada pedido.

SELECT
	pk_orderNumber AS ordem,
    sum(quantity) AS Qtde_Itens
FROM contain
GROUP BY Ordem;
 
 
-- 8.Calcule o total de vendas por loja.

SELECT
	s.nome AS store_name,
    sum(o.price) AS total_sales
FROM store AS s
INNER JOIN product AS p ON s.pk_sid = p.fk_sid
INNER JOIN orderitem AS o ON p.pk_pid = o.fk_pid
GROUP BY store_name;
 
-- 9.Liste as avaliações dos produtos (grade) com seus nomes e conteúdo de usuário.

SELECT 
	p.name AS product_name,
    c.grade AS score,
    c.content AS comments
FROM product AS p
INNER JOIN comments AS c ON p.pk_pid = c.fk_pid;
 
 
-- 10.Selecione os nomes dos compradores que fizeram pedidos.

SELECT 
	DISTINCT u.name
FROM buyer b
INNER JOIN users AS u ON b.pk_userID = u.pk_userID
INNER JOIN creditcard c ON u.pk_userID = c.fk_userID
INNER JOIN payment AS p ON c.pk_cardNumber = p.fk_creditcardNumber;
 
 
-- 10. Selecione os nomes dos compradores que fizeram pedidos

SELECT 
	DISTINCT u.nome
FROM 
	buyer AS b
JOIN users u ON b.pk_userID = u.pk_userID
JOIN creditcard AS c ON u.pk_userID = c.fk_userID
JOIN payment AS p ON c.pk_cardNumber = p.fk_creditCardNumber;


-- 11. Encontre os vendedores que gerenciam várias lojas.

SELECT 
	u.pk_userID AS ID, st.name AS LOJA, u.nome AS VENDEDOR
FROM
	users AS u
JOIN seller AS sl ON u.pk_userID = sl.pk_userID
JOIN manage AS m ON sl.pk_userID = m.fk_userid
JOIN store AS st ON m.fk_sid = st.pk_sid;


-- 12. Liste os nomes das lojas que oferecem produtos de uma determinada marca (por exemplo, "Apple")

SELECT
	s.name AS LOJA, p.fk_brandName AS MARCA
FROM
	product AS p
JOIN store AS s ON p.fk_sid = s.pk_sid
WHERE p.fk_brandName = "Microsoft";


-- 13. Encontre as informações de entrega de um pedido específico (por exemplo, orderNumber = 123)

SELECT
	a.province, a.city AS CIDADE, a.streetAddr AS RUA, a.postCode AS CEP, o.pk_orderNumber
FROM
	orders AS o
JOIN deliver_to AS d ON o.pk_orderNumber = d.fk_orderNumber
JOIN address AS a ON d.fk_addID = a.pk_addID
WHERE o.pk_orderNumber = "12992012";


-- 14. Calcule o valor médio das compras dos compradores.

SELECT 
	AVG(o.totalAmount) AS MEDIA
FROM 
	buyer AS b
JOIN users u ON b.pk_userID = u.pk_userID
JOIN creditcard AS c ON u.pk_userID = c.fk_userID
JOIN payment AS p ON c.pk_cardNumber = p.fk_creditCardNumber
JOIN orders AS o ON p.fk_orderNumber = o.pk_orderNumber;
 
 
-- 15.Liste as marcas que têm pontos de serviço em uma determinada cidade (por exemplo, "Nova York").
 
SELECT
	b.pk_brandname AS marca, s.city AS cidade
FROM 
	brand b
JOIN After_Sales_Service_At a ON b.pk_brandname = a.fk_brandname
JOIN servicePoint s ON a.fk_sid = s.pk_sid
WHERE s.city = "montreal";
 
 
-- 16.Encontre o nome e o endereço das lojas com uma classificação de cliente superior 4

SELECT
	NAME nome,
    streetaddr endereço
FROM
	store
WHERE customderGrade = "4";
 
 
-- 17.Liste os produtos com estoque esgotado.

SELECT
	p.name nomeProduto,
    amount quantidade
FROM
	product p
WHERE amount = "0";
 
 
-- 18.Encontre os produtos mais caros em cada marca.

SELECT
	b.pk_brandName marca,
    max(p.price)
FROM
	product p
JOIN brand b ON p.fk_brandName = b.pk_brandName
GROUP BY pk_brandName;
 
 
-- 19.Calcule o total de pedidos em que um determinado cartão de crédito (por exemplo, cardNumber = '1234567890') foi usado.

SELECT
	p.fk_creditcardNumber cartão,
    count(o.pk_orderNumber) pedidos
FROM
	payment p
JOIN orders o ON p.fk_orderNumber = o.pk_orderNumber
WHERE fk_creditcardNumber = "7283 8982 8361 5593" ;
 
 
-- 20.Liste  os  nomes  e  números  de  telefone  dos  usuários  que  não  fizeram pedidos.

SELECT
	NAME usuario,
    phoneNumber telefone
FROM
	users u
LEFT JOIN orders o ON u.pk_userID = o.pk_orderNumber
WHERE o.pk_orderNumber IS NULL;
 
 
-- 21.Liste os nomes dos produtos que foram revisados por compradores com uma classificação superior a 4.

SELECT
	p.name nome, c.grade
FROM
	product p
JOIN comments c ON p.pk_pid = c.fk_pid
WHERE c.grade > 4;
 
-- 22.Encontre os nomes dos vendedores que não gerenciam nenhuma loja.

SELECT
	u.name AS nome,
	count(st.pk_sid) as lojas
FROM
	users u
JOIN seller s
ON u.pk_userID = s.pk_userID
JOIN manage m
ON s.pk_userID = m.fk_userid
JOIN store st
ON m.fk_sid = st.pk_sid
GROUP BY nome
HAVING lojas = 0;
 
 
-- 23.Liste os nomes dos compradores que fizeram pelo menos 3 pedidos.

SELECT
	u.pk_userID AS ID,
    u.name AS NOME,
    COUNT(o.pk_orderNumber) AS qtde_pedidos
FROM users u
JOIN creditCard cc 
ON u.pk_userID = cc.fk_userID
JOIN bankCard bc 
ON cc.pk_cardNumber = bc.pk_cardNumber
JOIN payment p 
ON bc.pk_cardNumber = p.fk_creditCardNumber
JOIN orders o 
ON p.fk_orderNumber = o.pk_orderNumber
GROUP BY ID, NOME
HAVING qtde_pedidos >= 3;
 
-- 24.Encontre o total de pedidos pagos com cartão de crédito versus cartão de débito.

SELECT
	COUNT(cc.pk_cardNumber) credito,
    COUNT(db.pk_cardNumber) debito
FROM
	payment p
LEFT OUTER JOIN creditcard cc
ON p.fk_creditcardNumber = cc.pk_cardNumber
LEFT OUTER JOIN debitcard db
ON p.fk_creditcardNumber = db.pk_cardNumber
WHERE p.fk_orderNumber IN (SELECT pk_orderNumber FROM orders WHERE payment_state = 'Paid');
 
 
-- 25.Liste as marcas (brandName) que não têm produtos na loja com ID 1.

SELECT
	b.pk_brandName
FROM brand b
RIGHT OUTER JOIN product p
ON b.pk_brandName = p.fk_brandName
WHERE p.fk_sid  NOT IN (SELECT pk_sid FROM store WHERE pk_sid = 8);
SELECT pk_sid FROM store WHERE pk_sid = 8;
 
 
-- 26. Calcule a quantidade média de produtos disponíveis em todas as lojas.

SELECT 
	AVG(amount) AS QUANTIDADE_MEDIA
FROM
	product;


-- 27. Encontre os nomes das lojas que não têm produtos em estoque (amount = 0).

SELECT
	s.name AS LOJA
FROM 
	store AS s
JOIN product p ON s.pk_sid = p.fk_sid
GROUP BY s.name
HAVING SUM(p.amount) = 0;


-- 28. Liste os nomes dos vendedores que gerenciam uma loja localizada em "São Paulo".

SELECT
	u.nome AS VENDEDOR, st.name AS LOJA, st.city AS CIDADE_LOJA
FROM
	users AS u
JOIN seller s ON u.pk_userID = s.pk_userID
JOIN manage AS m ON u.pk_userID = m.fk_userid
JOIN store AS st ON m.fk_sid = st.pk_sid
WHERE st.city = 'São Paulo';


-- 29. Encontre o número total de produtos de uma marca específica (por exemplo, "Sony") disponíveis em todas as lojas.

SELECT 
	fk_brandName AS MARCA, COUNT(pk_pid) AS TOTAL_PRODUTOS
FROM
	product
WHERE fk_brandName = "Microsoft";


-- 30. Calcule o valor total de todas as compras feitas por um comprador específico (por exemplo, userid = 1).

SELECT u.pk_userID AS ID, u.nome AS CLIENTE, SUM(o.totalAmount) AS TOTAL_COMPRAS
FROM users u
JOIN creditCard cc ON u.pk_userID = cc.fk_userID
JOIN bankCard bc ON cc.pk_cardNumber = bc.pk_cardNumber
JOIN payment p ON bc.pk_cardNumber = p.fk_creditCardNumber
JOIN orders o ON p.fk_orderNumber = o.pk_orderNumber
WHERE u.pk_userID = 5
GROUP BY u.pk_userID, u.nome, u.phoneNumber, bc.pk_cardNumber;








    



