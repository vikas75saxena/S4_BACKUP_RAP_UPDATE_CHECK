@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo.typeName: 'PurchaseOrder'
@UI.headerInfo.title.value: 'PurchaseOrder'
define root view entity ZC_PURCHASEORDER
  provider contract transactional_query as projection on ZPURCHASEORDER
{
@UI.facet: [{  
    purpose: #STANDARD,
    id: 'PO',
    label: 'PO Sales Person Info',
    type: #FIELDGROUP_REFERENCE,
    targetQualifier: 'PO',
    position: 10  }]
@UI: { lineItem: [ { position: 10, importance: #HIGH, type: #STANDARD  } ],
       identification: [{ position: 10 }],
       selectionField: [{ position: 10 }],
       fieldGroup: [{ qualifier: 'PO', position: 10 }] }
  key PurchaseOrder,
@UI: { lineItem: [ { position: 20, importance: #HIGH, type: #STANDARD  } ],
       identification: [{ position: 20, type: #AS_FIELDGROUP }],
       fieldGroup: [{ qualifier: 'PO', position: 20 }] }
  SupplierRespSalesPersonName
}
