CLASS lhc_zpurchaseorder DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zpurchaseorder RESULT result.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zpurchaseorder.

    METHODS read FOR READ
      IMPORTING keys FOR READ zpurchaseorder RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zpurchaseorder.

ENDCLASS.

CLASS lhc_zpurchaseorder IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD update.
    DATA(lo_podata) = zcl_update_po=>get_instance( ).
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_podata>).
      DATA(ls_podata) = CORRESPONDING zcl_update_po=>ty_podata( <ls_podata> ).
      lo_podata->set_data( ls_podata ).
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zpurchaseorder DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PUBLIC SECTION.
    CLASS-DATA: mv_purchaseorder   TYPE ebeln,
                mv_salespersonname TYPE verkf.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

    METHODS do_update_directly.

    METHODS do_update_via_background_task.

    METHODS do_update_via_event.

    METHODS call_update_task_fm_admin_data.

ENDCLASS.

CLASS lsc_zpurchaseorder IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    DATA: lt_commit_msg TYPE bapiret2.
    DATA(lo_podata) = zcl_update_po=>get_instance( ).
    DATA(lt_podata) = lo_podata->get_data(  ).
    mv_purchaseorder = lt_podata[ 1 ]-purchaseorder.
    mv_salespersonname = lt_podata[ 1 ]-supplierrespsalespersonname.
*    do_update_directly(  ).
    do_update_via_background_task(  ).
*    do_update_via_event(  ).
    call_update_task_fm_admin_data(  ).
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

  METHOD do_update_directly.
    DATA: poheader            TYPE bapimepoheader,
          expoheader          TYPE bapimepoheader,
          poheaderx           TYPE bapimepoheaderx,
          lt_messages         TYPE STANDARD TABLE OF bapiret2.
    poheader-sales_pers = mv_salespersonname.
    poheaderx-sales_pers = 'X'.
    CALL FUNCTION 'BAPI_PO_CHANGE'
      EXPORTING
        purchaseorder = mv_purchaseorder
        poheader      = poheader
        poheaderx     = poheaderx
      IMPORTING
        expheader     = expoheader
      TABLES
        return        = lt_messages.
  ENDMETHOD.

  METHOD do_update_via_background_task.
    DATA: dest_name     TYPE bgrfc_dest_name_inbound.
    dest_name = 'BGRFC_TEST_VIK'.
    DATA(lo_dest) = cl_bgrfc_destination_inbound=>create( dest_name ).
    DATA(bgunit) = lo_dest->create_trfc_unit( ).
    CALL FUNCTION 'Z_UPDATE_PO_BACKGROUND'
      IN BACKGROUND UNIT bgunit
      EXPORTING
        purchaseorder   = mv_purchaseorder
        salespersonname = mv_salespersonname.
  ENDMETHOD.

  METHOD do_update_via_event.
    RAISE ENTITY EVENT ZPURCHASEORDER~SALESPERSONIDCHANGED
    FROM VALUE #( ( PurchaseOrderEv = mv_purchaseorder
                    SalesPersonIdEv = mv_salespersonname ) ).
  ENDMETHOD.

  METHOD call_update_task_fm_admin_data.
     select single verkf from ekko into @DATA(lv_salespersonnameold)
     where ebeln = @mv_purchaseorder.
     CALL FUNCTION 'Z_UPDATE_PO_ADMIN' IN UPDATE TASK
     exporting
      purchaseorder = mv_purchaseorder
      salespersonnamenew = mv_salespersonname
      salespersonnameold = lv_salespersonnameold
     exceptions
      random_error       = 01.

  ENDMETHOD.

ENDCLASS.
