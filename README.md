# SPMLMI

**SPMLMI: a structural perturbation method for predicting lncRNA–miRNA interactions based on a bilayer network in human**

# Data：

- ML_matrix: Known interaction pairs between miRNAs and lncRNAs.
- LS: The lncRNA similarity matrix.
- MS: The miRNA similarity matrix.

# Code：

- main_SPMLMI: The main program of SPLMI.
- perturbation:  The function for computing link predictability of complex networks.

# Run steps

1. Make data preparations. Specify a complete file path and file name.
2. Run "main_SPMLMI.m" for predicting lncRNA–miRNA interactions.

# Supplementary：

- lncRNA_id: The ids and names for  lncRNAs.
- miRNA_id: The ids and names for  miRNAs.
- Supplementary_Table_S1: The top 100 candidate lncRNA–miRNA interactions predicted by the SPMLMI method.
