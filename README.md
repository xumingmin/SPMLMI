# SPMLMI

**SPMLMI: Predicting lncRNA–miRNA interactions in humans using a structural perturbation method**

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
- Supplementary_Table_S1: Prediction results of the top 120 MALAT1-related miRNAs, and ranked by their prediction scores.
