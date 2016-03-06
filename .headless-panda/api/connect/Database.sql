SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE if exists HP_SITE;
DROP TABLE if exists HP_ROLE;
DROP TABLE if exists HP_USER;
DROP TABLE if exists HP_ARTICLE;
DROP TABLE if exists HP_EDIT;
DROP TABLE if exists HP_ITEM;
DROP TABLE if exists HP_CATEGORY;
DROP TABLE if exists HP_ART_CAT;
DROP TABLE if exists HP_APP;
DROP TABLE if exists HP_APP_LOG;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE HP_SITE(
	Id				INT(10)				PRIMARY KEY auto_increment,
	Title			VARCHAR(255)		NOT NULL,
	Secret			VARCHAR(255)		NOT NULL,
	Description		LONGTEXT			NULL,
	Author			VARCHAR(255)		DEFAULT "Sander Geraedts - Code Panda",
	Icon			VARCHAR(255)		NULL
);

CREATE TABLE HP_ROLE(
	Id				INT(10)				PRIMARY KEY auto_increment,
	Site_Id			INT(10)				NOT NULL,
	Name			VARCHAR(255)		NOT NULL,

	CONSTRAINT		UN_Name1			UNIQUE(Site_Id, Name),
	CONSTRAINT		FK_Site_Id1			FOREIGN KEY (Site_Id) REFERENCES HP_SITE(Id)
);

CREATE TABLE HP_USER(
	Id				INT(10)				PRIMARY KEY auto_increment,
	Role_Id			INT(10)				NOT NULL,
	Site_Id 		INT(10)				NOT NULL,
	Name 			VARCHAR(255)		NOT NULL,
	Username		VARCHAR(255) 		NOT NULL,
	Password		VARCHAR(255)		NOT NULL,
	Avatar			VARCHAR(255) 		NULL,
	Url				VARCHAR(255)		NULL,
	Bio				LONGTEXT 			NULL,

	CONSTRAINT 		CK_PasswordLength	CHECK (LENGTH(Password) > 7),
	CONSTRAINT		CK_PasswordUpper	CHECK (UPPER(Password) != Password),
	CONSTRAINT		CK_PasswordLower	CHECK (LOWER(Password) != Password),
	CONSTRAINT 		UN_Username1		UNIQUE(Site_Id, Username),
	CONSTRAINT 		FK_Role_Id1			FOREIGN KEY (Role_Id) REFERENCES HP_ROLE(Id),
	CONSTRAINT 		FK_Site_Id2 		FOREIGN KEY (Site_Id) REFERENCES HP_SITE(Id)
);

CREATE TABLE HP_ARTICLE(
	Id 				INT(10)				PRIMARY KEY auto_increment,
	Author_Id		INT(10)				NOT NULL,
	Site_Id 		INT(10)				NOT NULL,
	Title			VARCHAR(255)		NOT NULL,
	Excerpt			LONGTEXT 			NULL,
	Publish_Date	DATETIME			DEFAULT CURRENT_TIMESTAMP,
	Featured_Img	VARCHAR(255)		NULL,

	CONSTRAINT 		FK_User_Id1			FOREIGN KEY (Author_Id) REFERENCES HP_USER(Id),
	CONSTRAINT 		FK_Site_Id3			FOREIGN KEY (Site_Id) REFERENCES HP_SITE(Id)
);

CREATE TABLE HP_EDIT(
	Id 				INT(10)				PRIMARY KEY auto_increment,
	Article_Id		INT(10)				NOT NULL,
	Editor_Id		INT(10)				NOT NULL,
	Edit_Date		DATETIME 			DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT 		FK_Article_Id1		FOREIGN KEY (Article_Id) REFERENCES HP_ARTICLE(Id),
	CONSTRAINT 		FK_User_Id2 		FOREIGN KEY (Editor_Id) REFERENCES HP_USER(Id)
);

CREATE TABLE HP_ITEM(
	Id 				INT(10)				PRIMARY KEY auto_increment,
	Article_Id 		INT(10)				NOT NULL,
	Item_Type		VARCHAR(255)		NOT NULL,
	Item_Order		INT(10)				NOT NULL,
	Item_Text		LONGTEXT 			NOT NULL,

	CONSTRAINT 		UN_Order			UNIQUE(Article_Id, Item_Order),
	CONSTRAINT 		CK_Item_Type		CHECK (UPPER(Item_Type) == 'PARAGRAPH' OR UPPER(Item_Type) == 'IMAGE' OR UPPER(Item_Type) == 'H1' OR UPPER(Item_Type) == 'H2' OR UPPER(Item_Type) == 'H3' OR UPPER(Item_Type) == 'H4' OR UPPER(Item_Type) == 'H5' OR UPPER(Item_Type) == 'H6' OR UPPER(Item_Type) == 'VIDEO' OR UPPER(Item_Type) == 'IFRAME')
	CONSTRAINT 		FK_Article_Id2 		FOREIGN KEY (Article_Id) REFERENCES HP_ARTICLE(Id)
);

CREATE TABLE HP_CATEGORY(
	Id 				INT(10)				PRIMARY KEY auto_increment,
	Parent_Id		INT(10)				NULL,
	Site_Id 		INT(10)				NOT NULL,
	Name 			VARCHAR(255)		NOT NULL,

	CONSTRAINT 		FK_CategoryId1		FOREIGN KEY (Parent_Id) REFERENCES HP_CATEGORY(Id),
	CONSTRAINT 		FK_Site_Id4			FOREIGN KEY (Site_Id) REFERENCES HP_SITE(Id)
);

CREATE TABLE HP_ART_CAT(
	Article_Id 		INT(10)				NOT NULL,
	Category_Id		INT(10)				NOT NULL,

	CONSTRAINT 		FK_Article_Id3 		FOREIGN KEY (Article_Id) REFERENCES HP_ARTICLE(Id),
	CONSTRAINT 		FK_CategoryId2		FOREIGN KEY (Category_Id) REFERENCES HP_CATEGORY(Id)
);

CREATE TABLE HP_APP(
	Id  			CHAR(40)			PRIMARY KEY,
	Site_Id 		INT(10)				NOT NULL,
	Name 		 	VARCHAR(255)		NOT NULL,
	Description 	LONGTEXT 			NULL,

	CONSTRAINT 		FK_Site_Id5 		FOREIGN KEY (Site_Id) REFERENCES HP_SITE(Id)
);

CREATE TABLE HP_APP_LOG(
	Id 				INT(10)				PRIMARY KEY auto_increment,
	App_Id 			CHAR(40)			NOT NULL,
	App_Time		DATETIME 			DEFAULT CURRENT_TIMESTAMP,
	Method			VARCHAR(255)		NULL,

	CONSTRAINT 		FK_App_Id1			FOREIGN KEY (App_Id) REFERENCES HP_APP(Id)
);

INSERT INTO HP_SITE(Title, Secret, Description, Icon) VALUES ('Code Panda', 'lkdrfjadklsjsdakljf', 'Code Panda, Nederlandse webdevelopment en design met een persoonlijke touch. Actief in de regio Best en Eindhoven, maar natuurlijk ook daarbuiten.', 'http://www.codepanda.nl/assets/img/icon.png');
INSERT INTO HP_SITE(Title, Secret, Description, Icon) VALUES ('VVNBest', 'uirnmcelmjcfjmkmfeiojrcfk', 'Veilig Verkeer Nederland Afdeling Best.', 'http://www.vvnbest.nl/assets/img/icon.png');

INSERT INTO HP_ROLE(Site_Id, Name) VALUES (1, 'Administrator');
INSERT INTO HP_ROLE(Site_Id, Name) VALUES (1, 'Editor');
INSERT INTO HP_ROLE(Site_Id, Name) VALUES (1, 'Author');
INSERT INTO HP_ROLE(Site_Id, Name) VALUES (1, 'Guest');

INSERT INTO HP_ROLE(Site_Id, Name) VALUES (2, 'Administrator');
INSERT INTO HP_ROLE(Site_Id, Name) VALUES (2, 'Editor');
INSERT INTO HP_ROLE(Site_Id, Name) VALUES (2, 'Author');
INSERT INTO HP_ROLE(Site_Id, Name) VALUES (2, 'Guest');

INSERT INTO HP_USER(Role_Id, Site_Id, Name, Username, Password, Avatar, Url, Bio) VALUES (1, 1, 'Sander Geraedts', 'admin', 'Sg06121994', 'http://www.codepanda.nl/assets/img/avatar.png', 'http://www.codepanda.nl/', 'My Bio...');

INSERT INTO HP_ARTICLE(Author_Id, Site_Id, Title, Featured_Img) VALUES (1, 1, '10 Ways to improve your UX', 'http://www.codepanda.nl/assets/img/ux.png');

INSERT INTO HP_ITEM(Article_Id, Item_Type, Item_Order, Item_Text) VALUES (1, 'H1', 1, '10 Ways to improve your UX');
INSERT INTO HP_ITEM(Article_Id, Item_Type, Item_Order, Item_Text) VALUES (1, 'PARAGRAPH', 2, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Iure necessitatibus sapiente excepturi vitae autem nesciunt saepe magnam nostrum animi, placeat. Quos, distinctio ipsam laboriosam cum deserunt necessitatibus id hic veniam.');

#INSERT INTO HP_APP(Site_Id, Name, Description)