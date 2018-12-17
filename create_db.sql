CREATE TABLE [dbo].[routes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](255) NULL
);

CREATE TABLE [dbo].[buses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[route_id] [int] NOT NULL,
    [name] [varchar](255) NOT NULL    
);

CREATE TABLE [dbo].[stops](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[route_id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
    [display_name] [varchar](255) NOT NULL,
    [read_name] [varchar](255) NOT NULL,
	[lat] [float] NOT NULL,
	[lon] [float] NOT NULL,
	[next_stop_id] [int] NOT NULL,
	[next_stop_distance] [float] NOT NULL,
	[next_stop_time_avg] [int] NOT NULL,
	[next_stop_time_history] [varbinary](1024) NOT NULL,
	[last_update] [bigint] NOT NULL
);

CREATE TABLE [dbo].[tracks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[bus_id] [int] NOT NULL,
	[lat] [float] NOT NULL,
	[lon] [float] NOT NULL,
    [speed] [float] NOT NULL,
    [bearing] [float] NOT NULL,
    [accuracy] [float] NOT NULL,
	[bus_time] [bigint] NOT NULL,
	[server_time] [bigint] NOT NULL,
	[prev_stop_id] [int] NOT NULL,
	[next_stop_id] [int] NOT NULL,
	[at_prev_stop] [tinyint] NOT NULL
);

CREATE TABLE [dbo].[logs](
    [id] [int] IDENTITY(1,1) NOT NULL,
	[bus_id] [int] NOT NULL,
    [message] [varchar](max) NOT NULL,
    [bus_time] [bigint] NOT NULL,
	[server_time] [bigint] NOT NULL
);

CREATE NONCLUSTERED INDEX [log_busid] ON [dbo].[logs] 
(
	[bus_id] ASC
);

CREATE NONCLUSTERED INDEX [busid] ON [dbo].[tracks] 
(
	[bus_id] ASC
);

CREATE NONCLUSTERED INDEX [busid_atprevstop] ON [dbo].[tracks] 
(
	[bus_id] ASC,
	[at_prev_stop] ASC
);

SET IDENTITY_INSERT routes ON
INSERT INTO routes(id, name) VALUES (1, 'City of Sweetwater Bus Route');
INSERT INTO routes(id, name) VALUES (2, 'FIU MMC and EC Bus Route');
SET IDENTITY_INSERT routes OFF

SET IDENTITY_INSERT buses ON
INSERT INTO buses(id, route_id, name) VALUES (5012,2,'MPV-1');
INSERT INTO buses(id, route_id, name) VALUES (25002,2,'MPV-2');
INSERT INTO buses(id, route_id, name) VALUES (5011,2,'MPV-3');
INSERT INTO buses(id, route_id, name) VALUES (5667,1,'SW-1');
INSERT INTO buses(id, route_id, name) VALUES (7140,1,'SW-2');
INSERT INTO buses(id, route_id, name) VALUES (8828,1,'SW-3');
INSERT INTO buses(id, route_id, name) VALUES (1103,1,'SW-4');
INSERT INTO buses(id, route_id, name) VALUES (4056,1,'SW-5');
INSERT INTO buses(id, route_id, name) VALUES (4061,1,'SW-6');
INSERT INTO buses(id, route_id, name) VALUES (25001,1,'SW-7');
SET IDENTITY_INSERT buses OFF

SET IDENTITY_INSERT stops ON
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1001,1,'1701 NW 110 Ave - City of Sweetwater Maintenance','Sweetwater Maintenance','Sweetwater Maintenance',25.789842,-80.374116,1002,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1002,1,'1701 NW 112th Avenue - Sweetwater Code Enforcement and Building and Zoning','Sweetwater Code Enforcement, Building and Zoning','Sweetwater Code Enforcement, Building and Zoning',25.789856,-80.376591,1003,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1003,1,'11401 NW 12th St - DOLPHIN MALL','11401 NW 12th St - DOLPHIN MALL','DOLPHIN MALL',25.790167,-80.382720,1004,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1004,1,'Entry #8 Atrio - Food Court','Entry #8 Atrio Food Court','Atrio Food Court',25.788982,-80.381359,1005,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1005,1,'Entry #7 Bloomingdales - The Outlet Store','Entry #7 Bloomingdales','Entry #7 Bloomingdales',25.788770,-80.379875,1006,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1006,1,'Burlington Coat Factory','Burlington Coat Factory','Burlington Coat Factory',25.788495,-80.378306,1007,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1007,1,'Entry #5 Dolphin Mall /  Marshall / Home Goods','Entry #5 Dolphin Mall','Entry #5 Dolphin Mall',25.788061,-80.377542,1008,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1008,1,'Entry #4 - Sacks Fifth Avenue Outlet.','Entry #4 - Sacks Fifth Avenue Outlet.','Saks Fifth Avenue Outlet',25.786340,-80.377756,1009,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1009,1,'ROSS','ROSS','ROSS',25.786288,-80.379077,1010,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1010,1,'Main Entrance Texas Brazil and Cheesecake Factory','Main Entrance Texas Brazil & Cheesecake Factory','Main Entrance Texas Brazil and Cheesecake Factory',25.786295,-80.381403,1011,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1011,1,'Entry #2 - Old Navy.','Entry #2 - Old Navy.','Entry #2 - Old Navy.',25.787467,-80.383355,1012,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1012,1,'Bass Pro Shop.','Bass Pro Shop.','Bass Pro Shop',25.788658,-80.384232,1013,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1013,1,'DOLPHIN MALL Miami-Dade Main Bus Stop','DOLPHIN MALL - Main Bus Stop','Main Bus Stop',25.790182,-80.382716,1014,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1014,1,'1801 NW 117th Avenue - IKEA','IKEA','IKEA',25.792441,-80.384875,1015,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1015,1,'11698 NW 25th St - US Postal Service','US Post Office','US Post Office',25.796089,-80.384969,1016,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1016,1,'11411 NW 25th St - Our Lady of Mercy Catholic Cemetary','Our Lady of Mercy Catholic Cemetary','Our Lady of Mercy Catholic Cemetary',25.796756,-80.380409,1017,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1017,1,'10730 NW 25th St La Covacha','La Covacha','La Covacha',25.796825,-80.369556,1018,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1018,1,'2390 NW 107th Avenue - Midas','Midas','Midas',25.795821,-80.369141,1019,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1019,1,'1890 NW 107th Avenue - BP gas station/ MD bus stop','BP gas station / MD bus stop','BP gas station and MD bus stop',25.791140,-80.369053,1020,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1020,1,'1500 NW 107th Avenue - County Federal Credit Union','County Federal Credit Union','County Federal Credit Union',25.788252,-80.368964,1021,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1021,1,'1414 NW 107th Avenue - MD bus stop','1414 NW 107th Avenue - MD bus stop','1414 Northwest 107th Avenue - MD bus stop',25.786728,-80.368925,1022,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1022,1,'1390 NW 107th Avenue - MD bus stop','1390 NW 107th Avenue - MD bus stop','1390 Northwest 107th Avenue - MD bus stop',25.785788,-80.368890,1023,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1023,1,'500 NW 107th Avenue - MD bus stop','500 NW 107th Avenue - MD bus stop','500 Northwest 107th Avenue - MD bus stop',25.775014,-80.369670,1024,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1024,1,'318 NW 107th Avenue - MD bus stop','318 NW 107th Avenue - MD bus stop','318 Northwest 107th Avenue - MD bus stop',25.773186,-80.369493,1025,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1025,1,'200 NW 107th Avenue - MD bus stop','200 NW 107th Avenue - MD bus stop','200 Northwest 107th Avenue - MD bus stop',25.770899,-80.369308,1026,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1026,1,'10701 NW W. Flagler - Mobil / Food Star','Mobil / Food Star','10701 Northwest W. Flagler - Mobil / Food Star',25.768930,-80.369127,1027,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1027,1,'10910 W. Flagler - My Pueblo Restaurant','My Pueblo Restaurant','10910 West Flagler - My Pueblo Restaurant',25.768546,-80.373628,1028,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1028,1,'10983 SW 4th Street - MD bus stop','10983 SW 4th Street - MD bus stop','10983 Southwest 4th Street - MD bus stop',25.764667,-80.374820,1029,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1029,1,'110th Avenue SW 5th St - MD bus stop','110th Avenue SW 5th St - MD bus stop','110th Avenue Southwest 5th Street - MD bus stop',25.764048,-80.374683,1030,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1030,1,'500 SW 109th Avenue - City of Sweetwater City Hall & Police Dept.','500 SW 109th Avenue - City of Sweetwater City Hall & PD','City of Sweetwater City Hall and Police Department',25.764052,-80.373102,1031,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1031,1,'512 SW 109th Avenue - City of Sweetwater Passport Office','City of Sweetwater Passport Office','Passport Office',25.763737,-80.372658,1032,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1032,1,'7th SW 110th Avenue - Stop sign','7th SW 110th Ave.','7th Southwest 110th Avenue',25.762511,-80.374408,1033,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1033,1,'7th Tr SW 110th Avenue - Stop sign','7th Terr SW 110th Ave.','7th Terrace and Southwest 110th Avenue',25.761653,-80.374474,1034,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1034,1,'7th Tr SW 113th & 114th Avenue','7th Terr SW 113th & 114th Ave.','7th Terrace and Southwest 113th to 114th Avenue',25.761595,-80.379491,1035,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1035,1,'250 SW 114th Avenue Jorge Mas Canosa Youth Center / Roselly Park','Jorge Mas Canosa Youth Center / Roselly Park','Jorge Mas Canosa Youth Center and  Roselly Park',25.766016,-80.380840,1036,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1036,1,'11495 W. Flagler - Social Security / Robles / Villa Hermosa','Social Security / Robles / Villa Hermosa','Social Security,  Robles  and Villa Hermosa',25.768366,-80.382832,1037,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1037,1,'11699 W. Flagler - Salon Del Reino De Los Testigos De Jehova','Salon Del Reino De Los Testigos De Jehova','Salon Del Reino De Los Testigos De Jehova',25.768327,-80.383487,1038,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1038,1,'117th Avenue SW 1st St - Corner','117th Avenue & SW 1st St ','117th Avenue and Southwest 1st Street',25.768286,-80.384690,1039,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1039,1,'11590 SW 2nd St - MD bus stop','11590 SW 2nd St - MD bus stop','11590 Southwest 2nd Street - MD bus stop',25.766397,-80.383631,1040,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1040,1,'11490 SW 2nd St - MD bus stop','11490 SW 2nd St - MD bus stop','11490 Southwest 2nd St - MD bus stop',25.766419,-80.382725,1041,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1041,1,'455 NW 114th Avenue - (New Building)','455 NW 114th Avenue - (New Building)','455 Northwest 114th Avenue, New Building',25.772568,-80.381368,1042,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1042,1,'4th Tr NW 110th Avenue','4th Tr NW 110th Avenue','4th Terraace and Northwest 110th Avenue',25.772740,-80.381375,1043,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1043,1,'6th St NW 114th Avenue','6th St NW 114th Avenue','6th St and Northwest 114th Avenue',25.774430,-80.381527,1044,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1044,1,'7th NW 113th Avenue','7th NW 113th Avenue','7th and Northwest 113th Avenue',25.775340,-80.379468,1045,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1045,1,'7th NW 112th Avenue','7th NW 112th Avenue','7th and Northwest 112th Avenue',25.775375,-80.377732,1046,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1046,1,'606 NW 112th Avenue - MD bus Stop','606 NW 112th Avenue - MD bus Stop','606 and Northwest 112th Avenue - MD bus Stop',25.774855,-80.377632,1047,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1047,1,'11235 NW 5th St - Vann Academy / MD bus stop','Vann Academy / MD bus stop','11235 Northwest 5th St - Vann Academy and MD bus stop',25.773343,-80.377481,1048,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1048,1,'112th Avenue NW 2nd Tr - MD bus stop','112th Avenue NW 2nd Tr - MD bus stop','112th Avenue and Northwest 2nd Terrace - MD bus stop',25.771329,-80.377317,1049,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1049,1,'112th Avenue NW 1st St - MD bus stop','112th Avenue NW 1st St - MD bus stop','112th Avenue and Northwest 1st Street - MD bus stop',25.769770,-80.377214,1050,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1050,1,'11200 W. Flagler - Tower Plaza / MD bus stop','Tower Plaza / MD bus stop','Tower Plaza and MD bus stop',25.768012,-80.377045,1051,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1051,1,'11200 SW 2nd St - MD bus stop','11200 SW 2nd St - MD bus stop','11200 Southwest 2nd Street - MD bus stop',25.766271,-80.376896,1052,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1052,1,'7th Tr SW 113th & 114th Avenue','7th Tr SW 113th & 114th Avenue','7th Terrace and Southwest 113th to 114th Avenue',25.761596,-80.380066,1053,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1053,1,'550 SW 115th Avenue - Sweetwater Creek','Sweetwater Creek','Sweetwater Creek',25.763505,-80.382726,1054,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1054,1,'115th SW 2nd Street - Stop sign','115th SW 2nd Street','115th Southwest 2nd Street',25.766370,-80.382880,1055,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1055,1,'11400 W. Flagler - Flagler Shopping Center / MD bus stop','Flagler Shopping Center / MD bus stop','11400 West Flagler - Flagler Shopping Center, MD bus stop',25.768147,-80.381379,1056,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1056,1,'11388 W. Flagler - MD bus stop','11388 W. Flagler - MD bus stop','11388 West Flagler - MD bus stop',25.768138,-80.380259,1057,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1057,1,'113th Avenue W. Flagler - MD bus stop','113th Avenue W. Flagler - MD bus stop','113th Avenue West. Flagler - MD bus stop',25.768206,-80.378428,1058,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1058,1,'11180 W. Flagler - MD bus stop','11180 W. Flagler - MD bus stop','11180 West Flagler - MD bus stop',25.768275,-80.376449,1059,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1059,1,'10900 W. Flagler - Finish Line Gas Station','Finish Line Gas Station','10900 West Flagler - Finish Line Gas Station',25.768302,-80.373549,1060,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1060,1,'10780 W Flagler  - Sedanos','Sedanos','10720 West Flagler - Sedanos',25.768343,-80.370601,1061,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1061,1,'50 SW 108th Avenue - MD bus stop','50 SW 108th Avenue - MD bus stop','50 Southwest 108th Avenue - MD bus stop',25.768110,-80.370911,1062,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1062,1,'10690 W. Flagler - Chase Bank','Chase Bank','10690 West Flagler - Chase Bank',25.768376,-80.368426,1063,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1063,1,'10500 W. Flagler - MacDonald','MacDonald','10500 West Flagler - MacDonald',25.768495,-80.366162,1064,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1064,1,'W. Flagler & 103 Ct. - MD bus stop','W. Flagler & 103 Ct. - MD bus stop','West Flagler and 103 Court. - MD bus stop',25.768540,-80.363497,1065,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1065,1,'10198 W. Flagler - Sunoco Gas Station / MD Bus stop','Sunoco Gas Station / MD Bus stop','Sunoco Gas Station and MD Bus stop',25.768640,-80.360436,1066,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1066,1,'10044 W. Flagler - Navarro','Navarro','Navarro',25.768697,-80.359272,1067,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1067,1,'W. Flagler & 99 Ct. - MD bus stop','W. Flagler & 99 Ct. - MD bus stop','West Flagler and 99 Court - MD bus stop',25.768739,-80.358205,1068,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1068,1,'Flagler & 97th Ave (Eastbound)','Flagler & 97th Ave (Eastbound)','Flagler and 97th Ave Eastbound',25.769217,-80.353259,1069,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1069,1,'Flagler & 94th Ave - MD bus stop (Eastbound)','Flagler & 94th Ave - MD bus stop (Eastbound)','Flagler and 94th Ave - MD bus stop Eastbound',25.769180,-80.348259,1070,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1070,1,'Flagler & 92nd Ave - Walmart Store','Flagler & 92nd Ave - Walmart Store','Walmart Store',25.769283,-80.343920,1071,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1071,1,'Flagler & 94th Ave - MD bus stop (Westbound)','Flagler & 94th Ave - MD bus stop (Westbound)','Flagler and 94th Ave - MD bus stop Westbound',25.769264,-80.349213,1072,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1072,1,'9695 W. Flagler - Winn Dixie Fresco Grocery','Winn Dixie Fresco Grocery','Winn Dixie Fresco Grocery',25.768852,-80.353415,1073,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1073,1,'9825 W. Flagler - Ruben Dario Park','Ruben Dario Park','Ruben Dario Park',25.769013,-80.355804,1074,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1074,1,'W. Flagler & 99 Ct. - MD bus stop','W. Flagler & 99 Ct. - MD bus stop','West Flagler and 99 Court - MD bus stop',25.768951,-80.358339,1075,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1075,1,'102nd Avenue SW 1st St.','102nd Avenue SW 1st St.','102nd Avenue and Southwest 1st Street.',25.767746,-80.360919,1076,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1076,1,'102nd Avenue SW 4th St. - Stop sign','102nd Avenue SW 4th St. - Stop sign','102nd Avenue and Southwest 4th St. - Stop sign',25.765104,-80.360700,1077,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1077,1,'10600 SW 4th St - Mildred & Claude Pepper Senior Center','Mildred & Claude Pepper Senior Center','Mildred & Claude Pepper Senior Center',25.764925,-80.366725,1078,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1078,1,'300 SW 107th Ave - Continental National Bank of Miami','Continental National Bank of Miami','Continental National Bank of Miami',25.764952,-80.368275,1079,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1079,1,'10750 SW 4th St - Sweetwater Towers','Sweetwater Towers','Sweetwater Towers',25.764881,-80.370111,1080,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1080,1,'10899 SW 4th St - MD bus stop','10899 SW 4th St - MD bus stop','10899 Southwest  4th Street - MD bus stop',25.764845,-80.372297,1081,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1081,1,'740 SW 107th Avenue','740 SW 107th Avenue','740 Southwest  107th Avenue',25.762037,-80.368366,1082,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1082,1,'1200 SW 108th Avenue - FIU','FIU','FIU',25.758136,-80.368424,1083,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1083,1,'1525 SW 107th Avenue - Publix Supermarket / MD bus stop','Publix Supermarket / MD bus stop','Publix Supermarket and MD bus stop',25.755364,-80.368422,1084,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1084,1,'1225 SW 107th Avenue - Palmer House / MD bus stop','Palmer House / MD bus stop','Palmer House and MD bus stop',25.757289,-80.368082,1085,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1085,1,'595 SW 107th Avenue - MD bus stop','595 SW 107th Avenue - MD bus stop','595 Southwest 107th Avenue - MD bus stop',25.763288,-80.368473,1086,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1086,1,'10555 W. Flagler (West Side) - FIU Engineering Center','FIU Engineering Center','FIU Engineering Center',25.769989,-80.368989,1087,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1087,1,'561 NW 107th Ave -West Lake Village / MD bus stop','West Lake Village / MD bus stop','West Lake Village and MD bus stop',25.773202,-80.369249,1088,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1088,1,'690 NW 107th Ave - Tropical Super Market','Tropical Super Market','Tropical Super Market',25.775358,-80.369436,1089,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1089,1,'1455 NW 107 Ave- Macys & Old Navy - INTERNATIONAL MALL','Macys & Old Navy - INTERNATIONAL MALL','Macys and Old Navy - INTERNATIONAL MALL',25.784529,-80.368509,1090,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (1090,1,'10750 NW 14th Street - MD bus stop','10750 NW 14th Street - MD bus stop','10750 Northwest 14th Street - MD bus stop',25.786259,-80.369101,1001,0,0,0x,0);

INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (2001,2,'GC','GC','GC',25.754741,-80.371036,2002,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (2002,2,'PG 5','PG 5','PG 5',25.759876,-80.370844,2003,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (2003,2,'109 Tower','109 Tower','109 Tower',25.762125,-80.372421,2004,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (2004,2,'4th Street Apartments','4th Street Apartments','4th Street Apartments',25.765398,-80.372703,2005,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (2005,2,'EC','EC','EC',25.769867,-80.368229,2006,0,0,0x,0);
INSERT INTO stops(id, route_id, name, display_name, read_name, lat, lon, next_stop_id, next_stop_distance, next_stop_time_avg, next_stop_time_history, last_update) VALUES (2006,2,'Lot 5','Lot 5','Lot 5',25.752659,-80.368751,2001,0,0,0x,0);

SET IDENTITY_INSERT stops OFF