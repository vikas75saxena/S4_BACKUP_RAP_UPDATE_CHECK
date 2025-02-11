FUNCTION z_update_po_admin.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(PURCHASEORDER) TYPE  EBELN
*"     VALUE(SALESPERSONNAMENEW) TYPE  EVERK
*"     VALUE(SALESPERSONNAMEOLD) TYPE  EVERK
*"  EXCEPTIONS
*"      RANDOM_ERROR
*"----------------------------------------------------------------------
  GET TIME STAMP FIELD DATA(lv_tstmp).
  DATA(ls_po_admin) = VALUE zsp_upd_admin(
  mandt = sy-mandt
  purchaseorder = purchaseorder
  salespersonnamenew = salespersonnamenew
  salespersonnameold = salespersonnameold
  change_date_time =  lv_tstmp
  changed_by = sy-uname ).
  INSERT zsp_upd_admin FROM ls_po_admin.

*  RAISE random_error.

ENDFUNCTION.
