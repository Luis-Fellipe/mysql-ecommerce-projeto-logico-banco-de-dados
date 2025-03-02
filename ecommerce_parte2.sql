
use ecommerce;

show tables;

insert into Clients (Fname, Minit, Lname, CPF, Address)
		values('Luís', 'F', 'Fellipe', 123456789, 'rua taltal 27, Copacabana - RJ'),
			  ('Pedro', 'X', 'Henrique', 234567891, 'rua taltal 14, Vila Velha - ES'),
			  ('Luiz', 'L', 'Felipe', 345678912, 'rua taltal 7, Cariacica - ES'),
			  ('Julia', 'A', 'Silva', 154384627, 'rua taltal 22, Nova Iguaçú - RJ'),
			  ('Esther', 'S', 'Gomes', 456789123, 'rua taltal 4, Madureira - RJ'),
			  ('Beatriz', 'A', 'Menezes', 987654321, 'rua taltal 43, Tijúca - RJ');
              
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

insert into product (Pname, Category, Rating, Size) values
						('Fone de ouvido', 'Elêtronico', '4', null),
                        ('Boneco Ben 10', 'Brinquedos', '3', null),
                        ('Blusa M', 'Vestimenta', '5', null),
                        ('Headset', 'Elêtronico', '5', null),
                        ('Cadeira gamer', 'Móveis', '4', null);
                        
select * from clients;
select * from product;

insert into orders (IdOrderClient, OrderStatus, OrderDescription, SendValue, PaymentCash) values
						(1, default, 'Compra via aplicativo', null, 1),
                        (2, default, 'Compra via aplicativo', 50, 0),
                        (3, 'Confirmado', null, null, 1),
                        (4, default, 'Compra via web site', 150, 0);

select * from orders;

insert into productOrder (IdPOproduct, IdPOorder, PoQuantity, PoStatus) values
						 (1,1,2,null),
						 (2,1,1,null),
						 (3,2,1,null);
                         
insert into productStorage (storageLocation, quantity) values
						   ('Rio de Janeiro', 1000),
						   ('Rio de Janeiro', 500),
                           ('São Paulo', 10),
                           ('São Paulo', 100),
                           ('Espirito Santo', 1),
                           ('Brasilia', 60);
                           
insert into storageLocation (idLproduct, idLstorage, location) values
							(1,2,'RJ'),
							(2,6,'ES');
                            
insert into supplier (SocialName, CNPJ, contact) values
					 ('Fenxus corp', 123456789123456, '21996458869'),
					 ('Xampson corp', 234567891234567, '21998534462'),
					 ('Lubrix corp', 345678912345678, '21996278533');
                     
insert into productsupplier(idPsSupplier, idPsProduct, quantity) values
					  (1,1,500),
					  (1,2,400),
					  (2,4,633),
					  (3,3,5),
					  (2,5,10);
                      
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
			  ('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', '21995647753'),
			  ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', '21993824678'),
			  ('Kids World', null, 456789123654485, null, 'São Paulo', '11993448777');
              
select * from product;
select * from seller;

insert into productSeller (idPseller, idPproduct, prodQuantity) values
					 (1,4,80),
					 (2,5,10);
                     
select * from productseller;

select count(*) from clients;

select * from clients c, orders o where c.idclient = o.idorderclient;

select concat(Fname, ' ', Lname) as Client_Name, OrderStatus, OrderDescription from clients c, orders o where c.idclient = o.idorderclient;

insert into orders (IdOrderClient, OrderStatus, OrderDescription, SendValue, PaymentCash) values
						(2, default, 'Compra via aplicativo', null, 1);
                        
select * from clients c, orders o
			where c.idclient = o.idorderclient
			group by idOrder;
            
select * from productorder;

select * from clients inner join orders on idclient = idorderclient
					inner join productorder on idPOorder = idOrder;
                    
select idClient, Fname, count(*) as Number_of_orders from clients
			inner join orders on idclient = idorderclient
                    group by IdClient;