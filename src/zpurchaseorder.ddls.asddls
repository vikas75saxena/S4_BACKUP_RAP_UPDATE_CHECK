@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order View'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define root view entity ZPURCHASEORDER as select from I_PurchaseOrderAPI01
{
    key PurchaseOrder,
    SupplierRespSalesPersonName
}
where CreatedByUser = 'SAXENAV'
 and PurchaseOrderType = 'NB'
