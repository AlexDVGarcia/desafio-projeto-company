create schema if not exists azure_company;
use azure_company;

select * from information_schema.table_constraints
    where constraint_schema = 'azure_company';

CREATE TABLE employee(
    Fname varchar(15) not null,
    Minit char(1),  -- Adicione o tamanho do campo char
    Lname varchar(15) not null,
    Ssn char(9) not null, 
    Bdate date,
    Address varchar(30),
    Sex char(1),  -- Adicione o tamanho do campo char
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salary_employee check (Salary > 2000.0),
    constraint pk_employee primary key (Ssn)
);

alter table employee 
    add constraint fk_employee 
    foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;

alter table employee modify Dno int not null default 1;

-- A instrução "desc" não é válida em MySQL. Use "DESCRIBE" ou "SHOW COLUMNS FROM" em vez disso.
DESCRIBE employee;

create table department(  -- Corrigido o nome da tabela de "departament" para "department"
    Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9) not null,
    Mgr_start_date date, 
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique(Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

alter table department drop foreign key fk_dept; -- Corrigido o comando para remover a chave estrangeira
alter table department 
    add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn)
    on update cascade;

-- A instrução "desc" não é válida em MySQL. Use "DESCRIBE" ou "SHOW COLUMNS FROM" em vez disso.
DESCRIBE department;

create table dept_locations(
    Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references department (Dnumber) -- Corrigido o nome da tabela referenciada
);

alter table dept_locations drop foreign key fk_dept_locations;

alter table dept_locations 
    add constraint fk_dept_locations foreign key (Dnumber) references department(Dnumber)
    on delete cascade
    on update cascade;

create table project(
    Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project foreign key (Dnum) references department(Dnumber) -- Corrigido o nome da tabela referenciada
);

create table works_on(
    Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
);

drop table dependent;
create table dependent(
    Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char(1),  -- Adicione o tamanho do campo char
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);

show tables;
-- A instrução "desc" não é válida em MySQL. Use "DESCRIBE" ou "SHOW COLUMNS FROM" em vez disso.
DESCRIBE dependent;