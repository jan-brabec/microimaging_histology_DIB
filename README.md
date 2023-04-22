# Manuscript: Coregistered histology sections with diffusion tensor imaging data at 200 μm resolution in meningioma tumors
* Code and data to the manuscript: **Brabec, J., Englund, E., Bengzon, J., Szczepankiewicz, F., van Westen, D., Sundgren, P.C., Nilsson, M., 2022. Coregistered H&E- and VEGF-stained histology slides with diffusion tensor imaging data at 200 μm resolution in meningioma tumors. Unpublished.**

* Contact: *jbrabec2 [at] jh [dot] edu*

## Objective

To facilitate the investigation of the biological underpinnings of DTI parameters, such as mean diffusivity (MD) or fractional anisotropy (FA), we performed ex-vivo diffusion tensor imaging (DTI) at 200 μm isotropic resolution on 16 excised meningioma tumor samples and coregistered them to the corresponding histology slides. Hereby, we provide the data, coregistration tool as well as processing pipeline. To show the potential of the data, we performed also an [example analysis using this data in our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas).

## How to obtain data
1. Clone this repository to Your machine.
2. Download the data from [AIDA repository](https://datahub.aida.scilifelab.se/10.23698/aida/micromen) and paste them into folder **data** one level above this directory (**microimaging_histology_DIB**). The [AIDA repository](https://datahub.aida.scilifelab.se/10.23698/aida/micromen) contains both raw and processed data as well as data related to our [example analysis from our other manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas).
3. You may also clone our [example analysis](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas) a folder on the same level as **microimaging_histology_DIB**.


## Data formats and how to read them
* Raw histological slides are stored as multi-image *.tif* files with separated RGB channels. We recommend viewing them using MATLAB:

```
H(:,:,1) = imread('filename.tif'),'Index',1);
H(:,:,2) = imread('filename.tif'),'Index',2);
H(:,:,3) = imread('filename.tif'),'Index',3);

imagesc(H);
axis image off;
```

* We have prepared a function that allows you to view coregistered H&E-, VEGF-stained histology section with mean diffusivity and in-plane fractional anisotropy (FAIP) maps. The function allows also one to zoom-in also on particular regions of the histology of the DTI map by clicking on one of the maps. Navigate yourself to the folder **Step_5_View_data**

```
view_HE_VEGF_MR(sample)
```

* Raw DTI images are stored as compressed *.nii.gz* files. These can be viewed e.g. by GUI in [Multidimensional Diffusion MRI software](https://github.com/markus-nilsson/md-dmri).

```
%Clone repository first from https://github.com/markus-nilsson/md-dmri 
run setup_paths %Sets paths into the environment
mgui %Opens GUI
```
* Processed MR and histological slides are stored as *.mat* files and larger ones as *.mat -v7.3* files. The reason for choosing *.mat -v7.3* was that it provided faster reading and writing compared with storing them as *.tif* files, at least for the MATLAB environment.
  * The *.mat (-v7.3)* can be opened using MATLAB which necessitates a license but also by a free software [Octave](https://octave.org). The images in Octave can be stored as *.tif* images instead (or other image formats without compression):

```
load filename.mat %HE.mat or VEGF.mat or similar
imwrite(HE,'filename_tif','tif') %Often the structure name is HE, VEGF or similar
```

  * The data can also be opened in Python by using the mat73 module:

```
pip install mat73 #If you did not have mat73 installed
import mat73 #Imports the mat73 module
data = mat73.loadmat('filename.mat') #Opens the file with name 'filename.mat'
```

## Data structure
* The data folder contains 16 folders numbered **1** to **16** where each corresponds to individual meningioma tumor samples. For each sample (**1-16**) you will find following sub-folders:
  * **raw_histo** folder that contains multi-image *.tif* files of the histology sections as scanned by the digital pathology slides scanner. The *.tif* files provide 3 images with red, green, and blue channels separated into three different images. The metadata obtained during the digitalization of the slices is stored in the *Metadata_HE.csv* and *metadata_VEGF.csv*. Samples 1, 3 and 11 do not contain VEGF- but only H&E-stained histology slides because the VEGF files were corrupted during saving from the pathology slide scanner. Sample 12 does not contain metadata for the HE-stained histology slide (the file was deleted by mistake).
  * **init_MR** sub-folder that contains DTI maps of a single slice before coregistration saved as *.mat* file.
  * **coreg_rigid** sub-folder that contains approximately aligned histology with MR.
  * **coreg_fine** sub-folder that contains coregistered DTI images in *MR.mat*, cropped H&E in *HE.mat*, defined landmarks in *HE_lm_fine.mat*, and structure anisotropy map that helped to coregister the images in the file *aniso2coreg.mat* (see [our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas)).
  * **cell_density** sub-folder that contains QuPath project with cell nuclei detected (see [our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas)).
  * **structure_anisotropy** sub-folder that contains structure anisotropy maps (see [our manuscript](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas)).
* The data folder also contains **DTI_raw**.
  * **raw** sub-folder that contains raw *.nii* files from the two measurements of the sample holder (upper part and lower part of the sample holder)
  * **processed** sub-folder that contains processed raw DTI data by our DTI pipeline. See [Step_1_Process_DTI](https://github.com/jan-brabec/microimaging_histology_DIB/tree/main/Step_1_Process_DTI).

## Summary of the DTI maps coregistered to the H&E-stained histology images.
* These are stored in the *MR* structure in *MR.mat* and contain
  * Calculated maps: S0 map, mean diffusivity (*MD*), fractional anisotropy (*FA*), in-plane fractional anisotropy (*FAIP*), axial diffuvisity (*AD*), radial diffusivity (*RD*).
  * Orientationally averaged diffusion-weighted data at 100 s/mm2 (single measurement), 1000 s/mm2 (averaged across 6 directions) and 3000 s/mm2 (also averaged across six directions) stored in the field *PA*.
  * All 13 diffusion-weighted measurements before averaging or calculating maps stored in the field *DWI*.

## How to recreate the coregistered data from raw data

### Step 0: Preparations
1. Analysis was performed with MATLAB version R2020a so make sure you have installed MATLAB. If you do not have a license for MATLAB, some of the MATLAB functionalities may be supported by free software [Octave](https://octave.org).
2. Clone [Multidimensional diffusion MRI repository](https://github.com/markus-nilsson/md-dmri) and run *setup_paths*.
3. Modify *dti_lls_4d_fit2param* function stored in file *mdm-dmri/methods/dti_llsdti_lls_4d_fit2param.m*. This is needed to save the estimated full diffusion tensor which is important later on for the calculation of the in-plane FA (FAIP). Add line the following code anywhere after line 24

```
dps.fulldt = dt_1x6; %paste anywhere below line 24 in the script mdm-dmri/methods/dti_llsdti_lls_4d_fit2param.m
```

### Step 1: Initialize
4. Process the raw DTI data by running script *a_DTI_meningiomas_pipeline* in the folder **Step_1_init** from this repository.
5. Create MR structure for the coregistration by running script *b_create_MR* in the folder **Step_1_init**. This will create **init_MR** folder.
6. Create thumbnails for the H&E and VEGF-stained histology by running *c_create_histo_thumbnail.m*. This will create thumbnails in the **raw_histo** folder to give a quick overview of the data.

### Step 2: Landmark-based rigid coregistration of H&E and VEGF images to MRI
7. Align approximately the histological slices with MR slices by running the script *register* in the folder **Step_3_Coreg_rigid**. See details in the section [Details of rigid coregistration](https://github.com/jan-brabec/microimaging_histology_DIB/blob/main/README.md#details-of-rigid-coregistration-step-2) below.

### Step 3: Landmark-based deformable coregistration of MRI to H&E images
8. Coregister the MR to histology sections by landmark-based approach for each sample by running the script *a_Coreg_fine_MR_to_HE* in the folder **Step_4_Coreg_HE_fine**. See further instructions below in the section [Details of land-mark based coregistration](https://github.com/jan-brabec/microimaging_histology_DIB/blob/main/README.md#details-of-landmark-based-deformable-coregistration-step-3) below.
9. Verify the position by *b_Validate_coregistration*. Click on either H&E or MRI image in the upper row and the bottom row will show zoom-in in the MRI image as well as the corresponding histology patch.
10. Create a mask around H&E imageby running *draw_HE_mask* in folder **Step_3_Coreg_HE_fine**.
11. Apply H&E mask to all coregistered images by *d_apply_HE_mask*. This will replace HE.mat files in the **Step_3_Coreg_HE_fine** with the same H&E but masked. This will also store downsampled H&E masks. For quantification analyses, it is useful to combine ROI around MR images with downsampled HE mask. This will make sure that only tumor regions are selected for the analysis.

### Step 4: Landmark-based rigid coregistration of VEGF to H&E images
12. Define landmarks on the H&E and VEGF maps by running script *a_Define_landmarks* in the folder **Step_5_Coreg_VEGF_to_HE**. The interface is the same as in the previous step but does not interpolate to obtain the deformable grid or register. Define landmarks and click 's' to save them.
13. Coregister the VEGF-stained histology to H&E-stained histology by running the script *b_Coregister_VEGF_to_HE*.
14. Investigate the quality of coregistration by running script *c_Validate_coregistration* and repeat defining newer landmarks if necessary.

### Step 5: View data
15. View the data by running the script *view_data* in the folder **Step_5_View_data**. Within this folder, you may also directly use the function

```
view_HE_VEGF_MR(sample)
```


### What next?
16. You may see a sample analysis using cell density, structural anisotropy, and convolutional neuronal networks in the [repository related to our manuscript: Mean diffusivity and fractional anisotropy at the mesoscopic level in meningioma tumors: Relation with cell density and tissue anisotropy](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas).

## Details of rigid coregistration (Step 2)
In this step, the histology image is rotated to approximately match the MR image without its shearing or image deformation. This is performed by running *Register* which performs the following steps:
* Basic rotation such as by 90 or 180 degrees: Rotations defined in *get_H_transform*.
* More precise rotation calculated from landmarks on DTI map (MD or FA) and histology images: landmark points defined in *get_landmarks*. Out of these, a more precise rotation angle is calculated. Since the goal is to define rotation angles only, these are often defined on the tumor borders visible in both H&E and MRI images.
* The validate quality of coregistration the script *Register* outputs an image in the main folder. Here, the overlap between the landmark is shown. 

## Details of landmark-based deformable coregistration (Step 3)
* Here, the image B (MRI) is coregisted to image A (H&E-stained histology section) by creating a deformable mesh grid over image B (MRI) based on defined landmarks. In this step, the the image A (H&E) is also cropped.
* These are defined both on both images in a way that we are certain that these landmarks are the same object in images A and B. For example, these can be tumor borders clearly visible on both histology and MRI image. Other within the tumors are high values of MD in MRI images and the presence of vessels in the H&E image.
* The landmark-based coregistration tool was written by Markus Nilsson (markus.nilsson@med.lu.se). Contact Markus e.g. further collaboration on the development of the tool.


### GUI
* The coregistration can be performed in GUI by running *Coreg_fine_MR_to_HE* in the folder **Step_4_Coreg_HE_fine**.

![alt text](https://github.com/jan-brabec/microimaging_histology_DIB/blob/main/Landmark_coregistration.png?raw=true)

The GUI has 6 subplots:
* In the left column, we can observe H&E images with defined 10 landmarks (white color) where the active (6th) landmark is presented with yellow color. Similarly, below we can observe MD images with the same landmarks.
* In the middle column we can observe a zoom-in on the active landmark in the H&E image (above) and MR (below) to fine-tune its position.
* In the right column we can observe a deformable grid. The upper row shows the grid over H&E. This is not deformed as the H&E image is only cropped. The bottom row shows the grid over the MR image (here MD). The grid is deformed based on the distance between the landmarks.

* The GUI can be controlled by:
  * a - add landmark.
  * d - delete landmark.
  * l - load landmark file.
  * s - save landmark file.
  * n - go to next landmark.
  * p - go to the previous landmark.
  * i - show the interpolation grid.
  * r - compute the final result and store it in the **coreg_fine** folder.

* We can also define landmarks based on FAIP and calculated structure anisotropy map. This we can do by exchanging the code in *Coreg_fine_MR_to_HE*

```
mn_reg_finetune(HE,MR.MD,lm_fn,o_pth,MR,'MR2HE',sample)
```

to this code

```
load(fullfile(o_pth,'aniso2coreg.mat'),'cFA') %this will load the calculated structure anisotropy map
mn_reg_finetune(cFA,MR.FAIP,lm_fn,o_pth,MR,'MR2HE',sample) %this will coregister FAIP map to structure anisotropy map
```

# Opening a QuPath project
[QuPath](https://qupath.github.io) is an open software for Bioimage analysis that was used to generate cell density maps from the related research article. However, it can also be used to view the histology slides - both raw or coregistered ones. Here we provide several suggestion for viewing the histology slides:

* Download and install the latest QuPath from: https://qupath.github.io (the version that was used to run the cell detection algorithm was version 0.23)
* Run QuPath and navigate yourself to: File -> Open.
* Open the project file of the specific sample (e.g. for sample 1 /data/1/cell_density/QuPath/project.qpproj).
* You will be asked to locate the HE.jpg file corresponding to this project. This is because when the project was created it was linked with an absolute but not relative path to this image. The image is located in the same folder as the project file, e.g.(e.g. for sample 1 /data/1/cell_density/QuPath/HE.jpg). This will load both the image as well as the cell nuclei detected.
* Since the images are large, loading of the images may take time and also requires a large amount of memory (RAM).
* You may want to see the scale bar (located in the left bottom corner by default) in real units instead of relative units (i.e. micrometers instead of pixels). If so, please modify following fields in the Image tab (this is located between Project and Annotation tabs): Pixel width and Pixel height. These can be set to 0.5 micrometers and 0.5 micrometers because at this resolution the histology slides were digitalized. Afterward, the scale bar will show micrometers instead of pixels.
* If you want to view also the coregistered VEGF-stained histology section (which are stored as .mat -v7.3 files in the database) in QuPath you will need to save these images in a QuPath readable format. QuPath can visualize .jpg files and you can modify the script [save_qupath](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas/blob/main/Step_a_Analyze_CD/save_qupath.m) to save the VEGF images as .jpg files. QuPath may be able to read also .tif files. We have not added this optionality into QuPath because we have analyzed cell density from H&E-stained images only in our [related research article](https://github.com/jan-brabec/microimaging_vs_histology_in_meningeomas). Please note that we could not provide a VEGF-stained histology section for tumor samples: 1, 3, and 11 because the files were corrupted during the digitalization.

## Additional notes
* The histology slide scanner provided histology slides in *.svs* format. These were later saved as *.tif* files using [ImageJ](https://imagej.nih.gov/ij/index.html) (version 1.53t) with [Bioformat plugin](https://docs.openmicroscopy.org/bio-formats/5.8.2/users/imagej/installing.html) (version 6.11.1) that needs to be installed separately. Alternatively, they can be saved as *.tif* using [Fiji](https://imagej.net/software/fiji/downloads) which is one of the distributions of ImageJ containing the Bioformat plugin. The red, green, and blue channels were separated into three images within a single *.tif* file using the Autoscale option on. The *.svs* files are not provided because they contain important metadata. The metadata from the slide scanner is, however, provided in the file **raw_histo** as *Metadata_HE.csv* or *Metadata_VEGF.csv*.
* Samples 1, 3 and 11 do not contain VEGF- but only H&E-stained histology slides because the VEGF files were corrupted during saving from the pathology slide scanner.
* Sample 12 does not contain metadata for the HE-stained histology slide (the file was deleted by mistake).
* Licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
