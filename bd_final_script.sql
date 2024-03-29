USE [master]
GO
/****** Object:  Database [gamemasters]    Script Date: 09-06-2017 18:47:54 ******/
CREATE DATABASE [gamemasters]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'gamemasters', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\gamemasters.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'gamemasters_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\gamemasters_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [gamemasters] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [gamemasters].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [gamemasters] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [gamemasters] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [gamemasters] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [gamemasters] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [gamemasters] SET ARITHABORT OFF 
GO
ALTER DATABASE [gamemasters] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [gamemasters] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [gamemasters] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [gamemasters] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [gamemasters] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [gamemasters] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [gamemasters] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [gamemasters] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [gamemasters] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [gamemasters] SET  ENABLE_BROKER 
GO
ALTER DATABASE [gamemasters] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [gamemasters] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [gamemasters] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [gamemasters] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [gamemasters] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [gamemasters] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [gamemasters] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [gamemasters] SET RECOVERY FULL 
GO
ALTER DATABASE [gamemasters] SET  MULTI_USER 
GO
ALTER DATABASE [gamemasters] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [gamemasters] SET DB_CHAINING OFF 
GO
ALTER DATABASE [gamemasters] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [gamemasters] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [gamemasters] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'gamemasters', N'ON'
GO
ALTER DATABASE [gamemasters] SET QUERY_STORE = OFF
GO
USE [gamemasters]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [gamemasters]
GO
/****** Object:  Schema [Game_Masters]    Script Date: 09-06-2017 18:47:55 ******/
CREATE SCHEMA [Game_Masters]
GO
/****** Object:  UserDefinedFunction [dbo].[get_user_community_id]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[get_user_community_id](@id varchar(50))
RETURNS INT
AS
BEGIN
    DECLARE @c_id INT ;
    SELECT @c_id = Game_Masters.Comunidade.ID
	FROM Game_Masters.Comunidade
    WHERE Game_Masters.Comunidade.ownerID = @id
	RETURN @c_id;
END

GO
/****** Object:  UserDefinedFunction [dbo].[Username_Exists]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Username_Exists](@username varchar(50), @pass varchar(50))
RETURNS INT
AS
BEGIN
    DECLARE @count INT ;
    SELECT @count = count (*) FROM Game_Masters.Conta
    WHERE Game_Masters.Conta.NickName = @username AND Game_Masters.Conta.pass = @pass
    IF @count = 1
    BEGIN
        RETURN '1'
    END
    return '0'
END
GO
/****** Object:  Table [Game_Masters].[Tipo_Utilizador]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Tipo_Utilizador](
	[ID] [int] NOT NULL,
	[Descricao] [varchar](100) NULL,
	[Is_Admin] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Game_Masters].[Utilizador]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Utilizador](
	[Nome] [varchar](50) NOT NULL,
	[typeID] [int] NULL,
	[Is_Banned] [bit] NULL,
	[Email] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Game_Masters].[Conta]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Conta](
	[NickName] [varchar](50) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NULL,
	[PayMethod] [varchar](50) NULL,
	[Ranking] [int] NULL,
	[pass] [varchar](50) NOT NULL,
	[Is_Disabled] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Game_Masters].[Reviews]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Reviews](
	[Nome] [varchar](50) NOT NULL,
	[Content] [varchar](500) NOT NULL,
	[user_email] [varchar](50) NOT NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[gameID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[udf_show_user]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_show_user]()
RETURNS TABLE
AS
	RETURN (SELECT Game_Masters.Utilizador.Nome as 'User Name', Is_Admin as 'User Admin', Is_Banned as 'User Banned', Game_Masters.Utilizador.Email as 'User Email', 
			COUNT(distinct Game_Masters.Conta.ID) as 'User Account',
			COUNT(distinct Game_Masters.Reviews.ID) as 'User Reviews' 
			FROM ((Game_Masters.Utilizador INNER JOIN Game_Masters.Tipo_Utilizador ON Utilizador.typeID = Tipo_Utilizador.ID) INNER JOIN Game_Masters.Conta ON Game_Masters.Utilizador.Email = Game_Masters.Conta.Email)
			INNER JOIN Game_Masters.Reviews ON Game_Masters.Utilizador.Email = Game_Masters.Reviews.user_email
			GROUP BY Game_Masters.Utilizador.Nome, Is_Admin, Is_Banned, Game_Masters.Utilizador.Email);

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getUser_Name]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getUser_Name](@Name VARCHAR(50))
RETURNS TABLE
AS
	RETURN (SELECT Nome as 'User Name', Email as 'User Email' FROM Game_Masters.Utilizador WHERE Nome like '%' + @Name + '%');

GO
/****** Object:  UserDefinedFunction [dbo].[udf_showBannedUsers]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_showBannedUsers]()
RETURNS TABLE
AS
	RETURN (SELECT Game_Masters.Utilizador.Nome as 'User Name', Is_Banned as 'User Banned', Game_Masters.Utilizador.Email as 'User Email'
			FROM Game_Masters.Utilizador
			WHERE Game_Masters.Utilizador.Is_Banned = '1'
			GROUP BY Game_Masters.Utilizador.Nome, Is_Banned, Game_Masters.Utilizador.Email);

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getBannedUser_ID]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getBannedUser_ID](@ID int)
RETURNS TABLE
AS
	RETURN (SELECT Nome as 'User Name', Email as 'User Email' FROM Game_Masters.Utilizador WHERE Game_Masters.Utilizador.Email = @ID AND Game_Masters.Utilizador.Is_Banned = '1');

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getBannedUser_Name]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getBannedUser_Name](@Nome VARCHAR(50))
RETURNS TABLE
AS
	RETURN (SELECT Nome as 'User Name', Email as 'User Email' FROM Game_Masters.Utilizador WHERE Game_Masters.Utilizador.Nome LIKE '%' + @Nome + '%' AND Game_Masters.Utilizador.Is_Banned = '1');

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getAccount_Name]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getAccount_Name](@NickName VARCHAR(50))
RETURNS TABLE
AS
	RETURN (SELECT * FROM Game_Masters.Conta WHERE NickName like '%' + @NickName + '%');

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getAccount_ID]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getAccount_ID](@ID int)
RETURNS TABLE
AS
RETURN (SELECT * FROM Game_Masters.Conta WHERE Game_Masters.Conta.ID = @ID);

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getAccount_Email]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getAccount_Email](@Email VARCHAR(50))
RETURNS TABLE
AS
	RETURN (SELECT * FROM Game_Masters.Conta WHERE Email like '%' + @Email + '%');

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getDisabledAccount_Name]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getDisabledAccount_Name](@NickName VARCHAR(50))
RETURNS TABLE
AS
	RETURN (SELECT * FROM Game_Masters.Conta WHERE Game_Masters.Conta.NickName = @NickName AND Game_Masters.Conta.Is_Disabled = '1');

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getDisabledAccount_ID]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getDisabledAccount_ID](@ID int)
RETURNS TABLE
AS
RETURN (SELECT * FROM Game_Masters.Conta WHERE Game_Masters.Conta.ID = @ID AND Game_Masters.Conta.Is_Disabled = '1');

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getDisabledAccount_Email]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getDisabledAccount_Email](@Email VARCHAR(50))
RETURNS TABLE
AS
	RETURN (SELECT * FROM Game_Masters.Conta WHERE Game_Masters.Conta.Email = @Email AND Game_Masters.Conta.Is_Disabled = '1');

GO
/****** Object:  Table [Game_Masters].[Loja]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Loja](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ownerID] [int] NOT NULL,
	[wishlist] [varchar](50) NULL,
	[Promocoes] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getAccount_Store]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getAccount_Store]()
RETURNS TABLE
AS
RETURN (SELECT NickName as 'Account Name', Email as 'Account Email', Game_Masters.Loja.ID as 'Store ID', wishlist as 'User Wishlist', Promocoes as 'Store Promotions'
		FROM Game_Masters.Conta JOIN Game_Masters.Loja ON Game_Masters.Conta.ID = Game_Masters.Loja.ID);

GO
/****** Object:  Table [Game_Masters].[Comunidade]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Comunidade](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ownerID] [int] NOT NULL,
	[Nome] [varchar](50) NULL,
	[Estado] [varchar](50) NULL,
	[Amigos] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getAccount_Community]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getAccount_Community]()
RETURNS TABLE
AS
RETURN (SELECT NickName as 'Account Name', Email as 'Account Email', Game_Masters.Comunidade.ID as 'Community ID', Game_Masters.Comunidade.Nome as 'Community Name', Estado as 'User State', Amigos as 'User Friend List'
		FROM Game_Masters.Conta JOIN Game_Masters.Comunidade ON Game_Masters.Conta.ID = Game_Masters.Comunidade.ID);

GO
/****** Object:  Table [Game_Masters].[Fornecedor]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Fornecedor](
	[Nome] [varchar](50) NOT NULL,
	[NIF] [int] NULL,
	[FAX] [int] NULL,
	[Endereco] [varchar](50) NULL,
	[CondPagamento] [varchar](50) NULL,
	[ID_Fornecedor] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[udf_show_provider]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_show_provider]()
RETURNS TABLE
AS
RETURN (SELECT Nome as 'Provider Name', NIF as 'Provider NIF', FAX as 'Provider FAX', Endereco as 'Provider Address', CondPagamento as 'Provider PayConditions', ID_Fornecedor as 'Provider ID' FROM Game_Masters.Fornecedor);

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getProvider_Name]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getProvider_Name](@Nome VARCHAR(50))
RETURNS TABLE
AS
	RETURN (SELECT Nome as 'Provider Name', NIF as 'Provider NIF', FAX as 'Provider FAX', Endereco as 'Provider Address', CondPagamento as 'Provider PayConditions', ID_Fornecedor as 'Provider ID' FROM Game_Masters.Fornecedor WHERE Nome like '%' + @Nome + '%');

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getProvider_ID]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getProvider_ID](@ID int)
RETURNS TABLE
AS
	RETURN (SELECT Nome as 'Provider Name', NIF as 'Provider NIF', FAX as 'Provider FAX', Endereco as 'Provider Address', CondPagamento as 'Provider PayConditions', ID_Fornecedor as 'Provider ID' FROM Game_Masters.Fornecedor WHERE Game_Masters.Fornecedor.ID_Fornecedor = @ID);

GO
/****** Object:  Table [Game_Masters].[Jogo]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Jogo](
	[NomeJogo] [varchar](50) NOT NULL,
	[Categoria] [varchar](50) NOT NULL,
	[Fornecedor] [varchar](50) NOT NULL,
	[Preço] [int] NULL,
	[numRegisto] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[numRegisto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getGame_Name]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getGame_Name](@Nome VARCHAR(50))
RETURNS TABLE
AS
	RETURN (SELECT * FROM Game_Masters.Jogo WHERE NomeJogo like '%' + @Nome + '%');

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getGame_Register]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getGame_Register](@numRegisto int)
RETURNS TABLE
AS
	RETURN (SELECT * FROM Game_Masters.Jogo WHERE Game_Masters.Jogo.numRegisto = @numRegisto);

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getGame_Review]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getGame_Review](@Jogo int)
RETURNS TABLE
AS
	RETURN (SELECT Game_Masters.Reviews.Nome, Game_Masters.Reviews.Content, Game_Masters.Reviews.user_email FROM Game_Masters.Reviews Where Game_Masters.Reviews.gameID = @Jogo);

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getGame_Preço]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getGame_Preço](@Preço int)
RETURNS TABLE
AS
	RETURN (SELECT * FROM Game_Masters.Jogo WHERE Game_Masters.Jogo.Preço = @Preço);

GO
/****** Object:  Table [Game_Masters].[Comprar]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Comprar](
	[ID_Conta] [int] NOT NULL,
	[numJogo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Conta] ASC,
	[numJogo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[udf_showPurchase]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_showPurchase]()
RETURNS TABLE
AS
	RETURN (SELECT ID_Conta as 'Account ID', NomeJogo as 'Game', numJogo as 'Game Register Number' FROM Game_Masters.Comprar INNER JOIN Game_Masters.Jogo ON Game_Masters.Comprar.numJogo = Game_Masters.Jogo.numRegisto);

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getPurchase_ID]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getPurchase_ID](@ID int)
RETURNS TABLE
AS
	RETURN (SELECT * FROM Game_Masters.Comprar WHERE Game_Masters.Comprar.ID_Conta = @ID);

GO
/****** Object:  Table [Game_Masters].[Junta_se]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Junta_se](
	[ID_Conta] [int] NOT NULL,
	[ID_Comunidade] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Conta] ASC,
	[ID_Comunidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[udf_showJoin]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_showJoin]()
RETURNS TABLE
AS
	RETURN (SELECT ID_Conta AS 'Account ID', ID_Comunidade AS 'Community ID', Nome AS 'Community Name' FROM Game_Masters.Comunidade JOIN Game_Masters.Junta_se ON Game_Masters.Comunidade.ID = Game_Masters.Junta_se.ID_Comunidade);

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getJoin_ID]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getJoin_ID](@ID int)
RETURNS TABLE
AS
	RETURN (SELECT ID_Conta AS 'Account ID', ID_Comunidade AS 'Community ID', Nome AS 'Community Name' FROM Game_Masters.Comunidade JOIN Game_Masters.Junta_se ON Game_Masters.Comunidade.ID = Game_Masters.Junta_se.ID_Comunidade WHERE Game_Masters.Junta_se.ID_Conta = @ID);

GO
/****** Object:  UserDefinedFunction [dbo].[udf_getJoin_Name]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_getJoin_Name](@Nome VARCHAR(50))
RETURNS TABLE
AS
	RETURN (SELECT ID_Conta AS 'Account ID', ID_Comunidade AS 'Community ID', Nome AS 'Community Name' FROM Game_Masters.Comunidade JOIN Game_Masters.Junta_se ON Game_Masters.Comunidade.ID = Game_Masters.Junta_se.ID_Comunidade WHERE Game_Masters.Comunidade.Nome = @Nome);

GO
/****** Object:  Table [Game_Masters].[Pesquisa]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Pesquisa](
	[ID_Loja] [int] NOT NULL,
	[Nome_Pesquisa] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Loja] ASC,
	[Nome_Pesquisa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[show_Search]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[show_Search]()
RETURNS TABLE
AS
	RETURN(SELECT Game_Masters.Pesquisa.ID_Loja as 'User ID', Game_Masters.Pesquisa.Nome_Pesquisa as 'Search Name' FROM Game_Masters.Pesquisa)

GO
/****** Object:  UserDefinedFunction [dbo].[show_Search_ID]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[show_Search_ID](@ID INT)
RETURNS TABLE
AS
	RETURN(SELECT Game_Masters.Pesquisa.ID_Loja as 'User ID', Game_Masters.Pesquisa.Nome_Pesquisa as 'Search Name' FROM Game_Masters.Pesquisa WHERE Game_Masters.Pesquisa.ID_Loja = @ID)

GO
/****** Object:  UserDefinedFunction [dbo].[show_Search_Name]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[show_Search_Name](@nome VARCHAR(50))
RETURNS TABLE
AS
	RETURN(SELECT Game_Masters.Pesquisa.ID_Loja as 'User ID', Game_Masters.Pesquisa.Nome_Pesquisa as 'Search Name' FROM Game_Masters.Pesquisa WHERE Game_Masters.Pesquisa.Nome_Pesquisa = @nome)

GO
/****** Object:  Table [Game_Masters].[Biblioteca]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Biblioteca](
	[ownerID] [int] NOT NULL,
	[numJogo] [int] NOT NULL,
	[game_status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ownerID] ASC,
	[numJogo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[udf_show_games]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[udf_show_games](@ID int)
RETURNS TABLE
AS
	RETURN (SELECT Game_Masters.Jogo.NomeJogo AS 'Nome', Game_Masters.Jogo.Categoria, Game_Masters.Jogo.Fornecedor, Game_Masters.Biblioteca.game_status as 'Instalado' FROM Game_Masters.Biblioteca INNER JOIN Game_Masters.Jogo ON Game_Masters.Biblioteca.numJogo = Game_Masters.Jogo.numRegisto WHERE Game_Masters.Biblioteca.ownerID=@ID);

GO
/****** Object:  UserDefinedFunction [dbo].[get_user_community]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[get_user_community](@id varchar(50))
RETURNS Table
AS
	Return(
    SELECT Game_Masters.Conta.NickName as 'Username', Game_Masters.Conta.Email as 'Email' 
	FROM (Game_Masters.Junta_se INNER JOIN Game_Masters.Comunidade ON Game_Masters.Junta_se.ID_Comunidade = Game_Masters.Comunidade.ID) INNER JOIN Game_Masters.Conta ON Game_Masters.Conta.ID = Game_Masters.Junta_se.ID_Conta
    WHERE Game_Masters.Comunidade.ownerID = @id
    )

GO
/****** Object:  UserDefinedFunction [dbo].[searchUsers]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[searchUsers](@nome varchar(50))
RETURNS Table
AS
	Return(
    SELECT Game_Masters.Conta.NickName as 'Username', Game_Masters.Conta.Email as 'Email', Game_Masters.Conta.ID 
	FROM Game_Masters.Conta
	WHERE Game_Masters.Conta.NickName LIKE '%' + @nome + '%' OR Game_Masters.Conta.Email LIKE '%' + @nome + '%'
    )

GO
/****** Object:  UserDefinedFunction [dbo].[get_loginInfo]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[get_loginInfo](@username varchar(50), @pass varchar(50))
RETURNS Table
AS
	Return(
    SELECT Game_Masters.Utilizador.Nome, Game_Masters.Conta.Email, Game_Masters.Conta.ID, Game_Masters.Conta.PayMethod 
	FROM Game_Masters.Conta INNER JOIN Game_Masters.Utilizador ON Game_Masters.Conta.Email = Game_Masters.Utilizador.Email
    WHERE Game_Masters.Conta.NickName = @username AND Game_Masters.Conta.pass = @pass
    )

GO
/****** Object:  UserDefinedFunction [dbo].[do_search]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[do_search](@nome varchar(50))
RETURNS Table
AS
	Return(
    SELECT Game_Masters.Jogo.NomeJogo as 'Name', Game_Masters.Jogo.Categoria as 'Category', Game_Masters.Jogo.Fornecedor as 'Shop', Game_Masters.Jogo.Preço as 'Price', Game_Masters.Jogo.numRegisto as 'GameID' 
	FROM Game_Masters.Jogo
    WHERE Game_Masters.Jogo.NomeJogo LIKE '%'+ @nome +'%' OR Game_Masters.Jogo.Fornecedor LIKE '%' + @nome + '%' OR Game_Masters.Jogo.Categoria LIKE '%' + @nome + '%'
    )

GO
/****** Object:  Table [Game_Masters].[Categoria]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Categoria](
	[Nome] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Game_Masters].[Jogar]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Jogar](
	[ID_Biblioteca] [int] NOT NULL,
	[ID_Comunidade] [int] NOT NULL,
	[jogo] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Biblioteca] ASC,
	[ID_Comunidade] ASC,
	[jogo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Game_Masters].[Pessoa]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Pessoa](
	[Nome] [varchar](50) NOT NULL,
	[dNascimento] [date] NULL,
	[Endereço] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [Game_Masters].[Tipo_Fornecedor]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Game_Masters].[Tipo_Fornecedor](
	[ID] [int] NOT NULL,
	[Descricao] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [Game_Masters].[Biblioteca] ([ownerID], [numJogo], [game_status]) VALUES (1, 1, 1)
INSERT [Game_Masters].[Biblioteca] ([ownerID], [numJogo], [game_status]) VALUES (1, 2, 0)
INSERT [Game_Masters].[Biblioteca] ([ownerID], [numJogo], [game_status]) VALUES (2, 2, 1)
INSERT [Game_Masters].[Biblioteca] ([ownerID], [numJogo], [game_status]) VALUES (2, 3, 0)
INSERT [Game_Masters].[Biblioteca] ([ownerID], [numJogo], [game_status]) VALUES (4, 1, 0)
INSERT [Game_Masters].[Biblioteca] ([ownerID], [numJogo], [game_status]) VALUES (4, 2, 0)
INSERT [Game_Masters].[Biblioteca] ([ownerID], [numJogo], [game_status]) VALUES (4, 3, 0)
SET IDENTITY_INSERT [Game_Masters].[Comunidade] ON 

INSERT [Game_Masters].[Comunidade] ([ID], [ownerID], [Nome], [Estado], [Amigos]) VALUES (3, 1, N'Amigos', N'Hello', N'')
INSERT [Game_Masters].[Comunidade] ([ID], [ownerID], [Nome], [Estado], [Amigos]) VALUES (4, 2, N'My friends', N'Hello', N'')
INSERT [Game_Masters].[Comunidade] ([ID], [ownerID], [Nome], [Estado], [Amigos]) VALUES (5, 4, N'Friends', N'', N'')
SET IDENTITY_INSERT [Game_Masters].[Comunidade] OFF
SET IDENTITY_INSERT [Game_Masters].[Conta] ON 

INSERT [Game_Masters].[Conta] ([NickName], [ID], [Email], [PayMethod], [Ranking], [pass], [Is_Disabled]) VALUES (N'jjoa', 1, N'teste@ua.pt', NULL, NULL, N'123456', 0)
INSERT [Game_Masters].[Conta] ([NickName], [ID], [Email], [PayMethod], [Ranking], [pass], [Is_Disabled]) VALUES (N'an', 2, N'ola@ua.pt', N'paypal', NULL, N'123456', 0)
INSERT [Game_Masters].[Conta] ([NickName], [ID], [Email], [PayMethod], [Ranking], [pass], [Is_Disabled]) VALUES (N'teste', 3, N'test@ua.pt', NULL, NULL, N'123456', 0)
INSERT [Game_Masters].[Conta] ([NickName], [ID], [Email], [PayMethod], [Ranking], [pass], [Is_Disabled]) VALUES (N'gonccalo', 4, N'bd@ua.pt', N'paypal', NULL, N'123456', 0)
SET IDENTITY_INSERT [Game_Masters].[Conta] OFF
INSERT [Game_Masters].[Fornecedor] ([Nome], [NIF], [FAX], [Endereco], [CondPagamento], [ID_Fornecedor]) VALUES (N'Company name', 22222, 1231289, N'PT', N'M', 1)
INSERT [Game_Masters].[Fornecedor] ([Nome], [NIF], [FAX], [Endereco], [CondPagamento], [ID_Fornecedor]) VALUES (N'Valve', 11111, 123456789, N'US', N'P', 1)
INSERT [Game_Masters].[Jogo] ([NomeJogo], [Categoria], [Fornecedor], [Preço], [numRegisto]) VALUES (N'CS-GO', N'FPS', N'Valve', 9, 1)
INSERT [Game_Masters].[Jogo] ([NomeJogo], [Categoria], [Fornecedor], [Preço], [numRegisto]) VALUES (N'HALF-LIFE', N'ADV', N'Valve', 5, 2)
INSERT [Game_Masters].[Jogo] ([NomeJogo], [Categoria], [Fornecedor], [Preço], [numRegisto]) VALUES (N'generic game name', N'ETC', N'Company name', 25, 3)
INSERT [Game_Masters].[Junta_se] ([ID_Conta], [ID_Comunidade]) VALUES (1, 4)
INSERT [Game_Masters].[Junta_se] ([ID_Conta], [ID_Comunidade]) VALUES (1, 5)
INSERT [Game_Masters].[Junta_se] ([ID_Conta], [ID_Comunidade]) VALUES (2, 3)
INSERT [Game_Masters].[Junta_se] ([ID_Conta], [ID_Comunidade]) VALUES (2, 5)
INSERT [Game_Masters].[Junta_se] ([ID_Conta], [ID_Comunidade]) VALUES (3, 4)
INSERT [Game_Masters].[Junta_se] ([ID_Conta], [ID_Comunidade]) VALUES (3, 5)
INSERT [Game_Masters].[Pessoa] ([Nome], [dNascimento], [Endereço]) VALUES (N'Andre', CAST(N'1990-07-01' AS Date), N'Rua')
INSERT [Game_Masters].[Pessoa] ([Nome], [dNascimento], [Endereço]) VALUES (N'gonçalo', CAST(N'1995-07-01' AS Date), N'asldkj')
INSERT [Game_Masters].[Pessoa] ([Nome], [dNascimento], [Endereço]) VALUES (N'Joao', CAST(N'1995-09-21' AS Date), N'Aveiro')
INSERT [Game_Masters].[Pessoa] ([Nome], [dNascimento], [Endereço]) VALUES (N'Teste', CAST(N'1990-06-01' AS Date), N'Rua ...')
INSERT [Game_Masters].[Tipo_Fornecedor] ([ID], [Descricao]) VALUES (1, N'Editora')
INSERT [Game_Masters].[Tipo_Utilizador] ([ID], [Descricao], [Is_Admin]) VALUES (0, N'MAIN ADMIN', 1)
INSERT [Game_Masters].[Tipo_Utilizador] ([ID], [Descricao], [Is_Admin]) VALUES (1, N'Normal User', 0)
INSERT [Game_Masters].[Utilizador] ([Nome], [typeID], [Is_Banned], [Email]) VALUES (N'gonçalo', 1, 0, N'bd@ua.pt')
INSERT [Game_Masters].[Utilizador] ([Nome], [typeID], [Is_Banned], [Email]) VALUES (N'Andre', 1, 0, N'ola@ua.pt')
INSERT [Game_Masters].[Utilizador] ([Nome], [typeID], [Is_Banned], [Email]) VALUES (N'Teste', 1, 0, N'test@ua.pt')
INSERT [Game_Masters].[Utilizador] ([Nome], [typeID], [Is_Banned], [Email]) VALUES (N'Joao', 1, 0, N'teste@ua.pt')
/****** Object:  Index [UQ__Conta__3214EC264B9D7793]    Script Date: 09-06-2017 18:47:55 ******/
ALTER TABLE [Game_Masters].[Conta] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_account_name]    Script Date: 09-06-2017 18:47:55 ******/
CREATE NONCLUSTERED INDEX [index_account_name] ON [Game_Masters].[Conta]
(
	[NickName] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_provider_address]    Script Date: 09-06-2017 18:47:55 ******/
CREATE NONCLUSTERED INDEX [index_provider_address] ON [Game_Masters].[Fornecedor]
(
	[Endereco] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Jogo__6E81168AA8E9C156]    Script Date: 09-06-2017 18:47:55 ******/
ALTER TABLE [Game_Masters].[Jogo] ADD UNIQUE NONCLUSTERED 
(
	[numRegisto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_game_category]    Script Date: 09-06-2017 18:47:55 ******/
CREATE NONCLUSTERED INDEX [index_game_category] ON [Game_Masters].[Jogo]
(
	[Categoria] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_game_name]    Script Date: 09-06-2017 18:47:55 ******/
CREATE NONCLUSTERED INDEX [index_game_name] ON [Game_Masters].[Jogo]
(
	[NomeJogo] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_game_provider]    Script Date: 09-06-2017 18:47:55 ******/
CREATE NONCLUSTERED INDEX [index_game_provider] ON [Game_Masters].[Jogo]
(
	[Fornecedor] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
/****** Object:  Index [index_game_register]    Script Date: 09-06-2017 18:47:55 ******/
CREATE NONCLUSTERED INDEX [index_game_register] ON [Game_Masters].[Jogo]
(
	[numRegisto] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Loja__3214EC265E4C2A35]    Script Date: 09-06-2017 18:47:55 ******/
ALTER TABLE [Game_Masters].[Loja] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Reviews__3214EC263D057D43]    Script Date: 09-06-2017 18:47:55 ******/
ALTER TABLE [Game_Masters].[Reviews] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Tipo_Uti__3214EC26F57D6C64]    Script Date: 09-06-2017 18:47:55 ******/
ALTER TABLE [Game_Masters].[Tipo_Utilizador] ADD UNIQUE NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [index_user_name]    Script Date: 09-06-2017 18:47:55 ******/
CREATE NONCLUSTERED INDEX [index_user_name] ON [Game_Masters].[Utilizador]
(
	[Nome] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
ALTER TABLE [Game_Masters].[Conta] ADD  DEFAULT ('0') FOR [Is_Disabled]
GO
ALTER TABLE [Game_Masters].[Tipo_Utilizador] ADD  DEFAULT ('0') FOR [Is_Admin]
GO
ALTER TABLE [Game_Masters].[Utilizador] ADD  DEFAULT ('0') FOR [Is_Banned]
GO
ALTER TABLE [Game_Masters].[Biblioteca]  WITH CHECK ADD  CONSTRAINT [GAME_LIBRARY] FOREIGN KEY([numJogo])
REFERENCES [Game_Masters].[Jogo] ([numRegisto])
GO
ALTER TABLE [Game_Masters].[Biblioteca] CHECK CONSTRAINT [GAME_LIBRARY]
GO
ALTER TABLE [Game_Masters].[Biblioteca]  WITH CHECK ADD  CONSTRAINT [ID_LIBRARY] FOREIGN KEY([ownerID])
REFERENCES [Game_Masters].[Conta] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Biblioteca] CHECK CONSTRAINT [ID_LIBRARY]
GO
ALTER TABLE [Game_Masters].[Comprar]  WITH CHECK ADD  CONSTRAINT [GAME_PURCHASE] FOREIGN KEY([numJogo])
REFERENCES [Game_Masters].[Jogo] ([numRegisto])
GO
ALTER TABLE [Game_Masters].[Comprar] CHECK CONSTRAINT [GAME_PURCHASE]
GO
ALTER TABLE [Game_Masters].[Comprar]  WITH CHECK ADD  CONSTRAINT [ID_PURCHASE] FOREIGN KEY([ID_Conta])
REFERENCES [Game_Masters].[Conta] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Comprar] CHECK CONSTRAINT [ID_PURCHASE]
GO
ALTER TABLE [Game_Masters].[Comunidade]  WITH CHECK ADD  CONSTRAINT [ID_COMMUNITY] FOREIGN KEY([ownerID])
REFERENCES [Game_Masters].[Conta] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Comunidade] CHECK CONSTRAINT [ID_COMMUNITY]
GO
ALTER TABLE [Game_Masters].[Conta]  WITH CHECK ADD  CONSTRAINT [ID_ACCOUNT] FOREIGN KEY([Email])
REFERENCES [Game_Masters].[Utilizador] ([Email])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Conta] CHECK CONSTRAINT [ID_ACCOUNT]
GO
ALTER TABLE [Game_Masters].[Fornecedor]  WITH CHECK ADD  CONSTRAINT [ID_PROVIDER] FOREIGN KEY([ID_Fornecedor])
REFERENCES [Game_Masters].[Tipo_Fornecedor] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Fornecedor] CHECK CONSTRAINT [ID_PROVIDER]
GO
ALTER TABLE [Game_Masters].[Jogar]  WITH CHECK ADD  CONSTRAINT [COMUNITY_GAMEPLAY] FOREIGN KEY([ID_Comunidade])
REFERENCES [Game_Masters].[Comunidade] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Jogar] CHECK CONSTRAINT [COMUNITY_GAMEPLAY]
GO
ALTER TABLE [Game_Masters].[Jogar]  WITH CHECK ADD  CONSTRAINT [LIBRARY_GAMEPLAY] FOREIGN KEY([ID_Biblioteca], [jogo])
REFERENCES [Game_Masters].[Biblioteca] ([ownerID], [numJogo])
GO
ALTER TABLE [Game_Masters].[Jogar] CHECK CONSTRAINT [LIBRARY_GAMEPLAY]
GO
ALTER TABLE [Game_Masters].[Jogo]  WITH CHECK ADD  CONSTRAINT [GAME_PROVIDER] FOREIGN KEY([Fornecedor])
REFERENCES [Game_Masters].[Fornecedor] ([Nome])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Jogo] CHECK CONSTRAINT [GAME_PROVIDER]
GO
ALTER TABLE [Game_Masters].[Junta_se]  WITH CHECK ADD  CONSTRAINT [JOIN_COMUNITY] FOREIGN KEY([ID_Comunidade])
REFERENCES [Game_Masters].[Comunidade] ([ID])
GO
ALTER TABLE [Game_Masters].[Junta_se] CHECK CONSTRAINT [JOIN_COMUNITY]
GO
ALTER TABLE [Game_Masters].[Junta_se]  WITH CHECK ADD  CONSTRAINT [JOIN_ID] FOREIGN KEY([ID_Conta])
REFERENCES [Game_Masters].[Conta] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Junta_se] CHECK CONSTRAINT [JOIN_ID]
GO
ALTER TABLE [Game_Masters].[Loja]  WITH CHECK ADD  CONSTRAINT [ID_STORE] FOREIGN KEY([ownerID])
REFERENCES [Game_Masters].[Conta] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Loja] CHECK CONSTRAINT [ID_STORE]
GO
ALTER TABLE [Game_Masters].[Reviews]  WITH CHECK ADD  CONSTRAINT [ID_GAME_REV] FOREIGN KEY([gameID])
REFERENCES [Game_Masters].[Jogo] ([numRegisto])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Reviews] CHECK CONSTRAINT [ID_GAME_REV]
GO
ALTER TABLE [Game_Masters].[Reviews]  WITH CHECK ADD  CONSTRAINT [ID_REVIEW] FOREIGN KEY([user_email])
REFERENCES [Game_Masters].[Utilizador] ([Email])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Reviews] CHECK CONSTRAINT [ID_REVIEW]
GO
ALTER TABLE [Game_Masters].[Utilizador]  WITH CHECK ADD  CONSTRAINT [ID_USER] FOREIGN KEY([typeID])
REFERENCES [Game_Masters].[Tipo_Utilizador] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Utilizador] CHECK CONSTRAINT [ID_USER]
GO
ALTER TABLE [Game_Masters].[Utilizador]  WITH CHECK ADD  CONSTRAINT [NAME_USER] FOREIGN KEY([Nome])
REFERENCES [Game_Masters].[Pessoa] ([Nome])
ON DELETE CASCADE
GO
ALTER TABLE [Game_Masters].[Utilizador] CHECK CONSTRAINT [NAME_USER]
GO
ALTER TABLE [Game_Masters].[Jogar]  WITH CHECK ADD  CONSTRAINT [DISABLE_GAMEPLAY] CHECK  (([ID_Biblioteca]=(-1) OR [ID_Comunidade]=(-1)))
GO
ALTER TABLE [Game_Masters].[Jogar] CHECK CONSTRAINT [DISABLE_GAMEPLAY]
GO
ALTER TABLE [Game_Masters].[Loja]  WITH CHECK ADD  CONSTRAINT [DISABLED_STORE] CHECK  (([ID]=(-1)))
GO
ALTER TABLE [Game_Masters].[Loja] CHECK CONSTRAINT [DISABLED_STORE]
GO
/****** Object:  StoredProcedure [dbo].[delAllAccounts]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delAllAccounts]
AS
BEGIN
	DELETE FROM Game_Masters.Conta
END

GO
/****** Object:  StoredProcedure [dbo].[delAllCommunities]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delAllCommunities]
AS
BEGIN
	DELETE FROM Game_Masters.Comunidade
END

GO
/****** Object:  StoredProcedure [dbo].[delAllGames]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delAllGames]
AS
BEGIN
	DELETE FROM Game_Masters.Jogo
END

GO
/****** Object:  StoredProcedure [dbo].[delAllLibraries]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delAllLibraries]
AS
BEGIN
	DELETE FROM Game_Masters.Biblioteca
END

GO
/****** Object:  StoredProcedure [dbo].[delAllProviders]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delAllProviders]
AS
BEGIN
	DELETE FROM Game_Masters.Fornecedor
END

GO
/****** Object:  StoredProcedure [dbo].[delAllReviews]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delAllReviews]
AS
BEGIN
	DELETE FROM Game_Masters.Reviews
END

GO
/****** Object:  StoredProcedure [dbo].[delAllStores]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delAllStores]
AS
BEGIN
	DELETE FROM Game_Masters.Loja
END

GO
/****** Object:  StoredProcedure [dbo].[delAllUsers]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[delAllUsers]
AS
BEGIN
	DELETE FROM Game_Masters.Utilizador
END

GO
/****** Object:  StoredProcedure [dbo].[sp_banUser]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_banUser]
	@ID_user1 int
AS
	IF @ID_user1 IS NULL
	BEGIN
		PRINT 'The user ID cannot be null!'
		RETURN
	END

	DECLARE @count1 INT
	SELECT @count1 = COUNT(Email) FROM Game_Masters.Utilizador WHERE Game_Masters.Utilizador.Email = @ID_user1;
	
	IF @count1 = 0
	BEGIN
		RAISERROR ('The users do not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Utilizador SET
			Game_Masters.Utilizador.Is_Banned = '1'
		WHERE Game_Masters.Utilizador.Email = @ID_user1;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to ban the user!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createAccount]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createAccount]
	@NickName VARCHAR(50),
	@Email VARCHAR(50),
	@pass VARCHAR(50)
	AS
	DECLARE @count1 INT
	SELECT @count1 = COUNT(Email) FROM Game_Masters.Utilizador WHERE Game_Masters.Utilizador.Email = @Email;
	IF @count1 = 0
	BEGIN
		RAISERROR ('The user do not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Conta([NickName],[Email], [pass])
		VALUES (@NickName, @Email, @pass)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the account!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createAdmin]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createAdmin]
	@Nome VARCHAR(50),
	@Email VARCHAR(50)
	AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Utilizador ([Nome], [typeID], [Email])
		VALUES (@Nome, 0, @Email)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An Error has occured when creating the admin!', 16, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createCommunity]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createCommunity]
	@ownerID int,
	@Nome VARCHAR(50),
	@Estado VARCHAR(50),
	@Amigos VARCHAR(50)
AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Comunidade([ownerID], [Nome], [Estado], [Amigos])
		VALUES (@ownerID, @Nome, @Estado, @Amigos)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the community!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createGame]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createGame]
	@Nome VARCHAR(50),
	@Categoria VARCHAR(50),
	@Fornecedor VARCHAR(50),
	@Preço int,
	@numRegisto int
	AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Jogo ([NomeJogo], [Categoria], [Fornecedor], [Preço], [numRegisto])
		VALUES (@Nome, @Categoria, @Fornecedor, @Preço, @numRegisto)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the game!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createGameplay]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createGameplay]
	@ID_Biblioteca int,
	@ID_Comunidade int,
	@jogo int
AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Jogar([ID_Biblioteca], [ID_Comunidade], [jogo])
		VALUES (@ID_Biblioteca, @ID_Comunidade, @jogo)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the gameplay!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createJoins]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createJoins]
	@ID_Conta int,
	@ID_Comunidade int
AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Junta_se([ID_Conta], [ID_Comunidade])
		VALUES (@ID_Conta, @ID_Comunidade)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to create the join!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createLibrary]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createLibrary]
	@owner int,
	@numJogo int,
	@game_status BIT
AS
	DECLARE @count INT
	SELECT @count = COUNT(ID) FROM Game_Masters.Conta WHERE Game_Masters.Conta.ID = @owner;
	IF @count = 0
	BEGIN
		RAISERROR ('The user does not exist!', 14, 1)
		RETURN
	END
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Biblioteca([ownerID], [numJogo], [game_status])
		VALUES (@owner, @numJogo, @game_status)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the library!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createPerson]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createPerson]
	@Nome VARCHAR(50),
	@dNascimento Date,
	@Endereço VARCHAR(50)

	AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Pessoa([Nome], [dNascimento], [Endereço])
		VALUES (@Nome, @dNascimento, @Endereço)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the person!', 16, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createProvider]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createProvider]
	   @Nome VARCHAR(50),
	   @NIF int,
	   @FAX int,
	   @Endereco VARCHAR(50),
	   @CondPagamento VARCHAR(50),
	   @ID_Fornecedor int

AS
	DECLARE @count INT
	--checks if the provider type exists
	SELECT @count = COUNT(ID) FROM Game_Masters.Tipo_Fornecedor WHERE Game_Masters.Tipo_Fornecedor.ID = @ID_Fornecedor;
	IF @count = 0
	BEGIN
		RAISERROR ('The provider type does not exist!', 14, 1)
		RETURN
    END

	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Fornecedor([Nome], [NIF], [FAX], [Endereco], [CondPagamento], [ID_Fornecedor])
		VALUES (@Nome, @NIF, @FAX, @Endereco, @CondPagamento, @ID_Fornecedor)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the provider!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createProviderRole]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createProviderRole]
	  @ID int,
	  @Descricao VARCHAR(100)
AS
	  BEGIN TRANSACTION;
	  BEGIN TRY
		  INSERT INTO Game_Masters.Tipo_Fornecedor([ID], [Descricao])
		  VALUES (@ID, @Descricao)
		  COMMIT TRANSACTION;
	  END TRY
	  BEGIN CATCH
		  RAISERROR ('An error has occured when creating the provider role!', 14, 1)
		  ROLLBACK TRANSACTION;
	  END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createPurchase]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createPurchase]
	@ID_Conta int,
	@numJogo int
AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Comprar([ID_Conta], [numJogo])
		VALUES (@ID_Conta, @numJogo)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the purchase!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createReview]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createReview]
	@Nome VARCHAR(50),
	@user_email VARCHAR(50),
	@Content VARCHAR(500),
	@game int
AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Reviews([Nome], [Content], [user_email], [gameID])
		VALUES (@Nome, @Content, @user_email, @game)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the review!', 16, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createSearch]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createSearch]
	@ID_Loja int,
	@Nome_Pesquisa VARCHAR(50)
AS
	DECLARE @disabled BIT;
	SELECT @disabled = Game_Masters.Conta.Is_Disabled FROM Game_Masters.Conta WHERE Game_Masters.Conta.ID = @ID_Loja;
	IF @disabled = '1'
	BEGIN
		RAISERROR('The user account is disabled therefor you cannot create search!', 16, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Pesquisa([ID_Loja], [Nome_Pesquisa])
		VALUES(@ID_Loja, @Nome_Pesquisa)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to create the search!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createSearchGame]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createSearchGame]
	@ID_Loja int,
	@jogo VARCHAR(50)
AS
	IF @jogo IS NULL 
	BEGIN
		PRINT 'The name of the game for the search cannot be null!'
		RETURN
	END
	DECLARE @disabled BIT;
	SELECT @disabled = Game_Masters.Conta.Is_Disabled FROM Game_Masters.Conta WHERE Game_Masters.Conta.ID = @ID_Loja;

	IF @disabled = '1'
	BEGIN
		RAISERROR ('The user account is disabled therefore you cannot search for a game!', 16, 1)
		RETURN
	END


	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Pesquisa([ID_Loja], [Nome_Pesquisa])
		VALUES(@ID_Loja, @jogo)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to create a search for the game!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createStore]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createStore]
	@ownerID int
AS
	DECLARE @count INT
	   --checks if the provider exists
		SELECT @count = COUNT(ID) FROM Game_Masters.Conta WHERE Game_Masters.Conta.ID = @ownerID;

	   IF @count = 0
	   BEGIN
			RAISERROR ('The provider does not exist!', 14, 1)
			RETURN
	   END
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Loja([ownerID])
		VALUES (@ownerId)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the store!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createUser]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createUser]
	@Nome VARCHAR(50),
	@Email VARCHAR(50)
	AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Utilizador ([Nome], [typeID], [Email])
		VALUES (@Nome, 1, @Email)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An Error has occured when creating the user!', 16, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_createUserRole]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_createUserRole]
	@ID int,
	@Descricao VARCHAR(100),
	@Is_Admin BIT
	AS
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO Game_Masters.Tipo_Utilizador ([ID], [Descricao], [Is_Admin])
		VALUES (@ID, @Descricao, @Is_Admin)
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when creating the user role!', 16, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_disableAccount]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_disableAccount]
	@ID_user1 int
AS
	IF @ID_user1 IS NULL
	BEGIN
		PRINT 'The account ID cannot be null!'
		RETURN
	END

	DECLARE @count1 INT
	SELECT @count1 = COUNT(ID) FROM Game_Masters.Conta WHERE Game_Masters.Conta.ID = @ID_user1;
		
	IF @count1 = 0
	BEGIN
		RAISERROR ('The account introduced do not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Conta SET
			Game_Masters.Conta.Is_Disabled = '1'
		WHERE Game_Masters.Conta.ID = @ID_user1;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to disable the account!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_disbanUser]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_disbanUser]
	@ID_user1 int
AS
	IF @ID_user1 IS NULL
	BEGIN
		PRINT 'The user email cannot be null!'
		RETURN
	END

	DECLARE @count1 INT
	SELECT @count1 = COUNT(Email) FROM Game_Masters.Utilizador WHERE Game_Masters.Utilizador.Email = @ID_user1;

	IF @count1 = 0
	BEGIN
		RAISERROR ('The users do not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Utilizador SET
			Game_Masters.Utilizador.Is_Banned = '0'
		WHERE Game_Masters.Utilizador.Email = @ID_user1;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to disban the user!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_enableAccount]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_enableAccount]
	@ID_user1 int
AS
	IF @ID_user1 IS NULL
	BEGIN
		PRINT ' The account ID cannot be null!'
		RETURN
	END

	DECLARE @count1 INT
	SELECT @count1 = COUNT(ID) FROM Game_Masters.Conta WHERE Game_Masters.Conta.ID = @ID_user1;

	IF @count1 = 0
	BEGIN
		RAISERROR ('The account do not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Conta SET
			Game_Masters.Conta.Is_Disabled = '0'
		WHERE Game_Masters.Conta.ID = @ID_user1;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to enable the user account!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeAccount]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeAccount]
	@ID int
AS
	IF @ID IS NULL
	BEGIN 
		PRINT 'The ID of the account cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Conta WHERE ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to delete the account!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeCommunity]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeCommunity]
	@ID int
AS
	IF @ID IS NULL
	BEGIN 
		PRINT 'The community ID cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Comunidade WHERE Game_Masters.Comunidade.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove the user community!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeGame]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeGame]
	@numRegisto INT
AS
	IF @numRegisto IS NULL
	BEGIN
		PRINT 'The Name and numRegisto of the game cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Jogo WHERE Game_Masters.Jogo.numRegisto = @numRegisto;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to delete the game!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeGameplay]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeGameplay]
	@ID_Biblioteca int,
	@ID_Comunidade int,
	@jogo int
AS
	IF @ID_Biblioteca IS NULL OR @ID_Comunidade IS NULL OR @jogo IS NULL
	BEGIN
		PRINT 'The gameplay parameters cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Jogar WHERE Game_Masters.Jogar.ID_Biblioteca = @ID_Biblioteca AND Game_Masters.Jogar.ID_Comunidade = @ID_Comunidade AND Game_Masters.Jogar.jogo = @jogo;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove the gameplay!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeJoins]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeJoins]
	@ID_Conta int,
	@ID_Comunidade int
AS
	IF @ID_Conta IS NULL OR @ID_Comunidade IS NULL
	BEGIN 
		PRINT 'The join parameters cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Junta_se WHERE Game_Masters.Junta_se.ID_Conta = @ID_Conta AND Game_Masters.Junta_se.ID_Comunidade = @ID_Comunidade;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove the join!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeLibrary]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeLibrary]
	@owner int,
	@jogo int
AS
	IF @owner IS NULL
	BEGIN 
		PRINT 'The library ID cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Biblioteca WHERE Game_Masters.Biblioteca.ownerID = @owner AND Game_Masters.Biblioteca.numJogo = @jogo;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove the user library!', 14, 1);
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removePerson]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removePerson]
	@Nome VARCHAR(50)
AS
	IF @Nome IS NULL
	BEGIN
		PRINT 'The name of the person cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Pessoa WHERE Game_Masters.Pessoa.Nome = @Nome
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to delete the person!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeProvider]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeProvider]
	@Nome VARCHAR(50)
AS
	IF @Nome IS NULL
	BEGIN
		PRINT 'The Name and the ID of the provider cannot be null!'
		RETURN
	END
	DECLARE @count INT
	--checks if the provider exists
	SELECT @count = COUNT(Nome) FROM Game_Masters.Fornecedor WHERE Game_Masters.Fornecedor.Nome = @Nome;
	IF @count = 0
	BEGIN
		RAISERROR ('The provider does not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Fornecedor WHERE Game_Masters.Fornecedor.Nome = @Nome;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove the provider!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeProviderRole]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeProviderRole]
	@ID int
AS
	IF @ID IS NULL
	BEGIN
		PRINT 'The ID of the provider role cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Tipo_Fornecedor WHERE Game_Masters.Tipo_Fornecedor.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove the provider role!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removePurchase]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removePurchase]
	   @ID_Conta int,
	   @numJogo int
AS
	IF @ID_Conta IS NULL OR @numJogo IS NULL
	BEGIN
		PRINT 'The purchase parameters cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Comprar WHERE Game_Masters.Comprar.ID_Conta = @ID_Conta AND Game_Masters.Comprar.numJogo = @numJogo;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove the purchase!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeReview]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeReview]
	@ID int
AS
	IF @ID IS NULL
	BEGIN 
		PRINT 'The the id of the review cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Reviews WHERE Game_Masters.Reviews.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove the review!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeSearch]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeSearch]
	@ID_Loja int,
	@Nome_Pesquisa VARCHAR(50)
AS
	IF @ID_Loja IS NULL OR @Nome_Pesquisa IS NULL
	BEGIN
		PRINT 'The search parameters cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Pesquisa WHERE Game_Masters.Pesquisa.ID_Loja = @ID_Loja AND Game_Masters.Pesquisa.Nome_Pesquisa = @Nome_Pesquisa;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove search!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeStore]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeStore]
	@ID int
AS
	IF @ID IS NULL
	BEGIN
		PRINT 'The store ID cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Loja WHERE Game_Masters.Loja.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to remove the user store!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeUser]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeUser]
	@Email VARCHAR(50)
AS
	IF @Email IS NULL
	BEGIN
		PRINT 'The Email of the user cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Utilizador WHERE Game_Masters.Utilizador.Email = @Email;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to delete the user!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_removeUserRole]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_removeUserRole]
	@ID int
AS
	IF @ID IS NULL
	BEGIN
		PRINT 'The id of the user role cannot be null!'
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		DELETE FROM Game_Masters.Tipo_Utilizador WHERE Game_Masters.Tipo_Utilizador.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to delete the user role!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateAccount]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateAccount]
	@NickName VARCHAR(50),
	@ID int,
	@Email VARCHAR(50),
	@PayMethod VARCHAR(50),
	@pass VARCHAR(50)
AS
	IF @ID IS NULL
	BEGIN
		PRINT 'The account ID cannot be null!'
		RETURN
	END

	DECLARE @count INT

	--check if the Account ID exists
	SELECT @count = COUNT(ID) FROM Game_Masters.Conta WHERE Game_Masters.Conta.ID = @ID;

	IF @count = 0
	BEGIN
		RAISERROR ('The ID that you provided does not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Conta SET
			NickName = @NickName,
			Email = @Email,
			PayMethod = @PayMethod,
			pass = @pass
		WHERE Game_Masters.Conta.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to update the account!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateCommunity]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateCommunity]
	@ID int,
	@Nome VARCHAR(50),
	@Estado VARCHAR(50),
	@Amigos VARCHAR(50)
AS
	IF @ID IS NULL
	BEGIN
		PRINT 'The community ID cannot be null!'
		RETURN
	END

	DECLARE @count INT
	--check if the ID exists
	SELECT @count = COUNT(ID) FROM Game_Masters.Comunidade WHERE Game_Masters.Comunidade.ID = @ID;

	IF @count = 0
	BEGIN
		RAISERROR ('The community ID that you provided does not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Comunidade SET
			Nome = @Nome,
			Estado = @Estado,
			Amigos = @Amigos
		WHERE Game_Masters.Comunidade.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to update the user community!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateGame]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateGame]
	@Nome VARCHAR(50),
	@Categoria VARCHAR(50),
	@Fornecedor VARCHAR(50),
	@Preço int,
	@numRegisto int
AS
	IF @numRegisto IS NULL
	BEGIN
		PRINT 'The name and register number cannot be null!'
		RETURN
	END

	
	DECLARE @count2 INT
	SELECT @count2 = COUNT(numRegisto) FROM Game_Masters.Jogo WHERE Game_Masters.Jogo.numRegisto = @numRegisto;

	IF @count2 = 0
	BEGIN
		RAISERROR ('The name of the game or the register number does not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Jogo SET
			NomeJogo = @Nome,
			Categoria = @Categoria,
			Fornecedor = @Fornecedor,
			Preço = @Preço,
			numRegisto = @numRegisto
		WHERE Game_Masters.Jogo.numRegisto = @numRegisto;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to update the game!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateLibrary]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateLibrary]
	@owner int,
	@numjogo int,
	@game_status BIT
AS
	IF @owner IS NULL OR @numjogo IS NULL
	BEGIN
		PRINT 'The library ID cannot be null!'
		RETURN
	END

	DECLARE @count1 INT
	--check if the library exists
	SELECT @count1 = COUNT(ownerID) FROM Game_Masters.Biblioteca WHERE Game_Masters.Biblioteca.ownerID = @owner AND Game_Masters.Biblioteca.numJogo = @numjogo;
	
	IF @count1 = 0
	BEGIN
		RAISERROR ('The library that you provided does not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Biblioteca SET
			game_status = @game_status
		WHERE Game_Masters.Biblioteca.ownerID = @owner AND Game_Masters.Biblioteca.numJogo = @numjogo;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to update the user library!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updatePerson]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updatePerson]
	@Nome VARCHAR(50),
	@dNascimento Date,
	@Endereço VARCHAR(50)
AS
	IF @Nome IS NULL
	BEGIN
		PRINT 'The name of the person cannot be null!'
		RETURN
	END

	DECLARE @count INT

	--check if the Person exists
	SELECT @count = COUNT(Nome) FROM Game_Masters.Pessoa WHERE Game_Masters.Pessoa.Nome = @Nome;

	IF @count = 0
	BEGIN
		RAISERROR ('The name of the person that you provided does not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Pessoa SET
			Game_Masters.Pessoa.Nome = @Nome,
			Game_Masters.Pessoa.dNascimento = @dNascimento,
			Game_Masters.Pessoa.Endereço = @Endereço
		WHERE Game_Masters.Pessoa.Nome = @Nome;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to update the person!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateProvider]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateProvider]
	   @Nome VARCHAR(50),
	   @NIF int,
	   @FAX int,
	   @Endereco VARCHAR(50),
	   @CondPagamento VARCHAR(50),
	   @ID_Fornecedor int
AS
	   IF @Nome IS NULL
	   BEGIN
			PRINT 'The name of the provider cannot be null!'
			RETURN
	   END

	   DECLARE @count INT
	   --checks if the provider exists
		SELECT @count = COUNT(Nome) FROM Game_Masters.Fornecedor WHERE Game_Masters.Fornecedor.Nome = @Nome;

	   IF @count = 0
	   BEGIN
			RAISERROR ('The provider does not exist!', 14, 1)
			RETURN
	   END

	   BEGIN TRANSACTION;
	   BEGIN TRY
			UPDATE Game_Masters.Fornecedor SET
					NIF = @NIF,
					FAX = @FAX,
					Endereco = @Endereco,
					CondPagamento = @CondPagamento,
					ID_Fornecedor = @ID_Fornecedor
			WHERE Game_Masters.Fornecedor.Nome = @Nome
	   END TRY
	   BEGIN CATCH
			RAISERROR ('An error has occured when trying to update the provider!', 14, 1)
			ROLLBACK TRANSACTION;
	   END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateProviderRole]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateProviderRole]
	  @ID int,
	  @Descricao VARCHAR(100)
AS
	   IF @ID IS NULL
	   BEGIN
			PRINT 'The ID of the provider role cannot be null!'
			RETURN
	   END

	   DECLARE @count INT
	   --checks if the provider exists
		SELECT @count = COUNT(ID) FROM Game_Masters.Tipo_Fornecedor WHERE Game_Masters.Tipo_Fornecedor.ID = @ID;

	   IF @count = 0
	   BEGIN
			RAISERROR ('The provider role does not exist!', 14, 1)
			RETURN
	   END

	   BEGIN TRANSACTION;
	   BEGIN TRY
			UPDATE Game_Masters.Tipo_Fornecedor SET
					Game_Masters.Tipo_Fornecedor.Descricao = @Descricao
			WHERE Game_Masters.Tipo_Fornecedor.ID = @ID;
			COMMIT TRANSACTION;
	   END TRY
	   BEGIN CATCH
			RAISERROR ('An error has occured when trying to update the provider role!', 14, 1)
			ROLLBACK TRANSACTION;
	   END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateReviews]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateReviews]
	@Nome VARCHAR(50),
	@content VARCHAR(500),
	@ID int
AS
	IF @ID IS NULL
	BEGIN
		PRINT 'The review ID cannot be null!'
		RETURN
	END

	DECLARE @count2 INT
	SELECT @count2 = COUNT(ID) FROM Game_Masters.Reviews WHERE Game_Masters.Reviews.ID = @ID;

	IF @count2 = 0
	BEGIN
		RAISERROR ('The review ID provided does not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Reviews SET
			Nome = @Nome,
			Content = @content
		WHERE Game_Masters.Reviews.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to update the reviews!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateStore]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateStore]
	@ID int,
	@wishlist VARCHAR(50),
	@Promocoes VARCHAR(50)
AS
	IF @ID IS NULL
	BEGIN
		PRINT 'The store id cannot be null!'
		RETURN
	END

	DECLARE @count INT
	--checks if the ID exists
	SELECT @count = COUNT(ID) FROM Game_Masters.Loja WHERE Game_Masters.Loja.ID = @ID;

	IF @count = 0
	BEGIN
		RAISERROR ('The store ID that you provided does not exist!', 14, 1)
		RETURN
	END
	
	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Loja SET
			wishlist = @wishlist,
			Promocoes = @Promocoes
		WHERE Game_Masters.Loja.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to update the user store!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateUser]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateUser]
	@Nome VARCHAR(50),
	@Email VARCHAR(50)
AS
	IF @Email IS NULL
	BEGIN
		PRINT 'The email cannot be null!'
		RETURN
	END

	DECLARE @count INT

	--check if the ID exists
	SELECT @count = COUNT(Email) FROM Game_Masters.Utilizador WHERE Game_Masters.Utilizador.Email = @Email;

	IF @count = 0
	BEGIN
		RAISERROR ('The email that you provided does not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Utilizador SET
			Game_Masters.Utilizador.Nome = @Nome,
			Game_Masters.Utilizador.Email = @Email
		WHERE Game_Masters.Utilizador.Email = @Email;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to update the user!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  StoredProcedure [dbo].[sp_updateUserRole]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_updateUserRole]
	@ID int,
	@Descricao VARCHAR(100),
	@Is_Admin BIT
AS
	IF @ID IS NULL
	BEGIN
		PRINT 'The user role ID cannot be null!'
		RETURN
	END

	DECLARE @count INT

	--check if the ID exists
	SELECT @count = COUNT(ID) FROM Game_Masters.Tipo_Utilizador WHERE Game_Masters.Tipo_Utilizador.ID = @ID;

	IF @count = 0
	BEGIN
		RAISERROR ('The user role ID that you provided does not exist!', 14, 1)
		RETURN
	END

	BEGIN TRANSACTION;
	BEGIN TRY
		UPDATE Game_Masters.Tipo_Utilizador SET
			Game_Masters.Tipo_Utilizador.Descricao = @Descricao,
			Game_Masters.Tipo_Utilizador.Is_Admin = @Is_Admin
		WHERE Game_Masters.Tipo_Utilizador.ID = @ID;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		RAISERROR ('An error has occured when trying to update the user role!', 14, 1)
		ROLLBACK TRANSACTION;
	END CATCH;

GO
/****** Object:  Trigger [Game_Masters].[trigger_user]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [Game_Masters].[trigger_user] ON [Game_Masters].[Conta]
AFTER INSERT, UPDATE
AS
	SET NOCOUNT ON;
	DECLARE @count AS INT;
		SELECT @count=COUNT(Game_Masters.Conta.ID) FROM Game_Masters.Conta JOIN inserted ON Game_Masters.Conta.ID = inserted.ID;

	IF @count > 1
		BEGIN
			RAISERROR ('O utilizador nao pode ser gestor que mais do que 1 conta.', 16, 1);
			ROLLBACK TRAN;
		END;

GO
ALTER TABLE [Game_Masters].[Conta] ENABLE TRIGGER [trigger_user]
GO
/****** Object:  Trigger [Game_Masters].[trigger_account_store]    Script Date: 09-06-2017 18:47:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [Game_Masters].[trigger_account_store] ON [Game_Masters].[Loja]
AFTER INSERT, UPDATE
AS
	SET NOCOUNT ON;
	DECLARE @count AS INT;
		SELECT @count = COUNT(Game_Masters.Loja.ID) FROM Game_Masters.Loja JOIN inserted ON Game_Masters.Loja.ID = inserted.ID;


	IF @count > 1
		BEGIN
			RAISERROR ('O utilizador nao pode ser gestor que mais do que 1 loja.', 16, 1);
			ROLLBACK TRAN;
		END

GO
ALTER TABLE [Game_Masters].[Loja] ENABLE TRIGGER [trigger_account_store]
GO
USE [master]
GO
ALTER DATABASE [gamemasters] SET  READ_WRITE 
GO
