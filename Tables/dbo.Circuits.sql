CREATE TABLE [dbo].[Circuits]
(
[instructions] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Circuits] ADD CONSTRAINT [PK_Circuits] PRIMARY KEY CLUSTERED  ([instructions]) ON [PRIMARY]
GO
