USE [master]
GO
/****** Object:  Database [SmartPOS]    Script Date: 10/8/2023 12:08:58 PM ******/
CREATE DATABASE [SmartPOS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SmartPOS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVERDEVELOP\MSSQL\DATA\SmartPOS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SmartPOS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVERDEVELOP\MSSQL\DATA\SmartPOS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SmartPOS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SmartPOS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SmartPOS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SmartPOS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SmartPOS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SmartPOS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SmartPOS] SET ARITHABORT OFF 
GO
ALTER DATABASE [SmartPOS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SmartPOS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SmartPOS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SmartPOS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SmartPOS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SmartPOS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SmartPOS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SmartPOS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SmartPOS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SmartPOS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SmartPOS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SmartPOS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SmartPOS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SmartPOS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SmartPOS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SmartPOS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SmartPOS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SmartPOS] SET RECOVERY FULL 
GO
ALTER DATABASE [SmartPOS] SET  MULTI_USER 
GO
ALTER DATABASE [SmartPOS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SmartPOS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SmartPOS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SmartPOS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SmartPOS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SmartPOS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SmartPOS', N'ON'
GO
ALTER DATABASE [SmartPOS] SET QUERY_STORE = OFF
GO
USE [SmartPOS]
GO
/****** Object:  Table [dbo].[ChecksItems]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChecksItems](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CheckId] [int] NOT NULL,
	[ItemId] [int] NOT NULL,
	[QTY] [decimal](18, 4) NOT NULL,
	[price] [decimal](18, 4) NOT NULL,
	[totalPrice] [decimal](18, 4) NOT NULL,
 CONSTRAINT [PK_ChecksItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[DES] [varchar](50) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[price] [decimal](18, 4) NOT NULL,
	[itemImg] [image] NULL,
	[notes] [varchar](100) NULL,
 CONSTRAINT [PK_items] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewReceipt]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewReceipt]
AS
SELECT        dbo.ChecksItems.ItemId, dbo.Items.Name, dbo.ChecksItems.QTY, dbo.ChecksItems.totalPrice, dbo.ChecksItems.CheckId
FROM            dbo.ChecksItems INNER JOIN
                         dbo.Items ON dbo.ChecksItems.ItemId = dbo.Items.id
GO
/****** Object:  Table [dbo].[Checks]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Checks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[checkDate] [datetime] NOT NULL,
	[userId] [int] NOT NULL,
	[totalCheck] [decimal](18, 4) NOT NULL,
	[status] [varchar](50) NOT NULL,
	[TableId] [int] NULL,
	[CheckType] [varchar](50) NULL,
 CONSTRAINT [PK_Checks] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChecksPay]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChecksPay](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PaymentId] [int] NOT NULL,
	[PayVal] [decimal](18, 4) NOT NULL,
	[checkId] [int] NULL,
 CONSTRAINT [PK_ChecksPay] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Des] [nchar](10) NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userName] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[fullName] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[phone] [varchar](50) NULL,
	[jobDes] [varchar](50) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ViewCheckReport]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ViewCheckReport]
AS
SELECT        C.checkDate, C.totalCheck, C.status, CP.PaymentId, CP.PayVal, CP.checkId, C.id, C.userId, P.Des, U.userName, U.fullName
FROM            dbo.Checks AS C INNER JOIN
                         dbo.Users AS U ON C.userId = U.id INNER JOIN
                         dbo.ChecksPay AS CP ON C.id = CP.checkId INNER JOIN
                         dbo.Payments AS P ON CP.PaymentId = P.id
GO
/****** Object:  Table [dbo].[TablesLocations]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TablesLocations](
	[TableId] [int] NOT NULL,
	[locationX] [int] NOT NULL,
	[locationY] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tables](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DES] [varchar](50) NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwTablesRoom]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwTablesRoom]
AS
SELECT        T.id, T.DES, TL.locationX, TL.locationY, C.id AS C_ID, C.status, C.CheckType
FROM            dbo.Checks AS C RIGHT OUTER JOIN
                         dbo.Tables AS T ON C.TableId = T.id LEFT OUTER JOIN
                         dbo.TablesLocations AS TL ON T.id = TL.TableId
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DES] [varchar](50) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Options]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Options](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Rsetname] [varchar](50) NULL,
	[prenterName] [varchar](100) NULL,
	[RestAddress1] [varchar](50) NULL,
	[RestAddress2] [varchar](50) NULL,
	[receiptLine1] [varchar](50) NULL,
	[receiptLine2] [varchar](50) NULL,
	[telephone] [varchar](50) NULL,
	[logo] [image] NULL,
 CONSTRAINT [PK_Options] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[userpermission]    Script Date: 10/8/2023 12:08:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[userpermission](
	[permission_id] [int] NOT NULL,
	[main_screen] [varchar](50) NULL,
	[permission] [varchar](50) NULL,
	[userid] [int] NULL,
	[case] [bit] NULL,
 CONSTRAINT [PK_userpermission] PRIMARY KEY CLUSTERED 
(
	[permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "CP"
            Begin Extent = 
               Top = 148
               Left = 264
               Bottom = 278
               Right = 434
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "P"
            Begin Extent = 
               Top = 174
               Left = 522
               Bottom = 270
               Right = 692
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "U"
            Begin Extent = 
               Top = 14
               Left = 281
               Bottom = 144
               Right = 451
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewCheckReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewCheckReport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ChecksItems"
            Begin Extent = 
               Top = 40
               Left = 86
               Bottom = 234
               Right = 256
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Items"
            Begin Extent = 
               Top = 52
               Left = 378
               Bottom = 257
               Right = 548
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewReceipt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ViewReceipt'
GO
USE [master]
GO
ALTER DATABASE [SmartPOS] SET  READ_WRITE 
GO
