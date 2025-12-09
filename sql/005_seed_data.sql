TRUNCATE locales CASCADE;

INSERT INTO locales (code, name, country_code, language_code) VALUES
('en_US', 'English (United States)', 'US', 'en'),
('de_DE', 'German (Germany)', 'DE', 'de');

-- US Male First Names (200+)
INSERT INTO names (locale_id, name_type, value) VALUES
(1,'first_male','James'),(1,'first_male','Robert'),(1,'first_male','John'),(1,'first_male','Michael'),(1,'first_male','David'),
(1,'first_male','William'),(1,'first_male','Richard'),(1,'first_male','Joseph'),(1,'first_male','Thomas'),(1,'first_male','Christopher'),
(1,'first_male','Charles'),(1,'first_male','Daniel'),(1,'first_male','Matthew'),(1,'first_male','Anthony'),(1,'first_male','Mark'),
(1,'first_male','Donald'),(1,'first_male','Steven'),(1,'first_male','Paul'),(1,'first_male','Andrew'),(1,'first_male','Joshua'),
(1,'first_male','Kenneth'),(1,'first_male','Kevin'),(1,'first_male','Brian'),(1,'first_male','George'),(1,'first_male','Timothy'),
(1,'first_male','Ronald'),(1,'first_male','Edward'),(1,'first_male','Jason'),(1,'first_male','Jeffrey'),(1,'first_male','Ryan'),
(1,'first_male','Jacob'),(1,'first_male','Gary'),(1,'first_male','Nicholas'),(1,'first_male','Eric'),(1,'first_male','Jonathan'),
(1,'first_male','Stephen'),(1,'first_male','Larry'),(1,'first_male','Justin'),(1,'first_male','Scott'),(1,'first_male','Brandon'),
(1,'first_male','Benjamin'),(1,'first_male','Samuel'),(1,'first_male','Raymond'),(1,'first_male','Gregory'),(1,'first_male','Frank'),
(1,'first_male','Alexander'),(1,'first_male','Patrick'),(1,'first_male','Jack'),(1,'first_male','Dennis'),(1,'first_male','Jerry'),
(1,'first_male','Tyler'),(1,'first_male','Aaron'),(1,'first_male','Jose'),(1,'first_male','Adam'),(1,'first_male','Nathan'),
(1,'first_male','Henry'),(1,'first_male','Douglas'),(1,'first_male','Zachary'),(1,'first_male','Peter'),(1,'first_male','Kyle'),
(1,'first_male','Noah'),(1,'first_male','Ethan'),(1,'first_male','Jeremy'),(1,'first_male','Walter'),(1,'first_male','Christian'),
(1,'first_male','Keith'),(1,'first_male','Roger'),(1,'first_male','Terry'),(1,'first_male','Austin'),(1,'first_male','Sean'),
(1,'first_male','Gerald'),(1,'first_male','Carl'),(1,'first_male','Dylan'),(1,'first_male','Harold'),(1,'first_male','Jordan'),
(1,'first_male','Jesse'),(1,'first_male','Bryan'),(1,'first_male','Lawrence'),(1,'first_male','Arthur'),(1,'first_male','Gabriel'),
(1,'first_male','Bruce'),(1,'first_male','Albert'),(1,'first_male','Willie'),(1,'first_male','Alan'),(1,'first_male','Eugene'),
(1,'first_male','Billy'),(1,'first_male','Harry'),(1,'first_male','Ralph'),(1,'first_male','Roy'),(1,'first_male','Russell'),
(1,'first_male','Louis'),(1,'first_male','Philip'),(1,'first_male','Randy'),(1,'first_male','Johnny'),(1,'first_male','Howard'),
(1,'first_male','Vincent'),(1,'first_male','Liam'),(1,'first_male','Mason'),(1,'first_male','Aiden'),(1,'first_male','Jackson'),
(1,'first_male','Elijah'),(1,'first_male','Lucas'),(1,'first_male','Oliver'),(1,'first_male','Logan'),(1,'first_male','Connor'),
(1,'first_male','Landon'),(1,'first_male','Hunter'),(1,'first_male','Caleb'),(1,'first_male','Carter'),(1,'first_male','Owen'),
(1,'first_male','Evan'),(1,'first_male','Gavin'),(1,'first_male','Jayden'),(1,'first_male','Chase'),(1,'first_male','Cameron'),
(1,'first_male','Sebastian'),(1,'first_male','Dominic'),(1,'first_male','Adrian'),(1,'first_male','Cole'),(1,'first_male','Maxwell'),
(1,'first_male','Nathaniel'),(1,'first_male','Ian'),(1,'first_male','Alex'),(1,'first_male','Marcus'),(1,'first_male','Blake'),
(1,'first_male','Tristan'),(1,'first_male','Xavier'),(1,'first_male','Leonardo'),(1,'first_male','Antonio'),(1,'first_male','Miguel'),
(1,'first_male','Oscar'),(1,'first_male','Javier'),(1,'first_male','Victor'),(1,'first_male','Hugo'),(1,'first_male','Carlos'),
(1,'first_male','Luis'),(1,'first_male','Diego'),(1,'first_male','Ricardo'),(1,'first_male','Jorge'),(1,'first_male','Manuel'),
(1,'first_male','Francisco'),(1,'first_male','Eduardo'),(1,'first_male','Pedro'),(1,'first_male','Angel'),(1,'first_male','Fernando'),
(1,'first_male','Rafael'),(1,'first_male','Ramon'),(1,'first_male','Mario'),(1,'first_male','Sergio'),(1,'first_male','Ivan'),
(1,'first_male','Marco'),(1,'first_male','Alejandro'),(1,'first_male','Andres'),(1,'first_male','Pablo'),(1,'first_male','Roberto'),
(1,'first_male','Julio'),(1,'first_male','Alfredo'),(1,'first_male','Ernesto'),(1,'first_male','Enrique'),(1,'first_male','Harrison'),
(1,'first_male','Spencer'),(1,'first_male','Graham'),(1,'first_male','Elliott'),(1,'first_male','Preston'),(1,'first_male','Grant'),
(1,'first_male','Wesley'),(1,'first_male','Tucker'),(1,'first_male','Bradley'),(1,'first_male','Gordon'),(1,'first_male','Wayne'),
(1,'first_male','Craig'),(1,'first_male','Travis'),(1,'first_male','Todd'),(1,'first_male','Shane'),(1,'first_male','Brett'),
(1,'first_male','Derek'),(1,'first_male','Chad'),(1,'first_male','Trevor'),(1,'first_male','Neil'),(1,'first_male','Dale'),
(1,'first_male','Lee'),(1,'first_male','Glenn'),(1,'first_male','Tony'),(1,'first_male','Darren'),(1,'first_male','Lance'),
(1,'first_male','Mitchell'),(1,'first_male','Seth'),(1,'first_male','Ruben'),(1,'first_male','Dustin'),(1,'first_male','Ross'),
(1,'first_male','Martin'),(1,'first_male','Kurt'),(1,'first_male','Clint'),(1,'first_male','Leon'),(1,'first_male','Bernard');

-- US Female First Names (200+)
INSERT INTO names (locale_id, name_type, value) VALUES
(1,'first_female','Mary'),(1,'first_female','Patricia'),(1,'first_female','Jennifer'),(1,'first_female','Linda'),(1,'first_female','Elizabeth'),
(1,'first_female','Barbara'),(1,'first_female','Susan'),(1,'first_female','Jessica'),(1,'first_female','Sarah'),(1,'first_female','Karen'),
(1,'first_female','Lisa'),(1,'first_female','Nancy'),(1,'first_female','Betty'),(1,'first_female','Margaret'),(1,'first_female','Sandra'),
(1,'first_female','Ashley'),(1,'first_female','Kimberly'),(1,'first_female','Emily'),(1,'first_female','Donna'),(1,'first_female','Michelle'),
(1,'first_female','Dorothy'),(1,'first_female','Carol'),(1,'first_female','Amanda'),(1,'first_female','Melissa'),(1,'first_female','Deborah'),
(1,'first_female','Stephanie'),(1,'first_female','Rebecca'),(1,'first_female','Sharon'),(1,'first_female','Laura'),(1,'first_female','Cynthia'),
(1,'first_female','Kathleen'),(1,'first_female','Amy'),(1,'first_female','Angela'),(1,'first_female','Shirley'),(1,'first_female','Anna'),
(1,'first_female','Brenda'),(1,'first_female','Pamela'),(1,'first_female','Emma'),(1,'first_female','Nicole'),(1,'first_female','Helen'),
(1,'first_female','Samantha'),(1,'first_female','Katherine'),(1,'first_female','Christine'),(1,'first_female','Debra'),(1,'first_female','Rachel'),
(1,'first_female','Carolyn'),(1,'first_female','Janet'),(1,'first_female','Catherine'),(1,'first_female','Maria'),(1,'first_female','Heather'),
(1,'first_female','Diane'),(1,'first_female','Ruth'),(1,'first_female','Julie'),(1,'first_female','Olivia'),(1,'first_female','Joyce'),
(1,'first_female','Virginia'),(1,'first_female','Victoria'),(1,'first_female','Kelly'),(1,'first_female','Lauren'),(1,'first_female','Christina'),
(1,'first_female','Joan'),(1,'first_female','Evelyn'),(1,'first_female','Judith'),(1,'first_female','Megan'),(1,'first_female','Andrea'),
(1,'first_female','Cheryl'),(1,'first_female','Hannah'),(1,'first_female','Jacqueline'),(1,'first_female','Martha'),(1,'first_female','Gloria'),
(1,'first_female','Teresa'),(1,'first_female','Ann'),(1,'first_female','Sara'),(1,'first_female','Madison'),(1,'first_female','Frances'),
(1,'first_female','Kathryn'),(1,'first_female','Janice'),(1,'first_female','Jean'),(1,'first_female','Abigail'),(1,'first_female','Alice'),
(1,'first_female','Judy'),(1,'first_female','Sophia'),(1,'first_female','Grace'),(1,'first_female','Denise'),(1,'first_female','Amber'),
(1,'first_female','Doris'),(1,'first_female','Marilyn'),(1,'first_female','Danielle'),(1,'first_female','Beverly'),(1,'first_female','Isabella'),
(1,'first_female','Theresa'),(1,'first_female','Diana'),(1,'first_female','Natalie'),(1,'first_female','Brittany'),(1,'first_female','Charlotte'),
(1,'first_female','Marie'),(1,'first_female','Kayla'),(1,'first_female','Alexis'),(1,'first_female','Lori'),(1,'first_female','Sophia'),
(1,'first_female','Ava'),(1,'first_female','Mia'),(1,'first_female','Ella'),(1,'first_female','Chloe'),(1,'first_female','Penelope'),
(1,'first_female','Riley'),(1,'first_female','Zoey'),(1,'first_female','Nora'),(1,'first_female','Lily'),(1,'first_female','Eleanor'),
(1,'first_female','Hazel'),(1,'first_female','Violet'),(1,'first_female','Aurora'),(1,'first_female','Savannah'),(1,'first_female','Audrey'),
(1,'first_female','Brooklyn'),(1,'first_female','Bella'),(1,'first_female','Claire'),(1,'first_female','Skylar'),(1,'first_female','Lucy'),
(1,'first_female','Paisley'),(1,'first_female','Everly'),(1,'first_female','Anna'),(1,'first_female','Caroline'),(1,'first_female','Nova'),
(1,'first_female','Genesis'),(1,'first_female','Emilia'),(1,'first_female','Kennedy'),(1,'first_female','Maya'),(1,'first_female','Willow'),
(1,'first_female','Kinsley'),(1,'first_female','Naomi'),(1,'first_female','Aaliyah'),(1,'first_female','Elena'),(1,'first_female','Sarah'),
(1,'first_female','Ariana'),(1,'first_female','Allison'),(1,'first_female','Gabriella'),(1,'first_female','Alice'),(1,'first_female','Madelyn'),
(1,'first_female','Cora'),(1,'first_female','Ruby'),(1,'first_female','Eva'),(1,'first_female','Serenity'),(1,'first_female','Autumn'),
(1,'first_female','Adeline'),(1,'first_female','Hailey'),(1,'first_female','Gianna'),(1,'first_female','Valentina'),(1,'first_female','Isla');

-- US Last Names (200+)
INSERT INTO names (locale_id, name_type, value) VALUES
(1,'last','Smith'),(1,'last','Johnson'),(1,'last','Williams'),(1,'last','Brown'),(1,'last','Jones'),
(1,'last','Garcia'),(1,'last','Miller'),(1,'last','Davis'),(1,'last','Rodriguez'),(1,'last','Martinez'),
(1,'last','Hernandez'),(1,'last','Lopez'),(1,'last','Gonzalez'),(1,'last','Wilson'),(1,'last','Anderson'),
(1,'last','Thomas'),(1,'last','Taylor'),(1,'last','Moore'),(1,'last','Jackson'),(1,'last','Martin'),
(1,'last','Lee'),(1,'last','Perez'),(1,'last','Thompson'),(1,'last','White'),(1,'last','Harris'),
(1,'last','Sanchez'),(1,'last','Clark'),(1,'last','Ramirez'),(1,'last','Lewis'),(1,'last','Robinson'),
(1,'last','Walker'),(1,'last','Young'),(1,'last','Allen'),(1,'last','King'),(1,'last','Wright'),
(1,'last','Scott'),(1,'last','Torres'),(1,'last','Nguyen'),(1,'last','Hill'),(1,'last','Flores'),
(1,'last','Green'),(1,'last','Adams'),(1,'last','Nelson'),(1,'last','Baker'),(1,'last','Hall'),
(1,'last','Rivera'),(1,'last','Campbell'),(1,'last','Mitchell'),(1,'last','Carter'),(1,'last','Roberts'),
(1,'last','Gomez'),(1,'last','Phillips'),(1,'last','Evans'),(1,'last','Turner'),(1,'last','Diaz'),
(1,'last','Parker'),(1,'last','Cruz'),(1,'last','Edwards'),(1,'last','Collins'),(1,'last','Reyes'),
(1,'last','Stewart'),(1,'last','Morris'),(1,'last','Morales'),(1,'last','Murphy'),(1,'last','Cook'),
(1,'last','Rogers'),(1,'last','Gutierrez'),(1,'last','Ortiz'),(1,'last','Morgan'),(1,'last','Cooper'),
(1,'last','Peterson'),(1,'last','Bailey'),(1,'last','Reed'),(1,'last','Kelly'),(1,'last','Howard'),
(1,'last','Ramos'),(1,'last','Kim'),(1,'last','Cox'),(1,'last','Ward'),(1,'last','Richardson'),
(1,'last','Watson'),(1,'last','Brooks'),(1,'last','Chavez'),(1,'last','Wood'),(1,'last','James'),
(1,'last','Bennett'),(1,'last','Gray'),(1,'last','Mendoza'),(1,'last','Ruiz'),(1,'last','Hughes'),
(1,'last','Price'),(1,'last','Alvarez'),(1,'last','Castillo'),(1,'last','Sanders'),(1,'last','Patel'),
(1,'last','Myers'),(1,'last','Long'),(1,'last','Ross'),(1,'last','Foster'),(1,'last','Jimenez'),
(1,'last','Powell'),(1,'last','Jenkins'),(1,'last','Perry'),(1,'last','Russell'),(1,'last','Sullivan'),
(1,'last','Bell'),(1,'last','Coleman'),(1,'last','Butler'),(1,'last','Henderson'),(1,'last','Barnes'),
(1,'last','Gonzales'),(1,'last','Fisher'),(1,'last','Vasquez'),(1,'last','Simmons'),(1,'last','Stokes'),
(1,'last','Simpson'),(1,'last','Crawford'),(1,'last','Kennedy'),(1,'last','Porter'),(1,'last','Hunter'),
(1,'last','Hamilton'),(1,'last','Graham'),(1,'last','Reynolds'),(1,'last','Griffin'),(1,'last','Wallace'),
(1,'last','Moreno'),(1,'last','West'),(1,'last','Cole'),(1,'last','Hayes'),(1,'last','Bryant'),
(1,'last','Herrera'),(1,'last','Gibson'),(1,'last','Ellis'),(1,'last','Tran'),(1,'last','Medina'),
(1,'last','Aguilar'),(1,'last','Stevens'),(1,'last','Murray'),(1,'last','Ford'),(1,'last','Castro'),
(1,'last','Marshall'),(1,'last','Owens'),(1,'last','Harrison'),(1,'last','Fernandez'),(1,'last','McDonald'),
(1,'last','Woods'),(1,'last','Washington'),(1,'last','Kennedy'),(1,'last','Wells'),(1,'last','Vargas');

INSERT INTO names (locale_id, name_type, value) 
SELECT 1, 'middle_male', value FROM names WHERE locale_id = 1 AND name_type = 'first_male' LIMIT 100;
INSERT INTO names (locale_id, name_type, value) 
SELECT 1, 'middle_female', value FROM names WHERE locale_id = 1 AND name_type = 'first_female' LIMIT 100;

INSERT INTO titles (locale_id, gender, value) VALUES
(1,'male','Mr.'),(1,'female','Ms.'),(1,'female','Mrs.'),(1,'female','Miss'),
(1,'neutral','Dr.'),(1,'neutral','Prof.');

-- US States
INSERT INTO states (locale_id, name, abbreviation) VALUES
(1,'Alabama','AL'),(1,'Alaska','AK'),(1,'Arizona','AZ'),(1,'Arkansas','AR'),(1,'California','CA'),
(1,'Colorado','CO'),(1,'Connecticut','CT'),(1,'Delaware','DE'),(1,'Florida','FL'),(1,'Georgia','GA'),
(1,'Hawaii','HI'),(1,'Idaho','ID'),(1,'Illinois','IL'),(1,'Indiana','IN'),(1,'Iowa','IA'),
(1,'Kansas','KS'),(1,'Kentucky','KY'),(1,'Louisiana','LA'),(1,'Maine','ME'),(1,'Maryland','MD'),
(1,'Massachusetts','MA'),(1,'Michigan','MI'),(1,'Minnesota','MN'),(1,'Mississippi','MS'),(1,'Missouri','MO'),
(1,'Montana','MT'),(1,'Nebraska','NE'),(1,'Nevada','NV'),(1,'New Hampshire','NH'),(1,'New Jersey','NJ'),
(1,'New Mexico','NM'),(1,'New York','NY'),(1,'North Carolina','NC'),(1,'North Dakota','ND'),(1,'Ohio','OH'),
(1,'Oklahoma','OK'),(1,'Oregon','OR'),(1,'Pennsylvania','PA'),(1,'Rhode Island','RI'),(1,'South Carolina','SC'),
(1,'South Dakota','SD'),(1,'Tennessee','TN'),(1,'Texas','TX'),(1,'Utah','UT'),(1,'Vermont','VT'),
(1,'Virginia','VA'),(1,'Washington','WA'),(1,'West Virginia','WV'),(1,'Wisconsin','WI'),(1,'Wyoming','WY');

-- US Cities (with state references)
INSERT INTO cities (locale_id, state_id, name, postal_code_prefix) VALUES
(1,(SELECT id FROM states WHERE abbreviation='NY'),'New York','100'),
(1,(SELECT id FROM states WHERE abbreviation='CA'),'Los Angeles','900'),
(1,(SELECT id FROM states WHERE abbreviation='IL'),'Chicago','606'),
(1,(SELECT id FROM states WHERE abbreviation='TX'),'Houston','770'),
(1,(SELECT id FROM states WHERE abbreviation='AZ'),'Phoenix','850'),
(1,(SELECT id FROM states WHERE abbreviation='PA'),'Philadelphia','191'),
(1,(SELECT id FROM states WHERE abbreviation='TX'),'San Antonio','782'),
(1,(SELECT id FROM states WHERE abbreviation='CA'),'San Diego','921'),
(1,(SELECT id FROM states WHERE abbreviation='TX'),'Dallas','752'),
(1,(SELECT id FROM states WHERE abbreviation='CA'),'San Jose','951'),
(1,(SELECT id FROM states WHERE abbreviation='TX'),'Austin','787'),
(1,(SELECT id FROM states WHERE abbreviation='FL'),'Jacksonville','322'),
(1,(SELECT id FROM states WHERE abbreviation='TX'),'Fort Worth','761'),
(1,(SELECT id FROM states WHERE abbreviation='OH'),'Columbus','432'),
(1,(SELECT id FROM states WHERE abbreviation='NC'),'Charlotte','282'),
(1,(SELECT id FROM states WHERE abbreviation='CA'),'San Francisco','941'),
(1,(SELECT id FROM states WHERE abbreviation='IN'),'Indianapolis','462'),
(1,(SELECT id FROM states WHERE abbreviation='WA'),'Seattle','981'),
(1,(SELECT id FROM states WHERE abbreviation='CO'),'Denver','802'),
(1,(SELECT id FROM states WHERE abbreviation='DC'),'Washington','200'),
(1,(SELECT id FROM states WHERE abbreviation='MA'),'Boston','021'),
(1,(SELECT id FROM states WHERE abbreviation='TX'),'El Paso','799'),
(1,(SELECT id FROM states WHERE abbreviation='MI'),'Detroit','482'),
(1,(SELECT id FROM states WHERE abbreviation='TN'),'Nashville','372'),
(1,(SELECT id FROM states WHERE abbreviation='TN'),'Memphis','381'),
(1,(SELECT id FROM states WHERE abbreviation='OR'),'Portland','972'),
(1,(SELECT id FROM states WHERE abbreviation='OK'),'Oklahoma City','731'),
(1,(SELECT id FROM states WHERE abbreviation='NV'),'Las Vegas','891'),
(1,(SELECT id FROM states WHERE abbreviation='KY'),'Louisville','402'),
(1,(SELECT id FROM states WHERE abbreviation='MD'),'Baltimore','212'),
(1,(SELECT id FROM states WHERE abbreviation='WI'),'Milwaukee','532'),
(1,(SELECT id FROM states WHERE abbreviation='NM'),'Albuquerque','871'),
(1,(SELECT id FROM states WHERE abbreviation='AZ'),'Tucson','857'),
(1,(SELECT id FROM states WHERE abbreviation='CA'),'Fresno','937'),
(1,(SELECT id FROM states WHERE abbreviation='CA'),'Sacramento','958'),
(1,(SELECT id FROM states WHERE abbreviation='MO'),'Kansas City','641'),
(1,(SELECT id FROM states WHERE abbreviation='CA'),'Long Beach','908'),
(1,(SELECT id FROM states WHERE abbreviation='AZ'),'Mesa','852'),
(1,(SELECT id FROM states WHERE abbreviation='GA'),'Atlanta','303'),
(1,(SELECT id FROM states WHERE abbreviation='VA'),'Virginia Beach','234');

-- US Streets (100+)
INSERT INTO streets (locale_id, value) VALUES
(1,'Main'),(1,'Oak'),(1,'Maple'),(1,'Cedar'),(1,'Pine'),(1,'Elm'),(1,'Washington'),(1,'Lake'),(1,'Hill'),(1,'Park'),
(1,'Walnut'),(1,'Sunset'),(1,'Highland'),(1,'Lincoln'),(1,'Jackson'),(1,'Church'),(1,'Mill'),(1,'River'),(1,'Spring'),(1,'Forest'),
(1,'Madison'),(1,'Franklin'),(1,'Jefferson'),(1,'Adams'),(1,'Monroe'),(1,'Wilson'),(1,'Harrison'),(1,'Taylor'),(1,'Polk'),(1,'Tyler'),
(1,'Center'),(1,'North'),(1,'South'),(1,'East'),(1,'West'),(1,'Central'),(1,'College'),(1,'School'),(1,'Academy'),(1,'Market'),
(1,'Cherry'),(1,'Birch'),(1,'Willow'),(1,'Poplar'),(1,'Hickory'),(1,'Sycamore'),(1,'Chestnut'),(1,'Magnolia'),(1,'Dogwood'),(1,'Holly'),
(1,'Meadow'),(1,'Valley'),(1,'Ridge'),(1,'Summit'),(1,'Vista'),(1,'Crest'),(1,'Glen'),(1,'Dale'),(1,'Grove'),(1,'Court'),
(1,'Pleasant'),(1,'Union'),(1,'Liberty'),(1,'Independence'),(1,'Commerce'),(1,'Industrial'),(1,'Railroad'),(1,'Bridge'),(1,'Canal'),(1,'Harbor'),
(1,'Broadway'),(1,'First'),(1,'Second'),(1,'Third'),(1,'Fourth'),(1,'Fifth'),(1,'Sixth'),(1,'Seventh'),(1,'Eighth'),(1,'Ninth'),
(1,'Fairview'),(1,'Lakeview'),(1,'Riverside'),(1,'Hillside'),(1,'Parkview'),(1,'Woodland'),(1,'Greenwood'),(1,'Brookside'),(1,'Oakwood'),(1,'Maplewood'),
(1,'Country'),(1,'Village'),(1,'Colonial'),(1,'Heritage'),(1,'Pioneer'),(1,'Frontier'),(1,'Prairie'),(1,'Mountain'),(1,'Desert'),(1,'Ocean');

-- US Street Suffixes
INSERT INTO street_suffixes (locale_id, value) VALUES
(1,'Street'),(1,'Avenue'),(1,'Boulevard'),(1,'Drive'),(1,'Lane'),(1,'Road'),(1,'Way'),(1,'Place'),(1,'Court'),(1,'Circle'),
(1,'Trail'),(1,'Parkway'),(1,'Commons'),(1,'Square'),(1,'Terrace'),(1,'Loop'),(1,'Path'),(1,'Pike'),(1,'Highway'),(1,'Alley');

-- US Eye Colors
INSERT INTO eye_colors (locale_id, value, frequency) VALUES
(1,'Brown',55),(1,'Blue',27),(1,'Green',8),(1,'Hazel',7),(1,'Gray',3);

-- German Male First Names (200+)
INSERT INTO names (locale_id, name_type, value) VALUES
(2,'first_male','Lukas'),(2,'first_male','Leon'),(2,'first_male','Finn'),(2,'first_male','Paul'),(2,'first_male','Jonas'),
(2,'first_male','Ben'),(2,'first_male','Elias'),(2,'first_male','Noah'),(2,'first_male','Felix'),(2,'first_male','Luis'),
(2,'first_male','Maximilian'),(2,'first_male','Henry'),(2,'first_male','Luca'),(2,'first_male','Emil'),(2,'first_male','Moritz'),
(2,'first_male','Anton'),(2,'first_male','Jakob'),(2,'first_male','Oskar'),(2,'first_male','Theo'),(2,'first_male','Leo'),
(2,'first_male','Alexander'),(2,'first_male','David'),(2,'first_male','Julian'),(2,'first_male','Niklas'),(2,'first_male','Tim'),
(2,'first_male','Jan'),(2,'first_male','Max'),(2,'first_male','Philipp'),(2,'first_male','Tom'),(2,'first_male','Erik'),
(2,'first_male','Simon'),(2,'first_male','Sebastian'),(2,'first_male','Fabian'),(2,'first_male','Florian'),(2,'first_male','Tobias'),
(2,'first_male','Daniel'),(2,'first_male','Christian'),(2,'first_male','Michael'),(2,'first_male','Thomas'),(2,'first_male','Andreas'),
(2,'first_male','Stefan'),(2,'first_male','Markus'),(2,'first_male','Martin'),(2,'first_male','Peter'),(2,'first_male','Wolfgang'),
(2,'first_male','Klaus'),(2,'first_male','Werner'),(2,'first_male','Hans'),(2,'first_male','Jürgen'),(2,'first_male','Gerhard'),
(2,'first_male','Dieter'),(2,'first_male','Helmut'),(2,'first_male','Heinz'),(2,'first_male','Manfred'),(2,'first_male','Rolf'),
(2,'first_male','Karl'),(2,'first_male','Friedrich'),(2,'first_male','Wilhelm'),(2,'first_male','Heinrich'),(2,'first_male','Hermann'),
(2,'first_male','Walter'),(2,'first_male','Kurt'),(2,'first_male','Franz'),(2,'first_male','Rudolf'),(2,'first_male','Ernst'),
(2,'first_male','Otto'),(2,'first_male','Alfred'),(2,'first_male','Georg'),(2,'first_male','Bernhard'),(2,'first_male','Rainer'),
(2,'first_male','Uwe'),(2,'first_male','Bernd'),(2,'first_male','Matthias'),(2,'first_male','Jens'),(2,'first_male','Sven'),
(2,'first_male','Lars'),(2,'first_male','Torsten'),(2,'first_male','Kai'),(2,'first_male','Olaf'),(2,'first_male','Dirk'),
(2,'first_male','Holger'),(2,'first_male','Ingo'),(2,'first_male','Marco'),(2,'first_male','Dennis'),(2,'first_male','Patrick'),
(2,'first_male','Marcel'),(2,'first_male','Sascha'),(2,'first_male','Dominik'),(2,'first_male','Kevin'),(2,'first_male','Pascal'),
(2,'first_male','Yannik'),(2,'first_male','Robin'),(2,'first_male','Nils'),(2,'first_male','Timo'),(2,'first_male','Nico'),
(2,'first_male','Bastian'),(2,'first_male','Marvin'),(2,'first_male','Vincent'),(2,'first_male','Lennart'),(2,'first_male','Hannes');

-- German Female First Names 
INSERT INTO names (locale_id, name_type, value) VALUES
(2,'first_female','Emma'),(2,'first_female','Mia'),(2,'first_female','Hannah'),(2,'first_female','Sofia'),(2,'first_female','Anna'),
(2,'first_female','Emilia'),(2,'first_female','Lina'),(2,'first_female','Marie'),(2,'first_female','Lea'),(2,'first_female','Lena'),
(2,'first_female','Leonie'),(2,'first_female','Emily'),(2,'first_female','Amelie'),(2,'first_female','Sophie'),(2,'first_female','Luisa'),
(2,'first_female','Johanna'),(2,'first_female','Laura'),(2,'first_female','Nele'),(2,'first_female','Clara'),(2,'first_female','Lara'),
(2,'first_female','Maja'),(2,'first_female','Charlotte'),(2,'first_female','Ella'),(2,'first_female','Paula'),(2,'first_female','Lisa'),
(2,'first_female','Julia'),(2,'first_female','Sarah'),(2,'first_female','Katharina'),(2,'first_female','Maria'),(2,'first_female','Christina'),
(2,'first_female','Sabine'),(2,'first_female','Nicole'),(2,'first_female','Petra'),(2,'first_female','Monika'),(2,'first_female','Ursula'),
(2,'first_female','Elisabeth'),(2,'first_female','Renate'),(2,'first_female','Ingrid'),(2,'first_female','Helga'),(2,'first_female','Karin'),
(2,'first_female','Brigitte'),(2,'first_female','Erika'),(2,'first_female','Christa'),(2,'first_female','Gisela'),(2,'first_female','Margarete'),
(2,'first_female','Ruth'),(2,'first_female','Gertrud'),(2,'first_female','Hildegard'),(2,'first_female','Irmgard'),(2,'first_female','Elfriede'),
(2,'first_female','Susanne'),(2,'first_female','Andrea'),(2,'first_female','Claudia'),(2,'first_female','Birgit'),(2,'first_female','Heike'),
(2,'first_female','Martina'),(2,'first_female','Gabriele'),(2,'first_female','Anja'),(2,'first_female','Silke'),(2,'first_female','Tanja'),
(2,'first_female','Stefanie'),(2,'first_female','Melanie'),(2,'first_female','Nadine'),(2,'first_female','Katrin'),(2,'first_female','Sandra'),
(2,'first_female','Daniela'),(2,'first_female','Manuela'),(2,'first_female','Simone'),(2,'first_female','Marion'),(2,'first_female','Sonja'),
(2,'first_female','Franziska'),(2,'first_female','Jana'),(2,'first_female','Vanessa'),(2,'first_female','Jennifer'),(2,'first_female','Jessica'),
(2,'first_female','Jasmin'),(2,'first_female','Alina'),(2,'first_female','Miriam'),(2,'first_female','Carolin'),(2,'first_female','Antonia'),
(2,'first_female','Greta'),(2,'first_female','Marlene'),(2,'first_female','Ida'),(2,'first_female','Frieda'),(2,'first_female','Helena'),
(2,'first_female','Victoria'),(2,'first_female','Mathilda'),(2,'first_female','Theresa'),(2,'first_female','Elisa'),(2,'first_female','Fiona'),
(2,'first_female','Annika'),(2,'first_female','Merle'),(2,'first_female','Ronja'),(2,'first_female','Jule'),(2,'first_female','Svenja'),
(2,'first_female','Sina'),(2,'first_female','Vivien'),(2,'first_female','Celine'),(2,'first_female','Michelle'),(2,'first_female','Chiara');

-- German Last Names 
INSERT INTO names (locale_id, name_type, value) VALUES
(2,'last','Müller'),(2,'last','Schmidt'),(2,'last','Schneider'),(2,'last','Fischer'),(2,'last','Weber'),
(2,'last','Meyer'),(2,'last','Wagner'),(2,'last','Becker'),(2,'last','Schulz'),(2,'last','Hoffmann'),
(2,'last','Schäfer'),(2,'last','Koch'),(2,'last','Bauer'),(2,'last','Richter'),(2,'last','Klein'),
(2,'last','Wolf'),(2,'last','Schröder'),(2,'last','Neumann'),(2,'last','Schwarz'),(2,'last','Zimmermann'),
(2,'last','Braun'),(2,'last','Krüger'),(2,'last','Hofmann'),(2,'last','Hartmann'),(2,'last','Lange'),
(2,'last','Schmitt'),(2,'last','Werner'),(2,'last','Schmitz'),(2,'last','Krause'),(2,'last','Meier'),
(2,'last','Lehmann'),(2,'last','Schmid'),(2,'last','Schulze'),(2,'last','Maier'),(2,'last','Köhler'),
(2,'last','Herrmann'),(2,'last','König'),(2,'last','Walter'),(2,'last','Mayer'),(2,'last','Huber'),
(2,'last','Kaiser'),(2,'last','Fuchs'),(2,'last','Peters'),(2,'last','Lang'),(2,'last','Scholz'),
(2,'last','Möller'),(2,'last','Weiß'),(2,'last','Jung'),(2,'last','Hahn'),(2,'last','Schubert'),
(2,'last','Vogel'),(2,'last','Friedrich'),(2,'last','Keller'),(2,'last','Günther'),(2,'last','Frank'),
(2,'last','Berger'),(2,'last','Winkler'),(2,'last','Roth'),(2,'last','Beck'),(2,'last','Lorenz'),
(2,'last','Baumann'),(2,'last','Franke'),(2,'last','Albrecht'),(2,'last','Schuster'),(2,'last','Simon'),
(2,'last','Ludwig'),(2,'last','Böhm'),(2,'last','Winter'),(2,'last','Kraus'),(2,'last','Martin'),
(2,'last','Schumacher'),(2,'last','Krämer'),(2,'last','Vogt'),(2,'last','Stein'),(2,'last','Jäger'),
(2,'last','Otto'),(2,'last','Sommer'),(2,'last','Groß'),(2,'last','Seidel'),(2,'last','Heinrich'),
(2,'last','Brandt'),(2,'last','Haas'),(2,'last','Schreiber'),(2,'last','Graf'),(2,'last','Schulte'),
(2,'last','Dietrich'),(2,'last','Ziegler'),(2,'last','Kuhn'),(2,'last','Kühn'),(2,'last','Pohl'),
(2,'last','Engel'),(2,'last','Horn'),(2,'last','Busch'),(2,'last','Bergmann'),(2,'last','Thomas'),
(2,'last','Voigt'),(2,'last','Sauer'),(2,'last','Arnold'),(2,'last','Wolff'),(2,'last','Pfeiffer');

-- German Middle Names
INSERT INTO names (locale_id, name_type, value) 
SELECT 2, 'middle_male', value FROM names WHERE locale_id = 2 AND name_type = 'first_male' LIMIT 100;
INSERT INTO names (locale_id, name_type, value) 
SELECT 2, 'middle_female', value FROM names WHERE locale_id = 2 AND name_type = 'first_female' LIMIT 100;

-- German Titles
INSERT INTO titles (locale_id, gender, value) VALUES
(2,'male','Herr'),(2,'female','Frau'),
(2,'neutral','Dr.'),(2,'neutral','Prof.'),(2,'neutral','Prof. Dr.');

-- German States
INSERT INTO states (locale_id, name, abbreviation) VALUES
(2,'Baden-Württemberg','BW'),(2,'Bayern','BY'),(2,'Berlin','BE'),(2,'Brandenburg','BB'),
(2,'Bremen','HB'),(2,'Hamburg','HH'),(2,'Hessen','HE'),(2,'Mecklenburg-Vorpommern','MV'),
(2,'Niedersachsen','NI'),(2,'Nordrhein-Westfalen','NW'),(2,'Rheinland-Pfalz','RP'),(2,'Saarland','SL'),
(2,'Sachsen','SN'),(2,'Sachsen-Anhalt','ST'),(2,'Schleswig-Holstein','SH'),(2,'Thüringen','TH');

-- German Cities
INSERT INTO cities (locale_id, state_id, name, postal_code_prefix) VALUES
(2,(SELECT id FROM states WHERE name='Berlin' AND locale_id=2),'Berlin','10'),
(2,(SELECT id FROM states WHERE name='Hamburg' AND locale_id=2),'Hamburg','20'),
(2,(SELECT id FROM states WHERE name='Bayern' AND locale_id=2),'München','80'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Köln','50'),
(2,(SELECT id FROM states WHERE name='Hessen' AND locale_id=2),'Frankfurt','60'),
(2,(SELECT id FROM states WHERE name='Baden-Württemberg' AND locale_id=2),'Stuttgart','70'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Düsseldorf','40'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Dortmund','44'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Essen','45'),
(2,(SELECT id FROM states WHERE name='Sachsen' AND locale_id=2),'Leipzig','04'),
(2,(SELECT id FROM states WHERE name='Bremen' AND locale_id=2),'Bremen','28'),
(2,(SELECT id FROM states WHERE name='Sachsen' AND locale_id=2),'Dresden','01'),
(2,(SELECT id FROM states WHERE name='Niedersachsen' AND locale_id=2),'Hannover','30'),
(2,(SELECT id FROM states WHERE name='Bayern' AND locale_id=2),'Nürnberg','90'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Duisburg','47'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Bochum','44'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Wuppertal','42'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Bielefeld','33'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Bonn','53'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Münster','48'),
(2,(SELECT id FROM states WHERE name='Baden-Württemberg' AND locale_id=2),'Karlsruhe','76'),
(2,(SELECT id FROM states WHERE name='Baden-Württemberg' AND locale_id=2),'Mannheim','68'),
(2,(SELECT id FROM states WHERE name='Bayern' AND locale_id=2),'Augsburg','86'),
(2,(SELECT id FROM states WHERE name='Hessen' AND locale_id=2),'Wiesbaden','65'),
(2,(SELECT id FROM states WHERE name='Nordrhein-Westfalen' AND locale_id=2),'Gelsenkirchen','45');

-- German Streets
INSERT INTO streets (locale_id, value) VALUES
(2,'Haupt'),(2,'Schiller'),(2,'Goethe'),(2,'Beethoven'),(2,'Mozart'),
(2,'Bach'),(2,'Berliner'),(2,'Frankfurter'),(2,'Münchner'),(2,'Hamburger'),
(2,'Kölner'),(2,'Stuttgarter'),(2,'Düsseldorfer'),(2,'Leipziger'),(2,'Dresdner'),
(2,'Bremer'),(2,'Hannoversche'),(2,'Bonner'),(2,'Nürnberger'),(2,'Essener'),
(2,'Kirch'),(2,'Markt'),(2,'Rathaus'),(2,'Schul'),(2,'Bahnhof'),
(2,'Post'),(2,'Berg'),(2,'Tal'),(2,'Wald'),(2,'Wiesen'),
(2,'Garten'),(2,'Park'),(2,'Schloss'),(2,'Burg'),(2,'Turm'),
(2,'Brücken'),(2,'Fluss'),(2,'See'),(2,'Teich'),(2,'Bach'),
(2,'Linden'),(2,'Eichen'),(2,'Buchen'),(2,'Birken'),(2,'Tannen'),
(2,'Rosen'),(2,'Blumen'),(2,'Sonnen'),(2,'Mond'),(2,'Stern'),
(2,'Nord'),(2,'Süd'),(2,'Ost'),(2,'West'),(2,'Mittel'),
(2,'Ober'),(2,'Unter'),(2,'Vorder'),(2,'Hinter'),(2,'Neu'),
(2,'Alt'),(2,'Groß'),(2,'Klein'),(2,'Lang'),(2,'Kurz'),
(2,'Ring'),(2,'Damm'),(2,'Ufer'),(2,'Allee'),(2,'Promenade'),
(2,'Kaiser'),(2,'König'),(2,'Fürsten'),(2,'Herzog'),(2,'Graf'),
(2,'Bismarck'),(2,'Adenauer'),(2,'Brandt'),(2,'Kohl'),(2,'Merkel'),
(2,'Friedrich'),(2,'Wilhelm'),(2,'Karl'),(2,'Heinrich'),(2,'Ludwig'),
(2,'Friedens'),(2,'Freiheits'),(2,'Einheits'),(2,'Europa'),(2,'Welt'),
(2,'Sand'),(2,'Stein'),(2,'Felsen'),(2,'Mühlen'),(2,'Brunnen'),
(2,'Kloster'),(2,'Dom'),(2,'Kapellen'),(2,'Kreuz'),(2,'Heiligen');

-- German Street Suffixes 
INSERT INTO street_suffixes (locale_id, value) VALUES
(2,'straße'),(2,'weg'),(2,'gasse'),(2,'platz'),(2,'allee'),
(2,'ring'),(2,'damm'),(2,'ufer'),(2,'promenade'),(2,'pfad');

-- German Eye Colors
INSERT INTO eye_colors (locale_id, value, frequency) VALUES
(2,'Braun',35),(2,'Blau',40),(2,'Grün',15),(2,'Grau',8),(2,'Haselnuss',2);