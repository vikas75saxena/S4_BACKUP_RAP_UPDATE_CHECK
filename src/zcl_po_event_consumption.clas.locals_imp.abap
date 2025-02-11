*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS zcl_po_event_consumption_lcl DEFINITION INHERITING FROM cl_abap_behavior_event_handler.
  PRIVATE SECTION.
    METHODS: on_salespersonidchanged FOR ENTITY EVENT podata FOR zpurchaseorder~salespersonidchanged.
ENDCLASS.

CLASS zcl_po_event_consumption_lcl IMPLEMENTATION.

  METHOD on_salespersonidchanged.
    DATA: poheader      TYPE bapimepoheader,
          expoheader    TYPE bapimepoheader,
          poheaderx     TYPE bapimepoheaderx,
          lt_messages   TYPE STANDARD TABLE OF bapiret2,
          ls_commit_msg TYPE bapiret2.
    poheader-sales_pers = podata[ 1 ]-salespersonidev.
    poheaderx-sales_pers = 'X'.
    CALL FUNCTION 'BAPI_PO_CHANGE'
      EXPORTING
        purchaseorder = podata[ 1 ]-purchaseorderev
        poheader      = poheader
        poheaderx     = poheaderx
      IMPORTING
        expheader     = expoheader
      TABLES
        return        = lt_messages.
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
        wait   = 'X'
      IMPORTING
        return = ls_commit_msg.
  ENDMETHOD.

ENDCLASS.
