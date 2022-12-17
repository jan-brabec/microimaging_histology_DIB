# Manuscript: Coregistered H&E- and VEGF-stained histology slides with diffusion tensor imaging data at 200 μm resolution in meningioma tumors
* Code and data to the manuscript: **Brabec, J., Friedjungova, M., Vasata, D., Englund, E., Bengzon, J., Knutsson, L., van Zijl, P., Szczepankiewicz, F., Sundgren, P.C. and Nilsson, M., 2022. Coregistered H&E- and VEGF-stained histology slides with diffusion tensor imaging data at 200 μm resolution in meningioma tumors. Unpublished.**

* Contact: *jbrabec2 [at] jh [dot] edu*


## How to open data
* Most of the data can be opened in MATLAB environment because most of the data are stored as .mat -v7.3 format. This provides faster reading and writing of large files compared with storing them as .tiff files, at least when working in the MATLAB environment.
* The data can opened using free software [Octave](https://octave.org) and stored as images (.tiff for example, image format without compression)

```
load filename.mat %Often HE.mat or VEGF.mat
imwrite(HE,'filename_tiff','tiff') %Often the structure name is HE, VEGF etc
```

* The data can also be opened in Python by using mat73 module

```
pip install mat73 #If you did not have mat73 installed
import mat73 #Imports the mat73 module
data = mat73.loadmat('filename.mat') #Opens the file with name 'filename.mat'
```

## Data structure
The folder contains several 16 folders where each corresponds to a single tumor sample and folder DTI_raw containing raw data.
Each sample (1-16) has following folders:
* raw_histo folder contains multi-image .tiff files of the histology as scanned by the digital pathology slides scanner. The .tiff files provide 3 images with red, green and blue channels separated into three different images. The metadata obtained during the digitalization of the slices are stored in the "metadata_HE.csv" or "metadata_VEGF.csv".
* raw_MR folder contains DTI maps prior to coregistration saved in .mat file.
* coreg_rigid folder contains approximately aligned histology with MR.
* coreg_fine folder contains coregistered DTI images in MR.mat, cropped H&E in HE.mat, defined landmarks in HE_lm_fine.mat and structure anisotropy map that helped to coregister the images in the file aniso2coreg.mat (see [our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test)).
* cell_density folder contains QuPath projects and cell nuclei detected (see [our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test)).
* structure_anisotropy folder contains structure anisotropy maps (see [our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test)).


## How to recreate the coregistered data from raw data
1. Clone this repository to Your computer. Analysis was performed with MATLAB version R2020a so make sure you have installed MATLAB first. If you do not have access to MATLAB, you may try using [Octave](https://octave.org) but some functionality may not be supported.
2. Download the data from [AIDA repository](https://aida-doi-repository.github.io) and paste them into folder "data" at the same level as this directory (microimaging_histology_DIB). This directory contains both raw and processed data as well as data related to our [example analysis from our other manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test). See below "Data structure" for detailed explanation of the content.
3. The .svs files of the histology slides from the pathology slide scanner were saved as .tif files using [ImageJ](https://imagej.nih.gov/ij/index.html) but you also need to install [Bioformat plugin](https://docs.openmicroscopy.org/bio-formats/5.8.2/users/imagej/installing.htmlhttps://docs.openmicroscopy.org/bio-formats/5.8.2/users/imagej/installing.html) (Autoscale option on) and here, the channels (red, green, blue). were separated into three images within a single .tiff file. The svs files are, however, not provided, because they contains patient metadata. The metadata from the slide scanner are provided in the file "
4. Clone [Multidimensional diffusion MRI repository](https://github.com/markus-nilsson/md-dmri), run *setup_paths* and process the raw DTI data by running script *meningioma_pipe* in the folder Step_1_Process_DTI from this repository.
5. Create MR structure by running *create_MR* in the folder Step_2_Init.
6. Align approximately the histological slices with MR slices by running the script *register* in the folder Step_3_Coreg_rigid.
7. Coregister the MR to histology by landmark-based approach for each sample by running the script *jb_wrap_MR2HE* in the folder Step_4_Coreg_HE_fine. See details how to operate in the readme file in the folder the folder Step_4_Coreg_HE_fine.
8. Coregister the VEGF-stained histology to H&E-stained histology by running the script *jb_wrap_VEGF2HE* in the folder Step_5_Coreg_VEGF_to_HE for each sample.
9. You may see a sample analysis using cell density, structural anisotropy and by convolutional neuronal networks in the [repository related to our manuscript: Mean diffusivity and fractional anisotropy at the mesoscopic level in meningioma tumors: Relation with cell density and tissue anisotropy](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas_test)






# Others
* Licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
