create database ecommerce2;
use ecommerce2;

create table clients(
	IdClient int auto_increment primary key,
	Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(40),
    constraint unique_cpf_cliente unique (CPF)
    );

alter table clients auto_increment = 1;
    
create table paymentMethod(
	IdpaymentMethod int auto_increment primary key,
    PMidClient int,
    paymentMethod enum('Cartão de crédito', 'Pix'),
	constraint fk_payment_method foreign key(PMidClient) references clients(IdClient)
);

alter table paymentMethod auto_increment = 1;

create table creditCard(
	IdcreditCard int auto_increment primary key,
    PMIdCreditCard int,
    CardNumber char(16) not null,
    validity date not null,
	constraint fk_credit_Card foreign key(PMIdCreditCard) references paymentMethod(IdpaymentMethod),
    constraint unique_credit_card unique (CardNumber)
);

alter table creditCard auto_increment = 1;

create table pix(
	IdPix int auto_increment primary key,
    PmIdPix int,
    PixCode varchar(50) not null,
	constraint fk_pix foreign key(PmIdPix) references paymentMethod(IdpaymentMethod),
    constraint unique_pix_code unique (PixCode)
);

alter table pix auto_increment = 1;

create table product(
	IdProduct int auto_increment primary key,
	Pname varchar(20) not null,
    Category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    Rating float default 0,
    Size varchar(10)
    );
    
alter table product auto_increment = 1;
    
-- Para ser continuado no desafio: Terminar de implementar a tabela e criar a conexão com as tabelas nescessárias
-- refletir essa modificação no diagrama de esquema relacional
-- Criar constraints relacionadas ao pagamento

create table orders(
	IdOrder int auto_increment primary key not null,
    IdOrderClient int,
    OrderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    OrderDescription varchar(255),
    SendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key(IdOrderClient) references clients(IdClient)
			on update cascade
);

alter table orders auto_increment = 1;

create table productStorage(
	IdProductstorage int auto_increment primary key,
    StorageLocation varchar(40),
    Quantity int default 0
);

alter table productStorage auto_increment = 1;

create table supplier(
    IdSupplier int auto_increment primary key,
    SocialName varchar(40) not null,
    CNPJ char(15) not null,
    Contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

alter table supplier auto_increment = 1;

create table seller (
	IdSeller int auto_increment primary key,
    SocialName varchar(40) not null,
    AbstName varchar(255),
    Location varchar(255),
    personType enum('Pessoa física','Pessoa jurídica'),
    Contact char(11) not null
);

alter table seller auto_increment = 1;

create table naturalPerson (
	IdNPseller int,
	CPF char(11) not null,
	constraint fk_natural_person foreign key (IdNPseller) references seller(IdSeller),
    constraint unique_cpf_seller unique (CPF)
);

create table legalPerson (
	IdLPseller int,
	CNPJ char(14) not null,
	constraint fk_legal_person foreign key (IdLPseller) references seller(IdSeller),
    constraint unique_cnpj_seller unique (CNPJ)
);

create table productSeller(
	IdPseller int,
    IdPproduct int,
    ProdQuantity int default 1,
    primary key (IdPseller, IdPproduct),
    constraint fk_product_seller_seller foreign key (IdPseller) references seller(IdSeller),
    constraint fk_product_seller_product foreign key (IdPproduct) references product(IdProduct)
);

create table productOrder (
	IdPOproduct int,
    IdPOorder int,
    PoQuantity int default 1, 
    PoStatus enum('Disponível','Sem  estoque') default 'Disponível',
    primary key (IdPOproduct, IdPOorder),
    constraint fk_product_order_product foreign key (IdPOproduct) references product(IdProduct),
    constraint fk_product_order_order foreign key (IdPOorder) references orders(IdOrder)
);

create table storageLocation(
	IdLproduct int,
    IdLstorage int,
    Location varchar(255) not null,
    primary key (IdLproduct, IdLstorage),
    constraint fk_storage_location_product foreign key (IdLproduct) references product(IdProduct),
    constraint fk_storage_location_storage foreign key (IdLstorage) references productStorage(IdProductstorage)
);

create table productSupplier(
	IdPsSupplier int,
    IdPsProduct int,
    Quantity int not null,
    primary key (IdPsSupplier, IdPsProduct),
    constraint fk_product_supplier_supllier foreign key (IdPsSupplier) references supplier(IdSupplier),
    constraint fk_product_supplier_product foreign key (IdPsProduct) references product(IdProduct)
);

show tables;