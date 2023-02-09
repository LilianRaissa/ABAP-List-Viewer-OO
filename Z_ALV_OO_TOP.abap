*&---------------------------------------------------------------------*
*& Include          Z_ALV_MODELO_TOP
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ty_ekko,
         ebeln TYPE ekko-ebeln, "N° DOCUMENTO DE COMPRAS
         bukrs TYPE ekko-bukrs, "EMPRESA
       END OF ty_ekko,

       BEGIN OF ty_ekpo,
         ebeln TYPE ekko-ebeln, "N° DOCUMENTO DE COMPRAS
         ebelp TYPE ekpo-ebelp, "N° ITEM DO DOC DE COMPRAS
         aedat TYPE ekpo-aedat, "DATA DE MODIFICAÇÃO DO ITEM
       END OF ty_ekpo,

       BEGIN OF ty_alv,
         ebeln TYPE ekko-ebeln, "N° DOCUMENTO DE COMPRAS
         bukrs TYPE ekko-bukrs, "EMPRESA
         ebelp TYPE ekpo-ebelp, "N° ITEM DO DOC DE COMPRAS
         aedat TYPE ekpo-aedat, "DATA DE MODIFICAÇÃO DO ITEM
       END OF ty_alv,

       tt_ekko   TYPE STANDARD TABLE OF ty_ekko,
       tt_ekpo   TYPE STANDARD TABLE OF ty_ekpo,
       tt_fcat   TYPE STANDARD TABLE OF lvc_s_fcat,       "LAYOUT
       tt_layout TYPE STANDARD TABLE OF lvc_s_layo.       "LAYOUT.


**********************************************************************
DATA: gt_alv       TYPE TABLE OF ty_alv, " ALV
      gwa_alv      TYPE          ty_alv, " ALV

      go_click     LIKE sy-ucomm,                        "LAYOUT
      go_container TYPE REF TO cl_gui_custom_container,  "LAYOUT
      go_grid      TYPE REF TO cl_gui_alv_grid.          "LAYOUT