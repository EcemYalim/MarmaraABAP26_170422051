*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection_eml DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS:
      insert_data,
       read_data,
      update_data,
      delete_data.

ENDCLASS.


CLASS lcl_connection_eml IMPLEMENTATION.

  METHOD insert_data.
    DATA: lt_create TYPE TABLE FOR CREATE zr_tcon_170422051000.
    lt_create = VALUE #( ( %cid = 'C1'
                              Carrid = 'LH'
                              Connid = '0400'
                              AirportFrom = 'FRA'
                              CityFrom = 'Frankfurt'
                              CountryFrom = 'DE'
                              AirportTo = 'JFK'
                              CityTo = ' New York'
                              CountryTo = 'US')
                              (  %cid = 'C2'
                              Carrid = 'TK'
                              Connid = '0400'
                              AirportFrom = 'FRA'
                              CityFrom = 'Frankfurt'
                              CountryFrom = 'DE'
                              AirportTo = 'JFK'
                              CityTo = ' New York'
                              CountryTo = 'US')
                              (  %cid = 'C3'
                              Carrid = 'TK'
                              Connid = '0400'
                              AirportFrom = 'FRA'
                              CityFrom = 'Frankfurt'
                              CountryFrom = 'DE'
                              AirportTo = 'JFK'
                              CityTo = ' New York'
                              CountryTo = 'US') ).

    MODIFY ENTITIES OF  zr_tcon_170422051000
    ENTITY ZrTcon170422051000
    CREATE FIELDS ( Carrid
                     Connid
                     AirportFrom
                     CityFrom
                     CountryFrom
                      AirportTo
                      CityTo
                     CountryTo ) WITH lt_create FAILED DATA(ls_failed).

    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
    ENDIF.
  ENDMETHOD.

  METHOD read_data.

    DATA read_keys   TYPE TABLE FOR READ IMPORT zr_tcon_170422051000.

    DATA connections TYPE TABLE FOR READ RESULT zr_tcon_170422051000.



    read_keys = VALUE #( ( uuid = '0EB7FADDFAE01FE18B86EBC6BDF1E66B' ) ).



    READ ENTITIES OF zr_tcon_170422051000

        ENTITY ZrTcon170422051000

        ALL FIELDS

        WITH CORRESPONDING #( read_keys )

        RESULT connections.





  ENDMETHOD.

    METHOD update_data.
        DATA lt_update TYPE TABLE FOR UPDATE zr_tcon_170422051000.

        SELECT uuid FROM zr_tcon_170422051000 where uuid = '0EB7FADDFAE01FE18B86EBC6BDF1E66B'
        INTO TABLE @DATA(lt_keys) UP TO 1 ROWS.


        LOOP AT lt_keys INTO DATA(ls_key).
            lt_update = VALUE #( ( uuid = ls_key-uuid
                                    CityTo = 'Paris'
                                    %control-CityTo = if_abap_behv=>mk-on ) ).

        ENDLOOP.


        MODIFY ENTITIES OF zr_tcon_170422051000
            ENTITY ZrTcon170422051000 UPDATE FROM lt_update FAILED DATA(ls_failed).

         IF ls_failed IS INITIAL.
            COMMIT ENTITIES.
         ENDIF.

         ENDMETHOD.


    METHOD delete_data.
        DATA lt_delete TYPE TABLE FOR DELETE zr_tcon_170422051000.

       lt_delete = VALUE #( ( uuid = '0EB7FADDFAE01FE18B86EBC6BDF1E66B' ) ).


        MODIFY ENTITIES OF zr_tcon_170422051000
            ENTITY ZrTcon170422051000 DELETE FROM  lt_delete FAILED DATA(ls_failed).

         IF ls_failed IS INITIAL.
            COMMIT ENTITIES.
         ENDIF.

         ENDMETHOD.



ENDCLASS.
