*&---------------------------------------------------------------------*
*& Include          Z_ALV_MODELO_FOR
*&---------------------------------------------------------------------*

**********************************************************************
*                        START OF SELECTION                          *
**********************************************************************
START-OF-SELECTION.

  DATA: lt_ekko TYPE TABLE OF ty_ekko,
        lt_ekpo TYPE TABLE OF ty_ekpo.

  PERFORM f_select_data  CHANGING lt_ekko lt_ekpo.
  PERFORM f_output_table USING    lt_ekko lt_ekpo.

  IF gt_alv IS NOT INITIAL.
    CALL SCREEN 9100.
  ELSE.
    MESSAGE 'Valores não encontrados' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

**********************************************************************
*                       FORM f_select_data                           *
**********************************************************************

FORM f_select_data CHANGING ct_ekko TYPE tt_ekko
                            ct_ekpo TYPE tt_ekpo.

  " Busca o número de documento e empresa
  SELECT ebeln bukrs
    FROM ekko
  INTO TABLE ct_ekko
    WHERE ebeln IN s_ebeln
    AND   bukrs IN s_bukrs.

  " Se o documento for encontrado, segue a busca dos demais campos
  IF sy-subrc IS INITIAL.
    SELECT ebeln ebelp aedat
      FROM ekpo
    INTO TABLE ct_ekpo
     FOR ALL ENTRIES IN ct_ekko
      WHERE ebeln EQ ct_ekko-ebeln
      AND   aedat IN s_aedat.

  ELSE.
    MESSAGE 'Valores não encontrados' TYPE 'S' DISPLAY LIKE 'E'.
    STOP.
  ENDIF.

ENDFORM.

**********************************************************************
*                       FORM f_output_table                          *
**********************************************************************

FORM f_output_table USING pt_ekko TYPE tt_ekko
                          pt_ekpo TYPE tt_ekpo.

  DATA: lwa_ekko LIKE LINE OF pt_ekko,
        lwa_ekpo LIKE LINE OF pt_ekpo.

"--------------------- Preenchimento da tabela -----------------------
  LOOP AT pt_ekko INTO lwa_ekko.
    CLEAR gwa_alv.
      gwa_alv-ebeln = lwa_ekko-ebeln.
      gwa_alv-bukrs = lwa_ekko-bukrs.

    LOOP AT pt_ekpo INTO lwa_ekpo WHERE ebeln EQ lwa_ekko-ebeln.
      gwa_alv-ebelp = lwa_ekpo-ebelp.
      gwa_alv-aedat = lwa_ekpo-aedat.

      APPEND gwa_alv TO gt_alv.

    ENDLOOP.
  ENDLOOP.

  SORT gt_alv.

ENDFORM.

**********************************************************************
*                    FORM f_set_field_catalog                        *
**********************************************************************

FORM f_set_field_catalog CHANGING ct_fcat TYPE tt_fcat.

  DATA lwa_fcat LIKE LINE OF ct_fcat.
  CLEAR ct_fcat.

  CLEAR lwa_fcat.
  lwa_fcat-fieldname = 'EBELN'. " Documento de compra
  lwa_fcat-ref_table = 'EKKO'.
  lwa_fcat-ref_field = 'EBELN'.
  APPEND lwa_fcat TO ct_fcat.

  CLEAR lwa_fcat.
  lwa_fcat-fieldname = 'BUKRS'. " Empresa
  lwa_fcat-ref_table = 'EKKO'.
  lwa_fcat-ref_field = 'BUKRS'.
  APPEND lwa_fcat TO ct_fcat.

   CLEAR lwa_fcat.
  lwa_fcat-fieldname = 'EBELP'. "
  lwa_fcat-ref_table = 'EKPO'.
  lwa_fcat-ref_field = 'EBELP'.
  APPEND lwa_fcat TO ct_fcat.

  CLEAR lwa_fcat.
  lwa_fcat-fieldname = 'AEDAT'. "
  lwa_fcat-ref_table = 'EKPO'.
  lwa_fcat-ref_field = 'AEDAT'.
  APPEND lwa_fcat TO ct_fcat.
ENDFORM.

**********************************************************************
*                         FORM f_set_layout                          *
**********************************************************************

FORM f_set_layout CHANGING cwa_layout TYPE LINE OF tt_layout.
  CLEAR cwa_layout.
  cwa_layout-cwidth_opt = 'X'.
  cwa_layout-zebra = 'X'.
  cwa_layout-sel_mode = 'A'.
ENDFORM.