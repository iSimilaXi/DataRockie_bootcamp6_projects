-- List of best-selling PS4 games
-- https://www.kaggle.com/datasets/drahulsingh/list-of-best-selling-ps4-games?resource=download

CREATE TABLE 'ListofbestsellingPlayStation4videogames' ('Game' TEXT,'Copies_sold' INTEGER,'Release_date' TEXT,'Year_Released' TEXT,'Genre' TEXT,'Sub-genre' TEXT,'Developer' TEXT,'Publisher' TEXT,'Region-Specific_Publisher' TEXT);
INSERT INTO 'ListofbestsellingPlayStation4videogames' ('Game','Copies_sold','Release_date','Year_Released','Genre','Sub-genre','Developer','Publisher','Region-Specific_Publisher') VALUES 
 ('Minecraft: PlayStation 4 Edition','2000000','4-Sep-14',' 2,014 ','Sandbox','Survival','4J Studios','Sony Computer Entertainment','-'), 
 ('Monster Hunter: World','4670000','26-Jan-18',' 2,018 ','Action role-playing','-','Capcom','Capcom','-'), 
 ('The Witcher 3: Wild Hunt','10800000','18-May-15',' 2,015 ','Action role-playing','-','CD Projekt Red','CD Projekt','-'), 
 ('Cyberpunk 2077','3830000','10-Dec-20',' 2,020 ','Action role-playing','-','CD Projekt Red','CD Projekt','-'), 
 ('FIFA 17','3120000','27-Sep-16',' 2,016 ','Sports','-','EA Canada EA Bucharest','EA Sports','-'), 
 ('Star Wars Battlefront','8420000','17-Nov-15',' 2,015 ','First-person shooter','Third-Person Shooter','EA DICE','Electronic Arts','-'), 
 ('Battlefield 1','1300000','21-Oct-16',' 2,016 ','First-person shooter','-','EA DICE','Electronic Arts','-'), 
 ('Driveclub','2000000','7-Oct-14',' 2,014 ','Racing','-','Evolution Studios','Sony Computer Entertainment','-'), 
 ('Bloodborne','2000000','24-Mar-15',' 2,015 ','Action role-playing','-','FromSoftware','Sony Computer Entertainment','-'), 
 ('Killzone: Shadow Fall','2100000','15-Nov-13',' 2,013 ','First-person shooter','-','Guerrilla Games','Sony Computer Entertainment','-'), 
 ('Horizon Zero Dawn','10000000','28-Feb-17',' 2,017 ','Action role-playing','-','Guerrilla Games','Sony Interactive Entertainment','-'), 
 ('Marvel''s Spider-Man','20000000','7-Sep-18',' 2,018 ','Action-adventure','-','Insomniac Games','Sony Interactive Entertainment','-'), 
 ('Knack','2000000','15-Nov-13',' 2,013 ','Platform','Beat ''em up','Japan Studio','Sony Computer Entertainment','-'), 
 ('Metal Gear Solid V: The Phantom Pain','1100000','1-Sep-15',' 2,015 ','Action-adventure','Stealth','Kojima Productions','Konami','-'), 
 ('The Last of Us Remastered','10000000','29-Jul-14',' 2,014 ','Action-adventure','Survival Horror','Naughty Dog','Sony Computer Entertainment','-'), 
 ('The Last of Us Part II','10000000','19-Jun-20',' 2,020 ','Action-adventure','Survival Horror','Naughty Dog','Sony Interactive Entertainment','-'), 
 ('Uncharted 4: A Thief''s End','16000000','10-May-16',' 2,016 ','Action-adventure','-','Naughty Dog','Sony Interactive Entertainment','-'), 
 ('Nier: Automata','1600000','23-Feb-17',' 2,017 ','Action role-playing','-','PlatinumGames','Square Enix','-'), 
 ('Gran Turismo Sport','8000000','17-Oct-17',' 2,017 ','Racing','-','Polyphony Digital','Sony Interactive Entertainment','-'), 
 ('Persona 5 Royal','2300000','31-Oct-19',' 2,019 ','Role-playing','Social Simulation','P-Studio','Atlus','-'), 
 ('Detroit: Become Human','5500000','25-May-18',' 2,018 ','Adventure','-','Quantic Dream','Sony Interactive Entertainment','-'), 
 ('Grand Theft Auto V','2020000','18-Nov-14',' 2,014 ','Action-adventure','-','Rockstar North','Rockstar Games','-'), 
 ('God of War','19500000','20-Apr-18',' 2,018 ','Action-adventure','Hack And Slash','Santa Monica Studio','Sony Interactive Entertainment','-'), 
 ('Final Fantasy XII: The Zodiac Age','1000000','11-Jul-17',' 2,017 ','Role-playing','-','Square Enix','Square Enix','-'), 
 ('Dragon Quest XI: Echoes of an Elusive Age','1300000','29-Jul-17',' 2,017 ','Role-playing','-','Square Enix','Square Enix','-'), 
 ('Kingdom Hearts III','1000000','25-Jan-19',' 2,019 ','Action role-playing','-','Square Enix','Square Enix','-'), 
 ('Final Fantasy VII Remake','5000000','10-Apr-20',' 2,020 ','Action role-playing','-','Square Enix','Square Enix','-'), 
 ('Final Fantasy XV','2500000','29-Nov-16',' 2,016 ','Action role-playing','-','Square Enix Business Division 2','Square Enix','-'), 
 ('Ghost of Tsushima','9730000','17-Jul-20',' 2,020 ','Action-adventure','Stealth','Sucker Punch Productions','Sony Interactive Entertainment','-'), 
 ('Infamous Second Son','6000000','21-Mar-14',' 2,014 ','Action-adventure','-','Sucker Punch Productions','Sony Computer Entertainment','-'), 
 ('Nioh','1000000','7-Feb-17',' 2,017 ','Action role-playing','','Team Ninja','Sony Computer Entertainment','JP Koei tecmo'), 
 ('Nioh 2','1400000','12-Mar-20',' 2,020 ','Action role-playing','','Team Ninja','Sony Computer Entertainment','JP Koei tecmo'), 
 ('Crash Bandicoot N. Sane Trilogy','2500000','30-Jun-17',' 2,017 ','Platform','-','Vicarious Visions','Activision','-');


-- 1. best-selling developer within each genre, to worst
SELECT developer,
	genre,
	SUM(copies_sold) AS Sales
FROM ListofbestsellingPlayStation4videogames
GROUP BY developer, genre
ORDER BY sales DESC;

-- 2. best-selling games
SELECT  game,
      	developer,
        publisher,
	SUM(copies_sold) AS Sales
FROM ListofbestsellingPlayStation4videogames
GROUP BY developer, game, publisher
ORDER BY sales DESC;

-- 3. average sales per game for publisher + best-selling publisher
SELECT  publisher,
	AVG(copies_sold) AS Average_Sales,
        SUM(copies_sold) AS Total_Sales
FROM ListofbestsellingPlayStation4videogames
GROUP BY publisher
ORDER BY Average_Sales, Total_Sales DESC;

-- 4. sales for each year, best year for gaming (sell-wise)
SELECT year_released,
		SUM(copies_sold) AS sales
FROM ListofbestsellingPlayStation4videogames
GROUP BY year_released
ORDER BY sales DESC
