CLASS zcl_update_po DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_podata,
             purchaseorder               TYPE ebeln,
             supplierrespsalespersonname TYPE everk,
           END OF ty_podata,
           tty_podata TYPE STANDARD TABLE OF ty_podata WITH KEY purchaseorder.
    METHODS:
      constructor,
      get_data RETURNING VALUE(lt_podata) TYPE tty_podata,
      set_data IMPORTING ls_podata TYPE ty_podata.
    CLASS-METHODS
      get_instance RETURNING VALUE(lo_ref) TYPE REF TO zcl_update_po.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mt_podata        TYPE tty_podata.
    CLASS-DATA:      mo_ref           TYPE REF TO zcl_update_po.
ENDCLASS.



CLASS zcl_update_po IMPLEMENTATION.
  METHOD constructor.
  ENDMETHOD.
  METHOD get_data.
    lt_podata = mt_podata.
  ENDMETHOD.
  METHOD set_data.
    APPEND ls_podata TO mt_podata.
  ENDMETHOD.
  METHOD get_instance.
    IF mo_ref IS BOUND.
      RETURN mo_ref.
    ELSE.
      mo_ref = NEW zcl_update_po( ).
      RETURN mo_ref.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
