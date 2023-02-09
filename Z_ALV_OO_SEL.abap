*&---------------------------------------------------------------------*
*& Include          Z_ALV_MODELO_SEL
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK 001 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS: s_ebeln FOR ekko-ebeln OBLIGATORY,
                  s_bukrs FOR ekko-bukrs NO INTERVALS OBLIGATORY.
SELECTION-SCREEN END OF BLOCK 001.

SELECTION-SCREEN BEGIN OF BLOCK 002 WITH FRAME TITLE TEXT-002.
  SELECT-OPTIONS: s_aedat FOR ekpo-aedat.
SELECTION-SCREEN END OF BLOCK 002.