CLASS zcl_170422051_global_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_170422051_global_03 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    DATA status TYPE i.
    DATA flight_date TYPE d.
    DATA formatted_date TYPE string.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

* First Instance
**********************************************************************
    TRY.
        connection = NEW #(
          i_carrier_id    = 'IH'
          i_connection_id = '0400'
          i_status        = 1
          i_flight_date   = '20260309' ).

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( 'First method call failed.' ).
    ENDTRY.

* Second Instance
**********************************************************************
    TRY.
        connection = NEW #(
          i_carrier_id    = 'AA'
          i_connection_id = '0017'
          i_status        = 2
          i_flight_date   = '20260309' ).

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( 'Second method call failed.' ).
    ENDTRY.

**********************************************************************

    LOOP AT connections INTO connection.

      connection->get_attributes(
        IMPORTING
          e_carrier_id    = carrier_id
          e_connection_id = connection_id
          e_status        = status
          e_flight_date   = flight_date ).
      formatted_date =
              |{ flight_date+6(2) }.{ flight_date+4(2) }.{ flight_date(4) }|.
      out->write(
        |Flight Connection { carrier_id } { connection_id } Durum:{ status } Ucus Tarihi:{ formatted_date }|
      ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
