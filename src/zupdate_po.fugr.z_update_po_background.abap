FUNCTION z_update_po_background.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(PURCHASEORDER) TYPE  EBELN
*"     VALUE(SALESPERSONNAME) TYPE  EVERK
*"----------------------------------------------------------------------
  DATA: poheader    TYPE bapimepoheader,
        expoheader  TYPE bapimepoheader,
        poheaderx   TYPE bapimepoheaderx,
        lt_messages TYPE STANDARD TABLE OF bapiret2,
        lt_commit_msg TYPE bapiret2.
  poheader-sales_pers = salespersonname.
  poheaderx-sales_pers = 'X'.
  CALL FUNCTION 'BAPI_PO_CHANGE'
    EXPORTING
      purchaseorder = purchaseorder
      poheader      = poheader
      poheaderx     = poheaderx
    IMPORTING
      expheader     = expoheader
    TABLES
      return        = lt_messages.

message a001(zdemo_message).

ENDFUNCTION.
