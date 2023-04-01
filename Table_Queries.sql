
==== Database : Online Food Ordering System =====
CREATE TABLE [dbo].[offers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[item_id] [int] INT NOT NULL,
	[price] [float] NOT NULL,
	created_at DATETIME NOT NULL DEFAULT SYSDATETIME(),
    updated_at DATETIME,
	PRIMARY KEY CLUSTERED ([id] ASC),
	CONSTRAINT [FK_offers_items] FOREIGN KEY ([item_id]) REFERENCES [dbo].[items] ([id])
	)
CREATE TABLE [dbo].[item_order](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[item_id] [int]  NOT NULL,
	[order_id] [int] NOT NULL,
	[total] float NULL,
    [delivery_cost] float NULL,
    [grand_total] float NULL,
	created_at DATETIME NOT NULL DEFAULT SYSDATETIME(),
    updated_at DATETIME,
	PRIMARY KEY CLUSTERED ([id] ASC),
	CONSTRAINT [FK_itemorders_items] FOREIGN KEY ([item_id]) REFERENCES [dbo].[items] ([id]),
	CONSTRAINT [FK_itemorders_orders] FOREIGN KEY ([order_id]) REFERENCES [dbo].[orders] ([id])
	)
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[item_id] [int] NOT NULL,
	[user_id] nvarchar(450) NOT NULL,
	[price] [float] NOT NULL,
    [quantity] [int] NOT NULL,
	[status] nvarchar(450) NOT NULL,
	created_at DATETIME NOT NULL DEFAULT SYSDATETIME(),
    updated_at DATETIME,
	PRIMARY KEY CLUSTERED ([id] ASC),
	CONSTRAINT [FK_orders_items] FOREIGN KEY ([item_id]) REFERENCES [dbo].[items] ([id]),
	CONSTRAINT [FK_orders_AspNetUsers] FOREIGN KEY ([user_id]) REFERENCES [dbo].[AspNetUsers] ([Id])
	)




CREATE TABLE [dbo].[shipping_addresses](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[receiver_name] nvarchar(450) NULL,
	[phone] FLOAT NULL,
	[street_name] nvarchar(450) NULL,
	[city] nvarchar(450) NULL,
    [state] nvarchar(450)  NULL,
	created_at DATETIME NOT NULL DEFAULT SYSDATETIME(),
    updated_at DATETIME,
	PRIMARY KEY CLUSTERED ([id] ASC),
	CONSTRAINT [FK_shipping_addresses_order] FOREIGN KEY ([order_id]) REFERENCES [dbo].[order] ([id])
	)






    CREATE TABLE [dbo].[carts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] nvarchar(450) NOT NULL,
    [item_id] INT NOT  NULL,
	[quantity] INT NULL,
	[price] INT NULL,
	PRIMARY KEY CLUSTERED ([id] ASC),
	CONSTRAINT [FK_carts_AspNetUsers] FOREIGN KEY ([user_id]) REFERENCES [dbo].[AspNetUsers] ([Id]),
    CONSTRAINT [FK_cartitem_items] FOREIGN KEY ([item_id]) REFERENCES [dbo].[items] ([id])
	)

CREATE TABLE [dbo].[cart_item](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cart_id] INT NOT NULL,
    [item_id] INT NOT  NULL,
	PRIMARY KEY CLUSTERED ([id] ASC),
	CONSTRAINT [FK_cartitem_carts] FOREIGN KEY ([cart_id]) REFERENCES [dbo].[carts] ([id]),
	CONSTRAINT [FK_cartitem_items] FOREIGN KEY ([item_id]) REFERENCES [dbo].[items] ([id])
	)

CREATE TABLE [dbo].[feedbacks](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[item_id] INT NOT NULL,
	[user_id] nvarchar(450) NOT NULL,
	[comments] VARCHAR(200) NOT NULL,
    [rating] [int] NOT NULL,
	created_at DATETIME NOT NULL DEFAULT SYSDATETIME(),
    updated_at DATETIME,
	PRIMARY KEY CLUSTERED ([id] ASC),
	CONSTRAINT [FK_feedbacks_items] FOREIGN KEY ([item_id]) REFERENCES [dbo].[items] ([id]),
	CONSTRAINT [FK_feedbacks_AspNetUsers] FOREIGN KEY ([user_id]) REFERENCES [dbo].[AspNetUsers] ([Id])
	)

CREATE TABLE [dbo].[delivery_details](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[delivery_cost] FLOAT NOT NULL,
	[delivery_time] INT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT SYSDATETIME(),
    updated_at DATETIME,
	PRIMARY KEY CLUSTERED ([id] ASC),
	)

CREATE view get_allproducts as select i.id,i.name,i.description,i.price,i.image,i.category_id,c.name as category
from items i inner join categories c on i.category_id = c.id

create view get_total as 
		select sum(i.price*c.quantity) as sub_total,c.user_id from carts c inner join items i on c.item_id = i.id