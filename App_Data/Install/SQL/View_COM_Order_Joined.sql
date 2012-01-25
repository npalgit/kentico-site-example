CREATE VIEW [View_COM_Order_Joined] AS SELECT COM_Order.[OrderID], COM_Order.[OrderBillingAddressID], COM_Order.[OrderShippingAddressID], COM_Order.[OrderShippingOptionID], COM_Order.[OrderTotalShipping], COM_Order.[OrderTotalPrice], COM_Order.[OrderTotalTax], COM_Order.[OrderDate], COM_Order.[OrderStatusID], COM_Order.[OrderCurrencyID], COM_Order.[OrderCustomerID], COM_Order.[OrderCreatedByUserID], COM_Order.[OrderNote], COM_Order.[OrderSiteID], COM_Order.[OrderPaymentOptionID], COM_Order.[OrderInvoice], COM_Order.[OrderInvoiceNumber], COM_Order.[OrderDiscountCouponID], COM_Order.[OrderCompanyAddressID], COM_Order.[OrderTrackingNumber], COM_Order.[OrderCustomData], COM_Order.[OrderPaymentResult], COM_Order.[OrderGUID], COM_Order.[OrderLastModified], COM_Order.[OrderTotalPriceInMainCurrency], COM_Order.[OrderIsPaid], COM_Order.[OrderCulture], COM_Customer.[CustomerID], COM_Customer.[CustomerFirstName], COM_Customer.[CustomerLastName], COM_Customer.[CustomerEmail], COM_Customer.[CustomerPhone], COM_Customer.[CustomerFax], COM_Customer.[CustomerCompany], COM_Customer.[CustomerUserID], COM_Customer.[CustomerPreferredCurrencyID], COM_Customer.[CustomerPreferredShippingOptionID], COM_Customer.[CustomerCountryID], COM_Customer.[CustomerEnabled], COM_Customer.[CustomerPrefferedPaymentOptionID], COM_Customer.[CustomerStateID], COM_Customer.[CustomerGUID], COM_Customer.[CustomerTaxRegistrationID], COM_Customer.[CustomerOrganizationID], COM_Customer.[CustomerDiscountLevelID], COM_Customer.[CustomerCreated], COM_Customer.[CustomerLastModified], COM_Customer.[CustomerSiteID], COM_OrderStatus.[StatusID], COM_OrderStatus.[StatusName], COM_OrderStatus.[StatusDisplayName], COM_OrderStatus.[StatusOrder], COM_OrderStatus.[StatusEnabled], COM_OrderStatus.[StatusColor], COM_OrderStatus.[StatusGUID], COM_OrderStatus.[StatusLastModified], COM_OrderStatus.[StatusSendNotification], COM_OrderStatus.[StatusSiteID], COM_OrderStatus.[StatusOrderIsPaid], COM_Currency.[CurrencyID], COM_Currency.[CurrencyName], COM_Currency.[CurrencyDisplayName], COM_Currency.[CurrencyCode], COM_Currency.[CurrencyRoundTo], COM_Currency.[CurrencyEnabled], COM_Currency.[CurrencyFormatString], COM_Currency.[CurrencyIsMain], COM_Currency.[CurrencyGUID], COM_Currency.[CurrencyLastModified], COM_Currency.[CurrencySiteID] FROM COM_Order INNER JOIN COM_Customer ON COM_Order.OrderCustomerID = COM_Customer.CustomerID INNER JOIN COM_OrderStatus ON COM_Order.OrderStatusID = COM_OrderStatus.StatusID INNER JOIN COM_Currency ON COM_Order.OrderCurrencyID = COM_Currency.CurrencyID
GO