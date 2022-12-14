# Manuscript: Coregistered H&E- and VEGF-stained histology slides with diffusion tensor imaging data at 200 μm resolution in meningioma tumors
* Code and data to the manuscript: **Brabec, J., Friedjungova, M., Vasata, D., Englund, E., Bengzon, J., Knutsson, L., van Zijl, P., Szczepankiewicz, F., Sundgren, P.C. and Nilsson, M., 2022. Coregistered H&E- and VEGF-stained histology slides with diffusion tensor imaging data at 200 μm resolution in meningioma tumors. Unpublished.**

* Contact: *jbrabec2 [at] jh [dot] edu*


# How to recreate the coregistered data from raw data
1. Clone this repository to Your computer. Analysis performed with MATLAB version R2020a so make sure you have installed MATLAB first.
2. Download the data from [AIDA repository](https://aida-doi-repository.github.io) and paste them into folder "data" at the same level as this directory (microimaging_histology_DIB). This directory contains both raw and processed data as well as data related to our [example analysis from our other manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test). See below "Data structure" for detailed explanation of the content.
3. The .svs files of the histology slides from the pathology slide scanner were saved as .tif files using [ImageJ program with Bioformat plugin](https://imagej.nih.gov/ij/index.html) (Autoscale option on).
4. Clone [Multidimensional diffusion MRI repository](https://github.com/markus-nilsson/md-dmri), run *setup_paths* and process the raw DTI data by running script "meningioma_pipe" in the folder Step_1_Process_DTI from this repository.
5. Create MR structure by running *create_MR* in the folder Step_2_Init.
6. Align approximately the histological slices with MR slices by running the script *register* in the folder Step_3_Coreg_rigid.
7. Coregister the MR to histology by landmark-based approach for each sample by running the script *jb_wrap_MR2HE* in the folder Step_4_Coreg_HE_fine. See details how to operate in the readme file in the folder the folder Step_4_Coreg_HE_fine.
8. Coregister the VEGF-stained histology to H&E-stained histology by running the script *jb_wrap_VEGF2HE* in the folder Step_5_Coreg_VEGF_to_HE for each sample.
9. You may see a sample analysis using cell density, structural anisotropy and by convolutional neuronal networks in the [repository related to our manuscript: Mean diffusivity and fractional anisotropy at the mesoscopic level in meningioma tumors: Relation with cell density and tissue anisotropy](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test)


# Data structure
The folder contains several 16 folders where each corresponds to a single tumor sample and folder DTI_raw containing raw data.
Each sample (1-16) has following folders:
* raw_histo folder contains .svs files as well as .tif files of the histology as scanned by the digital pathology slides scanner and metadata
* raw_MR folder contains DTI maps prior to coregistration saved in .mat file.
* coreg_rigid folder contains approximately aligned histology with MR.
* coreg_fine folder contains coregistered DTI images in MR.mat, cropped H&E in HE.mat, defined landmarks in HE_lm_fine.mat and structure anisotropy map that helped to coregister the images in the file aniso2coreg.mat (see [our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test)).
* cell_density folder contains QuPath projects and cell nuclei detected (see [our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test)).
* structure_anisotropy folder contains structure anisotropy maps (see [our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test)).


* Licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
