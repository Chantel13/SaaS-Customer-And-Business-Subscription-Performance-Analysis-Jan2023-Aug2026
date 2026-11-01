SaaS ANALYSIS
SQL PORTFOLIO PROJECT

Objective: 
The objective of this project was to use SQL to analyse a SaaS business and understand how customers are acquired, how they use and manage their subscriptions, where revenue is being generated, and what challenges customers experience. I wanted to use real business questions to practise working with multiple related tables and turn the data into useful insights that could support better business decisions.

Tools:
SQL Server / SSMS

Author: MS MNYONI, CHANTEL

1.DATA OVERVIEW

--Check number of customers
SELECT
	COUNT(*) TotalCustomers
FROM Customers;

--Check number of subscriptions
SELECT
	COUNT(*) TotalSubscriptions
FROM Subscriptions

--Check number of payments
SELECT
	COUNT(*) TotalPayments
FROM Payments;

--Check number of product usage
SELECT
	COUNT(*) TotalUsage
FROM ProductUsage;

--Check number of support tickets
SELECT
	COUNT(*) TotalTickets
FROM SupportTickets;

--Check number of marketing campains
SELECT
	COUNT(*) TotalCampaigns
FROM MarketingCampaigns;

2.DATA QUALITY CHECKS 

--Check for duplicate customers 
SELECT 
	CustomerID, 
	COUNT(*) NumberOfCustomers 
FROM Customers 
GROUP BY CustomerID 
HAVING COUNT(*) > 1; 

--Check for SignupDates greater than today 
SELECT 
	SignupDate 
FROM Customers 
WHERE SignupDate > GETDATE(); 

--Check for duplicate subscriptions  
SELECT 
	SubscriptionID, 
	COUNT(*) NumberOfSubscriptions 
FROM Subscriptions 
GROUP BY SubscriptionID 
HAVING COUNT(*) > 1; 

--Check for duplicate payments 
SELECT 
	PaymentID, 
	COUNT(*) NumberOfPayments 
FROM Payments 
GROUP BY PaymentID 
HAVING COUNT(*) > 1; 

--Check for discount rates less than 0 
SELECT 
	DiscountRate 
FROM Payments 
WHERE DiscountRate < 0 OR DiscountRate > 100; 

--Check for gross amounts less than 0 
SELECT 
	GrossAmount 
FROM Payments 
WHERE GrossAmount < 0; 

--Check for net amounts less than 0 
SELECT 
	NetAmount 
FROM Payments 
WHERE NetAmount < 0; 

--Check for Monthly prices that are less than 0 
SELECT 
	MonthlyPrice 
FROM Subscriptions 
WHERE MonthlyPrice < 0; 

--Check for Payment dates that occur before the StartDate  
SELECT 
	P.PaymentDate, 
	S.StartDate 
FROM Payments p 
JOIN Subscriptions s 
	ON p.subscriptionid = s.subscriptionid 
WHERE P.PaymentDate < S.StartDate; 

--Check for duplicate product usage  
SELECT 
	UsageID, 
	COUNT(*) NumberOfUsages 
FROM ProductUsage 
GROUP BY UsageID 
HAVING COUNT(*) > 1; 

--Check for sessions less than 0 
SELECT 
	Sessions 
FROM ProductUsage 
WHERE Sessions < 0; 

--Check for minutes used that are less than 0 
SELECT 
	MinutesUsed 
FROM ProductUsage 
WHERE MinutesUsed < 0; 

--Check for duplicate support tickets  
SELECT 
	TicketID, 
	COUNT(*) NumberOfiTckets 
FROM SupportTickets 
GROUP BY TicketID 
HAVING COUNT(*) > 1; 

--Check for ResolvedDates that occurred before the CreatedDates 
SELECT 
	CreatedDate, 
	ResolvedDate 
FROM SupportTickets 
WHERE ResolvedDate < CreatedDate ; 

--Check for satisfaction scores less than 0 and greater than 5 
SELECT 
	SatisfactionScore 
FROM SupportTickets 
WHERE SatisfactionScore < 0 OR SatisfactionScore > 5; 

--Check for duplicate marketing campaigns  
SELECT 
	CampaignID, 
	COUNT(*) NumberOfCampaigns 
FROM MarketingCampaigns 
GROUP BY CampaignID 
HAVING COUNT(*) > 1; 

--Check for customers acquired values less than 0 
SELECT 
	CustomersAcquired 
FROM MarketingCampaigns 
WHERE CustomersAcquired < 0;

3. REVENUE AND SUBSCRIPTION PERFORMANCE 

--How has profit generated from calendar-year-to-date change over time

WITH TotalRevenue AS
(
	SELECT
		YEAR(PaymentDate) Year,
		SUM(GrossAmount) TotalGrossRevenue,
		SUM(NetAmount) NetPaymentRevenue
	FROM Payments
	WHERE MONTH(PaymentDate) <= 8
	GROUP BY 
		YEAR(PaymentDate)
)
SELECT
	Year,
	TotalGrossRevenue,
	NetPaymentRevenue,
	(TotalGrossRevenue - NetPaymentRevenue) * 1.0
	 / NULLIF(TotalGrossRevenue, 0) * 100 DiscountRate
FROM TotalRevenue
ORDER BY Year;

-- Is revenue growth being driven by an increase in the number of customers or by customers spending more per transaction

WITH RevenueGrowth AS
(
	SELECT
		YEAR(PaymentDate) Year,
		SUM(NetAmount) NetRevenue,
		COUNT(DISTINCT CustomerID) CustomerVolume
	FROM Payments
	WHERE MONTH(PaymentDate) <= 8
	GROUP BY YEAR(PaymentDate)
)
SELECT
	Year,
	NetRevenue,
	CustomerVolume,
	NetRevenue * 1.0 / CustomerVolume AverageRevenuePerCustomer
FROM RevenueGrowth
ORDER BY Year;

-- Are customers generating more revenue because they hold multiple subscriptions, or because the average subscription is generating more revenue

WITH SubscriptionRevenue AS
(
	SELECT
		YEAR(PaymentDate) Year,
		SUM(NetAmount) NetRevenue,
		COUNT(DISTINCT SubscriptionID) SubscriptionVolume
	FROM Payments
	WHERE MONTH(PaymentDate) <= 8
	GROUP BY YEAR(PaymentDate)
)
SELECT
	Year,
	NetRevenue,
	SubscriptionVolume,
	NetRevenue * 1.0 / SubscriptionVolume AverageRevenuePerSubscription
FROM SubscriptionRevenue
ORDER BY Year;

-- How has subscription volume change across different plans from 2023 to 2026

SELECT
	YEAR(StartDate) Year,
	[Plan],
	COUNT(SubscriptionID) SubscriptionVolume
FROM Subscriptions
WHERE MONTH(StartDate) <= 8
GROUP BY 
	YEAR(StartDate), 
	[Plan]
ORDER BY Year;

-- What is the percentage contributed by each plan to total new subscriptions for each year

WITH PlanContributions AS
(
	SELECT
		YEAR(StartDate) Year,
		[Plan],
		COUNT(SubscriptionID) SubscriptionVolume
	FROM Subscriptions
	WHERE MONTH(StartDate) <= 8
	GROUP BY 
		YEAR(StartDate), 
		[Plan]
)
SELECT
	Year,
	[Plan],
	SubscriptionVolume,
	SubscriptionVolume * 100.0 /
		SUM(SubscriptionVolume) OVER (PARTITION BY Year) PlanPercentage
FROM PlanContributions;

-- Did the average discount rate decrease in 2026 compared with previous years

SELECT
	YEAR(PaymentDate) Year,
	AVG(DiscountRate) AverageDiscountRate
FROM Payments
WHERE MONTH(PaymentDate) <= 8
GROUP BY YEAR(PaymentDate)
ORDER BY Year;

-- How has the average subscription duration days change over time

SELECT
		YEAR(StartDate) Year,
		COUNT(SubscriptionID) SubscriptionVolume,
		AVG(DATEDIFF(DAY, StartDate,
        ISNULL(EndDate, GETDATE()))) AverageSubscriptionDurationDays
	FROM Subscriptions
	WHERE MONTH(StartDate) <= 8
	GROUP BY 
		YEAR(StartDate)

-- What is the Average Gross Amount

SELECT
	YEAR(PaymentDate) Year,
	AVG(GrossAmount) AverageGrossAmount
FROM Payments
WHERE MONTH(PaymentDate) <= 8
GROUP BY YEAR(PaymentDate)
ORDER BY Year;

-- How does payment frequency differ from 2023 to 2026

SELECT
	YEAR(PaymentDate) Year,
	COUNT(PaymentID) * 1.0 /
	COUNT(DISTINCT SubscriptionID)
FROM Payments
WHERE MONTH(PaymentDate) <= 8
GROUP BY YEAR(PaymentDate)
ORDER BY Year;

-- What is the total NetAmount for each payment status, grouped by year

SELECT
	YEAR(PaymentDate) Year,
	PaymentStatus,
	COUNT(PaymentID) PaymentVolume,
	SUM(NetAmount) TotalNetValue
FROM Payments
WHERE MONTH(PaymentDate) <= 8
GROUP BY
	YEAR(PaymentDate),
	PaymentStatus
ORDER BY Year;

--Which industries have the highest cancellation rates

WITH IndustryStatus AS
(
	SELECT
		C.Industry,
		COUNT(*) AS TotalSubscriptions,
		SUM(CASE WHEN S.Status = 'Cancelled' THEN 1 ELSE 0 END) AS CancelledSubscriptions
	FROM Customers C
	JOIN Subscriptions S
		ON C.CustomerID = S.CustomerID
	GROUP BY C.Industry
)
SELECT
    Industry,
    TotalSubscriptions,
    CancelledSubscriptions,
    CancelledSubscriptions * 1.0 / TotalSubscriptions * 100 AS CancellationRate
FROM IndustryStatus
ORDER BY CancellationRate DESC;

--Which plans have the highest payment failue rates

WITH LeakagePayments AS
(
	SELECT
		S.[Plan],
		COUNT(*) NumberOfPlans,
		SUM(CASE WHEN P.PaymentStatus = 'Failed' THEN 1 ELSE 0 END) FailedPayments
	FROM Subscriptions s
	JOIN Payments p
		ON s.subscriptionid = p.subscriptionid
	GROUP BY S.[Plan]
)
SELECT
	[Plan],
	FailedPayments * 1.0 / NumberOfPlans * 100 FailureRate
FROM LeakagePayments;

4. CUSTOMER ACQUISITION AND BEHAVIOUR

--How has the number of customers changed overtime from January 2023 to August 2026

SELECT
	YEAR(SignupDate) Year,
	COUNT(*) NumberOfCustomers
FROM Customers
WHERE MONTH(SignupDate) <= 8
GROUP BY
	YEAR(SignupDate)
ORDER BY Year;

-- Which acquisition channels are responsible for having the most customers with failed and refunded payments in each year

WITH LeakagePayments AS
(
	SELECT
		YEAR(p.PaymentDate) Year,
		c.AcquisitionChannel,
		COUNT(DISTINCT p.CustomerID) NumberOfCustomers,
		SUM(p.NetAmount) TotalNetValue, 
		SUM( CASE WHEN p.PaymentStatus IN ('Failed','Refunded') THEN p.NetAmount ELSE 0 END) UnsuccessfulPayments
	FROM Customers c
	JOIN Payments p
		ON c.customerid = p.customerid
	WHERE MONTH(PaymentDate) <= 8
	GROUP BY 
		YEAR(p.PaymentDate),
		c.AcquisitionChannel
)
SELECT
	Year,
	AcquisitionChannel,
	NumberOfCustomers,
	TotalNetValue,
	UnsuccessfulPayments,
	UnsuccessfulPayments * 1.0 / TotalNetValue * 100 UnsuccessulPaymentValueRate
FROM LeakagePayments
ORDER BY Year;
		