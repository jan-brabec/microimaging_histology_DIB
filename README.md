# Manuscript: Coregistered H&E- and VEGF-stained histology slides with diffusion tensor imaging data at 200 μm resolution in meningioma tumors
* Code and data to the manuscript: **Brabec, J., Friedjungova, M., Vasata, D., Englund, E., Bengzon, J., Knutsson, L., van Zijl, P., Szczepankiewicz, F., Sundgren, P.C. and Nilsson, M., 2022. Coregistered H&E- and VEGF-stained histology slides with diffusion tensor imaging data at 200 μm resolution in meningioma tumors. Unpublished.**

* Contact: *jbrabec2 [at] jh [dot] edu*

# How to recompile the data
0. Download the data from AIDA repository and paste them into folder "data" at the same level as this directory. This directory contains both raw and processed data as well as an example analysis, see below "Data structure".
1. Process the raw DTI data by running script meningioma_pipe in folder Step_1_Process_DTI. Detailed instructions are in the readme file in the folder.
2. Create MR structure by running create_MR in the folder Step_2_Init.
3. Align approximately the histological slices with MR slices by running the script register in the folder Step_3_Coreg_rigid.
4. Coregister the MR to histology by landmark-based approach for each sample by running the script jb_wrap_MR2HE in the folder Step_4_Coreg_HE_fine. See details how to operate in the readme file in the folder the folder Step_4_Coreg_HE_fine.
5. Coregister the VEGF-stained histology to H&E-stained histology by running the script jb_wrap_VEGF2HE in the folder Step_5_Coreg_VEGF_to_HE for each sample.
6. You may see a sample analysis using cell density, structural anisotropy and by convolutional neuronal networks in the [repository related to our manuscript: Mean diffusivity and fractional anisotropy at the mesoscopic level in meningioma tumors: Relation with cell density and tissue anisotropy](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test)


# Data structure
The folder contains several 16 folders where each corresponds to a single tumor sample and folder DTI_raw containing raw data.
* raw_MR will c

* Licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
