-- ******************************************************
-- imageTest1.sql
--
-- Loader for Closet Maintenance Database
--
-- Description:	This script contains the DDL to load
--              the tables of the
--              Closet Maintenance database
--
-- There are 7 tables on this DB
--
-- Author:  Erica Abernathy
--
-- Date:   December 14, 2016
--
-- ******************************************************

-- ******************************************************
--    SPOOL SESSION
-- ******************************************************

spool imageTest1.lst

-- ******************************************************
--    DROP TABLES
-- Note:  Issue the appropiate commands to drop tables
-- ******************************************************

DROP table tbUserShoes purge;
DROP table tbUserHandbags purge;
DROP table tbShoeItem purge;
DROP table tbHandbagItem purge;
DROP table tbShoeType purge;
DROP table tbColors purge;
DROP table tbUsers purge;

DROP sequence seq_shoeItem;
DROP sequence seq_handbagItem;

DROP trigger TR_new_shoe_IN;
DROP trigger TR_new_handbag_IN;

-- ******************************************************
--    CREATE TABLES
-- ******************************************************

CREATE table tbUsers (
		uname 			varchar2(20)	not null
			constraint pk_tbUsers primary key,
		fname			varchar2(20)	not null,
		lname			varchar2(20)	not null,
		pwd				varchar2(20)	not null,
		userview		varchar2(20)	null
);

create table tbShoeType (
		descr		varChar2(100)			not null
);

CREATE table tbColors (
		colors   	varChar2(30)		not null
);

CREATE table tbShoeItem (
		shoeId      number (11,0)           not null
        	constraint pk_tbShoeItem primary key,
        shoeName      varchar2(50)          not null,	
        shoeBrand	  varchar2(50)          not null,		
        shoeColor     varchar2(80)          not null,
        shoeType	  varchar2(100)			not null,
        shoeURL		  varchar2(500)			null
);

CREATE table tbHandbagItem (
		handbagId      number (11,0)           not null
        	constraint pk_tbHandbagItem primary key,
        handbagName      varchar2(50)          not null,	
        handbagBrand	 varchar2(50)          not null,		
        handbagColor     varchar2(80)          not null,
        handbagURL		 varchar2(500)		   null
);

CREATE table tbUserShoes (
		uname 			varchar2(20) 	not null,
		shoeId			number(11,0)	not null
			constraint fk_shoeId_tbUserShoes references tbShoeItem (shoeId),
			constraint pk_userShoes primary key (uname, shoeId)
);

CREATE table tbUserHandbags (
		uname 			varchar2(20) 	not null,
		handbagId		number(11,0)	not null
			constraint fk_handbagId_tbUserHandbags references tbHandbagItem (handbagId),
			constraint pk_userHandbags primary key (uname, handbagId)
);

CREATE sequence seq_shoeItem
    increment by 1
    start with 1;
    
CREATE sequence seq_handbagItem
    increment by 1
    start with 1;
    

-- ******************************************************
--    CREATE TRIGGERS
-- ******************************************************

CREATE or REPLACE trigger TR_new_shoe_IN
	--- trigger executes BEFORE an INSERT into the SHOEITEM table 
	before insert on tbShoeItem
	--- trigger executes for each ROW being inserted 
	for each row
	
	--- begins a PL/SQL Block 
	begin
		--- get the next value of the PK sequence 
		SELECT seq_shoeItem.nextval 
			--- insert them into the :NEW ROW columns 
			into :new.shoeId
				FROM dual;
	end TR_new_shoeId_IN;
/    

CREATE or REPLACE trigger TR_new_handbag_IN
	--- trigger executes BEFORE an INSERT into the HANDBAGITEM table 
	before insert on tbHandbagItem
	--- trigger executes for each ROW being inserted 
	for each row
	
	--- begins a PL/SQL Block 
	begin
		--- get the next value of the PK sequence 
		SELECT seq_handbagItem.nextval 
			--- insert them into the :NEW ROW columns 
			into :new.handbagId
				FROM dual;
	end TR_new_handbagId_IN;
/ 

-- ******************************************************
--    CREATE PROCEDURES
-- ******************************************************

create or replace procedure add_shoe
	--- declare parameters
	(
		SHOENAME in TBSHOEITEM.SHOENAME%TYPE,
		SHOEBRAND in TBSHOEITEM.SHOEBRAND%TYPE,
		SHOECOLOR in TBSHOEITEM.SHOECOLOR%TYPE,
		SHOETYPE in TBSHOEITEM.SHOETYPE%TYPE,
		SHOEURL in TBSHOEITEM.SHOEURL%TYPE,
		UNAME in TBUSERSHOES.UNAME%TYPE
	)
	is
	begin
	
	--- add the new shoe into the table 
	
	insert into tbShoeItem
		(shoeName, shoeBrand, shoeColor, shoeType, shoeURL)  -- Use trigger --
		values
		(SHOENAME, SHOEBRAND, SHOECOLOR, SHOETYPE, SHOEURL); 
	
	--- add the shoeid to the users closet  
	
	insert into tbUserShoes
		(uname, shoeId) 
		values
		(UNAME, seq_shoeItem.currval);
		
end add_shoe;
/

create or replace procedure add_handbag
	--- declare parameters
	(
		HANDBAGNAME in TBHANDBAGITEM.HANDBAGNAME%TYPE,
		HANDBAGBRAND in TBHANDBAGITEM.HANDBAGBRAND%TYPE,
		HANDBAGCOLOR in TBHANDBAGITEM.HANDBAGCOLOR%TYPE,
		HANDBAGURL in TBHANDBAGITEM.HANDBAGURL%TYPE,
		UNAME in TBUSERHANDBAGS.UNAME%TYPE
	)
	is
	begin
	
	--- add the new HANDBAG into the table 
	
	insert into tbHandbagItem
		(handbagName, handbagBrand, handbagColor, handbagURL)  -- Use trigger --
		values
		(HANDBAGNAME, HANDBAGBRAND, HANDBAGCOLOR, HANDBAGURL); 
	
	--- add the handbagid to the users closet  
	
	insert into tbUserHandbags
		(uname, handbagId) 
		values
		(UNAME, seq_handbagItem.currval);
		
end add_handbag;
/
		
-- ******************************************************
--    POPULATE TABLES
-- ******************************************************

INSERT INTO tbUsers (uname, fname, lname, pwd, userview) values ('user', 'User1', 'Lastname', 'super1', 'all');
INSERT INTO tbUsers (uname, fname, lname, pwd, userview) values ('admin', 'Admin', 'Admin', 'super1', 'all');
INSERT INTO tbUsers (uname, fname, lname, pwd, userview) values ('none', 'None', 'None', 'super1', 'all');

INSERT INTO tbColors (colors) values ('black');
INSERT INTO tbColors (colors) values ('blue');
INSERT INTO tbColors (colors) values ('brown');
INSERT INTO tbColors (colors) values ('clear');
INSERT INTO tbColors (colors) values ('cream');
INSERT INTO tbColors (colors) values ('gold');
INSERT INTO tbColors (colors) values ('gray');
INSERT INTO tbColors (colors) values ('green');
INSERT INTO tbColors (colors) values ('maroon');
INSERT INTO tbColors (colors) values ('multi');
INSERT INTO tbColors (colors) values ('orange');
INSERT INTO tbColors (colors) values ('other');
INSERT INTO tbColors (colors) values ('pink');
INSERT INTO tbColors (colors) values ('purple');
INSERT INTO tbColors (colors) values ('red');
INSERT INTO tbColors (colors) values ('rose gold');
INSERT INTO tbColors (colors) values ('silver');
INSERT INTO tbColors (colors) values ('white');
INSERT INTO tbColors (colors) values ('yellow');
INSERT INTO tbColors (colors) values ('burgundy');

INSERT INTO tbShoeType (descr) values ('ankle strap');
INSERT INTO tbShoeType (descr) values ('ankle wrap');
INSERT INTO tbShoeType (descr) values ('ankle boot');
INSERT INTO tbShoeType (descr) values ('block heel');
INSERT INTO tbShoeType (descr) values ('dorsay');
INSERT INTO tbShoeType (descr) values ('espadrilles');
INSERT INTO tbShoeType (descr) values ('flats');
INSERT INTO tbShoeType (descr) values ('gladiator');
INSERT INTO tbShoeType (descr) values ('half boot');
INSERT INTO tbShoeType (descr) values ('knee boot');
INSERT INTO tbShoeType (descr) values ('mary jane');
INSERT INTO tbShoeType (descr) values ('mule');
INSERT INTO tbShoeType (descr) values ('other');
INSERT INTO tbShoeType (descr) values ('peep-toe');
INSERT INTO tbShoeType (descr) values ('peep-toe boot');
INSERT INTO tbShoeType (descr) values ('peep-toe pump');
INSERT INTO tbShoeType (descr) values ('platform');
INSERT INTO tbShoeType (descr) values ('pointed-toe');
INSERT INTO tbShoeType (descr) values ('pump');
INSERT INTO tbShoeType (descr) values ('rounded-toe');
INSERT INTO tbShoeType (descr) values ('sandal');
INSERT INTO tbShoeType (descr) values ('slide');
INSERT INTO tbShoeType (descr) values ('slingback');
INSERT INTO tbShoeType (descr) values ('sneakers');
INSERT INTO tbShoeType (descr) values ('spectators');
INSERT INTO tbShoeType (descr) values ('stiletto');
INSERT INTO tbShoeType (descr) values ('t-strap');
INSERT INTO tbShoeType (descr) values ('thigh boots');
INSERT INTO tbShoeType (descr) values ('thong');
INSERT INTO tbShoeType (descr) values ('wedge');
   
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('Chloe', 'Giuseppe Zanotti', 'black', 'peep-toe boot', 'images/giuseppe.jpg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('Romy', 'Jimmy Choo', 'brown', 'pump', 'https://cdna.lystit.com/photos/saksfifthavenue/0400089896636-brown-eeadc29b-.jpeg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('Nova', 'Donald J Pliner', 'orange', 'knee boot', 'images/nova.jpg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('Odelia Bootie', 'Michael Kors', 'brown', 'peep-toe boot', 'images/odelia.jpg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('Ailee', 'Michael Kors', 'black', 'knee boot', 'images/mkboot.jpg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('New York Bless-ed', 'Kenneth Cole', 'black', 'knee boot', 'http://highheelsdaily.com/wp-content/uploads/2014/01/Kenneth-Cole-boots.jpg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('Brinkley', 'Michael Kors', 'black', 'ankle strap', 'images/brinkley.jpeg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('My Best Ever', 'Luichiny', 'maroon', 'stiletto', 'http://static3.heels.com/images/shoes/double_view/thumbnail/ZLUI668_DOUBLETHUMB.jpg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('Classic Short II Leather', 'UGG', 'brown', 'half boot', 'https://az603552.vo.msecnd.net/images-prod/Products/3481-00736-6559-019.jpg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('Clara','Michael Kors', 'burgundy', 'knee boot', 'https://cdnb.lystit.com/200/250/tr/photos/7364-2015/08/01/michael-kors-merlot-clara-leather-and-suede-boot-purple-product-1-677614193-normal.jpeg');
INSERT INTO tbShoeItem (shoeName, shoeBrand, shoeColor, shoeType, shoeURL) values('Britton', 'Calvin Klein', 'black', 'knee boot', 'https://s-media-cache-ak0.pinimg.com/564x/81/b0/19/81b019bbbf9238adff0dc8769b2beca5.jpg');

INSERT INTO tbHandbagItem (handbagName, handbagBrand, handbagColor, handbagURL) values('Alix', 'Tom Ford', 'cream', 'https://s-media-cache-ak0.pinimg.com/564x/94/71/67/947167cb534d9a4e0e11cab43f27b74e.jpg');
INSERT INTO tbHandbagItem (handbagName, handbagBrand, handbagColor, handbagURL) values('Braided Grommet Bag', 'Michael Kors', 'brown', 'https://cdnc.lystit.com/photos/2012/12/04/michael-kors-natural-gold-michael-shoulder-bag-braided-grommet-large-product-1-5723570-827928830.jpeg');
INSERT INTO tbHandbagItem (handbagName, handbagBrand, handbagColor, handbagURL) values('Devon', 'Michael Kors', 'cream', 'https://s-media-cache-ak0.pinimg.com/564x/19/4f/42/194f4283f62e60ec48f3af2fe43650f5.jpg');
INSERT INTO tbHandbagItem (handbagName, handbagBrand, handbagColor, handbagURL) values('Stevie', 'Hobobags', 'orange', 'http://cdn02.hobo.weblinc-cdn.com/product_images/hobo-designer-wallet-stevie-vintage-leather/grenadine/579fe6aa46fc140ca8000a09/small_thumb.jpg?c=1472662841');
INSERT INTO tbHandbagItem (handbagName, handbagBrand, handbagColor, handbagURL) values('Brett Tote', 'Vince Camuto', 'gray', 'https://s-media-cache-ak0.pinimg.com/564x/7a/e7/87/7ae78782fc7a375296408959fa206752.jpg');
INSERT INTO tbHandbagItem (handbagName, handbagBrand, handbagColor, handbagURL) values('Ramona', 'Donald J Pliner', 'brown', 'https://s-media-cache-ak0.pinimg.com/564x/96/b3/f1/96b3f1788d205879d5f43bb19fe11a80.jpg');
INSERT INTO tbHandbagItem (handbagName, handbagBrand, handbagColor, handbagURL) values('Layton', 'Michael Kors', 'cream', 'https://s-media-cache-ak0.pinimg.com/564x/0e/a9/81/0ea9812c2c6c69d0375d2eb03ae07d65.jpg');
INSERT INTO tbHandbagItem (handbagName, handbagBrand, handbagColor, handbagURL) values('All T', 'Tory Burch', 'brown', 'https://s-media-cache-ak0.pinimg.com/564x/5a/cd/74/5acd74f1c45a6d0479d52467f32736ee.jpg');

INSERT INTO tbUserShoes (uname, shoeId) values('admin', '1');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '2');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '3');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '4');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '5');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '6');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '7');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '8');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '9');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '10');
INSERT INTO tbUserShoes (uname, shoeId) values('admin', '11');

INSERT INTO tbUserShoes (uname, shoeId) values('user', '1');
INSERT INTO tbUserShoes (uname, shoeId) values('user', '2');
INSERT INTO tbUserShoes (uname, shoeId) values('user', '6');
INSERT INTO tbUserShoes (uname, shoeId) values('user', '7');
INSERT INTO tbUserShoes (uname, shoeId) values('user', '8');

INSERT INTO tbUserHandbags (uname, handbagId) values('admin', '1');
INSERT INTO tbUserHandbags (uname, handbagId) values('admin', '2');
INSERT INTO tbUserHandbags (uname, handbagId) values('admin', '3');
INSERT INTO tbUserHandbags (uname, handbagId) values('admin', '4');
INSERT INTO tbUserHandbags (uname, handbagId) values('admin', '5');
INSERT INTO tbUserHandbags (uname, handbagId) values('admin', '6');
INSERT INTO tbUserHandbags (uname, handbagId) values('admin', '7');
INSERT INTO tbUserHandbags (uname, handbagId) values('admin', '8');

INSERT INTO tbUserHandbags (uname, handbagId) values('user', '1');
INSERT INTO tbUserHandbags (uname, handbagId) values('user', '2');
INSERT INTO tbUserHandbags (uname, handbagId) values('user', '3');
INSERT INTO tbUserHandbags (uname, handbagId) values('user', '8');



-- ******************************************************
--    VIEW TABLES
-- ******************************************************
select * from tbShoeItem;
select * from tbHandbagItem;
select * from tbUserShoes;
select * from tbuserHandbags;
select * from tbUsers;
select * from tbShoeType;
select * from tbColors;

SELECT seq_shoeItem.currval FROM dual;
SELECT seq_handbagItem.currval FROM dual;


-- ******************************************************
--    END SESSION
-- ******************************************************
commit;
spool off

 