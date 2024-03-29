function [Mp,Hp] = get_landmarks(sample,contrast)
% function [Mp,Hp] = untitled4(sample,contrast)
%    
% Returns landmarks positions.
% contrast = 1 for HE, contrast = 2 for EVG

%sample 1 HE
Mpa{1,1} = [84    36   ; 101   59  ; 103   92   ; 71    88    ; 59   69];
Hpa{1,1} = [15170 1698 ; 22560 9071; 25760 21040; 14180 21960 ; 9594 16230];
Hpa{1,1}(:,1) = Hpa{1,1}(:,1) + 1000;

%No EVG in sample 1

%sample 2 HE
Mpa{2,1} = [78    94   ; 59    90  ; 79    88   ; 36   77  ];
Hpa{2,1} = [17070 7624 ; 10780 6486; 17450 5576 ; 2659 3148];
Hpa{2,1}(:,2) = Hpa{2,1}(:,2) + 7000;

%sample 2 EVG

Mpa{2,2} = [78    94   ; 59    90  ; 79    88   ; 36   77  ];
Hpa{2,2} = [14110 18260; 8008 15330; 14760 16550; 526 11590];
Hpa{2,2}(:,1) = Hpa{2,2}(:,1) + 1000;

%sample 3 HE
Mpa{3,1} = [30   36   ; 78    34  ; 104   50  ; 109   91   ; 43    99   ; 75    56   ; 42    77   ; 72    87   ];
Hpa{3,1} = [3518 14670; 16980 2948; 28400 3560; 36660 14160; 20440 30280; 20850 11000; 15040 23650; 25540 20690];
Hpa{3,1}(:,1) = Hpa{3,1}(:,1) + 5000;

%sample 3 EVG
Mpa{3,2} = [30 36; 78 34; 104 50; 109 91; 44 102; 75 56; 42 77; 72 87 ];
Hpa{3,2} = [123 7670; 16990 580; 27750 4736; 32400 17450; 11860 28210; ...
        18220 9395; 8955 19875; 20310 20440 ];
 
%sample 4 HE
Mpa{4,1} = [29   38   ; 73    33   ; 103   45  ; 113   89   ; 46    98   ];
Hpa{4,1} = [535 23550; 10070  10460; 21210 6180; 33810 14900; 18470 33200];

%sample 4 EVG
Mpa{4,2} = [29   38   ; 73    33  ; 103   45  ; 113   89   ; 46    98   ];
Hpa{4,2} = [1313 13840; 13600 3132; 25370 1623; 35930 12940; 16090 27050];    
    
%sample 5 HE
Mpa{5,1} = [30   36  ; 73    29  ; 105   56   ; 112   82   ; 39   92   ];
Hpa{5,1} = [13410 204; 27630 9714; 30070 25400; 25440 34180; 2031 19060];
Hpa{5,1}(:,2) = Hpa{5,1}(:,2) + 1000;
    
%sample 5 EVG
Mpa{5,2} = [30    36 ; 73    29  ; 105   56   ; 112   82   ; 39   92   ];
Hpa{5,2} = [10680 117; 25440 8196; 29560 23270; 25440 32820; 1130 20080];
  
%sample 6 HE
Mpa{6,1} = [35   38   ; 92    35  ; 106   46   ; 112   82  ; 40   95   ];
Hpa{6,1} = [2625 11380; 22200 2991; 28340 5865; 34550 18290; 9927 30020];

%sample 6 EVG
Mpa{6,2} = [35   38  ; 92    35 ; 106   46  ; 112   82   ; 40   95   ];
Hpa{6,2} = [1310 8836; 20760 717; 26900 3514; 33100 15660; 8883 27870];
    
%sample 7 HE
Mpa{7,1} = [32   42   ; 83    38  ; 111   64  ; 112   87   ; 35   60   ];
Hpa{7,1} = [2726 10480; 18560 1489; 30470 5479; 35380 13350; 5893 15230];
    
%sample 7 EVG
Mpa{7,2} = [32   42  ; 83    38  ; 111   64  ; 112   87   ; 35   60   ];
Hpa{7,2} = [2222 7843; 19540 2633; 30440 8766; 33650 17610; 4284 13540];

%sample 8 HE
Mpa{8,1} = [35   40   ; 63    34  ; 110   54  ; 82    35   ; 110   67    ; 54    88   ; 38    89   ; 37    83   ; 86    87];
Hpa{8,1} = [18350 6055; 28240 2194; 44560 7752; 34260 2194 ; 45490 12080 ; 26770 21680; 20570 23550; 19810 21210; 38240 20390]; 

%sample 8 EVG
Mpa{8,2} = [35   40   ; 63    34  ; 110   54  ; 82    35   ; 110   67  ; 54    88   ; 38    89  ; 37    83  ; 86    87];
Hpa{8,2} = [2237 10280; 10740 4404; 28220 5774; 17270 2773 ; 30180 9753; 14000 23390; 8133 26710; 7480 24630; 25750 19020]; 

%sample 9 HE
Mpa{9,1} = [31   47   ; 79    39  ; 102   57  ; 110   94   ; 40   107   ];
Hpa{9,1} = [1598 14860; 15240 2156; 26290 2705; 36560 12980; 18140 33050];
    
%sample 9 EVG
Mpa{9,2} = [31   47   ; 79    39  ; 102   57  ; 110   94   ; 40   107   ];
Hpa{9,2} = [2044 21140; 11540 5216; 22120 2393; 34750 9530 ; 23060 33610];
    
%sample 10 HE
Mpa{10,1} = [33   41   ; 88    35  ; 110   49  ; 115   90   ; 46   101  ; 40    96];
Hpa{10,1} = [1324 29540; 2717  8324; 10070 1897; 26290 2705; 24320 28070; 21140 31240];
Hpa{10,1}(:,1) = Hpa{10,1}(:,1) + 5000;

%sample 10 EVG
Mpa{10,2} = [33   41   ; 88   35  ; 110   49  ; 115   90   ; 46   101   ; 40    96];
Hpa{10,2} = [1542 24850; 8317 4750; 17150 405 ; 32320 5486 ; 24440 29050; 19950 31180];

%sample 11 HE
Mpa{11,1} = [31    43 ; 56    45  ; 66    44  ; 91    47   ; 102   57   ; 83    77   ; 40    54  ; 37    69  ; 67   105 ];
Hpa{11,1} = [15200 489; 21440 7399; 23390 9502; 28420 17610; 28420 23100; 18430 22270; 14220 4620; 10020 7850; 7464 22870];
    
%No EVG for sample 11

%sample 12 HE
Mpa{12,1} = [36   40   ; 79    39  ; 106   53  ; 110   94   ; 42    97   ];
Hpa{12,1} = [1426 19360; 11890 7427; 23900 4580; 33520 13660; 17740 31670];
    
%sample 12 EVG
Mpa{12,2} = [36   40   ; 79    39  ; 106   53  ; 110   94   ; 42    97   ];
Hpa{12,2} = [1426 19360; 10100 6338; 21330 1775; 32260 9381 ; 19010 30020];
   
%sample 13 HE
Mpa{13,1} = [35   81   ; 103   94   ; 75    35   ; 69    76   ];
Hpa{13,1} = [5740 6949 ; 15050 29410; 28880 13940; 15050 15210];

%sample 13 EVG
Mpa{13,2} = [35   81   ; 103   94   ; 75    35   ; 69    76   ];
Hpa{13,2} = [2573 21900; 27160 23530; 19410 3973; 13780 17690];
    
%sample 14 HE
Mpa{14,1} = [45   42   ; 78    36  ; 106   50  ; 110   94  ; 52    101   ];
Hpa{14,1} = [1426 19360; 7706  5976; 16900 2789; 28570 8294; 20310 29010];
    
%sample 14 EVG
Mpa{14,2} = [45   42   ; 78    36  ; 106   50   ; 110   94   ; 52    101  ];
Hpa{14,2} = [1701 11120; 13290 2499; 23940 4890 ; 31330 14890; 14160 29300];
    
%sample 15 HE
Mpa{15,1} = [32   44   ; 83    38 ; 102   44  ; 114   90   ; 47    100  ];
Hpa{15,1} = [2582 23320; 9117 6498; 15280 1015; 31800 5296 ; 23010 28060];
    
%sample 15 EVG
Mpa{15,2} = [32   44   ; 83    38 ; 102   44  ; 114   90   ; 47    100  ];
% Hpa{15,2} = [1097 25020; 6869 7504; 13180 2004; 30160 5331 ; 21810 28560];
% Hpa{2,1}(:,2) = Hpa{2,1}(:,2) + 3000;
% Hpa{2,1}(:,1) = Hpa{2,1}(:,1) + 3000;

Hpa{15,2} = [7113 3656;25390 9838 ; 31360 15970; 27380 33490; 4425 25270  ];

    
%sample 16 HE
Mpa{16,1} = [34   43   ; 86     37 ; 109   54  ; 110   94   ; 40    100  ];
Hpa{16,1} = [3491 12350; 21340 3708; 31200 7538; 36170 21390; 12290 32960];
    
%sample 16 EVG
Mpa{16,2} = [34   43   ; 86    37  ; 109   54  ; 110   94   ; 40    100  ];
Hpa{16,2} = [1306 7229 ; 20860 2285; 29700 7828; 32090 22290; 6400  29250];
   




    
Mp = Mpa{sample,contrast};
Hp = Hpa{sample,contrast};
    


end

