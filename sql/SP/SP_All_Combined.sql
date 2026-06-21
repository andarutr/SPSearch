-- ============================================
-- SPSearch — All Stored Procedures (Combined)
-- Generated: 2026-06-22 05:27:23
-- Total: 209 procedures
-- ============================================

-- ============================================
-- HealthDB — 50 stored procedures
-- ============================================

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetAdmissions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Admissions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetAnesthesiaRecords
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AnesthesiaRecords
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetAppointments
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Appointments
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetAppointmentStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AppointmentStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetAppointmentTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AppointmentTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetAuditLogs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AuditLogs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetBeds
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Beds
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetBillingItemCategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM BillingItemCategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetBloodTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM BloodTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetConsultations
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Consultations
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetDepartments
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Departments
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetDischarges
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Discharges
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetDispensations
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Dispensations
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetDoctors
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Doctors
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetDrugCategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM DrugCategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetDrugInventory
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM DrugInventory
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetFollowUps
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM FollowUps
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetImagingResults
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ImagingResults
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetImagingStudies
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ImagingStudies
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetImagingTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ImagingTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetInsuranceClaims
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM InsuranceClaims
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetInsurancePolicies
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM InsurancePolicies
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetInvoices
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Invoices
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetLabNormalRanges
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM LabNormalRanges
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetLabResults
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM LabResults
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetLabTests
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM LabTests
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetLabTestTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM LabTestTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetMedicalEquipment
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM MedicalEquipment
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetMedications
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Medications
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetOperatingRooms
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM OperatingRooms
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetPatientAllergies
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PatientAllergies
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetPatients
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Patients
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetPaymentMethods
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PaymentMethods
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetPayments
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Payments
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetPrescriptions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Prescriptions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetReferrals
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Referrals
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetRooms
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Rooms
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetRoomTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM RoomTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetShiftTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ShiftTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetStaff
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Staff
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetStaffCertifications
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM StaffCertifications
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetStaffRoles
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM StaffRoles
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetStaffSchedules
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM StaffSchedules
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetSuppliers
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Suppliers
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetSurgeryRecords
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SurgeryRecords
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetSurgeryTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SurgeryTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetTransfers
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Transfers
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetVitalSigns
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM VitalSigns
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetWaitingList
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM WaitingList
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [HealthDB];
GO

CREATE OR ALTER PROCEDURE SP_HealthDB_GetWards
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Wards
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

-- ============================================
-- ShoppingDB — 134 stored procedures
-- ============================================

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetAbandonedCarts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AbandonedCarts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetAPILogs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM APILogs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetBannerTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM BannerTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetBrands
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Brands
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCampaigns
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Campaigns
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCampaignTargets
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CampaignTargets
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCampaignTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CampaignTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCartAbandonmentAnalytics
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CartAbandonmentAnalytics
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCartItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CartItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetChargebacks
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Chargebacks
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetChatMessages
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ChatMessages
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetClickTracking
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ClickTracking
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCMSBlogCategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CMSBlogCategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCMSPages
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CMSPages
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCompareProducts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CompareProducts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetConversionTracking
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ConversionTracking
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCountries
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Countries
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCoupons
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Coupons
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCouponTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CouponTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCouponUsage
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CouponUsage
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCreditMemos
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CreditMemos
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetCurrencies
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Currencies
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetDailySalesReports
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM DailySalesReports
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetDeliveryTracking
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM DeliveryTracking
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetDiscountTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM DiscountTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetEmailCampaigns
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM EmailCampaigns
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetEmailLogs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM EmailLogs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetEmailTemplates
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM EmailTemplates
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetEmailTemplateTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM EmailTemplateTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetErrorLogs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ErrorLogs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetFAQCategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM FAQCategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetFAQItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM FAQItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetFeedbackForms
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM FeedbackForms
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetGiftCards
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM GiftCards
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetGoodsReceipts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM GoodsReceipts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetInventoryCounts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM InventoryCounts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetInvoiceItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM InvoiceItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetInvoices
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Invoices
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetInvoiceStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM InvoiceStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetLiveChatSessions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM LiveChatSessions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetLoyaltyPoints
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM LoyaltyPoints
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetMediaFiles
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM MediaFiles
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetMediaTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM MediaTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetNewsletterSubscribers
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM NewsletterSubscribers
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetNotificationTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM NotificationTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetOrderCancellations
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM OrderCancellations
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetOrderItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM OrderItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetOrderNotes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM OrderNotes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetOrders
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Orders
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetOrderStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM OrderStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetOrderStatusHistory
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM OrderStatusHistory
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPageViews
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PageViews
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPaymentFees
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PaymentFees
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPaymentGatewayConfigs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PaymentGatewayConfigs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPaymentGateways
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PaymentGateways
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPaymentMethods
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PaymentMethods
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPaymentTransactions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PaymentTransactions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPayoutItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PayoutItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPayouts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Payouts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPayoutStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PayoutStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPerformanceMetrics
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PerformanceMetrics
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPermissions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Permissions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPricingTiers
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PricingTiers
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductAttributes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductAttributes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductAttributeValues
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductAttributeValues
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductCategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductCategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductDiscounts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductDiscounts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductImages
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductImages
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductPerformance
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductPerformance
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductPricing
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductPricing
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductQA
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductQA
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductReviews
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductReviews
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProducts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Products
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductSKUs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductSKUs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductTags
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductTags
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductTagsMap
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductTagsMap
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductVariants
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductVariants
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetProductViews
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ProductViews
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPromotionRules
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PromotionRules
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPromotions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Promotions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPurchaseOrderItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PurchaseOrderItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetPurchaseOrders
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PurchaseOrders
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetQAAnswers
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM QAAnswers
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReferralPrograms
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReferralPrograms
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReferralRewards
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReferralRewards
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetRefunds
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Refunds
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetRelatedProducts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM RelatedProducts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReturnItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReturnItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReturns
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Returns
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReturnStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReturnStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReviewImages
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReviewImages
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReviewModerationLogs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReviewModerationLogs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReviewStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReviewStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetReviewVotes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ReviewVotes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetRolePermissions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM RolePermissions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSavedForLater
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SavedForLater
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSearchQueries
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SearchQueries
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSellerRatings
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SellerRatings
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSEORedirects
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SEORedirects
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSettlementReports
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SettlementReports
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSettlementStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SettlementStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetShipmentItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ShipmentItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetShipments
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Shipments
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetShippingMethods
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ShippingMethods
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetShippingZones
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ShippingZones
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetShippingZoneTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ShippingZoneTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetShoppingSessions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ShoppingSessions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSiteSettings
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SiteSettings
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetStockAlerts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM StockAlerts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetStockMovements
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM StockMovements
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSubcategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Subcategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSubscriptionPlanTypes
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SubscriptionPlanTypes
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSubscriptions
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Subscriptions
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSupplierProducts
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SupplierProducts
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSuppliers
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Suppliers
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSupplierStatuses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SupplierStatuses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSupportTicketMessages
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SupportTicketMessages
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSupportTicketPriorities
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SupportTicketPriorities
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetSupportTickets
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SupportTickets
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetTicketCategories
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM TicketCategories
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUserAddresses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserAddresses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUserBehaviorLogs
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserBehaviorLogs
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUserDevices
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserDevices
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUserNotifications
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserNotifications
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUserPaymentMethods
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserPaymentMethods
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUserPreferences
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserPreferences
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUserRoles
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserRoles
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUsers
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Users
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetUserSessionAnalytics
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM UserSessionAnalytics
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetWarehouseInventory
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM WarehouseInventory
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetWarehouses
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Warehouses
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetWarehouseZones
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM WarehouseZones
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetWishlistItems
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM WishlistItems
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [ShoppingDB];
GO

CREATE OR ALTER PROCEDURE SP_ShoppingDB_GetWishlists
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM Wishlists
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

-- ============================================
-- TicketingDB — 25 stored procedures
-- ============================================

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetAS00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AS00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetAS00200
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AS00200
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetAT00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM AT00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetCA00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CA00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetCA00200
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CA00200
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetCF00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM CF00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetES00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ES00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetES00200
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ES00200
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetKN00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM KN00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetKN00200
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM KN00200
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetLG00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM LG00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetNT00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM NT00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetNT00200
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM NT00200
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetPR00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM PR00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetRP00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM RP00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetSL00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SL00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetSL00200
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SL00200
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetST00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM ST00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetSU00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SU00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetSU00200
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SU00200
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetSU00300
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM SU00300
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetTN00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM TN00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetTN00200
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM TN00200
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetTN00300
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM TN00300
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

USE [TicketingDB];
GO

CREATE OR ALTER PROCEDURE SP_TicketingDB_GetUS00100
    @RowId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT *
    FROM US00100
    WHERE (ROWID = @RowId OR @RowId IS NULL)
    ORDER BY ROWID;
END;

GO

-- ============================================
-- End of combined script
-- ============================================
