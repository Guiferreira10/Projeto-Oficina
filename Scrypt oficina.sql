-- Oficina Mecanica

-- drop database oficina;
create database oficina;
use oficina;

create table carro(
	idcarro int auto_increment primary key,
	Proprietario varchar(30) not null,
	Modelo varchar(30)not null,
	marca varchar(30)not null,
	placa char(7) not null,
	cpf char(11)not null,
	telefone char(11),
	constraint unique_cpf unique(cpf)
);

alter table carro auto_increment = 1;

create table Equipe(
	idequipe int primary key auto_increment,
    Enome varchar(30) not null
);

alter table Equipe auto_increment = 1;

create table OS(
	idOS int primary key auto_increment,
    idOScarro int,
    idOSequipe int,	
    DataEntrada date not null,
    Serviço enum('Conserto', 'Revisão') not null,
    pecas varchar(100),
    Valor float(10.2),
    StatusOS enum('Avalição','Em execução','Concluido') default'Avalição',
    conclusão date,
    constraint fk_carro_os foreign key (idOScarro) references carro(idcarro),
    constraint fk_equipe foreign key (idOSequipe) references equipe(idequipe)
);

alter table OS auto_increment = 1;

desc OS;

create table mecanico(
	idmecanico int primary key auto_increment,
    codigo char(5) not null,
    Nome varchar(30) not null,
    Endereço varchar(100),
    Epecialidade varchar(100) not null,
    constraint unico_mecanico unique(codigo)
);

alter table mecanico auto_increment = 1;

-- drop table mecanico;

create table mecanicoequipe(
	idMEmecanico int,
    idmeequipe int,
    primary key (idMEmecanico,idmeequipe),
	constraint fk_mecanico_equipe foreign key (idMEmecanico) references mecanico(idmecanico),
	constraint fk_equipe_mecanico foreign key (idmeequipe) references equipe(idequipe)

);



-- inserindo dados
insert into carro(proprietario,modelo,marca,placa,cpf,telefone)values
				 ('Ana Carolina Mendes','Civic','Honda','RTH3C91','09234567800','1198765432'),
                 ('Bruno Henrique Souza','Onix','Chevrolet','KLM1E34','34567890123','21996547890'),
                 ('Camila dos Santos Rocha','T-Cross','Volkswagen','DBX8G22','56789012345','31998881122'),
				 ('Diego Martins Ferreira','Ka','Ford','QWE5L67','67890123456','41991234567'),
                 ('Eduarda Lima Costa','Argo ','Fiat','ZXC9M12','78901234567','51997778899'),
                 ('Felipe Augusto Nunes','Kicks ','Nissan','ASR7P45','89012345678','61992223344'),
                 ('Gabriela Tavares Lima','HB20 ','Hyundai','JKL4B88','90123456789','71988887766'),
                 ('Henrique Batista Ramos','208 ','Peugeot','CVB6H78','23456789012','81996665544'),
                 ('Isabela Furtado Oliveira','Kwid ','Renault','MNB1X90','45678901234','91993332211'),
                 ('João Victor Almeida','Renegade ','Jeep','LOP7D66','01234567890','85987774455');


insert into equipe(enome) values
				('Alfa'),
				('Bravo'),
				('Delta'),
				('Omega');

insert into OS(idoscarro,idosequipe,DataEntrada,Serviço,pecas,valor,statusos,conclusão)values
				 (1,'2','2025-01-15','Conserto','farol',150,'concluido','2025-02-10'),
                 (2,'1','2025-02-02','Revisão','Oleo',70,'concluido','2025-02-12'),
                 (3,'4','2025-01-22','Conserto','Disco de freio',220.79,'concluido','2025-01-30'),
                 (4,'3','2025-03-10','Conserto','embreagem',7030.20,'Em Execução',null),
                 (5,'1','2025-03-05','Revisão','amortecedor',3000.0,'Em Execução',null),
                 (6,'2','2025-02-23','Conserto','motor',15000,'Em Execução',null),
                 (7,'3','2025-03-31','Conserto','radiador',3000.20,'Concluido','2025-04-07'),
                 (8,'4','2025-04-25','Revisão','Parte elétrica',null,null,null),
                 (9,'1','2025-02-10','Conserto','embreagem',7030.20,'Concluido','2025-03-01'),
                 (10,'2','2025-03-10','Conserto','tanque de gasolina',1500.00,'Em Execução',null);
                    
                    
     insert into mecanico(Codigo,nome,endereço,epecialidade)values
				('12345',' Ricardo Lopes da Silva','Rua das Acácias, 102 – Campinas, SP','Suspensão e freios'),
                ('14523','Juliana Costa Fernandes','Av. Brasil, 1980 – Belo Horizonte, MG','Injeção eletrônica'),
                ('36251','Marcos Vinícius Rocha','Rua Pará, 55 – Curitiba, PR','Câmbio automático'),
                ('24563','Fernanda Oliveira Nunes','Rua Dom Pedro II, 400 – Salvador, BA','Ar-condicionado automotivo'),
                ('23654','Marcos Vinícius Rocha','Rua Pará, 55 – Curitiba, PR','Câmbio automático');
                
     insert into mecanicoequipe(IDmemecanico,idmeequipe)values
				(1,2),
                (1,3),
                (2,1),
                (2,4),
                (3,2),
                (3,1),
                (4,4),
                (4,1);
                
                
	-- Verificar quais ordem de serviço representam os carros
    
    Select * from carro
    inner join os on idcarro = idos;
    
    Select IDos, proprietario, modelo, placa,valor from carro
    inner join os on idcarro = idos;
    
-- verificando os status dos carros
     Select IDos, proprietario, modelo, placa,valor from carro
    inner join os on idcarro = idos
    where statusos ='Concluido';
    
     Select IDos, proprietario, modelo, placa,valor,equipe from carro
    inner join os on idcarro = idos
	inner join equipe on idOSequipe = idequipe;
    
    
    Select IDos, proprietario, modelo, placa,valor,Enome as Nome_equipe,idequipe from equipe
    inner join os on idosequipe = idequipe
	inner join carro on idcarro = idos;
     where statusos ='Concluido';

    Select count(*) IDos, proprietario, modelo, placa,valor,Enome as Nome_equipe from os
    inner join equipe on idosequipe = idequipe
	inner join carro on idcarro = idos
	group by idosequipe;
    
	select enome, count(*)  from os
    inner join equipe on idosequipe = idequipe
    group by idosequipe;
    
    select * from mecanicoequipe
    inner join mecanico on idmemecanico = idmecanico
    inner join equipe on idmeequipe = idequipe
    inner join OS on idOSequipe  = idequipe
    inner join carro on idcarro = idOScarro;
    
     select idcarro,Proprietario,Enome, serviço,statusos from mecanicoequipe
    inner join mecanico on idmemecanico = idmecanico
    inner join equipe on idmeequipe = idequipe
    inner join OS on idOSequipe  = idequipe
    inner join carro on idcarro = idOScarro
    group by idos;
 
    select idcarro,Proprietario,Enome, serviço,statusos from mecanicoequipe
    inner join mecanico on idmemecanico = idmecanico
    inner join equipe on idmeequipe = idequipe
    inner join OS on idOSequipe  = idequipe
    inner join carro on idcarro = idOScarro
    group by idos;
    
	select codigo,nome,epecialidade,Proprietario,Enome, serviço,valor,statusos from mecanicoequipe
    inner join mecanico on idmemecanico = idmecanico
    inner join equipe on idmeequipe = idequipe
    inner join OS on idOSequipe  = idequipe
    inner join carro on idcarro = idOScarro
    where serviço = 'Revisão';
 
    
       
select proprietario,modelo,placa,pecas,valor,serviço,Enome as Equipe, statusos from os
Inner join carro on idcarro = idoscarro
inner join equipe on idosequipe = idequipe;

select proprietario,modelo,placa,pecas,valor,serviço,Enome as Equipe, statusos from os
Inner join carro on idcarro = idoscarro
inner join equipe on idosequipe = idequipe
where Enome = 'Alfa';

select proprietario,modelo,placa,pecas,valor,serviço,Enome as Equipe, statusos from os
Inner join carro on idcarro = idoscarro
inner join equipe on idosequipe = idequipe
where Statusos = 'concluido';

select * from os;