*----------------------------------------------------------------------*
*                     Include Z_ALV_MODELO_PBO
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
*---------------------Module STATUS_9100 OUTPUT------------------------*
*----------------------------------------------------------------------*

MODULE status_9100 OUTPUT.
 SET PF-STATUS 'STAT9100'.
ENDMODULE.


*----------------------------------------------------------------------*
*---------------------Module DISPLAY_ALV OUTPUT------------------------*
*----------------------------------------------------------------------*
MODULE display_alv OUTPUT.

  DATA: lt_fcat    TYPE TABLE OF lvc_s_fcat,
        lwa_layout TYPE          lvc_s_layo.

  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'GO_CONT'.
  ENDIF.

  IF go_grid IS INITIAL.
    CREATE OBJECT go_grid
      EXPORTING
        i_parent = go_container.

    PERFORM f_set_field_catalog CHANGING lt_fcat.
    PERFORM f_set_layout CHANGING lwa_layout.

    CALL METHOD go_grid->set_table_for_first_display
      EXPORTING
        is_layout       = lwa_layout
      CHANGING
        it_outtab       = gt_alv
        it_fieldcatalog = lt_fcat.
  ENDIF.

ENDMODULE.