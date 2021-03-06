USE [Test]
GO
/****** Object:  Table [dbo].[Test]    Script Date: 08/27/2015 15:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[Id] [uniqueidentifier] NOT NULL,
	[FullName] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Birthday] [date] NULL,
	[IsMale] [bit] NULL,
	[Category] [int] NULL,
	[Invoice] [float] NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Test] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertTest]    Script Date: 08/27/2015 15:47:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InsertTest]
	@Id uniqueidentifier,
	@FullName nvarchar(50),
	@Country nvarchar(50),
	@Birthday date,
	@IsMale bit,
	@Category int,
	@Invoice float,
	@CreatedDate datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @current uniqueidentifier
	SELECT @current = Id FROM dbo.Test WHERE Id = @Id
	IF @current IS NULL
	BEGIN
		SET @Id = NEWID()
		INSERT INTO dbo.Test (Id, FullName, Country, Birthday, IsMale, Category, Invoice, CreatedDate)
			VALUES (@Id, @FullName, @Country, @Birthday, @IsMale, @Category, @Invoice, @CreatedDate)
	END
	ELSE
		UPDATE dbo.Test
			SET FullName = @FullName, Country = @Country, Birthday = @Birthday, IsMale = @IsMale, 
				Category = @Category, Invoice = @Invoice, CreatedDate = @CreatedDate
			WHERE Id = @Id

	SELECT @Id AS Id
END
GO
/****** Object:  Default [DF_Test_Id]    Script Date: 08/27/2015 15:47:46 ******/
ALTER TABLE [dbo].[Test] ADD  CONSTRAINT [DF_Test_Id]  DEFAULT (newid()) FOR [Id]
GO
