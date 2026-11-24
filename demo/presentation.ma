//Maya ASCII 2026 scene
//Name: presentation.ma
//Last modified: 二, 11月 24, 2026 07:18:40 上午
//Codeset: UTF-8
requires maya "2026";
currentUnit -l centimeter -a degree -t film;
fileInfo "application" "maya";
fileInfo "product" "Maya 2026";
fileInfo "version" "2026";
fileInfo "cutIdentifier" "202502240946-c910a8ba47";
fileInfo "osv" "Mac OS X 21.2.1";
fileInfo "UUID" "B5CB1585-9D47-EA84-A788-4CA0E5FC287C";
createNode transform -s -n "persp";
	rename -uid "C68C9EAA-414B-AC51-103D-BCB6FEB1EA06";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 28 21 28 ;
	setAttr ".r" -type "double3" -27.938352729602379 44.999999999999972 -5.172681101354183e-14 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "BAEF1CC6-BB44-3AC2-EBA6-AB954BADC34C";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".fl" 34.999999999999993;
	setAttr ".coi" 44.82186966202994;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".hc" -type "string" "viewSet -p %camera";
createNode transform -s -n "top";
	rename -uid "28D48758-024D-AE5A-7A70-44BB37251542";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "772A04BD-C84D-12F6-4717-3FB5F610C08B";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
createNode transform -s -n "front";
	rename -uid "8F40DD64-4D45-331E-0266-EDA332A21128";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "1843978F-504C-F864-DD95-F28E9F84431E";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
createNode transform -s -n "side";
	rename -uid "AA655ED9-BA40-DF83-C632-B4B1C6DACCA5";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "08940F81-D849-8AA1-6687-73AD62F4308E";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
createNode transform -n "roofA_building";
	rename -uid "E118ADD9-8D44-D683-3CB3-A5894D79BB6E";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" -320 -1000 -20 ;
	setAttr ".sp" -type "double3" -320 -1000 -20 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "roofA_buildingShape" -p "roofA_building";
	rename -uid "3E1D1AB5-BD4C-86B6-4DCD-E9A237026371";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" -2.43888855 -22.2166748
		 2.8944397 -22.2166748 2.8944397 0.0055555701 -2.43888855 0.0055555701 -2.8833313
		 -22.2166748 2.44999695 -22.2166748 2.44999695 0.0055555701 -2.8833313 0.0055555701
		 -6.88336182 -2.43888855 -0.21666718 -2.43888855 -0.21666718 2.8944397 -6.88336182
		 2.8944397 -6.88336182 -2.8833313 -0.21666718 -2.8833313 -0.21666718 2.44999695 -6.88336182
		 2.44999695 -6.88336182 -22.2166748 -0.21666718 -22.2166748 -0.21666718 0.0055555701
		 -6.88336182 0.0055555701 -6.88336182 0.0055555701 -0.21666718 0.0055555701 -0.21666718
		 22.2277832 -6.88336182 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  -620 -2000 220 -20 -2000 220 -620 0 220 -20 0 220
		 -620 0 -260 -20 0 -260 -620 -2000 -260 -20 -2000 -260;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "roofB_building";
	rename -uid "8F5D7516-7A4C-9287-0441-E9B46DD8BE53";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" 435 -1015 -50 ;
	setAttr ".sp" -type "double3" 435 -1015 -50 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "roofB_buildingShape" -p "roofB_building";
	rename -uid "886EFD87-0248-4696-90E9-10BFB05D11B2";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" -2.21665955 -22.2166748
		 3.33889771 -22.2166748 3.33889771 -0.32777786 -2.21665955 -0.32777786 -3.32778931
		 -22.2166748 2.2277832 -22.2166748 2.2277832 -0.32777786 -3.32778931 -0.32777786 1.22777557
		 -2.21665955 8.45001221 -2.21665955 8.45001221 3.33889771 1.22777557 3.33889771 1.22777557
		 -3.32778931 8.45001221 -3.32778931 8.45001221 2.2277832 1.22777557 2.2277832 1.22777557
		 -22.2166748 8.45001221 -22.2166748 8.45001221 -0.32777786 1.22777557 -0.32777786
		 1.22777557 0.33888817 8.45001221 0.33888817 8.45001221 22.2277832 1.22777557 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  110 -2000 200 760 -2000 200 110 -30 200 760 -30 200
		 110 -30 -300 760 -30 -300 110 -2000 -300 760 -2000 -300;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "roofA_top";
	rename -uid "CD33CF36-2B48-A287-9DFD-179BF24E5F5D";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".t" -type "double3" -320 4 -20 ;
	setAttr ".toonLook" -type "string" "pop_ground";
createNode mesh -n "roofA_topShape" -p "roofA_top";
	rename -uid "F847FFD4-CB40-4382-BCD7-A69E6EB4EF68";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "roofB_top";
	rename -uid "8F02FC57-7C41-C8AD-93F6-5D90F9F373EC";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".t" -type "double3" 435 -26 -50 ;
	setAttr ".toonLook" -type "string" "pop_ground";
createNode mesh -n "roofB_topShape" -p "roofB_top";
	rename -uid "5BA60E2E-0446-80F7-01AC-1289942A5A58";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "skyline_near";
	rename -uid "139C6F41-1C46-E5D7-9622-31BD96CA00DD";
	setAttr ".rp" -type "double3" -170 -590 -1310 ;
	setAttr ".sp" -type "double3" -170 -590 -1310 ;
createNode transform -n "tower_0" -p "skyline_near";
	rename -uid "8F81DCCA-DC4E-DB70-58CD-229F23161E6B";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" -1375 -810 -1050 ;
	setAttr ".sp" -type "double3" -1375 -810 -1050 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tower_0Shape" -p "tower_0";
	rename -uid "086904CA-8D48-0A2B-711F-ED99A802B124";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 10.0055541992 -22.2166748
		 13.33886719 -22.2166748 13.33886719 4.2277832 10.0055541992 4.2277832 -13.32775879
		 -22.2166748 -9.9944458 -22.2166748 -9.9944458 4.2277832 -13.32775879 4.2277832 -16.66113281
		 10.0055541992 -13.88330078 10.0055541992 -13.88330078 13.33886719 -16.66113281 13.33886719
		 -16.66113281 -13.32775879 -13.88330078 -13.32775879 -13.88330078 -9.9944458 -16.66113281
		 -9.9944458 -16.66113281 -22.2166748 -13.88330078 -22.2166748 -13.88330078 4.2277832
		 -16.66113281 4.2277832 -16.66113281 -4.2166748 -13.88330078 -4.2166748 -13.88330078
		 22.2277832 -16.66113281 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  -1500 -2000 -900 -1250 -2000 -900 -1500 380 -900
		 -1250 380 -900 -1500 380 -1200 -1250 380 -1200 -1500 -2000 -1200 -1250 -2000 -1200;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "tower_2" -p "skyline_near";
	rename -uid "5E152DE8-C846-93A5-9F40-649EA2D43EA5";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" -800 -850 -1570 ;
	setAttr ".sp" -type "double3" -800 -850 -1570 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tower_2Shape" -p "tower_2";
	rename -uid "02FF9478-7F43-77FA-AACB-BBB11E12B4AE";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 15.7833252 -22.2166748
		 19.11669922 -22.2166748 19.11669922 3.33889771 15.7833252 3.33889771 -19.10559082
		 -22.2166748 -15.7722168 -22.2166748 -15.7722168 3.33889771 -19.10559082 3.33889771
		 -9.9944458 15.7833252 -7.7722168 15.7833252 -7.7722168 19.11669922 -9.9944458 19.11669922
		 -9.9944458 -19.10559082 -7.7722168 -19.10559082 -7.7722168 -15.7722168 -9.9944458
		 -15.7722168 -9.9944458 -22.2166748 -7.7722168 -22.2166748 -7.7722168 3.33889771 -9.9944458
		 3.33889771 -9.9944458 -3.32778931 -7.7722168 -3.32778931 -7.7722168 22.2277832 -9.9944458
		 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  -900 -2000 -1420 -700 -2000 -1420 -900 300 -1420
		 -700 300 -1420 -900 300 -1720 -700 300 -1720 -900 -2000 -1720 -700 -2000 -1720;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "tower_4" -p "skyline_near";
	rename -uid "53EFC4C6-DA41-D74D-20A4-249F2045E0DD";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" -210 -740 -1310 ;
	setAttr ".sp" -type "double3" -210 -740 -1310 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tower_4Shape" -p "tower_4";
	rename -uid "7F86A441-8B41-4B9E-C982-F7A188E958B8";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 12.89440918 -22.2166748
		 16.2277832 -22.2166748 16.2277832 5.7833252 12.89440918 5.7833252 -16.2166748 -22.2166748
		 -12.88330078 -22.2166748 -12.88330078 5.7833252 -16.2166748 5.7833252 -3.32778931
		 12.89440918 -1.32777405 12.89440918 -1.32777405 16.2277832 -3.32778931 16.2277832
		 -3.32778931 -16.2166748 -1.32777405 -16.2166748 -1.32777405 -12.88330078 -3.32778931
		 -12.88330078 -3.32778931 -22.2166748 -1.32777405 -22.2166748 -1.32777405 5.7833252
		 -3.32778931 5.7833252 -3.32778931 -5.7722168 -1.32777405 -5.7722168 -1.32777405 22.2277832
		 -3.32778931 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  -300 -2000 -1160 -120 -2000 -1160 -300 520 -1160
		 -120 520 -1160 -300 520 -1460 -120 520 -1460 -300 -2000 -1460 -120 -2000 -1460;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "tower_6" -p "skyline_near";
	rename -uid "BEA3040E-6E43-B371-4E18-E6898F839361";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" 410 -680 -1050 ;
	setAttr ".sp" -type "double3" 410 -680 -1050 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tower_6Shape" -p "tower_6";
	rename -uid "7D9E5157-2A45-AABB-5AF7-C684668E7BCD";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 10.0055541992 -22.2166748
		 13.33886719 -22.2166748 13.33886719 7.11663818 10.0055541992 7.11663818 -13.32775879
		 -22.2166748 -9.9944458 -22.2166748 -9.9944458 7.11663818 -13.32775879 7.11663818
		 3.33889771 10.0055541992 5.7833252 10.0055541992 5.7833252 13.33886719 3.33889771
		 13.33886719 3.33889771 -13.32775879 5.7833252 -13.32775879 5.7833252 -9.9944458 3.33889771
		 -9.9944458 3.33889771 -22.2166748 5.7833252 -22.2166748 5.7833252 7.11663818 3.33889771
		 7.11663818 3.33889771 -7.10552979 5.7833252 -7.10552979 5.7833252 22.2277832 3.33889771
		 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  300 -2000 -900 520 -2000 -900 300 640 -900
		 520 640 -900 300 640 -1200 520 640 -1200 300 -2000 -1200 520 -2000 -1200;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "tower" -p "skyline_near";
	rename -uid "4E6C43C2-ED47-F1ED-62E6-2C90C675D5F3";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" 1030 -590 -1570 ;
	setAttr ".sp" -type "double3" 1030 -590 -1570 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "towerShape" -p "|skyline_near|tower";
	rename -uid "E11A96E1-DD42-C798-FF9C-17967CBFF04C";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 15.7833252 -22.2166748
		 19.11669922 -22.2166748 19.11669922 9.11663818 15.7833252 9.11663818 -19.10559082
		 -22.2166748 -15.7722168 -22.2166748 -15.7722168 9.11663818 -19.10559082 9.11663818
		 10.0055541992 15.7833252 12.89440918 15.7833252 12.89440918 19.11669922 10.0055541992
		 19.11669922 10.0055541992 -19.10559082 12.89440918 -19.10559082 12.89440918 -15.7722168
		 10.0055541992 -15.7722168 10.0055541992 -22.2166748 12.89440918 -22.2166748 12.89440918
		 9.11663818 10.0055541992 9.11663818 10.0055541992 -9.10552979 12.89440918 -9.10552979
		 12.89440918 22.2277832 10.0055541992 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  900 -2000 -1420 1160 -2000 -1420 900 820 -1420
		 1160 820 -1420 900 820 -1720 1160 820 -1720 900 -2000 -1720 1160 -2000 -1720;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "skyline_far";
	rename -uid "6DBA1606-8D45-9A7D-B70E-8BAFFDC658B1";
	setAttr ".rp" -type "double3" 160 -450 -1310 ;
	setAttr ".sp" -type "double3" 160 -450 -1310 ;
createNode transform -n "tower_1" -p "skyline_far";
	rename -uid "AF6AE00E-5844-F859-F04B-1EB0FBD4B49B";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" -1080 -690 -1310 ;
	setAttr ".sp" -type "double3" -1080 -690 -1310 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tower_1Shape" -p "tower_1";
	rename -uid "DDABE5AA-814A-3F97-97A2-1DAE37FF7C46";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 12.89440918 -22.2166748
		 16.2277832 -22.2166748 16.2277832 6.89447021 12.89440918 6.89447021 -16.2166748 -22.2166748
		 -12.88330078 -22.2166748 -12.88330078 6.89447021 -16.2166748 6.89447021 -13.10559082
		 12.89440918 -10.88336182 12.89440918 -10.88336182 16.2277832 -13.10559082 16.2277832
		 -13.10559082 -16.2166748 -10.88336182 -16.2166748 -10.88336182 -12.88330078 -13.10559082
		 -12.88330078 -13.10559082 -22.2166748 -10.88336182 -22.2166748 -10.88336182 6.89447021
		 -13.10559082 6.89447021 -13.10559082 -6.88336182 -10.88336182 -6.88336182 -10.88336182
		 22.2277832 -13.10559082 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  -1180 -2000 -1160 -980 -2000 -1160 -1180 620 -1160
		 -980 620 -1160 -1180 620 -1460 -980 620 -1460 -1180 -2000 -1460 -980 -2000 -1460;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "tower" -p "skyline_far";
	rename -uid "4129DABA-1A45-0684-B3FA-F1BCC71D53CF";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" -500 -550 -1050 ;
	setAttr ".sp" -type "double3" -500 -550 -1050 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "towerShape" -p "|skyline_far|tower";
	rename -uid "000E110A-2044-BD63-9121-A8A77E880A7E";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 10.0055541992 -22.2166748
		 13.33886719 -22.2166748 13.33886719 10.0055541992 10.0055541992 10.0055541992 -13.32775879
		 -22.2166748 -9.9944458 -22.2166748 -9.9944458 10.0055541992 -13.32775879 10.0055541992
		 -6.88336182 10.0055541992 -4.2166748 10.0055541992 -4.2166748 13.33886719 -6.88336182
		 13.33886719 -6.88336182 -13.32775879 -4.2166748 -13.32775879 -4.2166748 -9.9944458
		 -6.88336182 -9.9944458 -6.88336182 -22.2166748 -4.2166748 -22.2166748 -4.2166748
		 10.0055541992 -6.88336182 10.0055541992 -6.88336182 -9.9944458 -4.2166748 -9.9944458
		 -4.2166748 22.2277832 -6.88336182 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  -620 -2000 -900 -380 -2000 -900 -620 900 -900
		 -380 900 -900 -620 900 -1200 -380 900 -1200 -620 -2000 -1200 -380 -2000 -1200;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "tower_5" -p "skyline_far";
	rename -uid "02459B73-D242-6BCF-1800-AE9C83D1F93A";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" 90 -450 -1570 ;
	setAttr ".sp" -type "double3" 90 -450 -1570 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tower_5Shape" -p "tower_5";
	rename -uid "8D48E079-4544-68C6-459F-6B82E6206B05";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 15.7833252 -22.2166748
		 19.11669922 -22.2166748 19.11669922 12.2277832 15.7833252 12.2277832 -19.10559082
		 -22.2166748 -15.7722168 -22.2166748 -15.7722168 12.2277832 -19.10559082 12.2277832
		 -0.43888855 15.7833252 2.44999695 15.7833252 2.44999695 19.11669922 -0.43888855 19.11669922
		 -0.43888855 -19.10559082 2.44999695 -19.10559082 2.44999695 -15.7722168 -0.43888855
		 -15.7722168 -0.43888855 -22.2166748 2.44999695 -22.2166748 2.44999695 12.2277832
		 -0.43888855 12.2277832 -0.43888855 -12.2166748 2.44999695 -12.2166748 2.44999695
		 22.2277832 -0.43888855 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  -40 -2000 -1420 220 -2000 -1420 -40 1100 -1420
		 220 1100 -1420 -40 1100 -1720 220 1100 -1720 -40 -2000 -1720 220 -2000 -1720;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "tower_7" -p "skyline_far";
	rename -uid "F0E4BD62-624C-F075-A313-B6AA1634DDA6";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" 710 -790 -1310 ;
	setAttr ".sp" -type "double3" 710 -790 -1310 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tower_7Shape" -p "tower_7";
	rename -uid "E36C82F9-8342-053B-FCB2-558B6B0E389C";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 12.89440918 -22.2166748
		 16.2277832 -22.2166748 16.2277832 4.67221069 12.89440918 4.67221069 -16.2166748 -22.2166748
		 -12.88330078 -22.2166748 -12.88330078 4.67221069 -16.2166748 4.67221069 6.67224121
		 12.89440918 9.11663818 12.89440918 9.11663818 16.2277832 6.67224121 16.2277832 6.67224121
		 -16.2166748 9.11663818 -16.2166748 9.11663818 -12.88330078 6.67224121 -12.88330078
		 6.67224121 -22.2166748 9.11663818 -22.2166748 9.11663818 4.67221069 6.67224121 4.67221069
		 6.67224121 -4.66110229 9.11663818 -4.66110229 9.11663818 22.2277832 6.67224121 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  600 -2000 -1160 820 -2000 -1160 600 420 -1160
		 820 420 -1160 600 420 -1460 820 420 -1460 600 -2000 -1460 820 -2000 -1460;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "tower_9" -p "skyline_far";
	rename -uid "EEFB41FD-3A48-D11B-8404-11BD6EEF3BC9";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".rp" -type "double3" 1370 -760 -1050 ;
	setAttr ".sp" -type "double3" 1370 -760 -1050 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tower_9Shape" -p "tower_9";
	rename -uid "677B0871-524A-8CD5-9C1F-F8A2067888AA";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 6 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "back";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 1 "f[2]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottom";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "f[3]";
	setAttr ".gtag[2].gtagnm" -type "string" "front";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 1 "f[0]";
	setAttr ".gtag[3].gtagnm" -type "string" "left";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "f[5]";
	setAttr ".gtag[4].gtagnm" -type "string" "right";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "f[4]";
	setAttr ".gtag[5].gtagnm" -type "string" "top";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 1 "f[1]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 24 ".uvst[0].uvsp[0:23]" -type "float2" 10.0055541992 -22.2166748
		 13.33886719 -22.2166748 13.33886719 5.33889771 10.0055541992 5.33889771 -13.32775879
		 -22.2166748 -9.9944458 -22.2166748 -9.9944458 5.33889771 -13.32775879 5.33889771
		 13.7833252 10.0055541992 16.67224121 10.0055541992 16.67224121 13.33886719 13.7833252
		 13.33886719 13.7833252 -13.32775879 16.67224121 -13.32775879 16.67224121 -9.9944458
		 13.7833252 -9.9944458 13.7833252 -22.2166748 16.67224121 -22.2166748 16.67224121
		 5.33889771 13.7833252 5.33889771 13.7833252 -5.32778931 16.67224121 -5.32778931 16.67224121
		 22.2277832 13.7833252 22.2277832;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 8 ".vt[0:7]"  1240 -2000 -900 1500 -2000 -900 1240 480 -900
		 1500 480 -900 1240 480 -1200 1500 480 -1200 1240 -2000 -1200 1500 -2000 -1200;
	setAttr -s 12 ".ed[0:11]"  0 1 0 2 3 0 4 5 0 6 7 0 0 2 0 1 3 0 2 4 0
		 3 5 0 4 6 0 5 7 0 6 0 0 7 1 0;
	setAttr -s 6 -ch 24 ".fc[0:5]" -type "polyFaces" 
		f 4 0 5 -2 -5
		mu 0 4 16 17 18 19
		f 4 1 7 -3 -7
		mu 0 4 8 9 10 11
		f 4 2 9 -4 -9
		mu 0 4 20 21 22 23
		f 4 3 11 -1 -11
		mu 0 4 12 13 14 15
		f 4 -12 -10 -8 -6
		mu 0 4 0 1 2 3
		f 4 10 4 6 8
		mu 0 4 4 5 6 7;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "water_tank";
	rename -uid "BDE880AC-2545-FDF2-65D4-EE8B0353FD3E";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".t" -type "double3" -480 120 -120 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "water_tankShape" -p "water_tank";
	rename -uid "B9D6909D-C84D-C9E5-E24A-0D9EDAA25EF1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "tank_stand";
	rename -uid "5CF55ED6-0346-4289-6054-ABB83DF79353";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".t" -type "double3" -480 38 -120 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tank_standShape" -p "tank_stand";
	rename -uid "852BD711-EE4D-64C6-9D64-2FA51FCFF745";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "tank_roof";
	rename -uid "AB00442C-E642-B6AA-72A6-539FC753263D";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".t" -type "double3" -480 195 -120 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "tank_roofShape" -p "tank_roof";
	rename -uid "12826E61-4E49-9F0F-C53E-A2A49E041BE6";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "antenna";
	rename -uid "875C8F94-FE45-F163-1DD3-438D03F46A76";
	addAttr -ci true -sn "toonLook" -ln "toonLook" -dt "string";
	setAttr ".t" -type "double3" 620 100 -200 ;
	setAttr ".toonLook" -type "string" "pop_comic";
createNode mesh -n "antennaShape" -p "antenna";
	rename -uid "4910BBCF-8346-502C-68E0-03A49FB0BB14";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "ac_unit0";
	rename -uid "927449F7-E04C-83CF-5D4E-2DB62F7A7F98";
	setAttr ".t" -type "double3" -260 30 -160 ;
createNode mesh -n "ac_unit0Shape" -p "ac_unit0";
	rename -uid "5211640F-9F4B-3E66-B16B-939B34866801";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "ac_unit1";
	rename -uid "C4C80DF3-CF44-1AEE-7A4C-45804343FEEA";
	setAttr ".t" -type "double3" -190 30 -160 ;
createNode mesh -n "ac_unit1Shape" -p "ac_unit1";
	rename -uid "8B73966F-AB4A-EA20-12AD-608ECD0B449D";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "ac_unit2";
	rename -uid "4E8ED405-134B-296C-04A9-36A85D398A48";
	setAttr ".t" -type "double3" 420 0 -180 ;
createNode mesh -n "ac_unit2Shape" -p "ac_unit2";
	rename -uid "B68B0634-BE4A-5BCB-717E-C78E2F1EAAFE";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "bean_GRP";
	rename -uid "6E968009-F743-24B9-F85A-EC979FE8F3E2";
	setAttr ".rp" -type "double3" -3.814697265625e-06 41 -3.814697265625e-06 ;
	setAttr ".sp" -type "double3" -3.814697265625e-06 41 -3.814697265625e-06 ;
createNode transform -n "bean_rig" -p "bean_GRP";
	rename -uid "72563D18-064E-31F2-2AFF-5588D031A68B";
	setAttr ".rp" -type "double3" -3.814697265625e-06 41 -3.814697265625e-06 ;
	setAttr ".sp" -type "double3" -3.814697265625e-06 41 -3.814697265625e-06 ;
createNode joint -n "bean_root_jnt" -p "bean_rig";
	rename -uid "DE61B2A1-A74C-CBE1-B4DC-FBB38E3D434C";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".bps" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
createNode joint -n "bean_mid_jnt" -p "bean_root_jnt";
	rename -uid "2D4EF5AD-6443-5961-FB06-368BE681C296";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".t" -type "double3" 0 22 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".bps" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 22 0 1;
createNode joint -n "bean_top_jnt" -p "bean_mid_jnt";
	rename -uid "7841F41C-1546-A645-6893-8E8E6B9BEB8D";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".t" -type "double3" 0 22 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".bps" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 44 0 1;
createNode joint -n "bean_end_jnt" -p "bean_top_jnt";
	rename -uid "DD06D4F4-F742-D889-1AB6-BCAA7C4F65EE";
	addAttr -ci true -sn "liw" -ln "lockInfluenceWeights" -min 0 -max 1 -at "bool";
	setAttr ".t" -type "double3" 0 18 0 ;
	setAttr ".mnrl" -type "double3" -360 -360 -360 ;
	setAttr ".mxrl" -type "double3" 360 360 360 ;
	setAttr ".bps" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 62 0 1;
createNode transform -n "bean_head" -p "bean_top_jnt";
	rename -uid "9D70E8DD-774F-577C-C44B-80BD2B924917";
	setAttr ".t" -type "double3" 0 22 0 ;
createNode mesh -n "bean_headShape" -p "bean_head";
	rename -uid "166B910A-2843-A681-9CC3-A882D530E87F";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "bean_eye_L" -p "bean_top_jnt";
	rename -uid "45C685FE-7248-949A-354D-63A558F1B5A5";
	setAttr ".t" -type "double3" 5.5 25 14.2 ;
	setAttr ".s" -type "double3" 1 1.5 0.6 ;
createNode mesh -n "bean_eye_LShape" -p "bean_eye_L";
	rename -uid "96162CD9-2346-A405-3CE2-06902FA26584";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "bean_eye_R" -p "bean_top_jnt";
	rename -uid "EAB99C79-BA4E-46DC-5BE6-8F8E82255C63";
	setAttr ".t" -type "double3" -5.5 25 14.2 ;
	setAttr ".s" -type "double3" 1 1.5 0.6 ;
createNode mesh -n "bean_eye_RShape" -p "bean_eye_R";
	rename -uid "52FD7C2E-884E-11BD-E25B-4E9E1B43AE18";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "bean_scarf" -p "bean_top_jnt";
	rename -uid "895F6C7B-6347-D232-415F-C49FC53786E1";
	setAttr ".t" -type "double3" 0 6 0 ;
createNode mesh -n "bean_scarfShape" -p "bean_scarf";
	rename -uid "C6944599-8742-18AE-768C-B1ABAAD5B842";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
createNode transform -n "bean_geo" -p "bean_GRP";
	rename -uid "F15DF8AD-E64D-6AFC-663A-AFB8FD08819F";
	setAttr ".rp" -type "double3" 4.76837158203125e-06 34.428638458251953 5.7220458984375e-06 ;
	setAttr ".sp" -type "double3" 4.76837158203125e-06 34.428638458251953 5.7220458984375e-06 ;
createNode transform -n "bean_body" -p "bean_geo";
	rename -uid "5AC7EC76-794B-42E7-9328-428FB9DFDE00";
	setAttr -l on ".tx";
	setAttr -l on ".ty";
	setAttr -l on ".tz";
	setAttr -l on ".rx";
	setAttr -l on ".ry";
	setAttr -l on ".rz";
	setAttr -l on ".sx";
	setAttr -l on ".sy";
	setAttr -l on ".sz";
	setAttr ".rp" -type "double3" 0 34.42863655090332 0 ;
	setAttr ".sp" -type "double3" 0 34.42863655090332 0 ;
createNode mesh -n "bean_bodyShape" -p "bean_body";
	rename -uid "DA6FAAA7-B04F-22EB-A5FD-03A26BB364E1";
	setAttr -k off ".v";
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr ".ndt" 0;
	setAttr ".vcs" 2;
createNode mesh -n "bean_bodyShapeOrig" -p "bean_body";
	rename -uid "F92535CF-C044-E26F-9ECD-F09929AFCBCF";
	setAttr -k off ".v";
	setAttr ".io" yes;
	setAttr ".vir" yes;
	setAttr ".vif" yes;
	setAttr -s 10 ".gtag";
	setAttr ".gtag[0].gtagnm" -type "string" "bottom";
	setAttr ".gtag[0].gtagcmp" -type "componentList" 2 "f[0:383]" "f[2304:2399]";
	setAttr ".gtag[1].gtagnm" -type "string" "bottomRing";
	setAttr ".gtag[1].gtagcmp" -type "componentList" 1 "e[192:255]";
	setAttr ".gtag[2].gtagnm" -type "string" "cylBottomCap";
	setAttr ".gtag[2].gtagcmp" -type "componentList" 2 "vtx[0:127]" "vtx[608]";
	setAttr ".gtag[3].gtagnm" -type "string" "cylBottomRing";
	setAttr ".gtag[3].gtagcmp" -type "componentList" 1 "vtx[96:127]";
	setAttr ".gtag[4].gtagnm" -type "string" "cylSides";
	setAttr ".gtag[4].gtagcmp" -type "componentList" 1 "vtx[96:511]";
	setAttr ".gtag[5].gtagnm" -type "string" "cylTopCap";
	setAttr ".gtag[5].gtagcmp" -type "componentList" 2 "vtx[480:607]" "vtx[609]";
	setAttr ".gtag[6].gtagnm" -type "string" "cylTopRing";
	setAttr ".gtag[6].gtagcmp" -type "componentList" 1 "vtx[480:511]";
	setAttr ".gtag[7].gtagnm" -type "string" "sides";
	setAttr ".gtag[7].gtagcmp" -type "componentList" 1 "f[384:1919]";
	setAttr ".gtag[8].gtagnm" -type "string" "top";
	setAttr ".gtag[8].gtagcmp" -type "componentList" 2 "f[1920:2303]" "f[2400:2495]";
	setAttr ".gtag[9].gtagnm" -type "string" "topRing";
	setAttr ".gtag[9].gtagcmp" -type "componentList" 1 "e[960:1023]";
	setAttr ".uvst[0].uvsn" -type "string" "map1";
	setAttr -s 2651 ".uvst[0].uvsp";
	setAttr ".uvst[0].uvsp[0:249]" -type "float2" 0.62447774 0.11890344 0.61736453
		 0.11304116 0.60581332 0.10763846 0.59026802 0.10290295 0.57132596 0.099016607 0.5497151
		 0.096128792 0.52626604 0.094350487 0.50187975 0.09375003 0.47749346 0.094350487 0.45404434
		 0.096128792 0.43243349 0.099016592 0.41349143 0.10290292 0.39794612 0.10763843 0.38639486
		 0.11304115 0.37928164 0.11890343 0.37687975 0.12499999 0.37928158 0.13109657 0.3863948
		 0.13695884 0.397946 0.14236155 0.41349137 0.14709708 0.43243343 0.15098342 0.45404428
		 0.15387121 0.47749341 0.15564954 0.50187969 0.15625 0.52626598 0.15564954 0.5497151
		 0.15387124 0.57132596 0.15098342 0.59026802 0.14709708 0.60581338 0.14236158 0.61736465
		 0.13695887 0.62447786 0.13109657 0.62687969 0.125 0.74707574 0.1128069 0.73284936
		 0.10108234 0.70974696 0.090276927 0.67865628 0.080805898 0.64077222 0.073033214 0.59755057
		 0.067257598 0.55065233 0.063700989 0.50187981 0.06250006 0.45310724 0.063700974 0.40620899
		 0.067257568 0.36298734 0.073033184 0.32510322 0.080805838 0.29401249 0.090276867
		 0.27091002 0.10108228 0.25668359 0.11280684 0.25187987 0.12499999 0.25668347 0.13719311
		 0.27090991 0.14891768 0.29401237 0.1597231 0.32510304 0.16919413 0.36298716 0.17696682
		 0.40620881 0.18274245 0.45310706 0.18629906 0.50187963 0.18749997 0.55065221 0.18629906
		 0.59755051 0.18274248 0.64077222 0.17696685 0.67865634 0.16919416 0.70974708 0.15972313
		 0.73284954 0.1489177 0.74707603 0.13719314 0.75187969 0.125 0.86967373 0.10671034
		 0.84833419 0.089123517 0.81368053 0.072915375 0.76704454 0.058708847 0.71021843 0.047049835
		 0.64538598 0.038386405 0.57503867 0.033051476 0.50187987 0.031250089 0.42872107 0.033051461
		 0.3583737 0.03838636 0.29354119 0.047049761 0.23671496 0.058708772 0.19007891 0.072915301
		 0.15542516 0.089123428 0.13408548 0.10671027 0.12687993 0.12499997 0.13408542 0.14328969
		 0.15542501 0.16087651 0.19007868 0.17708465 0.23671469 0.19129121 0.29354084 0.20295024
		 0.3583734 0.21161366 0.42872077 0.21694857 0.50187963 0.21874997 0.57503849 0.2169486
		 0.64538586 0.21161368 0.71021843 0.20295027 0.76704466 0.19129127 0.81368077 0.17708471
		 0.84833455 0.16087657 0.86967421 0.14328972 0.87687969 0.125 0.99227178 0.1006138
		 0.96381903 0.07716468 0.91761422 0.055553854 0.85543287 0.036611795 0.77966475 0.021066442
		 0.69322145 0.0095151961 0.59942496 0.0024019778 0.50187993 1.1920929e-07 0.40433484
		 0.002401948 0.31053835 0.0095151365 0.22409499 0.021066368 0.14832672 0.036611691
		 0.086145312 0.055553734 0.039940327 0.077164561 0.011487424 0.10061368 0.0018800199
		 0.12499996 0.011487305 0.14938623 0.039940119 0.17283538 0.086145014 0.19444621 0.14832637
		 0.21338826 0.2240946 0.22893363 0.31053793 0.24048489 0.40433449 0.24759811 0.50187963
		 0.24999997 0.59942478 0.24759814 0.69322133 0.24048492 0.77966475 0.22893369 0.85543299
		 0.21338835 0.91761446 0.19444627 0.96381938 0.17283544 0.99227238 0.14938629 1.0018796921
		 0.125 0 0.25 0.03125 0.25 0.0625 0.25 0.09375 0.25 0.125 0.25 0.15625 0.25 0.1875
		 0.25 0.21875 0.25 0.25 0.25 0.28125 0.25 0.3125 0.25 0.34375 0.25 0.375 0.25 0.40625
		 0.25 0.4375 0.25 0.46875 0.25 0.5 0.25 0.53125 0.25 0.5625 0.25 0.59375 0.25 0.625
		 0.25 0.65625 0.25 0.6875 0.25 0.71875 0.25 0.75 0.25 0.78125 0.25 0.8125 0.25 0.84375
		 0.25 0.875 0.25 0.90625 0.25 0.9375 0.25 0.96875 0.25 1 0.25 0 0.29166666 0.03125
		 0.29166666 0.0625 0.29166666 0.09375 0.29166666 0.125 0.29166666 0.15625 0.29166666
		 0.1875 0.29166666 0.21875 0.29166666 0.25 0.29166666 0.28125 0.29166666 0.3125 0.29166666
		 0.34375 0.29166666 0.375 0.29166666 0.40625 0.29166666 0.4375 0.29166666 0.46875
		 0.29166666 0.5 0.29166666 0.53125 0.29166666 0.5625 0.29166666 0.59375 0.29166666
		 0.625 0.29166666 0.65625 0.29166666 0.6875 0.29166666 0.71875 0.29166666 0.75 0.29166666
		 0.78125 0.29166666 0.8125 0.29166666 0.84375 0.29166666 0.875 0.29166666 0.90625
		 0.29166666 0.9375 0.29166666 0.96875 0.29166666 1 0.29166666 0 0.33333331 0.03125
		 0.33333331 0.0625 0.33333331 0.09375 0.33333331 0.125 0.33333331 0.15625 0.33333331
		 0.1875 0.33333331 0.21875 0.33333331 0.25 0.33333331 0.28125 0.33333331 0.3125 0.33333331
		 0.34375 0.33333331 0.375 0.33333331 0.40625 0.33333331 0.4375 0.33333331 0.46875
		 0.33333331 0.5 0.33333331 0.53125 0.33333331 0.5625 0.33333331 0.59375 0.33333331
		 0.625 0.33333331 0.65625 0.33333331 0.6875 0.33333331 0.71875 0.33333331 0.75 0.33333331
		 0.78125 0.33333331 0.8125 0.33333331 0.84375 0.33333331 0.875 0.33333331 0.90625
		 0.33333331 0.9375 0.33333331 0.96875 0.33333331 1 0.33333331 0 0.37499997 0.03125
		 0.37499997 0.0625 0.37499997 0.09375 0.37499997 0.125 0.37499997 0.15625 0.37499997
		 0.1875 0.37499997 0.21875 0.37499997 0.25 0.37499997 0.28125 0.37499997 0.3125 0.37499997
		 0.34375 0.37499997 0.375 0.37499997 0.40625 0.37499997 0.4375 0.37499997 0.46875
		 0.37499997 0.5 0.37499997 0.53125 0.37499997 0.5625 0.37499997 0.59375 0.37499997
		 0.625 0.37499997 0.65625 0.37499997 0.6875 0.37499997;
	setAttr ".uvst[0].uvsp[250:499]" 0.71875 0.37499997 0.75 0.37499997 0.78125
		 0.37499997 0.8125 0.37499997 0.84375 0.37499997 0.875 0.37499997 0.90625 0.37499997
		 0.9375 0.37499997 0.96875 0.37499997 1 0.37499997 0 0.41666663 0.03125 0.41666663
		 0.0625 0.41666663 0.09375 0.41666663 0.125 0.41666663 0.15625 0.41666663 0.1875 0.41666663
		 0.21875 0.41666663 0.25 0.41666663 0.28125 0.41666663 0.3125 0.41666663 0.34375 0.41666663
		 0.375 0.41666663 0.40625 0.41666663 0.4375 0.41666663 0.46875 0.41666663 0.5 0.41666663
		 0.53125 0.41666663 0.5625 0.41666663 0.59375 0.41666663 0.625 0.41666663 0.65625
		 0.41666663 0.6875 0.41666663 0.71875 0.41666663 0.75 0.41666663 0.78125 0.41666663
		 0.8125 0.41666663 0.84375 0.41666663 0.875 0.41666663 0.90625 0.41666663 0.9375 0.41666663
		 0.96875 0.41666663 1 0.41666663 0 0.45833328 0.03125 0.45833328 0.0625 0.45833328
		 0.09375 0.45833328 0.125 0.45833328 0.15625 0.45833328 0.1875 0.45833328 0.21875
		 0.45833328 0.25 0.45833328 0.28125 0.45833328 0.3125 0.45833328 0.34375 0.45833328
		 0.375 0.45833328 0.40625 0.45833328 0.4375 0.45833328 0.46875 0.45833328 0.5 0.45833328
		 0.53125 0.45833328 0.5625 0.45833328 0.59375 0.45833328 0.625 0.45833328 0.65625
		 0.45833328 0.6875 0.45833328 0.71875 0.45833328 0.75 0.45833328 0.78125 0.45833328
		 0.8125 0.45833328 0.84375 0.45833328 0.875 0.45833328 0.90625 0.45833328 0.9375 0.45833328
		 0.96875 0.45833328 1 0.45833328 0 0.49999994 0.03125 0.49999994 0.0625 0.49999994
		 0.09375 0.49999994 0.125 0.49999994 0.15625 0.49999994 0.1875 0.49999994 0.21875
		 0.49999994 0.25 0.49999994 0.28125 0.49999994 0.3125 0.49999994 0.34375 0.49999994
		 0.375 0.49999994 0.40625 0.49999994 0.4375 0.49999994 0.46875 0.49999994 0.5 0.49999994
		 0.53125 0.49999994 0.5625 0.49999994 0.59375 0.49999994 0.625 0.49999994 0.65625
		 0.49999994 0.6875 0.49999994 0.71875 0.49999994 0.75 0.49999994 0.78125 0.49999994
		 0.8125 0.49999994 0.84375 0.49999994 0.875 0.49999994 0.90625 0.49999994 0.9375 0.49999994
		 0.96875 0.49999994 1 0.49999994 0 0.54166663 0.03125 0.54166663 0.0625 0.54166663
		 0.09375 0.54166663 0.125 0.54166663 0.15625 0.54166663 0.1875 0.54166663 0.21875
		 0.54166663 0.25 0.54166663 0.28125 0.54166663 0.3125 0.54166663 0.34375 0.54166663
		 0.375 0.54166663 0.40625 0.54166663 0.4375 0.54166663 0.46875 0.54166663 0.5 0.54166663
		 0.53125 0.54166663 0.5625 0.54166663 0.59375 0.54166663 0.625 0.54166663 0.65625
		 0.54166663 0.6875 0.54166663 0.71875 0.54166663 0.75 0.54166663 0.78125 0.54166663
		 0.8125 0.54166663 0.84375 0.54166663 0.875 0.54166663 0.90625 0.54166663 0.9375 0.54166663
		 0.96875 0.54166663 1 0.54166663 0 0.58333331 0.03125 0.58333331 0.0625 0.58333331
		 0.09375 0.58333331 0.125 0.58333331 0.15625 0.58333331 0.1875 0.58333331 0.21875
		 0.58333331 0.25 0.58333331 0.28125 0.58333331 0.3125 0.58333331 0.34375 0.58333331
		 0.375 0.58333331 0.40625 0.58333331 0.4375 0.58333331 0.46875 0.58333331 0.5 0.58333331
		 0.53125 0.58333331 0.5625 0.58333331 0.59375 0.58333331 0.625 0.58333331 0.65625
		 0.58333331 0.6875 0.58333331 0.71875 0.58333331 0.75 0.58333331 0.78125 0.58333331
		 0.8125 0.58333331 0.84375 0.58333331 0.875 0.58333331 0.90625 0.58333331 0.9375 0.58333331
		 0.96875 0.58333331 1 0.58333331 0 0.625 0.03125 0.625 0.0625 0.625 0.09375 0.625
		 0.125 0.625 0.15625 0.625 0.1875 0.625 0.21875 0.625 0.25 0.625 0.28125 0.625 0.3125
		 0.625 0.34375 0.625 0.375 0.625 0.40625 0.625 0.4375 0.625 0.46875 0.625 0.5 0.625
		 0.53125 0.625 0.5625 0.625 0.59375 0.625 0.625 0.625 0.65625 0.625 0.6875 0.625 0.71875
		 0.625 0.75 0.625 0.78125 0.625 0.8125 0.625 0.84375 0.625 0.875 0.625 0.90625 0.625
		 0.9375 0.625 0.96875 0.625 1 0.625 0 0.66666669 0.03125 0.66666669 0.0625 0.66666669
		 0.09375 0.66666669 0.125 0.66666669 0.15625 0.66666669 0.1875 0.66666669 0.21875
		 0.66666669 0.25 0.66666669 0.28125 0.66666669 0.3125 0.66666669 0.34375 0.66666669
		 0.375 0.66666669 0.40625 0.66666669 0.4375 0.66666669 0.46875 0.66666669 0.5 0.66666669
		 0.53125 0.66666669 0.5625 0.66666669 0.59375 0.66666669 0.625 0.66666669 0.65625
		 0.66666669 0.6875 0.66666669 0.71875 0.66666669 0.75 0.66666669 0.78125 0.66666669
		 0.8125 0.66666669 0.84375 0.66666669 0.875 0.66666669 0.90625 0.66666669 0.9375 0.66666669
		 0.96875 0.66666669 1 0.66666669 0 0.70833337 0.03125 0.70833337 0.0625 0.70833337
		 0.09375 0.70833337 0.125 0.70833337 0.15625 0.70833337 0.1875 0.70833337 0.21875
		 0.70833337 0.25 0.70833337;
	setAttr ".uvst[0].uvsp[500:749]" 0.28125 0.70833337 0.3125 0.70833337 0.34375
		 0.70833337 0.375 0.70833337 0.40625 0.70833337 0.4375 0.70833337 0.46875 0.70833337
		 0.5 0.70833337 0.53125 0.70833337 0.5625 0.70833337 0.59375 0.70833337 0.625 0.70833337
		 0.65625 0.70833337 0.6875 0.70833337 0.71875 0.70833337 0.75 0.70833337 0.78125 0.70833337
		 0.8125 0.70833337 0.84375 0.70833337 0.875 0.70833337 0.90625 0.70833337 0.9375 0.70833337
		 0.96875 0.70833337 1 0.70833337 0 0.75000006 0.03125 0.75000006 0.0625 0.75000006
		 0.09375 0.75000006 0.125 0.75000006 0.15625 0.75000006 0.1875 0.75000006 0.21875
		 0.75000006 0.25 0.75000006 0.28125 0.75000006 0.3125 0.75000006 0.34375 0.75000006
		 0.375 0.75000006 0.40625 0.75000006 0.4375 0.75000006 0.46875 0.75000006 0.5 0.75000006
		 0.53125 0.75000006 0.5625 0.75000006 0.59375 0.75000006 0.625 0.75000006 0.65625
		 0.75000006 0.6875 0.75000006 0.71875 0.75000006 0.75 0.75000006 0.78125 0.75000006
		 0.8125 0.75000006 0.84375 0.75000006 0.875 0.75000006 0.90625 0.75000006 0.9375 0.75000006
		 0.96875 0.75000006 1 0.75000006 0.99227178 0.85061383 0.96381903 0.82716465 0.91761422
		 0.80555385 0.85543287 0.7866118 0.77966475 0.77106643 0.69322145 0.75951517 0.59942496
		 0.75240195 0.50187993 0.75000012 0.40433484 0.75240195 0.31053835 0.75951517 0.22409499
		 0.77106637 0.14832672 0.78661168 0.086145312 0.80555373 0.039940327 0.82716453 0.011487424
		 0.85061371 0.0018800199 0.87499994 0.011487305 0.89938623 0.039940119 0.92283535
		 0.086145014 0.94444621 0.14832637 0.96338826 0.2240946 0.97893363 0.31053793 0.99048489
		 0.40433449 0.99759811 0.50187963 1 0.59942478 0.99759817 0.69322133 0.99048495 0.77966475
		 0.97893369 0.85543299 0.96338832 0.91761446 0.94444627 0.96381938 0.92283547 0.99227238
		 0.89938629 1.0018796921 0.875 0.86967373 0.85671031 0.84833419 0.83912349 0.81368053
		 0.82291538 0.76704454 0.80870885 0.71021843 0.79704982 0.64538598 0.7883864 0.57503867
		 0.78305149 0.50187987 0.78125012 0.42872107 0.78305149 0.3583737 0.78838634 0.29354119
		 0.79704976 0.23671496 0.80870879 0.19007891 0.82291532 0.15542516 0.83912343 0.13408548
		 0.85671026 0.12687993 0.875 0.13408542 0.89328969 0.15542501 0.91087651 0.19007868
		 0.92708468 0.23671469 0.94129121 0.29354084 0.95295024 0.3583734 0.96161366 0.42872077
		 0.96694857 0.50187963 0.96875 0.57503849 0.96694863 0.64538586 0.96161366 0.71021843
		 0.95295024 0.76704466 0.94129127 0.81368077 0.92708468 0.84833455 0.91087657 0.86967421
		 0.89328969 0.87687969 0.875 0.74707574 0.86280692 0.73284936 0.85108232 0.70974696
		 0.84027696 0.67865628 0.8308059 0.64077222 0.82303321 0.59755057 0.81725758 0.55065233
		 0.81370097 0.50187981 0.81250006 0.45310724 0.81370097 0.40620899 0.81725758 0.36298734
		 0.82303321 0.32510322 0.83080584 0.29401249 0.84027684 0.27091002 0.85108227 0.25668359
		 0.86280686 0.25187987 0.875 0.25668347 0.88719308 0.27090991 0.89891768 0.29401237
		 0.9097231 0.32510304 0.9191941 0.36298716 0.92696679 0.40620881 0.93274248 0.45310706
		 0.93629909 0.50187963 0.9375 0.55065221 0.93629909 0.59755051 0.93274248 0.64077222
		 0.92696685 0.67865634 0.91919416 0.70974708 0.90972316 0.73284954 0.89891768 0.74707603
		 0.88719314 0.75187969 0.875 0.62447774 0.86890346 0.61736453 0.86304116 0.60581332
		 0.85763848 0.59026802 0.85290295 0.57132596 0.84901661 0.5497151 0.84612882 0.52626604
		 0.84435046 0.50187975 0.84375 0.47749346 0.84435046 0.45404434 0.84612882 0.43243349
		 0.84901661 0.41349143 0.85290289 0.39794612 0.85763842 0.38639486 0.86304116 0.37928164
		 0.8689034 0.37687975 0.875 0.37928158 0.8810966 0.3863948 0.88695884 0.397946 0.89236152
		 0.41349137 0.89709711 0.43243343 0.90098345 0.45404428 0.90387118 0.47749341 0.90564954
		 0.50187969 0.90625 0.52626598 0.90564954 0.5497151 0.90387124 0.57132596 0.90098345
		 0.59026802 0.89709711 0.60581338 0.89236158 0.61736465 0.88695884 0.62447786 0.8810966
		 0.62687969 0.875 0.50187969 0.125 0.50187969 0.875 0.68044186 0.11145847 0.66644359
		 0.10300972 0.64612114 0.095406063 0.62025559 0.088939667 0.58984101 0.083859056 0.55604601
		 0.080359459 0.5201695 0.078575388 0.48359007 0.078575388 0.44771352 0.080359459 0.41391855
		 0.083859041 0.38350385 0.088939629 0.3576383 0.095406011 0.33731586 0.10300968 0.32331753
		 0.11145842 0.31618121 0.12042756 0.31618118 0.12957241 0.32331744 0.13854155 0.33731577
		 0.1469903 0.35763818 0.15459397 0.38350374 0.16106036 0.41391841 0.16614097 0.44771338
		 0.16964057 0.48358995 0.17142464 0.52016938 0.17142464 0.55604595 0.16964057 0.58984095
		 0.166141 0.62025559 0.16106038 0.6461212 0.15459399 0.66644365 0.14699033 0.68044204
		 0.13854158 0.68757832 0.12957242 0.6875782 0.12042759 0.7994833 0.10243078 0.77615273
		 0.088349544 0.74228203 0.075676762 0.69917285 0.064899445 0.64848179 0.056431763
		 0.59215689 0.050599117 0.5323627 0.047625653 0.47139698 0.047625646 0.41160277 0.050599091
		 0.35527778 0.056431718 0.30458668 0.064899385 0.26147741 0.075676695 0.22760664 0.088349476
		 0.20427606 0.1024307 0.19238222 0.11737926 0.19238217 0.13262069 0.20427595 0.14756924
		 0.22760649 0.16165048 0.26147717 0.17432329 0.30458644 0.1851006 0.35527757 0.19356829
		 0.4116025 0.19940093 0.47139674 0.20237438 0.53236252 0.2023744 0.59215677 0.19940096
		 0.64848173 0.19356832 0.69917291 0.18510064 0.74228215 0.17432332 0.77615297 0.16165054
		 0.7994836 0.14756928 0.81137741 0.13262072;
	setAttr ".uvst[0].uvsp[750:999]" 0.81137723 0.11737931 0.91852474 0.093403086
		 0.88586199 0.073689356 0.83844304 0.055947468 0.77809012 0.04085923 0.70712262 0.02900447
		 0.62826777 0.020838764 0.5445559 0.016675916 0.45920393 0.016675904 0.37549198 0.020838726
		 0.29663706 0.029004406 0.22566947 0.040859148 0.16531649 0.055947375 0.11789743 0.073689252
		 0.085234597 0.093402989 0.068583213 0.11433097 0.068583168 0.13566896 0.085234463
		 0.15659696 0.11789721 0.17631069 0.16531619 0.19405258 0.22566915 0.20914084 0.2966367
		 0.2209956 0.37549165 0.22916131 0.45920366 0.23332416 0.54455566 0.23332417 0.62826765
		 0.22916135 0.70712262 0.22099563 0.77809018 0.2091409 0.83844322 0.19405264 0.88586229
		 0.17631075 0.9185251 0.156597 0.93517649 0.13566899 0.93517625 0.11433104 0.015625
		 0.27083331 0.046875 0.27083331 0.078125 0.27083331 0.109375 0.27083331 0.140625 0.27083331
		 0.171875 0.27083331 0.203125 0.27083331 0.234375 0.27083331 0.265625 0.27083331 0.296875
		 0.27083331 0.328125 0.27083331 0.359375 0.27083331 0.390625 0.27083331 0.421875 0.27083331
		 0.453125 0.27083331 0.484375 0.27083331 0.515625 0.27083331 0.546875 0.27083331 0.578125
		 0.27083331 0.609375 0.27083331 0.640625 0.27083331 0.671875 0.27083331 0.703125 0.27083331
		 0.734375 0.27083331 0.765625 0.27083331 0.796875 0.27083331 0.828125 0.27083331 0.859375
		 0.27083331 0.890625 0.27083331 0.921875 0.27083331 0.953125 0.27083331 0.984375 0.27083331
		 0.015625 0.3125 0.046875 0.3125 0.078125 0.3125 0.109375 0.3125 0.140625 0.3125 0.171875
		 0.3125 0.203125 0.3125 0.234375 0.3125 0.265625 0.3125 0.296875 0.3125 0.328125 0.3125
		 0.359375 0.3125 0.390625 0.3125 0.421875 0.3125 0.453125 0.3125 0.484375 0.3125 0.515625
		 0.3125 0.546875 0.3125 0.578125 0.3125 0.609375 0.3125 0.640625 0.3125 0.671875 0.3125
		 0.703125 0.3125 0.734375 0.3125 0.765625 0.3125 0.796875 0.3125 0.828125 0.3125 0.859375
		 0.3125 0.890625 0.3125 0.921875 0.3125 0.953125 0.3125 0.984375 0.3125 0.015625 0.35416666
		 0.046875 0.35416666 0.078125 0.35416666 0.109375 0.35416666 0.140625 0.35416666 0.171875
		 0.35416666 0.203125 0.35416666 0.234375 0.35416666 0.265625 0.35416666 0.296875 0.35416666
		 0.328125 0.35416666 0.359375 0.35416666 0.390625 0.35416666 0.421875 0.35416666 0.453125
		 0.35416666 0.484375 0.35416666 0.515625 0.35416666 0.546875 0.35416666 0.578125 0.35416666
		 0.609375 0.35416666 0.640625 0.35416666 0.671875 0.35416666 0.703125 0.35416666 0.734375
		 0.35416666 0.765625 0.35416666 0.796875 0.35416666 0.828125 0.35416666 0.859375 0.35416666
		 0.890625 0.35416666 0.921875 0.35416666 0.953125 0.35416666 0.984375 0.35416666 0.015625
		 0.39583328 0.046875 0.39583328 0.078125 0.39583328 0.109375 0.39583328 0.140625 0.39583328
		 0.171875 0.39583328 0.203125 0.39583328 0.234375 0.39583328 0.265625 0.39583328 0.296875
		 0.39583328 0.328125 0.39583328 0.359375 0.39583328 0.390625 0.39583328 0.421875 0.39583328
		 0.453125 0.39583328 0.484375 0.39583328 0.515625 0.39583328 0.546875 0.39583328 0.578125
		 0.39583328 0.609375 0.39583328 0.640625 0.39583328 0.671875 0.39583328 0.703125 0.39583328
		 0.734375 0.39583328 0.765625 0.39583328 0.796875 0.39583328 0.828125 0.39583328 0.859375
		 0.39583328 0.890625 0.39583328 0.921875 0.39583328 0.953125 0.39583328 0.984375 0.39583328
		 0.015625 0.43749994 0.046875 0.43749994 0.078125 0.43749994 0.109375 0.43749994 0.140625
		 0.43749994 0.171875 0.43749994 0.203125 0.43749994 0.234375 0.43749994 0.265625 0.43749994
		 0.296875 0.43749994 0.328125 0.43749994 0.359375 0.43749994 0.390625 0.43749994 0.421875
		 0.43749994 0.453125 0.43749994 0.484375 0.43749994 0.515625 0.43749994 0.546875 0.43749994
		 0.578125 0.43749994 0.609375 0.43749994 0.640625 0.43749994 0.671875 0.43749994 0.703125
		 0.43749994 0.734375 0.43749994 0.765625 0.43749994 0.796875 0.43749994 0.828125 0.43749994
		 0.859375 0.43749994 0.890625 0.43749994 0.921875 0.43749994 0.953125 0.43749994 0.984375
		 0.43749994 0.015625 0.47916663 0.046875 0.47916663 0.078125 0.47916663 0.109375 0.47916663
		 0.140625 0.47916663 0.171875 0.47916663 0.203125 0.47916663 0.234375 0.47916663 0.265625
		 0.47916663 0.296875 0.47916663 0.328125 0.47916663 0.359375 0.47916663 0.390625 0.47916663
		 0.421875 0.47916663 0.453125 0.47916663 0.484375 0.47916663 0.515625 0.47916663 0.546875
		 0.47916663 0.578125 0.47916663 0.609375 0.47916663 0.640625 0.47916663 0.671875 0.47916663
		 0.703125 0.47916663 0.734375 0.47916663 0.765625 0.47916663 0.796875 0.47916663 0.828125
		 0.47916663 0.859375 0.47916663 0.890625 0.47916663 0.921875 0.47916663 0.953125 0.47916663
		 0.984375 0.47916663 0.015625 0.52083325 0.046875 0.52083325 0.078125 0.52083325 0.109375
		 0.52083325 0.140625 0.52083325 0.171875 0.52083325 0.203125 0.52083325 0.234375 0.52083325
		 0.265625 0.52083325 0.296875 0.52083325 0.328125 0.52083325 0.359375 0.52083325 0.390625
		 0.52083325 0.421875 0.52083325 0.453125 0.52083325 0.484375 0.52083325 0.515625 0.52083325
		 0.546875 0.52083325 0.578125 0.52083325 0.609375 0.52083325 0.640625 0.52083325 0.671875
		 0.52083325 0.703125 0.52083325 0.734375 0.52083325 0.765625 0.52083325;
	setAttr ".uvst[0].uvsp[1000:1249]" 0.796875 0.52083325 0.828125 0.52083325 0.859375
		 0.52083325 0.890625 0.52083325 0.921875 0.52083325 0.953125 0.52083325 0.984375 0.52083325
		 0.015625 0.56249994 0.046875 0.56249994 0.078125 0.56249994 0.109375 0.56249994 0.140625
		 0.56249994 0.171875 0.56249994 0.203125 0.56249994 0.234375 0.56249994 0.265625 0.56249994
		 0.296875 0.56249994 0.328125 0.56249994 0.359375 0.56249994 0.390625 0.56249994 0.421875
		 0.56249994 0.453125 0.56249994 0.484375 0.56249994 0.515625 0.56249994 0.546875 0.56249994
		 0.578125 0.56249994 0.609375 0.56249994 0.640625 0.56249994 0.671875 0.56249994 0.703125
		 0.56249994 0.734375 0.56249994 0.765625 0.56249994 0.796875 0.56249994 0.828125 0.56249994
		 0.859375 0.56249994 0.890625 0.56249994 0.921875 0.56249994 0.953125 0.56249994 0.984375
		 0.56249994 0.015625 0.60416663 0.046875 0.60416663 0.078125 0.60416663 0.109375 0.60416663
		 0.140625 0.60416663 0.171875 0.60416663 0.203125 0.60416663 0.234375 0.60416663 0.265625
		 0.60416663 0.296875 0.60416663 0.328125 0.60416663 0.359375 0.60416663 0.390625 0.60416663
		 0.421875 0.60416663 0.453125 0.60416663 0.484375 0.60416663 0.515625 0.60416663 0.546875
		 0.60416663 0.578125 0.60416663 0.609375 0.60416663 0.640625 0.60416663 0.671875 0.60416663
		 0.703125 0.60416663 0.734375 0.60416663 0.765625 0.60416663 0.796875 0.60416663 0.828125
		 0.60416663 0.859375 0.60416663 0.890625 0.60416663 0.921875 0.60416663 0.953125 0.60416663
		 0.984375 0.60416663 0.015625 0.64583337 0.046875 0.64583337 0.078125 0.64583337 0.109375
		 0.64583337 0.140625 0.64583337 0.171875 0.64583337 0.203125 0.64583337 0.234375 0.64583337
		 0.265625 0.64583337 0.296875 0.64583337 0.328125 0.64583337 0.359375 0.64583337 0.390625
		 0.64583337 0.421875 0.64583337 0.453125 0.64583337 0.484375 0.64583337 0.515625 0.64583337
		 0.546875 0.64583337 0.578125 0.64583337 0.609375 0.64583337 0.640625 0.64583337 0.671875
		 0.64583337 0.703125 0.64583337 0.734375 0.64583337 0.765625 0.64583337 0.796875 0.64583337
		 0.828125 0.64583337 0.859375 0.64583337 0.890625 0.64583337 0.921875 0.64583337 0.953125
		 0.64583337 0.984375 0.64583337 0.015625 0.6875 0.046875 0.6875 0.078125 0.6875 0.109375
		 0.6875 0.140625 0.6875 0.171875 0.6875 0.203125 0.6875 0.234375 0.6875 0.265625 0.6875
		 0.296875 0.6875 0.328125 0.6875 0.359375 0.6875 0.390625 0.6875 0.421875 0.6875 0.453125
		 0.6875 0.484375 0.6875 0.515625 0.6875 0.546875 0.6875 0.578125 0.6875 0.609375 0.6875
		 0.640625 0.6875 0.671875 0.6875 0.703125 0.6875 0.734375 0.6875 0.765625 0.6875 0.796875
		 0.6875 0.828125 0.6875 0.859375 0.6875 0.890625 0.6875 0.921875 0.6875 0.953125 0.6875
		 0.984375 0.6875 0.015625 0.72916669 0.046875 0.72916669 0.078125 0.72916669 0.109375
		 0.72916669 0.140625 0.72916669 0.171875 0.72916669 0.203125 0.72916669 0.234375 0.72916669
		 0.265625 0.72916669 0.296875 0.72916669 0.328125 0.72916669 0.359375 0.72916669 0.390625
		 0.72916669 0.421875 0.72916669 0.453125 0.72916669 0.484375 0.72916669 0.515625 0.72916669
		 0.546875 0.72916669 0.578125 0.72916669 0.609375 0.72916669 0.640625 0.72916669 0.671875
		 0.72916669 0.703125 0.72916669 0.734375 0.72916669 0.765625 0.72916669 0.796875 0.72916669
		 0.828125 0.72916669 0.859375 0.72916669 0.890625 0.72916669 0.921875 0.72916669 0.953125
		 0.72916669 0.984375 0.72916669 0.9185251 0.90659702 0.88586229 0.92631072 0.83844316
		 0.94405264 0.77809024 0.9591409 0.70712256 0.9709956 0.62826765 0.97916138 0.5445556
		 0.98332417 0.45920366 0.98332417 0.37549162 0.97916126 0.2966367 0.9709956 0.22566912
		 0.95914084 0.16531619 0.94405258 0.11789721 0.92631072 0.085234463 0.90659696 0.068583168
		 0.88566899 0.068583213 0.86433095 0.085234597 0.84340298 0.11789743 0.82368928 0.16531648
		 0.80594736 0.22566947 0.7908591 0.29663706 0.7790044 0.37549198 0.77083874 0.45920393
		 0.76667595 0.54455584 0.76667595 0.62826777 0.77083874 0.70712262 0.77900445 0.77809012
		 0.79085922 0.83844304 0.80594748 0.88586199 0.82368934 0.91852474 0.84340304 0.93517625
		 0.86433101 0.93517649 0.88566899 0.7994836 0.8975693 0.77615297 0.91165054 0.74228221
		 0.92432332 0.69917291 0.93510067 0.64848173 0.94356829 0.59215677 0.94940102 0.53236252
		 0.9523744 0.4713968 0.9523744 0.4116025 0.94940096 0.35527754 0.94356835 0.30458644
		 0.93510056 0.2614772 0.92432332 0.22760649 0.91165048 0.20427595 0.89756924 0.19238217
		 0.88262069 0.19238222 0.86737925 0.20427606 0.8524307 0.22760665 0.83834946 0.26147741
		 0.82567668 0.30458668 0.81489938 0.35527778 0.80643177 0.41160274 0.8005991 0.47139701
		 0.79762566 0.5323627 0.79762566 0.59215689 0.8005991 0.64848179 0.80643177 0.69917285
		 0.81489944 0.74228209 0.8256768 0.77615273 0.83834952 0.79948324 0.85243076 0.81137723
		 0.86737931 0.81137741 0.88262069 0.68044204 0.88854158 0.66644365 0.8969903 0.6461212
		 0.904594 0.62025559 0.91106039 0.58984095 0.91614103 0.55604595 0.9196406 0.52016938
		 0.92142463 0.48358995 0.92142463 0.4477134 0.91964054 0.41391844 0.91614091 0.38350374
		 0.91106033 0.35763821 0.90459394 0.33731577 0.8969903 0.32331744 0.88854152 0.31618118
		 0.87957245 0.31618121 0.87042755 0.32331753 0.86145842 0.33731586 0.85300964 0.3576383
		 0.845406;
	setAttr ".uvst[0].uvsp[1250:1499]" 0.38350385 0.83893967 0.41391852 0.83385909
		 0.44771349 0.83035946 0.48359007 0.82857537 0.5201695 0.82857537 0.55604601 0.83035946
		 0.58984095 0.83385909 0.62025559 0.83893967 0.64612114 0.84540606 0.66644353 0.8530097
		 0.68044186 0.86145848 0.6875782 0.87042755 0.68757832 0.87957245 0.58124065 0.11898154
		 0.57501918 0.11522654 0.56598705 0.11184714 0.55449122 0.10897318 0.5409736 0.10671514
		 0.52595359 0.10515976 0.51000851 0.10436684 0.49375096 0.10436684 0.47780585 0.10515976
		 0.46278584 0.10671512 0.44926819 0.10897317 0.43777242 0.11184712 0.42874023 0.11522653
		 0.42251873 0.11898152 0.41934705 0.1229678 0.41934702 0.12703218 0.4225187 0.13101847
		 0.42874017 0.13477346 0.43777236 0.13815288 0.44926819 0.14102684 0.46278581 0.14328487
		 0.47780576 0.14484026 0.49375093 0.14563318 0.51000845 0.14563318 0.52595359 0.14484026
		 0.5409736 0.14328489 0.55449122 0.14102684 0.56598705 0.13815288 0.57501924 0.13477348
		 0.58124071 0.13101847 0.5844124 0.12703219 0.5844124 0.12296782 0.58124071 0.88101846
		 0.57501924 0.88477349 0.56598705 0.8881529 0.55449122 0.89102679 0.5409736 0.89328486
		 0.52595359 0.89484024 0.51000845 0.89563322 0.49375093 0.89563322 0.47780576 0.89484024
		 0.46278581 0.89328486 0.44926819 0.89102679 0.43777236 0.8881529 0.42874017 0.88477343
		 0.4225187 0.88101846 0.41934702 0.87703222 0.41934705 0.87296778 0.42251873 0.86898154
		 0.42874023 0.86522651 0.43777242 0.8618471 0.44926819 0.85897321 0.46278584 0.85671514
		 0.47780585 0.85515976 0.49375096 0.85436678 0.51000851 0.85436678 0.52595359 0.85515976
		 0.5409736 0.85671514 0.55449122 0.85897321 0.56598705 0.86184716 0.57501918 0.86522657
		 0.58124065 0.86898154 0.5844124 0.87296778 0.5844124 0.87703222 0.62092113 0.1159723
		 0.67510694 0.10706175 0.73996258 0.10694462 0.68577671 0.11585517 0.61158895 0.11033981
		 0.65778017 0.098957695 0.72129816 0.095679633 0.5980407 0.10527071 0.63446212 0.091854423
		 0.69420159 0.085541412 0.58079696 0.10095978 0.60604906 0.08602491 0.65971422 0.076919556
		 0.56052053 0.097572699 0.57363284 0.081693195 0.61916137 0.070145406 0.53799057 0.095239639
		 0.53845918 0.079025738 0.57410145 0.065479293 0.5140729 0.094050258 0.50187981 0.078125045
		 0.5262661 0.063100524 0.48968661 0.094050258 0.46530035 0.07902573 0.47749352 0.063100517
		 0.4657689 0.095239639 0.43012667 0.08169318 0.42965811 0.065479271 0.44323891 0.097572692
		 0.39771041 0.086024888 0.38459817 0.070145376 0.42296246 0.10095976 0.36929733 0.091854379
		 0.34404528 0.076919511 0.40571877 0.10527068 0.3459793 0.09895765 0.30955786 0.085541353
		 0.39217049 0.11033979 0.32865244 0.10706171 0.28246126 0.095679574 0.38283825 0.11597229
		 0.31798261 0.11585514 0.26379681 0.10694456 0.3780807 0.12195171 0.31437981 0.12499999
		 0.25428173 0.11890341 0.37808067 0.12804827 0.31798252 0.13414484 0.25428167 0.13109654
		 0.38283819 0.1340277 0.32865235 0.14293826 0.26379669 0.14305539 0.3921704 0.13966019
		 0.34597918 0.15104233 0.28246114 0.15432039 0.40571868 0.14472932 0.36929721 0.15814561
		 0.30955771 0.16445862 0.4229624 0.14904025 0.39771029 0.16397512 0.3440451 0.17308047
		 0.44323885 0.15242732 0.43012655 0.16830683 0.38459799 0.17985463 0.46576884 0.15476038
		 0.46530023 0.1709743 0.42965794 0.18452075 0.48968655 0.15594977 0.50187969 0.17187499
		 0.47749335 0.18689951 0.51407284 0.15594977 0.53845906 0.1709743 0.52626592 0.18689951
		 0.53799057 0.15476039 0.57363284 0.16830686 0.57410133 0.18452077 0.56052053 0.15242733
		 0.60604906 0.16397513 0.61916137 0.17985466 0.58079696 0.14904025 0.63446218 0.15814562
		 0.65971428 0.1730805 0.5980407 0.14472933 0.65778023 0.15104236 0.69420171 0.16445865
		 0.61158901 0.13966022 0.67510712 0.14293829 0.72129834 0.15432042 0.62092125 0.13402772
		 0.68577695 0.13414486 0.73996282 0.14305542 0.62567878 0.12804829 0.68937969 0.125
		 0.74947786 0.13109657 0.62567872 0.12195172 0.74947774 0.11890345 0.79059178 0.095102929
		 0.85900396 0.097916931 0.80837476 0.10975862 0.76171374 0.081596151 0.83100736 0.081019446
		 0.72285044 0.069757372 0.79036254 0.065812111 0.67549533 0.060041524 0.73863149 0.052879341
		 0.62146831 0.052822001 0.67780221 0.04271812 0.56284547 0.048376232 0.61021233 0.03571894
		 0.50187981 0.046875075 0.5384593 0.032150783 0.44091415 0.048376217 0.46530047 0.032150775
		 0.38229135 0.052821964 0.39354739 0.03571891 0.32826427 0.060041472 0.32595745 0.04271806
		 0.28090909 0.069757305 0.26512808 0.052879266 0.2420457 0.081596084 0.21339694 0.065812036
		 0.21316759 0.095102854 0.17275204 0.081019364 0.19538453 0.10975856 0.14475532 0.097916849
		 0.1893799 0.12499998 0.1304827 0.11585512 0.19538444 0.1402414 0.13048267 0.13414483
		 0.21316746 0.15489709 0.14475521 0.1520831 0.24204552 0.16840388 0.17275184 0.16898058
		 0.28090888 0.18024267 0.21339668 0.18418793 0.328264 0.18995853 0.26512778 0.19712073
		 0.38229111 0.19717805 0.32595712 0.20728195 0.44091392 0.20162381 0.39354709 0.21428111
		 0.50187963 0.20312497 0.4653002 0.21784927 0.56284535 0.20162383 0.53845906 0.21784928
		 0.62146819 0.19717808 0.61021221 0.21428114 0.67549533 0.18995856 0.67780215 0.20728198
		 0.7228505 0.18024272 0.73863155 0.19712077 0.76171392 0.16840392 0.79036272 0.18418799
		 0.79059207 0.15489714 0.83100766 0.16898064 0.80837512 0.14024143 0.85900438 0.15208314
		 0.81437969 0.125 0.87327695 0.13414486 0.87327671 0.11585517 0.90607661 0.083144099
		 0.9780454 0.088889241 0.93097275 0.10366207 0.86564738 0.064234614 0.94071662 0.066359267
		 0.81123871 0.047660321 0.88652354 0.046082824 0.74494159 0.034058139 0.81754881 0.028839119
		 0.66930372 0.0239508 0.7364431 0.015290819 0.58723181 0.017726727 0.6463232 0.0059585869;
	setAttr ".uvst[0].uvsp[1500:1749]" 0.50187993 0.015625104 0.55065244 0.0012010485
		 0.41652796 0.017726704 0.45310739 0.0012010336 0.33445603 0.023950748 0.3574366 0.0059585422
		 0.25881809 0.034058064 0.26731667 0.015290752 0.19252084 0.047660232 0.18621086 0.028839029
		 0.13811211 0.064234518 0.11723602 0.046082713 0.097682744 0.083143994 0.063042819
		 0.066359147 0.07278645 0.10366198 0.025713876 0.088889122 0.064379975 0.12499996
		 0.0066837221 0.11280682 0.072786361 0.14633796 0.0066836625 0.13719308 0.097682565
		 0.16685595 0.025713712 0.1611108 0.13811184 0.18576543 0.063042566 0.18364079 0.19252053
		 0.20233974 0.11723569 0.20391724 0.25881773 0.21594194 0.18621048 0.22116095 0.33445567
		 0.22604927 0.26731628 0.23470926 0.41652763 0.23227334 0.35743621 0.2440415 0.50187963
		 0.23437497 0.45310706 0.24879904 0.58723164 0.23227337 0.55065221 0.24879906 0.6693036
		 0.2260493 0.64632308 0.24404153 0.74494159 0.21594198 0.73644304 0.23470931 0.81123883
		 0.20233981 0.81754887 0.22116102 0.86564761 0.18576549 0.88652372 0.20391731 0.90607697
		 0.16685601 0.94071692 0.18364085 0.93097329 0.146338 0.97804588 0.16111086 0.93937969
		 0.125 0.99707603 0.13719314 0.99707574 0.1128069 0.015625 0.25 0.03125 0.27083331
		 0.015625 0.29166666 0 0.27083331 0.046875 0.25 0.0625 0.27083331 0.046875 0.29166666
		 0.078125 0.25 0.09375 0.27083331 0.078125 0.29166666 0.109375 0.25 0.125 0.27083331
		 0.109375 0.29166666 0.140625 0.25 0.15625 0.27083331 0.140625 0.29166666 0.171875
		 0.25 0.1875 0.27083331 0.171875 0.29166666 0.203125 0.25 0.21875 0.27083331 0.203125
		 0.29166666 0.234375 0.25 0.25 0.27083331 0.234375 0.29166666 0.265625 0.25 0.28125
		 0.27083331 0.265625 0.29166666 0.296875 0.25 0.3125 0.27083331 0.296875 0.29166666
		 0.328125 0.25 0.34375 0.27083331 0.328125 0.29166666 0.359375 0.25 0.375 0.27083331
		 0.359375 0.29166666 0.390625 0.25 0.40625 0.27083331 0.390625 0.29166666 0.421875
		 0.25 0.4375 0.27083331 0.421875 0.29166666 0.453125 0.25 0.46875 0.27083331 0.453125
		 0.29166666 0.484375 0.25 0.5 0.27083331 0.484375 0.29166666 0.515625 0.25 0.53125
		 0.27083331 0.515625 0.29166666 0.546875 0.25 0.5625 0.27083331 0.546875 0.29166666
		 0.578125 0.25 0.59375 0.27083331 0.578125 0.29166666 0.609375 0.25 0.625 0.27083331
		 0.609375 0.29166666 0.640625 0.25 0.65625 0.27083331 0.640625 0.29166666 0.671875
		 0.25 0.6875 0.27083331 0.671875 0.29166666 0.703125 0.25 0.71875 0.27083331 0.703125
		 0.29166666 0.734375 0.25 0.75 0.27083331 0.734375 0.29166666 0.765625 0.25 0.78125
		 0.27083331 0.765625 0.29166666 0.796875 0.25 0.8125 0.27083331 0.796875 0.29166666
		 0.828125 0.25 0.84375 0.27083331 0.828125 0.29166666 0.859375 0.25 0.875 0.27083331
		 0.859375 0.29166666 0.890625 0.25 0.90625 0.27083331 0.890625 0.29166666 0.921875
		 0.25 0.9375 0.27083331 0.921875 0.29166666 0.953125 0.25 0.96875 0.27083331 0.953125
		 0.29166666 0.984375 0.25 1 0.27083331 0.984375 0.29166666 0.03125 0.3125 0.015625
		 0.33333331 0 0.3125 0.0625 0.3125 0.046875 0.33333331 0.09375 0.3125 0.078125 0.33333331
		 0.125 0.3125 0.109375 0.33333331 0.15625 0.3125 0.140625 0.33333331 0.1875 0.3125
		 0.171875 0.33333331 0.21875 0.3125 0.203125 0.33333331 0.25 0.3125 0.234375 0.33333331
		 0.28125 0.3125 0.265625 0.33333331 0.3125 0.3125 0.296875 0.33333331 0.34375 0.3125
		 0.328125 0.33333331 0.375 0.3125 0.359375 0.33333331 0.40625 0.3125 0.390625 0.33333331
		 0.4375 0.3125 0.421875 0.33333331 0.46875 0.3125 0.453125 0.33333331 0.5 0.3125 0.484375
		 0.33333331 0.53125 0.3125 0.515625 0.33333331 0.5625 0.3125 0.546875 0.33333331 0.59375
		 0.3125 0.578125 0.33333331 0.625 0.3125 0.609375 0.33333331 0.65625 0.3125 0.640625
		 0.33333331 0.6875 0.3125 0.671875 0.33333331 0.71875 0.3125 0.703125 0.33333331 0.75
		 0.3125 0.734375 0.33333331 0.78125 0.3125 0.765625 0.33333331 0.8125 0.3125 0.796875
		 0.33333331 0.84375 0.3125 0.828125 0.33333331 0.875 0.3125 0.859375 0.33333331 0.90625
		 0.3125 0.890625 0.33333331 0.9375 0.3125 0.921875 0.33333331 0.96875 0.3125 0.953125
		 0.33333331 1 0.3125 0.984375 0.33333331 0.03125 0.35416663 0.015625 0.37499997 0
		 0.35416663 0.0625 0.35416663 0.046875 0.37499997 0.09375 0.35416663 0.078125 0.37499997
		 0.125 0.35416663 0.109375 0.37499997 0.15625 0.35416663 0.140625 0.37499997 0.1875
		 0.35416663 0.171875 0.37499997 0.21875 0.35416663 0.203125 0.37499997 0.25 0.35416663
		 0.234375 0.37499997 0.28125 0.35416663 0.265625 0.37499997 0.3125 0.35416663 0.296875
		 0.37499997 0.34375 0.35416663 0.328125 0.37499997 0.375 0.35416663 0.359375 0.37499997
		 0.40625 0.35416663 0.390625 0.37499997 0.4375 0.35416663 0.421875 0.37499997 0.46875
		 0.35416663 0.453125 0.37499997 0.5 0.35416663 0.484375 0.37499997 0.53125 0.35416663
		 0.515625 0.37499997 0.5625 0.35416663 0.546875 0.37499997;
	setAttr ".uvst[0].uvsp[1750:1999]" 0.59375 0.35416663 0.578125 0.37499997 0.625
		 0.35416663 0.609375 0.37499997 0.65625 0.35416663 0.640625 0.37499997 0.6875 0.35416663
		 0.671875 0.37499997 0.71875 0.35416663 0.703125 0.37499997 0.75 0.35416663 0.734375
		 0.37499997 0.78125 0.35416663 0.765625 0.37499997 0.8125 0.35416663 0.796875 0.37499997
		 0.84375 0.35416663 0.828125 0.37499997 0.875 0.35416663 0.859375 0.37499997 0.90625
		 0.35416663 0.890625 0.37499997 0.9375 0.35416663 0.921875 0.37499997 0.96875 0.35416663
		 0.953125 0.37499997 1 0.35416663 0.984375 0.37499997 0.03125 0.39583331 0.015625
		 0.41666663 0 0.39583331 0.0625 0.39583331 0.046875 0.41666663 0.09375 0.39583331
		 0.078125 0.41666663 0.125 0.39583331 0.109375 0.41666663 0.15625 0.39583331 0.140625
		 0.41666663 0.1875 0.39583331 0.171875 0.41666663 0.21875 0.39583331 0.203125 0.41666663
		 0.25 0.39583331 0.234375 0.41666663 0.28125 0.39583331 0.265625 0.41666663 0.3125
		 0.39583331 0.296875 0.41666663 0.34375 0.39583331 0.328125 0.41666663 0.375 0.39583331
		 0.359375 0.41666663 0.40625 0.39583331 0.390625 0.41666663 0.4375 0.39583331 0.421875
		 0.41666663 0.46875 0.39583331 0.453125 0.41666663 0.5 0.39583331 0.484375 0.41666663
		 0.53125 0.39583331 0.515625 0.41666663 0.5625 0.39583331 0.546875 0.41666663 0.59375
		 0.39583331 0.578125 0.41666663 0.625 0.39583331 0.609375 0.41666663 0.65625 0.39583331
		 0.640625 0.41666663 0.6875 0.39583331 0.671875 0.41666663 0.71875 0.39583331 0.703125
		 0.41666663 0.75 0.39583331 0.734375 0.41666663 0.78125 0.39583331 0.765625 0.41666663
		 0.8125 0.39583331 0.796875 0.41666663 0.84375 0.39583331 0.828125 0.41666663 0.875
		 0.39583331 0.859375 0.41666663 0.90625 0.39583331 0.890625 0.41666663 0.9375 0.39583331
		 0.921875 0.41666663 0.96875 0.39583331 0.953125 0.41666663 1 0.39583331 0.984375
		 0.41666663 0.03125 0.43749994 0.015625 0.45833328 0 0.43749994 0.0625 0.43749994
		 0.046875 0.45833328 0.09375 0.43749994 0.078125 0.45833328 0.125 0.43749994 0.109375
		 0.45833328 0.15625 0.43749994 0.140625 0.45833328 0.1875 0.43749994 0.171875 0.45833328
		 0.21875 0.43749994 0.203125 0.45833328 0.25 0.43749994 0.234375 0.45833328 0.28125
		 0.43749994 0.265625 0.45833328 0.3125 0.43749994 0.296875 0.45833328 0.34375 0.43749994
		 0.328125 0.45833328 0.375 0.43749994 0.359375 0.45833328 0.40625 0.43749994 0.390625
		 0.45833328 0.4375 0.43749994 0.421875 0.45833328 0.46875 0.43749994 0.453125 0.45833328
		 0.5 0.43749994 0.484375 0.45833328 0.53125 0.43749994 0.515625 0.45833328 0.5625
		 0.43749994 0.546875 0.45833328 0.59375 0.43749994 0.578125 0.45833328 0.625 0.43749994
		 0.609375 0.45833328 0.65625 0.43749994 0.640625 0.45833328 0.6875 0.43749994 0.671875
		 0.45833328 0.71875 0.43749994 0.703125 0.45833328 0.75 0.43749994 0.734375 0.45833328
		 0.78125 0.43749994 0.765625 0.45833328 0.8125 0.43749994 0.796875 0.45833328 0.84375
		 0.43749994 0.828125 0.45833328 0.875 0.43749994 0.859375 0.45833328 0.90625 0.43749994
		 0.890625 0.45833328 0.9375 0.43749994 0.921875 0.45833328 0.96875 0.43749994 0.953125
		 0.45833328 1 0.43749994 0.984375 0.45833328 0.03125 0.47916663 0.015625 0.49999994
		 0 0.47916663 0.0625 0.47916663 0.046875 0.49999994 0.09375 0.47916663 0.078125 0.49999994
		 0.125 0.47916663 0.109375 0.49999994 0.15625 0.47916663 0.140625 0.49999994 0.1875
		 0.47916663 0.171875 0.49999994 0.21875 0.47916663 0.203125 0.49999994 0.25 0.47916663
		 0.234375 0.49999994 0.28125 0.47916663 0.265625 0.49999994 0.3125 0.47916663 0.296875
		 0.49999994 0.34375 0.47916663 0.328125 0.49999994 0.375 0.47916663 0.359375 0.49999994
		 0.40625 0.47916663 0.390625 0.49999994 0.4375 0.47916663 0.421875 0.49999994 0.46875
		 0.47916663 0.453125 0.49999994 0.5 0.47916663 0.484375 0.49999994 0.53125 0.47916663
		 0.515625 0.49999994 0.5625 0.47916663 0.546875 0.49999994 0.59375 0.47916663 0.578125
		 0.49999994 0.625 0.47916663 0.609375 0.49999994 0.65625 0.47916663 0.640625 0.49999994
		 0.6875 0.47916663 0.671875 0.49999994 0.71875 0.47916663 0.703125 0.49999994 0.75
		 0.47916663 0.734375 0.49999994 0.78125 0.47916663 0.765625 0.49999994 0.8125 0.47916663
		 0.796875 0.49999994 0.84375 0.47916663 0.828125 0.49999994 0.875 0.47916663 0.859375
		 0.49999994 0.90625 0.47916663 0.890625 0.49999994 0.9375 0.47916663 0.921875 0.49999994
		 0.96875 0.47916663 0.953125 0.49999994 1 0.47916663 0.984375 0.49999994 0.03125 0.52083325
		 0.015625 0.54166663 0 0.52083325 0.0625 0.52083325 0.046875 0.54166663 0.09375 0.52083325
		 0.078125 0.54166663 0.125 0.52083325 0.109375 0.54166663 0.15625 0.52083325 0.140625
		 0.54166663 0.1875 0.52083325 0.171875 0.54166663 0.21875 0.52083325 0.203125 0.54166663
		 0.25 0.52083325 0.234375 0.54166663 0.28125 0.52083325 0.265625 0.54166663 0.3125
		 0.52083325 0.296875 0.54166663 0.34375 0.52083325 0.328125 0.54166663 0.375 0.52083325
		 0.359375 0.54166663 0.40625 0.52083325 0.390625 0.54166663;
	setAttr ".uvst[0].uvsp[2000:2249]" 0.4375 0.52083325 0.421875 0.54166663 0.46875
		 0.52083325 0.453125 0.54166663 0.5 0.52083325 0.484375 0.54166663 0.53125 0.52083325
		 0.515625 0.54166663 0.5625 0.52083325 0.546875 0.54166663 0.59375 0.52083325 0.578125
		 0.54166663 0.625 0.52083325 0.609375 0.54166663 0.65625 0.52083325 0.640625 0.54166663
		 0.6875 0.52083325 0.671875 0.54166663 0.71875 0.52083325 0.703125 0.54166663 0.75
		 0.52083325 0.734375 0.54166663 0.78125 0.52083325 0.765625 0.54166663 0.8125 0.52083325
		 0.796875 0.54166663 0.84375 0.52083325 0.828125 0.54166663 0.875 0.52083325 0.859375
		 0.54166663 0.90625 0.52083325 0.890625 0.54166663 0.9375 0.52083325 0.921875 0.54166663
		 0.96875 0.52083325 0.953125 0.54166663 1 0.52083325 0.984375 0.54166663 0.03125 0.5625
		 0.015625 0.58333331 0 0.5625 0.0625 0.5625 0.046875 0.58333331 0.09375 0.5625 0.078125
		 0.58333331 0.125 0.5625 0.109375 0.58333331 0.15625 0.5625 0.140625 0.58333331 0.1875
		 0.5625 0.171875 0.58333331 0.21875 0.5625 0.203125 0.58333331 0.25 0.5625 0.234375
		 0.58333331 0.28125 0.5625 0.265625 0.58333331 0.3125 0.5625 0.296875 0.58333331 0.34375
		 0.5625 0.328125 0.58333331 0.375 0.5625 0.359375 0.58333331 0.40625 0.5625 0.390625
		 0.58333331 0.4375 0.5625 0.421875 0.58333331 0.46875 0.5625 0.453125 0.58333331 0.5
		 0.5625 0.484375 0.58333331 0.53125 0.5625 0.515625 0.58333331 0.5625 0.5625 0.546875
		 0.58333331 0.59375 0.5625 0.578125 0.58333331 0.625 0.5625 0.609375 0.58333331 0.65625
		 0.5625 0.640625 0.58333331 0.6875 0.5625 0.671875 0.58333331 0.71875 0.5625 0.703125
		 0.58333331 0.75 0.5625 0.734375 0.58333331 0.78125 0.5625 0.765625 0.58333331 0.8125
		 0.5625 0.796875 0.58333331 0.84375 0.5625 0.828125 0.58333331 0.875 0.5625 0.859375
		 0.58333331 0.90625 0.5625 0.890625 0.58333331 0.9375 0.5625 0.921875 0.58333331 0.96875
		 0.5625 0.953125 0.58333331 1 0.5625 0.984375 0.58333331 0.03125 0.60416663 0.015625
		 0.625 0 0.60416663 0.0625 0.60416663 0.046875 0.625 0.09375 0.60416663 0.078125 0.625
		 0.125 0.60416663 0.109375 0.625 0.15625 0.60416663 0.140625 0.625 0.1875 0.60416663
		 0.171875 0.625 0.21875 0.60416663 0.203125 0.625 0.25 0.60416663 0.234375 0.625 0.28125
		 0.60416663 0.265625 0.625 0.3125 0.60416663 0.296875 0.625 0.34375 0.60416663 0.328125
		 0.625 0.375 0.60416663 0.359375 0.625 0.40625 0.60416663 0.390625 0.625 0.4375 0.60416663
		 0.421875 0.625 0.46875 0.60416663 0.453125 0.625 0.5 0.60416663 0.484375 0.625 0.53125
		 0.60416663 0.515625 0.625 0.5625 0.60416663 0.546875 0.625 0.59375 0.60416663 0.578125
		 0.625 0.625 0.60416663 0.609375 0.625 0.65625 0.60416663 0.640625 0.625 0.6875 0.60416663
		 0.671875 0.625 0.71875 0.60416663 0.703125 0.625 0.75 0.60416663 0.734375 0.625 0.78125
		 0.60416663 0.765625 0.625 0.8125 0.60416663 0.796875 0.625 0.84375 0.60416663 0.828125
		 0.625 0.875 0.60416663 0.859375 0.625 0.90625 0.60416663 0.890625 0.625 0.9375 0.60416663
		 0.921875 0.625 0.96875 0.60416663 0.953125 0.625 1 0.60416663 0.984375 0.625 0.03125
		 0.64583337 0.015625 0.66666669 0 0.64583337 0.0625 0.64583337 0.046875 0.66666669
		 0.09375 0.64583337 0.078125 0.66666669 0.125 0.64583337 0.109375 0.66666669 0.15625
		 0.64583337 0.140625 0.66666669 0.1875 0.64583337 0.171875 0.66666669 0.21875 0.64583337
		 0.203125 0.66666669 0.25 0.64583337 0.234375 0.66666669 0.28125 0.64583337 0.265625
		 0.66666669 0.3125 0.64583337 0.296875 0.66666669 0.34375 0.64583337 0.328125 0.66666669
		 0.375 0.64583337 0.359375 0.66666669 0.40625 0.64583337 0.390625 0.66666669 0.4375
		 0.64583337 0.421875 0.66666669 0.46875 0.64583337 0.453125 0.66666669 0.5 0.64583337
		 0.484375 0.66666669 0.53125 0.64583337 0.515625 0.66666669 0.5625 0.64583337 0.546875
		 0.66666669 0.59375 0.64583337 0.578125 0.66666669 0.625 0.64583337 0.609375 0.66666669
		 0.65625 0.64583337 0.640625 0.66666669 0.6875 0.64583337 0.671875 0.66666669 0.71875
		 0.64583337 0.703125 0.66666669 0.75 0.64583337 0.734375 0.66666669 0.78125 0.64583337
		 0.765625 0.66666669 0.8125 0.64583337 0.796875 0.66666669 0.84375 0.64583337 0.828125
		 0.66666669 0.875 0.64583337 0.859375 0.66666669 0.90625 0.64583337 0.890625 0.66666669
		 0.9375 0.64583337 0.921875 0.66666669 0.96875 0.64583337 0.953125 0.66666669 1 0.64583337
		 0.984375 0.66666669 0.03125 0.6875 0.015625 0.70833337 0 0.6875 0.0625 0.6875 0.046875
		 0.70833337 0.09375 0.6875 0.078125 0.70833337 0.125 0.6875 0.109375 0.70833337 0.15625
		 0.6875 0.140625 0.70833337 0.1875 0.6875 0.171875 0.70833337 0.21875 0.6875 0.203125
		 0.70833337 0.25 0.6875 0.234375 0.70833337;
	setAttr ".uvst[0].uvsp[2250:2499]" 0.28125 0.6875 0.265625 0.70833337 0.3125
		 0.6875 0.296875 0.70833337 0.34375 0.6875 0.328125 0.70833337 0.375 0.6875 0.359375
		 0.70833337 0.40625 0.6875 0.390625 0.70833337 0.4375 0.6875 0.421875 0.70833337 0.46875
		 0.6875 0.453125 0.70833337 0.5 0.6875 0.484375 0.70833337 0.53125 0.6875 0.515625
		 0.70833337 0.5625 0.6875 0.546875 0.70833337 0.59375 0.6875 0.578125 0.70833337 0.625
		 0.6875 0.609375 0.70833337 0.65625 0.6875 0.640625 0.70833337 0.6875 0.6875 0.671875
		 0.70833337 0.71875 0.6875 0.703125 0.70833337 0.75 0.6875 0.734375 0.70833337 0.78125
		 0.6875 0.765625 0.70833337 0.8125 0.6875 0.796875 0.70833337 0.84375 0.6875 0.828125
		 0.70833337 0.875 0.6875 0.859375 0.70833337 0.90625 0.6875 0.890625 0.70833337 0.9375
		 0.6875 0.921875 0.70833337 0.96875 0.6875 0.953125 0.70833337 1 0.6875 0.984375 0.70833337
		 0.03125 0.72916675 0.015625 0.75000006 0 0.72916675 0.0625 0.72916675 0.046875 0.75000006
		 0.09375 0.72916675 0.078125 0.75000006 0.125 0.72916675 0.109375 0.75000006 0.15625
		 0.72916675 0.140625 0.75000006 0.1875 0.72916675 0.171875 0.75000006 0.21875 0.72916675
		 0.203125 0.75000006 0.25 0.72916675 0.234375 0.75000006 0.28125 0.72916675 0.265625
		 0.75000006 0.3125 0.72916675 0.296875 0.75000006 0.34375 0.72916675 0.328125 0.75000006
		 0.375 0.72916675 0.359375 0.75000006 0.40625 0.72916675 0.390625 0.75000006 0.4375
		 0.72916675 0.421875 0.75000006 0.46875 0.72916675 0.453125 0.75000006 0.5 0.72916675
		 0.484375 0.75000006 0.53125 0.72916675 0.515625 0.75000006 0.5625 0.72916675 0.546875
		 0.75000006 0.59375 0.72916675 0.578125 0.75000006 0.625 0.72916675 0.609375 0.75000006
		 0.65625 0.72916675 0.640625 0.75000006 0.6875 0.72916675 0.671875 0.75000006 0.71875
		 0.72916675 0.703125 0.75000006 0.75 0.72916675 0.734375 0.75000006 0.78125 0.72916675
		 0.765625 0.75000006 0.8125 0.72916675 0.796875 0.75000006 0.84375 0.72916675 0.828125
		 0.75000006 0.875 0.72916675 0.859375 0.75000006 0.90625 0.72916675 0.890625 0.75000006
		 0.9375 0.72916675 0.921875 0.75000006 0.96875 0.72916675 0.953125 0.75000006 1 0.72916675
		 0.984375 0.75000006 0.97804588 0.91111088 0.90607697 0.91685605 0.85900438 0.90208316
		 0.93097329 0.89633799 0.94071692 0.93364084 0.86564761 0.9357655 0.83100766 0.9189806
		 0.88652372 0.95391726 0.81123883 0.95233977 0.79036272 0.93418801 0.81754887 0.97116101
		 0.74494159 0.96594197 0.73863155 0.94712079 0.73644304 0.98470932 0.6693036 0.9760493
		 0.67780215 0.95728195 0.64632308 0.99404156 0.58723164 0.9822734 0.61021221 0.96428114
		 0.55065221 0.99879909 0.50187963 0.984375 0.53845906 0.96784931 0.45310706 0.99879909
		 0.41652763 0.98227334 0.4653002 0.96784925 0.35743621 0.9940415 0.33445567 0.9760493
		 0.39354709 0.96428108 0.26731628 0.98470926 0.25881773 0.96594191 0.32595712 0.95728195
		 0.18621048 0.97116095 0.19252053 0.95233977 0.26512778 0.94712073 0.11723569 0.95391726
		 0.13811184 0.93576545 0.21339668 0.93418795 0.063042566 0.93364078 0.097682565 0.91685593
		 0.17275184 0.9189806 0.025713712 0.91111076 0.072786361 0.89633799 0.14475521 0.9020831
		 0.0066836625 0.88719308 0.064379975 0.875 0.13048267 0.88414484 0.0066837221 0.8628068
		 0.07278645 0.85366201 0.1304827 0.8658551 0.025713876 0.83888912 0.097682744 0.83314395
		 0.14475532 0.84791684 0.063042819 0.81635916 0.13811211 0.8142345 0.17275204 0.8310194
		 0.11723602 0.79608274 0.19252084 0.79766023 0.21339694 0.81581205 0.18621086 0.77883899
		 0.25881809 0.78405809 0.26512808 0.80287927 0.26731667 0.76529074 0.33445603 0.77395076
		 0.32595745 0.79271805 0.3574366 0.75595856 0.41652796 0.76772672 0.39354739 0.78571892
		 0.45310739 0.75120103 0.50187993 0.76562512 0.46530047 0.7821508 0.55065244 0.75120103
		 0.58723181 0.76772672 0.5384593 0.7821508 0.6463232 0.75595856 0.66930372 0.77395082
		 0.61021233 0.78571892 0.7364431 0.7652908 0.74494159 0.78405809 0.67780221 0.79271811
		 0.81754881 0.77883911 0.81123871 0.79766035 0.73863149 0.80287933 0.88652354 0.79608285
		 0.86564738 0.81423461 0.79036254 0.81581211 0.94071662 0.81635928 0.90607661 0.83314407
		 0.83100736 0.8310194 0.9780454 0.83888924 0.93097275 0.85366207 0.85900396 0.8479169
		 0.99707574 0.86280692 0.93937969 0.875 0.87327671 0.86585516 0.99707603 0.88719314
		 0.87327695 0.88414484 0.79059207 0.90489709 0.73996282 0.89305544 0.80837512 0.89024138
		 0.76171392 0.91840392 0.72129834 0.90432042 0.7228505 0.93024272 0.69420171 0.91445863
		 0.67549533 0.93995857 0.65971428 0.9230805 0.62146819 0.94717807 0.61916137 0.92985463
		 0.56284535 0.95162386 0.57410133 0.93452078 0.50187963 0.953125 0.52626592 0.93689954
		 0.44091392 0.9516238 0.47749335 0.93689954 0.38229111 0.94717807 0.42965794 0.93452078
		 0.328264 0.93995851 0.38459799 0.92985463 0.28090888 0.93024266 0.3440451 0.92308044
		 0.24204552 0.91840386 0.30955771 0.91445863 0.21316746 0.90489709 0.28246114 0.90432036
		 0.19538444 0.89024138 0.26379669 0.89305538 0.1893799 0.875 0.25428167 0.88109654
		 0.19538453 0.85975856 0.25428173 0.8689034 0.21316759 0.84510285 0.26379681 0.85694456
		 0.2420457 0.83159608 0.28246126 0.84567952 0.28090909 0.81975734 0.30955786 0.83554137
		 0.32826427 0.81004149 0.34404528 0.82691956;
	setAttr ".uvst[0].uvsp[2500:2650]" 0.38229135 0.80282199 0.38459817 0.82014537
		 0.44091415 0.7983762 0.42965811 0.81547928 0.50187981 0.79687512 0.47749352 0.81310052
		 0.56284547 0.7983762 0.5262661 0.81310052 0.62146831 0.80282199 0.57410145 0.81547928
		 0.67549533 0.81004155 0.61916137 0.82014537 0.72285044 0.81975734 0.65971422 0.82691956
		 0.76171374 0.83159614 0.69420159 0.83554143 0.79059178 0.84510291 0.72129816 0.84567964
		 0.80837476 0.85975862 0.73996258 0.85694462 0.81437969 0.875 0.74947774 0.86890346
		 0.74947786 0.8810966 0.67510712 0.89293826 0.62092125 0.88402772 0.68577695 0.8841449
		 0.65778023 0.90104234 0.61158901 0.88966024 0.63446218 0.90814567 0.5980407 0.89472938
		 0.60604906 0.91397512 0.58079696 0.89904028 0.57363284 0.91830683 0.56052053 0.90242732
		 0.53845906 0.92097431 0.53799057 0.90476036 0.50187969 0.921875 0.51407284 0.90594977
		 0.46530023 0.92097431 0.48968655 0.90594977 0.43012655 0.91830683 0.46576884 0.90476036
		 0.39771029 0.91397512 0.44323885 0.90242732 0.36929721 0.90814561 0.4229624 0.89904028
		 0.34597918 0.90104234 0.40571868 0.89472932 0.32865235 0.89293826 0.3921704 0.88966018
		 0.31798252 0.88414484 0.38283819 0.88402772 0.31437981 0.875 0.37808067 0.8780483
		 0.31798261 0.8658551 0.3780807 0.8719517 0.32865244 0.85706174 0.38283825 0.86597228
		 0.3459793 0.84895766 0.39217049 0.86033976 0.36929733 0.84185433 0.40571877 0.85527062
		 0.39771041 0.83602488 0.42296246 0.85095978 0.43012667 0.83169317 0.44323891 0.84757268
		 0.46530035 0.82902575 0.4657689 0.84523964 0.50187981 0.828125 0.48968661 0.84405023
		 0.53845918 0.82902575 0.5140729 0.84405023 0.57363284 0.83169317 0.53799057 0.84523964
		 0.60604906 0.83602488 0.56052053 0.84757268 0.63446212 0.84185445 0.58079696 0.85095978
		 0.65778017 0.84895772 0.5980407 0.85527074 0.67510694 0.85706174 0.61158895 0.86033982
		 0.68577671 0.86585522 0.62092113 0.86597228 0.68937969 0.875 0.62567872 0.8719517
		 0.62567878 0.8780483 0.56317872 0.12195172 0.55962211 0.11902058 0.55384648 0.11631923
		 0.54607385 0.11395147 0.53660285 0.1120083 0.52579737 0.1105644 0.5140729 0.10967524
		 0.50187969 0.10937501 0.48968658 0.10967524 0.47796202 0.1105644 0.46715659 0.1120083
		 0.45768556 0.11395146 0.44991291 0.11631922 0.44413728 0.11902057 0.44058067 0.12195171
		 0.43937972 0.12499999 0.44058064 0.12804829 0.44413725 0.13097942 0.44991285 0.13368078
		 0.45768553 0.13604854 0.46715656 0.13799171 0.47796199 0.1394356 0.48968655 0.14032477
		 0.50187969 0.140625 0.51407284 0.14032477 0.52579737 0.13943562 0.53660285 0.13799171
		 0.54607385 0.13604854 0.55384654 0.13368079 0.55962217 0.13097943 0.56317878 0.12804829
		 0.56437969 0.125 0.55962217 0.88097942 0.56317878 0.8780483 0.55384654 0.88368082
		 0.54607385 0.88604856 0.53660285 0.88799173 0.52579737 0.88943565 0.51407284 0.89032477
		 0.50187969 0.890625 0.48968655 0.89032477 0.47796199 0.88943559 0.46715656 0.88799173
		 0.45768553 0.88604856 0.44991285 0.88368076 0.44413725 0.88097942 0.44058064 0.8780483
		 0.43937972 0.875 0.44058067 0.8719517 0.44413728 0.86902058 0.44991291 0.86631918
		 0.45768556 0.86395144 0.46715659 0.86200833 0.47796202 0.86056441 0.48968658 0.85967523
		 0.50187969 0.859375 0.5140729 0.85967523 0.52579737 0.86056441 0.53660285 0.86200833
		 0.54607385 0.86395144 0.55384648 0.86631924 0.55962211 0.86902058 0.56317872 0.8719517
		 0.56437969 0.875;
	setAttr ".cuvs" -type "string" "map1";
	setAttr ".dcc" -type "string" "Diffuse";
	setAttr ".covm[0]"  0 1 1;
	setAttr ".cdvm[0]"  0 1 1;
	setAttr -s 2498 ".pt";
	setAttr ".pt[0:165]" -type "float3"  0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0;
	setAttr ".pt[166:331]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[332:497]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[498:663]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[664:829]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[830:995]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[996:1161]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[1162:1327]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[1328:1493]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[1494:1659]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[1660:1825]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[1826:1991]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[1992:2157]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[2158:2323]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[2324:2489]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0;
	setAttr ".pt[2490:2497]" 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 
		0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0 0 9.4286366 0;
	setAttr -s 2498 ".vt";
	setAttr ".vt[0:165]"  6.7349391 -7.28481722 -1.33966279 6.34417439 -7.28481722 -2.6278429
		 5.70960569 -7.28481722 -3.81503654 4.85562038 -7.28481722 -4.85562038 3.81503677 -7.28481722 -5.70960522
		 2.6278429 -7.28481722 -6.34417439 1.33966279 -7.28481722 -6.73493958 -1.8626458e-09 -7.28481722 -6.86688423
		 -1.33966279 -7.28481722 -6.7349391 -2.6278429 -7.28481722 -6.34417439 -3.81503654 -7.28481722 -5.70960569
		 -4.85562038 -7.28481722 -4.85562038 -5.70960522 -7.28481722 -3.81503677 -6.34417439 -7.28481722 -2.6278429
		 -6.73493958 -7.28481722 -1.33966279 -6.86688423 -7.28481722 1.8626456e-09 -6.7349391 -7.28481722 1.33966279
		 -6.34417439 -7.28481722 2.6278429 -5.70960569 -7.28481722 3.81503654 -4.85562038 -7.28481722 4.85562038
		 -3.81503677 -7.28481722 5.70960522 -2.6278429 -7.28481722 6.34417439 -1.33966279 -7.28481722 6.73493958
		 1.8626454e-09 -7.28481722 6.86688423 1.33966279 -7.28481722 6.7349391 2.6278429 -7.28481722 6.34417439
		 3.81503654 -7.28481722 5.70960569 4.85562038 -7.28481722 4.85562038 5.70960522 -7.28481722 3.81503677
		 6.34417439 -7.28481722 2.6278429 6.73493958 -7.28481722 1.33966279 6.86688423 -7.28481722 -1.8626451e-09
		 12.18697357 -3.48570824 -2.42413998 11.47987843 -3.48570824 -4.75512123 10.33161736 -3.48570824 -6.90336609
		 8.78631783 -3.48570824 -8.78631783 6.90336609 -3.48570824 -10.33161736 4.75512123 -3.48570824 -11.47987843
		 2.42413998 -3.48570824 -12.18697357 -7.4505815e-09 -3.48570824 -12.42573071 -2.42413998 -3.48570824 -12.18697357
		 -4.75512123 -3.48570824 -11.47987843 -6.90336609 -3.48570824 -10.33161736 -8.78631783 -3.48570824 -8.78631783
		 -10.33161736 -3.48570824 -6.90336609 -11.47987843 -3.48570824 -4.75512123 -12.18697357 -3.48570824 -2.42413998
		 -12.42573071 -3.48570824 7.4505815e-09 -12.18697357 -3.48570824 2.42413998 -11.47987843 -3.48570824 4.75512123
		 -10.33161736 -3.48570824 6.90336609 -8.78631783 -3.48570824 8.78631783 -6.90336609 -3.48570824 10.33161736
		 -4.75512123 -3.48570824 11.47987843 -2.42413998 -3.48570824 12.18697357 7.4505806e-09 -3.48570824 12.42573071
		 2.42413998 -3.48570824 12.18697357 4.75512123 -3.48570824 11.47987843 6.90336609 -3.48570824 10.33161736
		 8.78631783 -3.48570824 8.78631783 10.33161736 -3.48570824 6.90336609 11.47987843 -3.48570824 4.75512123
		 12.18697357 -3.48570824 2.42413998 12.42573071 -3.48570824 -7.4505806e-09 15.92304611 2.24278331 -3.16728973
		 14.99918079 2.24278331 -6.21286345 13.49890709 2.24278331 -9.019680023 11.47987747 2.24278331 -11.47987556
		 9.019681931 2.24278331 -13.49890614 6.21286535 2.24278331 -14.99918079 3.16729164 2.24278331 -15.92304611
		 1.0058284e-06 2.24278331 -16.2349968 -3.16728973 2.24278331 -15.92304611 -6.21286345 2.24278331 -14.99918175
		 -9.019680023 2.24278331 -13.49890709 -11.47987556 2.24278331 -11.47987747 -13.49890614 2.24278331 -9.019681931
		 -14.99918079 2.24278331 -6.21286535 -15.92304611 2.24278331 -3.16729164 -16.2349987 2.24278331 -7.301569e-07
		 -15.92304707 2.24278331 3.16729021 -14.9991827 2.24278331 6.21286392 -13.49890804 2.24278331 9.019680977
		 -11.47987747 2.24278331 11.47987556 -9.019681931 2.24278331 13.49890804 -6.21286535 2.24278331 14.9991827
		 -3.16729116 2.24278331 15.92304707 -3.4272671e-07 2.24278331 16.2349987 3.16729069 2.24278331 15.92304707
		 6.21286488 2.24278331 14.99918365 9.019681931 2.24278331 13.49890804 11.47987747 2.24278331 11.47987747
		 13.49890804 2.24278331 9.019681931 14.99918365 2.24278331 6.21286535 15.92304802 2.24278331 3.16729116
		 16.2349987 2.24278331 2.0861626e-07 17.40214157 8.47229576 -3.46149397 16.39245796 8.47229576 -6.78997135
		 14.75282669 8.47229576 -9.85751343 12.54624939 8.47229576 -12.54623795 9.85752678 8.47229576 -14.75281906
		 6.78998566 8.47229576 -16.39245605 3.46150804 8.47229576 -17.40214157 7.0035458e-06 8.47229576 -17.7430706
		 -3.46149445 8.47229576 -17.40214348 -6.78997326 8.47229576 -16.39246178 -9.85751724 8.47229576 -14.7528286
		 -12.54624271 8.47229576 -12.5462513 -14.75282288 8.47229576 -9.85752869 -16.39245987 8.47229576 -6.78998566
		 -17.40214539 8.47229576 -3.46150708 -17.74307632 8.47229576 -5.0663948e-06 -17.4021492 8.47229576 3.46149778
		 -16.3924675 8.47229576 6.78997707 -14.75283241 8.47229576 9.85752201 -12.5462532 8.47229576 12.54624748
		 -9.85752964 8.47229576 14.7528286 -6.78998518 8.47229576 16.3924675 -3.46150589 8.47229576 17.40215111
		 -2.5033951e-06 8.47229576 17.74308014 3.46150136 8.47229576 17.40215302 6.78998184 8.47229576 16.39247131
		 9.85752678 8.47229576 14.75283432 12.5462532 8.47229576 12.54625511 14.75283432 8.47229576 9.85752964
		 16.39247131 8.47229576 6.7899847 17.40215683 8.47229576 3.46150398 17.74308395 8.47229576 1.3783574e-06
		 17.56931305 11.66666698 -3.49474573 16.54993057 11.66666698 -6.85519695 14.89454746 11.66666698 -9.95220852
		 12.6667738 11.66666698 -12.6667614 9.95222378 11.66666698 -14.89453793 6.85521364 11.66666698 -16.54992676
		 3.49476147 11.66666698 -17.56931114 8.0168247e-06 11.66666698 -17.913517 -3.49474597 11.66666698 -17.56931496
		 -6.85519981 11.66666698 -16.54993439 -9.95221233 11.66666698 -14.89455032 -12.66676617 11.66666698 -12.66677666
		 -14.89454269 11.66666698 -9.95222473 -16.54993248 11.66666698 -6.85521364 -17.56931686 11.66666698 -3.49476051
		 -17.91352272 11.66666698 -5.8114529e-06 -17.56932068 11.66666698 3.49474955 -16.54994011 11.66666698 6.85520411
		 -14.89455414 11.66666698 9.9522171 -12.66677856 11.66666698 12.66677094 -9.95222473 11.66666698 14.89454937
		 -6.85521317 11.66666698 16.5499382 -3.49475884 11.66666698 17.56932449 -2.8461218e-06 11.66666698 17.91352844
		 3.49475384 11.66666698 17.5693264 6.85520935 11.66666698 16.54994583 9.95222282 11.66666698 14.894557
		 12.66677761 11.66666698 12.66678047 14.89455605 11.66666698 9.95222664 16.54994583 11.66666698 6.85521221
		 17.56933022 11.66666698 3.49475694 17.91353226 11.66666698 1.5795231e-06 17.56931305 14.33333397 -3.49474573
		 16.54993057 14.33333397 -6.85519695 14.89454746 14.33333397 -9.95220852 12.6667738 14.33333397 -12.6667614
		 9.95222378 14.33333397 -14.89453793 6.85521364 14.33333397 -16.54992676;
	setAttr ".vt[166:331]" 3.49476147 14.33333397 -17.56931114 8.0168247e-06 14.33333397 -17.913517
		 -3.49474597 14.33333397 -17.56931496 -6.85519981 14.33333397 -16.54993439 -9.95221233 14.33333397 -14.89455032
		 -12.66676617 14.33333397 -12.66677666 -14.89454269 14.33333397 -9.95222473 -16.54993248 14.33333397 -6.85521364
		 -17.56931686 14.33333397 -3.49476051 -17.91352272 14.33333397 -5.8114529e-06 -17.56932068 14.33333397 3.49474955
		 -16.54994011 14.33333397 6.85520411 -14.89455414 14.33333397 9.9522171 -12.66677856 14.33333397 12.66677094
		 -9.95222473 14.33333397 14.89454937 -6.85521317 14.33333397 16.5499382 -3.49475884 14.33333397 17.56932449
		 -2.8461218e-06 14.33333397 17.91352844 3.49475384 14.33333397 17.5693264 6.85520935 14.33333397 16.54994583
		 9.95222282 14.33333397 14.894557 12.66677761 14.33333397 12.66678047 14.89455605 14.33333397 9.95222664
		 16.54994583 14.33333397 6.85521221 17.56933022 14.33333397 3.49475694 17.91353226 14.33333397 1.5795231e-06
		 17.56931305 17 -3.49474573 16.54993057 17 -6.85519695 14.89454746 17 -9.95220852
		 12.6667738 17 -12.6667614 9.95222378 17 -14.89453793 6.85521364 17 -16.54992676 3.49476147 17 -17.56931114
		 8.0168247e-06 17 -17.913517 -3.49474597 17 -17.56931496 -6.85519981 17 -16.54993439
		 -9.95221233 17 -14.89455032 -12.66676617 17 -12.66677666 -14.89454269 17 -9.95222473
		 -16.54993248 17 -6.85521364 -17.56931686 17 -3.49476051 -17.91352272 17 -5.8114529e-06
		 -17.56932068 17 3.49474955 -16.54994011 17 6.85520411 -14.89455414 17 9.9522171 -12.66677856 17 12.66677094
		 -9.95222473 17 14.89454937 -6.85521317 17 16.5499382 -3.49475884 17 17.56932449 -2.8461218e-06 17 17.91352844
		 3.49475384 17 17.5693264 6.85520935 17 16.54994583 9.95222282 17 14.894557 12.66677761 17 12.66678047
		 14.89455605 17 9.95222664 16.54994583 17 6.85521221 17.56933022 17 3.49475694 17.91353226 17 1.5795231e-06
		 17.56931305 19.66666794 -3.49474573 16.54993057 19.66666794 -6.85519695 14.89454746 19.66666794 -9.95220852
		 12.6667738 19.66666794 -12.6667614 9.95222378 19.66666794 -14.89453793 6.85521364 19.66666794 -16.54992676
		 3.49476147 19.66666794 -17.56931114 8.0168247e-06 19.66666794 -17.913517 -3.49474597 19.66666794 -17.56931496
		 -6.85519981 19.66666794 -16.54993439 -9.95221233 19.66666794 -14.89455032 -12.66676617 19.66666794 -12.66677666
		 -14.89454269 19.66666794 -9.95222473 -16.54993248 19.66666794 -6.85521364 -17.56931686 19.66666794 -3.49476051
		 -17.91352272 19.66666794 -5.8114529e-06 -17.56932068 19.66666794 3.49474955 -16.54994011 19.66666794 6.85520411
		 -14.89455414 19.66666794 9.9522171 -12.66677856 19.66666794 12.66677094 -9.95222473 19.66666794 14.89454937
		 -6.85521317 19.66666794 16.5499382 -3.49475884 19.66666794 17.56932449 -2.8461218e-06 19.66666794 17.91352844
		 3.49475384 19.66666794 17.5693264 6.85520935 19.66666794 16.54994583 9.95222282 19.66666794 14.894557
		 12.66677761 19.66666794 12.66678047 14.89455605 19.66666794 9.95222664 16.54994583 19.66666794 6.85521221
		 17.56933022 19.66666794 3.49475694 17.91353226 19.66666794 1.5795231e-06 17.56931305 22.33333397 -3.49474573
		 16.54993057 22.33333397 -6.85519695 14.89454746 22.33333397 -9.95220852 12.6667738 22.33333397 -12.6667614
		 9.95222378 22.33333397 -14.89453793 6.85521364 22.33333397 -16.54992676 3.49476147 22.33333397 -17.56931114
		 8.0168247e-06 22.33333397 -17.913517 -3.49474597 22.33333397 -17.56931496 -6.85519981 22.33333397 -16.54993439
		 -9.95221233 22.33333397 -14.89455032 -12.66676617 22.33333397 -12.66677666 -14.89454269 22.33333397 -9.95222473
		 -16.54993248 22.33333397 -6.85521364 -17.56931686 22.33333397 -3.49476051 -17.91352272 22.33333397 -5.8114529e-06
		 -17.56932068 22.33333397 3.49474955 -16.54994011 22.33333397 6.85520411 -14.89455414 22.33333397 9.9522171
		 -12.66677856 22.33333397 12.66677094 -9.95222473 22.33333397 14.89454937 -6.85521317 22.33333397 16.5499382
		 -3.49475884 22.33333397 17.56932449 -2.8461218e-06 22.33333397 17.91352844 3.49475384 22.33333397 17.5693264
		 6.85520935 22.33333397 16.54994583 9.95222282 22.33333397 14.894557 12.66677761 22.33333397 12.66678047
		 14.89455605 22.33333397 9.95222664 16.54994583 22.33333397 6.85521221 17.56933022 22.33333397 3.49475694
		 17.91353226 22.33333397 1.5795231e-06 17.56931305 25.000001907349 -3.49474573 16.54993057 25.000001907349 -6.85519695
		 14.89454746 25.000001907349 -9.95220852 12.6667738 25.000001907349 -12.6667614 9.95222378 25.000001907349 -14.89453793
		 6.85521364 25.000001907349 -16.54992676 3.49476147 25.000001907349 -17.56931114 8.0168247e-06 25.000001907349 -17.913517
		 -3.49474597 25.000001907349 -17.56931496 -6.85519981 25.000001907349 -16.54993439
		 -9.95221233 25.000001907349 -14.89455032 -12.66676617 25.000001907349 -12.66677666
		 -14.89454269 25.000001907349 -9.95222473 -16.54993248 25.000001907349 -6.85521364
		 -17.56931686 25.000001907349 -3.49476051 -17.91352272 25.000001907349 -5.8114529e-06
		 -17.56932068 25.000001907349 3.49474955 -16.54994011 25.000001907349 6.85520411 -14.89455414 25.000001907349 9.9522171
		 -12.66677856 25.000001907349 12.66677094 -9.95222473 25.000001907349 14.89454937
		 -6.85521317 25.000001907349 16.5499382 -3.49475884 25.000001907349 17.56932449 -2.8461218e-06 25.000001907349 17.91352844
		 3.49475384 25.000001907349 17.5693264 6.85520935 25.000001907349 16.54994583 9.95222282 25.000001907349 14.894557
		 12.66677761 25.000001907349 12.66678047 14.89455605 25.000001907349 9.95222664 16.54994583 25.000001907349 6.85521221
		 17.56933022 25.000001907349 3.49475694 17.91353226 25.000001907349 1.5795231e-06
		 17.56931305 27.66666794 -3.49474573 16.54993057 27.66666794 -6.85519695 14.89454746 27.66666794 -9.95220852
		 12.6667738 27.66666794 -12.6667614 9.95222378 27.66666794 -14.89453793 6.85521364 27.66666794 -16.54992676
		 3.49476147 27.66666794 -17.56931114 8.0168247e-06 27.66666794 -17.913517 -3.49474597 27.66666794 -17.56931496
		 -6.85519981 27.66666794 -16.54993439 -9.95221233 27.66666794 -14.89455032 -12.66676617 27.66666794 -12.66677666;
	setAttr ".vt[332:497]" -14.89454269 27.66666794 -9.95222473 -16.54993248 27.66666794 -6.85521364
		 -17.56931686 27.66666794 -3.49476051 -17.91352272 27.66666794 -5.8114529e-06 -17.56932068 27.66666794 3.49474955
		 -16.54994011 27.66666794 6.85520411 -14.89455414 27.66666794 9.9522171 -12.66677856 27.66666794 12.66677094
		 -9.95222473 27.66666794 14.89454937 -6.85521317 27.66666794 16.5499382 -3.49475884 27.66666794 17.56932449
		 -2.8461218e-06 27.66666794 17.91352844 3.49475384 27.66666794 17.5693264 6.85520935 27.66666794 16.54994583
		 9.95222282 27.66666794 14.894557 12.66677761 27.66666794 12.66678047 14.89455605 27.66666794 9.95222664
		 16.54994583 27.66666794 6.85521221 17.56933022 27.66666794 3.49475694 17.91353226 27.66666794 1.5795231e-06
		 17.56931305 30.33333588 -3.49474573 16.54993057 30.33333588 -6.85519695 14.89454746 30.33333588 -9.95220852
		 12.6667738 30.33333588 -12.6667614 9.95222378 30.33333588 -14.89453793 6.85521364 30.33333588 -16.54992676
		 3.49476147 30.33333588 -17.56931114 8.0168247e-06 30.33333588 -17.913517 -3.49474597 30.33333588 -17.56931496
		 -6.85519981 30.33333588 -16.54993439 -9.95221233 30.33333588 -14.89455032 -12.66676617 30.33333588 -12.66677666
		 -14.89454269 30.33333588 -9.95222473 -16.54993248 30.33333588 -6.85521364 -17.56931686 30.33333588 -3.49476051
		 -17.91352272 30.33333588 -5.8114529e-06 -17.56932068 30.33333588 3.49474955 -16.54994011 30.33333588 6.85520411
		 -14.89455414 30.33333588 9.9522171 -12.66677856 30.33333588 12.66677094 -9.95222473 30.33333588 14.89454937
		 -6.85521317 30.33333588 16.5499382 -3.49475884 30.33333588 17.56932449 -2.8461218e-06 30.33333588 17.91352844
		 3.49475384 30.33333588 17.5693264 6.85520935 30.33333588 16.54994583 9.95222282 30.33333588 14.894557
		 12.66677761 30.33333588 12.66678047 14.89455605 30.33333588 9.95222664 16.54994583 30.33333588 6.85521221
		 17.56933022 30.33333588 3.49475694 17.91353226 30.33333588 1.5795231e-06 17.56931305 33 -3.49474573
		 16.54993057 33 -6.85519695 14.89454746 33 -9.95220852 12.6667738 33 -12.6667614 9.95222378 33 -14.89453793
		 6.85521364 33 -16.54992676 3.49476147 33 -17.56931114 8.0168247e-06 33 -17.913517
		 -3.49474597 33 -17.56931496 -6.85519981 33 -16.54993439 -9.95221233 33 -14.89455032
		 -12.66676617 33 -12.66677666 -14.89454269 33 -9.95222473 -16.54993248 33 -6.85521364
		 -17.56931686 33 -3.49476051 -17.91352272 33 -5.8114529e-06 -17.56932068 33 3.49474955
		 -16.54994011 33 6.85520411 -14.89455414 33 9.9522171 -12.66677856 33 12.66677094
		 -9.95222473 33 14.89454937 -6.85521317 33 16.5499382 -3.49475884 33 17.56932449 -2.8461218e-06 33 17.91352844
		 3.49475384 33 17.5693264 6.85520935 33 16.54994583 9.95222282 33 14.894557 12.66677761 33 12.66678047
		 14.89455605 33 9.95222664 16.54994583 33 6.85521221 17.56933022 33 3.49475694 17.91353226 33 1.5795231e-06
		 17.56931305 35.66666794 -3.49474573 16.54993057 35.66666794 -6.85519695 14.89454746 35.66666794 -9.95220852
		 12.6667738 35.66666794 -12.6667614 9.95222378 35.66666794 -14.89453793 6.85521364 35.66666794 -16.54992676
		 3.49476147 35.66666794 -17.56931114 8.0168247e-06 35.66666794 -17.913517 -3.49474597 35.66666794 -17.56931496
		 -6.85519981 35.66666794 -16.54993439 -9.95221233 35.66666794 -14.89455032 -12.66676617 35.66666794 -12.66677666
		 -14.89454269 35.66666794 -9.95222473 -16.54993248 35.66666794 -6.85521364 -17.56931686 35.66666794 -3.49476051
		 -17.91352272 35.66666794 -5.8114529e-06 -17.56932068 35.66666794 3.49474955 -16.54994011 35.66666794 6.85520411
		 -14.89455414 35.66666794 9.9522171 -12.66677856 35.66666794 12.66677094 -9.95222473 35.66666794 14.89454937
		 -6.85521317 35.66666794 16.5499382 -3.49475884 35.66666794 17.56932449 -2.8461218e-06 35.66666794 17.91352844
		 3.49475384 35.66666794 17.5693264 6.85520935 35.66666794 16.54994583 9.95222282 35.66666794 14.894557
		 12.66677761 35.66666794 12.66678047 14.89455605 35.66666794 9.95222664 16.54994583 35.66666794 6.85521221
		 17.56933022 35.66666794 3.49475694 17.91353226 35.66666794 1.5795231e-06 17.56931305 38.33333588 -3.49474573
		 16.54993057 38.33333588 -6.85519695 14.89454746 38.33333588 -9.95220852 12.6667738 38.33333588 -12.6667614
		 9.95222378 38.33333588 -14.89453793 6.85521364 38.33333588 -16.54992676 3.49476147 38.33333588 -17.56931114
		 8.0168247e-06 38.33333588 -17.913517 -3.49474597 38.33333588 -17.56931496 -6.85519981 38.33333588 -16.54993439
		 -9.95221233 38.33333588 -14.89455032 -12.66676617 38.33333588 -12.66677666 -14.89454269 38.33333588 -9.95222473
		 -16.54993248 38.33333588 -6.85521364 -17.56931686 38.33333588 -3.49476051 -17.91352272 38.33333588 -5.8114529e-06
		 -17.56932068 38.33333588 3.49474955 -16.54994011 38.33333588 6.85520411 -14.89455414 38.33333588 9.9522171
		 -12.66677856 38.33333588 12.66677094 -9.95222473 38.33333588 14.89454937 -6.85521317 38.33333588 16.5499382
		 -3.49475884 38.33333588 17.56932449 -2.8461218e-06 38.33333588 17.91352844 3.49475384 38.33333588 17.5693264
		 6.85520935 38.33333588 16.54994583 9.95222282 38.33333588 14.894557 12.66677761 38.33333588 12.66678047
		 14.89455605 38.33333588 9.95222664 16.54994583 38.33333588 6.85521221 17.56933022 38.33333588 3.49475694
		 17.91353226 38.33333588 1.5795231e-06 17.40214157 41.52770615 -3.46149397 16.39245796 41.52770615 -6.78997087
		 14.75282669 41.52770615 -9.85751438 12.54624939 41.52770615 -12.54623795 9.85752678 41.52770615 -14.75281906
		 6.78998566 41.52770615 -16.39245605 3.46150804 41.52770615 -17.40214157 7.0109963e-06 41.52770615 -17.7430706
		 -3.46149445 41.52770615 -17.40214348 -6.78997326 41.52770615 -16.39246368 -9.85751724 41.52770615 -14.7528286
		 -12.54624271 41.52770615 -12.5462513 -14.75282288 41.52770615 -9.85752869 -16.39245987 41.52770615 -6.78998566
		 -17.40214539 41.52770615 -3.46150708 -17.74307632 41.52770615 -5.0738454e-06 -17.4021492 41.52770615 3.46149778
		 -16.3924675 41.52770615 6.78997707;
	setAttr ".vt[498:663]" -14.75283241 41.52770615 9.85752201 -12.5462532 41.52770615 12.54624748
		 -9.85752964 41.52770615 14.7528286 -6.78998518 41.52770615 16.3924675 -3.46150589 41.52770615 17.40215111
		 -2.5033951e-06 41.52770615 17.74308014 3.46150136 41.52770615 17.40215302 6.78998184 41.52770615 16.39247131
		 9.85752678 41.52770615 14.75283432 12.5462532 41.52770615 12.54625511 14.75283432 41.52770615 9.85752964
		 16.39247131 41.52770615 6.7899847 17.40215683 41.52770615 3.46150398 17.74308395 41.52770615 1.3783574e-06
		 15.92304611 47.75721741 -3.16728973 14.99918079 47.75721741 -6.21286345 13.49890709 47.75721741 -9.019680023
		 11.47987747 47.75721741 -11.47987556 9.019681931 47.75721741 -13.49890614 6.21286583 47.75721741 -14.99918079
		 3.16729164 47.75721741 -15.92304611 1.013279e-06 47.75721741 -16.2349968 -3.16728973 47.75721741 -15.92304611
		 -6.21286392 47.75721741 -14.99918175 -9.019680023 47.75721741 -13.49890709 -11.47987556 47.75721741 -11.47987747
		 -13.49890614 47.75721741 -9.019681931 -14.99918175 47.75721741 -6.21286583 -15.92304611 47.75721741 -3.16729164
		 -16.2349968 47.75721741 -7.3760748e-07 -15.92304707 47.75721741 3.16729021 -14.9991827 47.75721741 6.21286392
		 -13.49890804 47.75721741 9.019680977 -11.47987747 47.75721741 11.47987556 -9.019681931 47.75721741 13.49890709
		 -6.21286583 47.75721741 14.99918175 -3.16729116 47.75721741 15.92304707 -3.4272671e-07 47.75721741 16.2349987
		 3.16729069 47.75721741 15.92304707 6.21286488 47.75721741 14.9991827 9.019681931 47.75721741 13.49890804
		 11.47987747 47.75721741 11.47987747 13.49890804 47.75721741 9.019681931 14.99918365 47.75721741 6.21286535
		 15.92304802 47.75721741 3.16729116 16.2349987 47.75721741 2.0861626e-07 12.18697357 53.48571014 -2.42413998
		 11.47987843 53.48571014 -4.75512123 10.33161736 53.48571014 -6.90336609 8.78631783 53.48571014 -8.78631783
		 6.90336609 53.48571014 -10.33161736 4.75512123 53.48571014 -11.47987843 2.42413998 53.48571014 -12.18697357
		 -7.4505815e-09 53.48571014 -12.42573071 -2.42413998 53.48571014 -12.18697357 -4.75512123 53.48571014 -11.47987843
		 -6.90336609 53.48571014 -10.33161736 -8.78631783 53.48571014 -8.78631783 -10.33161736 53.48571014 -6.90336609
		 -11.47987843 53.48571014 -4.75512123 -12.18697357 53.48571014 -2.42413998 -12.42573071 53.48571014 7.4505815e-09
		 -12.18697357 53.48571014 2.42413998 -11.47987843 53.48571014 4.75512123 -10.33161736 53.48571014 6.90336609
		 -8.78631783 53.48571014 8.78631783 -6.90336609 53.48571014 10.33161736 -4.75512123 53.48571014 11.47987843
		 -2.42413998 53.48571014 12.18697357 7.4505806e-09 53.48571014 12.42573071 2.42413998 53.48571014 12.18697357
		 4.75512123 53.48571014 11.47987843 6.90336609 53.48571014 10.33161736 8.78631783 53.48571014 8.78631783
		 10.33161736 53.48571014 6.90336609 11.47987843 53.48571014 4.75512123 12.18697357 53.48571014 2.42413998
		 12.42573071 53.48571014 -7.4505806e-09 6.73493958 57.28482056 -1.33966279 6.34417439 57.28482056 -2.6278429
		 5.70960522 57.28482056 -3.81503677 4.85562038 57.28482056 -4.85562038 3.81503654 57.28482056 -5.70960569
		 2.6278429 57.28482056 -6.34417439 1.33966279 57.28482056 -6.7349391 1.8626445e-09 57.28482056 -6.86688423
		 -1.33966279 57.28482056 -6.73493958 -2.6278429 57.28482056 -6.34417439 -3.81503677 57.28482056 -5.70960522
		 -4.85562038 57.28482056 -4.85562038 -5.70960569 57.28482056 -3.81503654 -6.34417439 57.28482056 -2.6278429
		 -6.7349391 57.28482056 -1.33966279 -6.86688423 57.28482056 -1.8626447e-09 -6.73493958 57.28482056 1.33966279
		 -6.34417439 57.28482056 2.6278429 -5.70960522 57.28482056 3.81503677 -4.85562038 57.28482056 4.85562038
		 -3.81503654 57.28482056 5.70960569 -2.6278429 57.28482056 6.34417439 -1.33966279 57.28482056 6.7349391
		 -1.8626449e-09 57.28482056 6.86688423 1.33966279 57.28482056 6.73493958 2.6278429 57.28482056 6.34417439
		 3.81503677 57.28482056 5.70960522 4.85562038 57.28482056 4.85562038 5.70960569 57.28482056 3.81503654
		 6.34417439 57.28482056 2.6278429 6.7349391 57.28482056 1.33966279 6.86688423 57.28482056 1.8626451e-09
		 -4.6566129e-10 -8.92863655 2.1245796e-09 -4.6566129e-10 58.92863846 -2.1245796e-09
		 6.70844746 -7.25627184 -2.034985304 6.18254042 -7.25627184 -3.30463696 5.41904211 -7.25627184 -4.44729328
		 4.44729328 -7.25627184 -5.41904211 3.30463696 -7.25627184 -6.18254042 2.034985304 -7.25627184 -6.70844746
		 0.68713045 -7.25627184 -6.97655296 -0.68713045 -7.25627184 -6.97655249 -2.034985304 -7.25627184 -6.70844746
		 -3.30463696 -7.25627184 -6.18254042 -4.44729328 -7.25627184 -5.41904211 -5.41904211 -7.25627184 -4.44729328
		 -6.18254042 -7.25627184 -3.30463696 -6.70844746 -7.25627184 -2.034985304 -6.97655296 -7.25627184 -0.68713045
		 -6.97655249 -7.25627184 0.68713045 -6.70844746 -7.25627184 2.034985304 -6.18254042 -7.25627184 3.30463696
		 -5.41904211 -7.25627184 4.44729328 -4.44729328 -7.25627184 5.41904211 -3.30463696 -7.25627184 6.18254042
		 -2.034985304 -7.25627184 6.70844746 -0.68713045 -7.25627184 6.97655296 0.68713045 -7.25627184 6.97655249
		 2.034985304 -7.25627184 6.70844746 3.30463696 -7.25627184 6.18254042 4.44729328 -7.25627184 5.41904211
		 5.41904211 -7.25627184 4.44729328 6.18254042 -7.25627184 3.30463696 6.70844746 -7.25627184 2.034985304
		 6.97655296 -7.25627184 0.68713045 6.97655249 -7.25627184 -0.68713045 11.89054489 -3.48570824 -3.6069572
		 10.95838737 -3.48570824 -5.85738087 9.60510731 -3.48570824 -7.8827076 7.8827076 -3.48570824 -9.60510731
		 5.85738039 -3.48570824 -10.95838737 3.6069572 -3.48570824 -11.89054489 1.21792042 -3.48570824 -12.36575317
		 -1.21792042 -3.48570824 -12.36575317 -3.6069572 -3.48570824 -11.89054489 -5.85738087 -3.48570824 -10.95838737
		 -7.8827076 -3.48570824 -9.60510731 -9.60510731 -3.48570824 -7.8827076 -10.95838737 -3.48570824 -5.85738039
		 -11.89054489 -3.48570824 -3.6069572 -12.36575317 -3.48570824 -1.21792042 -12.36575317 -3.48570824 1.21792042
		 -11.89054489 -3.48570824 3.6069572 -10.95838737 -3.48570824 5.85738087 -9.60510731 -3.48570824 7.8827076
		 -7.8827076 -3.48570824 9.60510731 -5.85738039 -3.48570824 10.95838737 -3.6069572 -3.48570824 11.89054489;
	setAttr ".vt[664:829]" -1.21792042 -3.48570824 12.36575317 1.21792042 -3.48570824 12.36575317
		 3.6069572 -3.48570824 11.89054489 5.85738087 -3.48570824 10.95838737 7.8827076 -3.48570824 9.60510731
		 9.60510731 -3.48570824 7.8827076 10.95838737 -3.48570824 5.85738039 11.89054489 -3.48570824 3.6069572
		 12.36575317 -3.48570824 1.21792042 12.36575317 -3.48570824 -1.21792042 15.53574181 2.24278331 -4.71271515
		 14.3178215 2.24278331 -7.65303421 12.5496769 2.24278331 -10.29925156 10.29925346 2.24278331 -12.54967499
		 7.65303612 2.24278331 -14.3178215 4.71271706 2.24278331 -15.53574181 1.59129047 2.24278331 -16.15663338
		 -1.59128845 2.24278331 -16.15663338 -4.71271515 2.24278331 -15.53574371 -7.65303516 2.24278331 -14.31782341
		 -10.29925251 2.24278331 -12.5496769 -12.54967594 2.24278331 -10.29925346 -14.3178215 2.24278331 -7.65303612
		 -15.53574371 2.24278331 -4.71271706 -16.15663338 2.24278331 -1.59129024 -16.15663338 2.24278331 1.59128881
		 -15.53574371 2.24278331 4.7127161 -14.31782341 2.24278331 7.65303516 -12.54967785 2.24278331 10.29925346
		 -10.29925346 2.24278331 12.5496769 -7.65303612 2.24278331 14.31782341 -4.71271706 2.24278331 15.53574371
		 -1.59128988 2.24278331 16.15663338 1.59128928 2.24278331 16.15663338 4.7127161 2.24278331 15.53574371
		 7.65303612 2.24278331 14.31782341 10.29925346 2.24278331 12.54967785 12.54967785 2.24278331 10.29925346
		 14.31782341 2.24278331 7.65303612 15.53574562 2.24278331 4.71271706 16.15663528 2.24278331 1.59128964
		 16.15663338 2.24278331 -1.59128881 16.97885895 8.47229576 -5.15047359 15.64780998 8.47229576 -8.36392021
		 13.71542263 8.47229576 -11.25594711 11.25595856 8.47229576 -13.71541309 8.36393452 8.47229576 -15.64780426
		 5.1504879 8.47229576 -16.97885895 1.73911166 8.47229576 -17.65742493 -1.73909783 8.47229576 -17.65742874
		 -5.1504755 8.47229576 -16.97886467 -8.36392307 8.47229576 -15.64781189 -11.25595093 8.47229576 -13.71542454
		 -13.71541691 8.47229576 -11.25596046 -15.64780998 8.47229576 -8.36393452 -16.97886467 8.47229576 -5.1504879
		 -17.65743065 8.47229576 -1.73911047 -17.65743256 8.47229576 1.73910046 -16.97887039 8.47229576 5.15047884
		 -15.64781761 8.47229576 8.36392689 -13.71542835 8.47229576 11.25595474 -11.25596237 8.47229576 13.71542263
		 -8.36393452 8.47229576 15.64781475 -5.15048695 8.47229576 16.97887039 -1.7391082 8.47229576 17.65743637
		 1.73910356 8.47229576 17.65743637 5.15048313 8.47229576 16.9788723 8.36393166 8.47229576 15.64781952
		 11.25596046 8.47229576 13.71543026 13.71542931 8.47229576 11.25596237 15.64781952 8.47229576 8.36393452
		 16.97887611 8.47229576 5.15048552 17.65744209 8.47229576 1.7391063 17.65743256 8.47229576 -1.73910069
		 17.14196396 11.66666794 -5.19994974 15.79812813 11.66666794 -8.44426632 13.84717846 11.66666794 -11.36407471
		 11.36408806 11.66666794 -13.84716797 8.44428253 11.66666794 -15.79812241 5.19996643 11.66666794 -17.14196396
		 1.7558192 11.66666794 -17.82704926 -1.75580323 11.66666794 -17.82705116 -5.19995165 11.66666794 -17.14196968
		 -8.44426918 11.66666794 -15.79813194 -11.36407852 11.66666794 -13.84718132 -13.84717178 11.66666794 -11.36408997
		 -15.79812813 11.66666794 -8.44428253 -17.14196968 11.66666794 -5.19996595 -17.82705498 11.66666794 -1.75581765
		 -17.82705688 11.66666794 1.75580621 -17.1419754 11.66666794 5.19995546 -15.79813766 11.66666794 8.44427395
		 -13.84718418 11.66666794 11.36408329 -11.36409187 11.66666794 13.84717751 -8.44428253 11.66666794 15.79813385
		 -5.199965 11.66666794 17.1419754 -1.75581527 11.66666794 17.8270607 1.75580978 11.66666794 17.82706261
		 5.19996071 11.66666794 17.14197922 8.44427872 11.66666794 15.79814053 11.36408997 11.66666794 13.84718704
		 13.84718513 11.66666794 11.36409283 15.79813957 11.66666794 8.44428253 17.14198303 11.66666794 5.19996357
		 17.82706833 11.66666794 1.75581288 17.82705688 11.66666794 -1.75580657 17.14196396 14.33333397 -5.19994974
		 15.79812813 14.33333397 -8.44426632 13.84717846 14.33333397 -11.36407471 11.36408806 14.33333397 -13.84716797
		 8.44428253 14.33333397 -15.79812241 5.19996643 14.33333397 -17.14196396 1.7558192 14.33333397 -17.82704926
		 -1.75580323 14.33333397 -17.82705116 -5.19995165 14.33333397 -17.14196968 -8.44426918 14.33333397 -15.79813194
		 -11.36407852 14.33333397 -13.84718132 -13.84717178 14.33333397 -11.36408997 -15.79812813 14.33333397 -8.44428253
		 -17.14196968 14.33333397 -5.19996595 -17.82705498 14.33333397 -1.75581765 -17.82705688 14.33333397 1.75580621
		 -17.1419754 14.33333397 5.19995546 -15.79813766 14.33333397 8.44427395 -13.84718418 14.33333397 11.36408329
		 -11.36409187 14.33333397 13.84717751 -8.44428253 14.33333397 15.79813385 -5.199965 14.33333397 17.1419754
		 -1.75581527 14.33333397 17.8270607 1.75580978 14.33333397 17.82706261 5.19996071 14.33333397 17.14197922
		 8.44427872 14.33333397 15.79814053 11.36408997 14.33333397 13.84718704 13.84718513 14.33333397 11.36409283
		 15.79813957 14.33333397 8.44428253 17.14198303 14.33333397 5.19996357 17.82706833 14.33333397 1.75581288
		 17.82705688 14.33333397 -1.75580657 17.14196396 17 -5.19994974 15.79812813 17 -8.44426632
		 13.84717846 17 -11.36407471 11.36408806 17 -13.84716797 8.44428253 17 -15.79812241
		 5.19996643 17 -17.14196396 1.7558192 17 -17.82704926 -1.75580323 17 -17.82705116
		 -5.19995165 17 -17.14196968 -8.44426918 17 -15.79813194 -11.36407852 17 -13.84718132
		 -13.84717178 17 -11.36408997 -15.79812813 17 -8.44428253 -17.14196968 17 -5.19996595
		 -17.82705498 17 -1.75581765 -17.82705688 17 1.75580621 -17.1419754 17 5.19995546
		 -15.79813766 17 8.44427395 -13.84718418 17 11.36408329 -11.36409187 17 13.84717751
		 -8.44428253 17 15.79813385 -5.199965 17 17.1419754 -1.75581527 17 17.8270607 1.75580978 17 17.82706261
		 5.19996071 17 17.14197922 8.44427872 17 15.79814053 11.36408997 17 13.84718704 13.84718513 17 11.36409283;
	setAttr ".vt[830:995]" 15.79813957 17 8.44428253 17.14198303 17 5.19996357
		 17.82706833 17 1.75581288 17.82705688 17 -1.75580657 17.14196396 19.66666794 -5.19994974
		 15.79812813 19.66666794 -8.44426632 13.84717846 19.66666794 -11.36407471 11.36408806 19.66666794 -13.84716797
		 8.44428253 19.66666794 -15.79812241 5.19996643 19.66666794 -17.14196396 1.7558192 19.66666794 -17.82704926
		 -1.75580323 19.66666794 -17.82705116 -5.19995165 19.66666794 -17.14196968 -8.44426918 19.66666794 -15.79813194
		 -11.36407852 19.66666794 -13.84718132 -13.84717178 19.66666794 -11.36408997 -15.79812813 19.66666794 -8.44428253
		 -17.14196968 19.66666794 -5.19996595 -17.82705498 19.66666794 -1.75581765 -17.82705688 19.66666794 1.75580621
		 -17.1419754 19.66666794 5.19995546 -15.79813766 19.66666794 8.44427395 -13.84718418 19.66666794 11.36408329
		 -11.36409187 19.66666794 13.84717751 -8.44428253 19.66666794 15.79813385 -5.199965 19.66666794 17.1419754
		 -1.75581527 19.66666794 17.8270607 1.75580978 19.66666794 17.82706261 5.19996071 19.66666794 17.14197922
		 8.44427872 19.66666794 15.79814053 11.36408997 19.66666794 13.84718704 13.84718513 19.66666794 11.36409283
		 15.79813957 19.66666794 8.44428253 17.14198303 19.66666794 5.19996357 17.82706833 19.66666794 1.75581288
		 17.82705688 19.66666794 -1.75580657 17.14196396 22.33333397 -5.19994974 15.79812813 22.33333397 -8.44426632
		 13.84717846 22.33333397 -11.36407471 11.36408806 22.33333397 -13.84716797 8.44428253 22.33333397 -15.79812241
		 5.19996643 22.33333397 -17.14196396 1.7558192 22.33333397 -17.82704926 -1.75580323 22.33333397 -17.82705116
		 -5.19995165 22.33333397 -17.14196968 -8.44426918 22.33333397 -15.79813194 -11.36407852 22.33333397 -13.84718132
		 -13.84717178 22.33333397 -11.36408997 -15.79812813 22.33333397 -8.44428253 -17.14196968 22.33333397 -5.19996595
		 -17.82705498 22.33333397 -1.75581765 -17.82705688 22.33333397 1.75580621 -17.1419754 22.33333397 5.19995546
		 -15.79813766 22.33333397 8.44427395 -13.84718418 22.33333397 11.36408329 -11.36409187 22.33333397 13.84717751
		 -8.44428253 22.33333397 15.79813385 -5.199965 22.33333397 17.1419754 -1.75581527 22.33333397 17.8270607
		 1.75580978 22.33333397 17.82706261 5.19996071 22.33333397 17.14197922 8.44427872 22.33333397 15.79814053
		 11.36408997 22.33333397 13.84718704 13.84718513 22.33333397 11.36409283 15.79813957 22.33333397 8.44428253
		 17.14198303 22.33333397 5.19996357 17.82706833 22.33333397 1.75581288 17.82705688 22.33333397 -1.75580657
		 17.14196396 25.000003814697 -5.19994974 15.79812813 25.000003814697 -8.44426632 13.84717846 25.000003814697 -11.36407471
		 11.36408806 25.000003814697 -13.84716797 8.44428253 25.000003814697 -15.79812241
		 5.19996643 25.000003814697 -17.14196396 1.7558192 25.000003814697 -17.82704926 -1.75580323 25.000003814697 -17.82705116
		 -5.19995165 25.000003814697 -17.14196968 -8.44426918 25.000003814697 -15.79813194
		 -11.36407852 25.000003814697 -13.84718132 -13.84717178 25.000003814697 -11.36408997
		 -15.79812813 25.000003814697 -8.44428253 -17.14196968 25.000003814697 -5.19996595
		 -17.82705498 25.000003814697 -1.75581765 -17.82705688 25.000003814697 1.75580621
		 -17.1419754 25.000003814697 5.19995546 -15.79813766 25.000003814697 8.44427395 -13.84718418 25.000003814697 11.36408329
		 -11.36409187 25.000003814697 13.84717751 -8.44428253 25.000003814697 15.79813385
		 -5.199965 25.000003814697 17.1419754 -1.75581527 25.000003814697 17.8270607 1.75580978 25.000003814697 17.82706261
		 5.19996071 25.000003814697 17.14197922 8.44427872 25.000003814697 15.79814053 11.36408997 25.000003814697 13.84718704
		 13.84718513 25.000003814697 11.36409283 15.79813957 25.000003814697 8.44428253 17.14198303 25.000003814697 5.19996357
		 17.82706833 25.000003814697 1.75581288 17.82705688 25.000003814697 -1.75580657 17.14196396 27.66666794 -5.19994974
		 15.79812813 27.66666794 -8.44426632 13.84717846 27.66666794 -11.36407471 11.36408806 27.66666794 -13.84716797
		 8.44428253 27.66666794 -15.79812241 5.19996643 27.66666794 -17.14196396 1.7558192 27.66666794 -17.82704926
		 -1.75580323 27.66666794 -17.82705116 -5.19995165 27.66666794 -17.14196968 -8.44426918 27.66666794 -15.79813194
		 -11.36407852 27.66666794 -13.84718132 -13.84717178 27.66666794 -11.36408997 -15.79812813 27.66666794 -8.44428253
		 -17.14196968 27.66666794 -5.19996595 -17.82705498 27.66666794 -1.75581765 -17.82705688 27.66666794 1.75580621
		 -17.1419754 27.66666794 5.19995546 -15.79813766 27.66666794 8.44427395 -13.84718418 27.66666794 11.36408329
		 -11.36409187 27.66666794 13.84717751 -8.44428253 27.66666794 15.79813385 -5.199965 27.66666794 17.1419754
		 -1.75581527 27.66666794 17.8270607 1.75580978 27.66666794 17.82706261 5.19996071 27.66666794 17.14197922
		 8.44427872 27.66666794 15.79814053 11.36408997 27.66666794 13.84718704 13.84718513 27.66666794 11.36409283
		 15.79813957 27.66666794 8.44428253 17.14198303 27.66666794 5.19996357 17.82706833 27.66666794 1.75581288
		 17.82705688 27.66666794 -1.75580657 17.14196396 30.33333588 -5.19994974 15.79812813 30.33333588 -8.44426632
		 13.84717846 30.33333588 -11.36407471 11.36408806 30.33333588 -13.84716797 8.44428253 30.33333588 -15.79812241
		 5.19996643 30.33333588 -17.14196396 1.7558192 30.33333588 -17.82704926 -1.75580323 30.33333588 -17.82705116
		 -5.19995165 30.33333588 -17.14196968 -8.44426918 30.33333588 -15.79813194 -11.36407852 30.33333588 -13.84718132
		 -13.84717178 30.33333588 -11.36408997 -15.79812813 30.33333588 -8.44428253 -17.14196968 30.33333588 -5.19996595
		 -17.82705498 30.33333588 -1.75581765 -17.82705688 30.33333588 1.75580621 -17.1419754 30.33333588 5.19995546
		 -15.79813766 30.33333588 8.44427395 -13.84718418 30.33333588 11.36408329 -11.36409187 30.33333588 13.84717751
		 -8.44428253 30.33333588 15.79813385 -5.199965 30.33333588 17.1419754 -1.75581527 30.33333588 17.8270607
		 1.75580978 30.33333588 17.82706261 5.19996071 30.33333588 17.14197922 8.44427872 30.33333588 15.79814053
		 11.36408997 30.33333588 13.84718704 13.84718513 30.33333588 11.36409283 15.79813957 30.33333588 8.44428253
		 17.14198303 30.33333588 5.19996357 17.82706833 30.33333588 1.75581288 17.82705688 30.33333588 -1.75580657
		 17.14196396 33 -5.19994974 15.79812813 33 -8.44426632;
	setAttr ".vt[996:1161]" 13.84717846 33 -11.36407471 11.36408806 33 -13.84716797
		 8.44428253 33 -15.79812241 5.19996643 33 -17.14196396 1.7558192 33 -17.82704926 -1.75580323 33 -17.82705116
		 -5.19995165 33 -17.14196968 -8.44426918 33 -15.79813194 -11.36407852 33 -13.84718132
		 -13.84717178 33 -11.36408997 -15.79812813 33 -8.44428253 -17.14196968 33 -5.19996595
		 -17.82705498 33 -1.75581765 -17.82705688 33 1.75580621 -17.1419754 33 5.19995546
		 -15.79813766 33 8.44427395 -13.84718418 33 11.36408329 -11.36409187 33 13.84717751
		 -8.44428253 33 15.79813385 -5.199965 33 17.1419754 -1.75581527 33 17.8270607 1.75580978 33 17.82706261
		 5.19996071 33 17.14197922 8.44427872 33 15.79814053 11.36408997 33 13.84718704 13.84718513 33 11.36409283
		 15.79813957 33 8.44428253 17.14198303 33 5.19996357 17.82706833 33 1.75581288 17.82705688 33 -1.75580657
		 17.14196396 35.66666794 -5.19994974 15.79812813 35.66666794 -8.44426632 13.84717846 35.66666794 -11.36407471
		 11.36408806 35.66666794 -13.84716797 8.44428253 35.66666794 -15.79812241 5.19996643 35.66666794 -17.14196396
		 1.7558192 35.66666794 -17.82704926 -1.75580323 35.66666794 -17.82705116 -5.19995165 35.66666794 -17.14196968
		 -8.44426918 35.66666794 -15.79813194 -11.36407852 35.66666794 -13.84718132 -13.84717178 35.66666794 -11.36408997
		 -15.79812813 35.66666794 -8.44428253 -17.14196968 35.66666794 -5.19996595 -17.82705498 35.66666794 -1.75581765
		 -17.82705688 35.66666794 1.75580621 -17.1419754 35.66666794 5.19995546 -15.79813766 35.66666794 8.44427395
		 -13.84718418 35.66666794 11.36408329 -11.36409187 35.66666794 13.84717751 -8.44428253 35.66666794 15.79813385
		 -5.199965 35.66666794 17.1419754 -1.75581527 35.66666794 17.8270607 1.75580978 35.66666794 17.82706261
		 5.19996071 35.66666794 17.14197922 8.44427872 35.66666794 15.79814053 11.36408997 35.66666794 13.84718704
		 13.84718513 35.66666794 11.36409283 15.79813957 35.66666794 8.44428253 17.14198303 35.66666794 5.19996357
		 17.82706833 35.66666794 1.75581288 17.82705688 35.66666794 -1.75580657 17.14196396 38.33333588 -5.19994974
		 15.79812813 38.33333588 -8.44426632 13.84717846 38.33333588 -11.36407471 11.36408806 38.33333588 -13.84716797
		 8.44428253 38.33333588 -15.79812241 5.19996643 38.33333588 -17.14196396 1.7558192 38.33333588 -17.82704926
		 -1.75580323 38.33333588 -17.82705116 -5.19995165 38.33333588 -17.14196968 -8.44426918 38.33333588 -15.79813194
		 -11.36407852 38.33333588 -13.84718132 -13.84717178 38.33333588 -11.36408997 -15.79812813 38.33333588 -8.44428253
		 -17.14196968 38.33333588 -5.19996595 -17.82705498 38.33333588 -1.75581765 -17.82705688 38.33333588 1.75580621
		 -17.1419754 38.33333588 5.19995546 -15.79813766 38.33333588 8.44427395 -13.84718418 38.33333588 11.36408329
		 -11.36409187 38.33333588 13.84717751 -8.44428253 38.33333588 15.79813385 -5.199965 38.33333588 17.1419754
		 -1.75581527 38.33333588 17.8270607 1.75580978 38.33333588 17.82706261 5.19996071 38.33333588 17.14197922
		 8.44427872 38.33333588 15.79814053 11.36408997 38.33333588 13.84718704 13.84718513 38.33333588 11.36409283
		 15.79813957 38.33333588 8.44428253 17.14198303 38.33333588 5.19996357 17.82706833 38.33333588 1.75581288
		 17.82705688 38.33333588 -1.75580657 16.97885895 41.52770615 -5.15047359 15.64780998 41.52770615 -8.36392021
		 13.71542263 41.52770615 -11.25594711 11.25595856 41.52770615 -13.71541405 8.36393452 41.52770615 -15.64780426
		 5.1504879 41.52770615 -16.97885895 1.73911178 41.52770615 -17.65742493 -1.73909771 41.52770615 -17.65742683
		 -5.15047503 41.52770615 -16.97886467 -8.36392307 41.52770615 -15.6478138 -11.25594997 41.52770615 -13.71542549
		 -13.71541691 41.52770615 -11.25596046 -15.64780998 41.52770615 -8.36393452 -16.97886467 41.52770615 -5.1504879
		 -17.65743065 41.52770615 -1.73911047 -17.65743256 41.52770615 1.73910046 -16.97887039 41.52770615 5.15047884
		 -15.64781761 41.52770615 8.36392689 -13.7154274 41.52770615 11.25595474 -11.25596237 41.52770615 13.71542168
		 -8.36393452 41.52770615 15.64781475 -5.15048695 41.52770615 16.97887039 -1.73910832 41.52770615 17.65743637
		 1.73910356 41.52770615 17.65743828 5.15048313 41.52770615 16.97887421 8.36393166 41.52770615 15.64782047
		 11.25596046 41.52770615 13.71543026 13.7154274 41.52770615 11.25596333 15.64781952 41.52770615 8.36393452
		 16.97887611 41.52770615 5.15048599 17.657444 41.52770615 1.73910618 17.65743256 41.52770615 -1.73910058
		 15.53574181 47.75721741 -4.71271515 14.31782246 47.75721741 -7.65303469 12.5496769 47.75721741 -10.29925156
		 10.29925346 47.75721741 -12.54967499 7.65303707 47.75721741 -14.31782055 4.71271706 47.75721741 -15.53574181
		 1.59129047 47.75721741 -16.15663147 -1.59128833 47.75721741 -16.15663147 -4.71271515 47.75721741 -15.53574276
		 -7.65303516 47.75721741 -14.31782341 -10.29925251 47.75721741 -12.5496769 -12.54967594 47.75721741 -10.29925346
		 -14.3178215 47.75721741 -7.65303707 -15.53574276 47.75721741 -4.71271706 -16.15663338 47.75721741 -1.59129024
		 -16.15663338 47.75721741 1.59128881 -15.53574371 47.75721741 4.71271563 -14.31782341 47.75721741 7.65303564
		 -12.5496769 47.75721741 10.29925346 -10.29925346 47.75721741 12.5496769 -7.65303707 47.75721741 14.31782246
		 -4.71271706 47.75721741 15.53574371 -1.59128988 47.75721741 16.15663338 1.59128928 47.75721741 16.15663338
		 4.7127161 47.75721741 15.53574371 7.65303612 47.75721741 14.31782436 10.29925346 47.75721741 12.54967785
		 12.5496769 47.75721741 10.29925346 14.31782341 47.75721741 7.65303707 15.53574467 47.75721741 4.71271658
		 16.15663528 47.75721741 1.59128964 16.15663338 47.75721741 -1.59128881 11.89054489 53.48570251 -3.6069572
		 10.95838833 53.48570251 -5.85738039 9.60510731 53.48570251 -7.8827076 7.8827076 53.48570251 -9.60510731
		 5.85738039 53.48570251 -10.95838737 3.6069572 53.48570251 -11.89054489 1.21792042 53.48570251 -12.36575317
		 -1.21792042 53.48570251 -12.36575317;
	setAttr ".vt[1162:1327]" -3.6069572 53.48570251 -11.89054489 -5.85738039 53.48570251 -10.95838833
		 -7.8827076 53.48570251 -9.60510731 -9.60510731 53.48570251 -7.8827076 -10.95838737 53.48570251 -5.85738039
		 -11.89054489 53.48570251 -3.6069572 -12.36575317 53.48570251 -1.21792042 -12.36575317 53.48570251 1.21792042
		 -11.89054489 53.48570251 3.6069572 -10.95838833 53.48570251 5.85738039 -9.60510731 53.48570251 7.8827076
		 -7.8827076 53.48570251 9.60510731 -5.85738039 53.48570251 10.95838737 -3.6069572 53.48570251 11.89054489
		 -1.21792042 53.48570251 12.36575317 1.21792042 53.48570251 12.36575317 3.6069572 53.48570251 11.89054489
		 5.85738039 53.48570251 10.95838833 7.8827076 53.48570251 9.60510731 9.60510731 53.48570251 7.8827076
		 10.95838737 53.48570251 5.85738039 11.89054489 53.48570251 3.6069572 12.36575317 53.48570251 1.21792042
		 12.36575317 53.48570251 -1.21792042 6.70844746 57.25627136 -2.034985304 6.18254042 57.25627136 -3.30463696
		 5.41904211 57.25627136 -4.44729328 4.44729328 57.25627136 -5.41904211 3.30463696 57.25627136 -6.18254042
		 2.034985304 57.25627136 -6.70844746 0.68713045 57.25627136 -6.97655296 -0.68713045 57.25627136 -6.97655296
		 -2.034985304 57.25627136 -6.70844746 -3.30463696 57.25627136 -6.18254042 -4.44729328 57.25627136 -5.41904211
		 -5.41904211 57.25627136 -4.44729328 -6.18254042 57.25627136 -3.30463696 -6.70844746 57.25627136 -2.034985304
		 -6.97655296 57.25627136 -0.68713045 -6.97655296 57.25627136 0.68713045 -6.70844746 57.25627136 2.034985304
		 -6.18254042 57.25627136 3.30463696 -5.41904211 57.25627136 4.44729328 -4.44729328 57.25627136 5.41904211
		 -3.30463696 57.25627136 6.18254042 -2.034985304 57.25627136 6.70844746 -0.68713045 57.25627136 6.97655296
		 0.68713045 57.25627136 6.97655296 2.034985304 57.25627136 6.70844746 3.30463696 57.25627136 6.18254042
		 4.44729328 57.25627136 5.41904211 5.41904211 57.25627136 4.44729328 6.18254042 57.25627136 3.30463696
		 6.70844746 57.25627136 2.034985304 6.97655296 57.25627136 0.68713045 6.97655296 57.25627136 -0.68713045
		 9.57344246 -5.67887592 -1.90427589 9.01798439 -5.67887592 -3.73537183 8.11597157 -5.67887592 -5.42291927
		 6.90206623 -5.67887592 -6.90206718 5.4229188 -5.67887592 -8.11597157 3.73537159 -5.67887592 -9.017985344
		 1.90427589 -5.67887592 -9.57344246 0 -5.67887592 -9.76099682 -1.90427589 -5.67887592 -9.57344246
		 -3.73537183 -5.67887592 -9.01798439 -5.42291927 -5.67887592 -8.11597157 -6.90206718 -5.67887592 -6.90206623
		 -8.11597157 -5.67887592 -5.4229188 -9.017985344 -5.67887592 -3.73537159 -9.57344246 -5.67887592 -1.90427589
		 -9.76099682 -5.67887592 0 -9.57344246 -5.67887592 1.90427589 -9.01798439 -5.67887592 3.73537183
		 -8.11597157 -5.67887592 5.42291927 -6.90206623 -5.67887592 6.90206718 -5.4229188 -5.67887592 8.11597157
		 -3.73537159 -5.67887592 9.017985344 -1.90427589 -5.67887592 9.57344246 0 -5.67887592 9.76099682
		 1.90427589 -5.67887592 9.57344246 3.73537183 -5.67887592 9.01798439 5.42291927 -5.67887592 8.11597157
		 6.90206718 -5.67887592 6.90206623 8.11597157 -5.67887592 5.4229188 9.017985344 -5.67887592 3.73537159
		 9.57344246 -5.67887592 1.90427589 9.76099682 -5.67887592 0 14.32766914 -0.80811214 -2.84995031
		 13.49636841 -0.80811214 -5.59037876 12.14641094 -0.80811214 -8.11597252 10.32967186 -0.80811214 -10.32967186
		 8.11597157 -0.80811214 -12.14640999 5.59037876 -0.80811214 -13.49636841 2.84995031 -0.80811214 -14.32766724
		 0 -0.80811214 -14.60836411 -2.84995031 -0.80811214 -14.32766914 -5.59037876 -0.80811214 -13.49636841
		 -8.11597252 -0.80811214 -12.14641094 -10.32967186 -0.80811214 -10.32967186 -12.14640999 -0.80811214 -8.11597157
		 -13.49636841 -0.80811214 -5.59037876 -14.32766724 -0.80811214 -2.84995031 -14.60836411 -0.80811214 0
		 -14.32766914 -0.80811214 2.84995031 -13.49636841 -0.80811214 5.59037876 -12.14641094 -0.80811214 8.11597252
		 -10.32967186 -0.80811214 10.32967186 -8.11597157 -0.80811214 12.14640999 -5.59037876 -0.80811214 13.49636841
		 -2.84995031 -0.80811214 14.32766724 0 -0.80811214 14.60836411 2.84995031 -0.80811214 14.32766914
		 5.59037876 -0.80811214 13.49636841 8.11597252 -0.80811214 12.14641094 10.32967186 -0.80811214 10.32967186
		 12.14640999 -0.80811214 8.11597157 13.49636841 -0.80811214 5.59037876 14.32766724 -0.80811214 2.84995031
		 14.60836411 -0.80811214 0 16.90062904 5.55584908 -3.36174011 15.92004395 5.55584908 -6.59429359
		 14.32766247 5.55584908 -9.57343292 12.18467712 5.55584908 -12.18467045 9.57344055 5.55584908 -14.3276577
		 6.59430218 5.55584908 -15.92004204 3.36174798 5.55584908 -16.90062714 4.0233135e-06 5.55584908 -17.23173141
		 -3.36174011 5.55584908 -16.90062904 -6.59429502 5.55584908 -15.92004585 -9.57343483 5.55584908 -14.32766438
		 -12.18467331 5.55584908 -12.18467712 -14.32766056 5.55584908 -9.57344055 -15.9200449 5.55584908 -6.59430218
		 -16.90063095 5.55584908 -3.3617475 -17.23173523 5.55584908 -2.8610229e-06 -16.90063095 5.55584908 3.36174202
		 -15.92004871 5.55584908 6.59429741 -14.32766628 5.55584908 9.57343769 -12.18467903 5.55584908 12.18467522
		 -9.57344151 5.55584908 14.32766438 -6.5943017 5.55584908 15.92004871 -3.36174679 5.55584908 16.90063477
		 -1.4305115e-06 5.55584908 17.23173714 3.36174417 5.55584908 16.90063477 6.59429932 5.55584908 15.92005157
		 9.57344055 5.55584908 14.32766724 12.18467903 5.55584908 12.18467999 14.32766724 5.55584908 9.57344151
		 15.92005157 5.55584908 6.59430122 16.90063667 5.55584908 3.3617456 17.23173904 5.55584908 8.046627e-07
		 17.56931305 10.33333397 -3.49474573 16.54993057 10.33333397 -6.85519695 14.89454746 10.33333397 -9.95220852
		 12.66677475 10.33333397 -12.6667614 9.95222282 10.33333397 -14.89453888 6.85521364 10.33333397 -16.54992676
		 3.49476147 10.33333397 -17.56931114 8.0168247e-06 10.33333397 -17.913517 -3.49474621 10.33333397 -17.56931496
		 -6.85519934 10.33333397 -16.54993629 -9.95221138 10.33333397 -14.89455032 -12.66676617 10.33333397 -12.66677666
		 -14.89454269 10.33333397 -9.95222473 -16.54993248 10.33333397 -6.85521364;
	setAttr ".vt[1328:1493]" -17.56931686 10.33333397 -3.49476051 -17.91352272 10.33333397 -5.8114529e-06
		 -17.56932068 10.33333397 3.49474955 -16.54994202 10.33333397 6.85520363 -14.89455414 10.33333397 9.95221615
		 -12.66677856 10.33333397 12.66677094 -9.95222473 10.33333397 14.89455032 -6.85521269 10.33333397 16.5499382
		 -3.49475908 10.33333397 17.56932449 -2.8610229e-06 10.33333397 17.91352844 3.49475384 10.33333397 17.56932449
		 6.85520887 10.33333397 16.54994392 9.95222282 10.33333397 14.89455795 12.66677856 10.33333397 12.66678143
		 14.89455605 10.33333397 9.95222569 16.54994583 10.33333397 6.85521221 17.56933022 10.33333397 3.49475694
		 17.91353226 10.33333397 1.5795231e-06 17.56931305 13 -3.49474573 16.54993057 13 -6.85519695
		 14.89454746 13 -9.95220852 12.66677475 13 -12.6667614 9.95222282 13 -14.89453888
		 6.85521364 13 -16.54992676 3.49476147 13 -17.56931114 8.0168247e-06 13 -17.913517
		 -3.49474621 13 -17.56931496 -6.85519934 13 -16.54993629 -9.95221138 13 -14.89455032
		 -12.66676617 13 -12.66677666 -14.89454269 13 -9.95222473 -16.54993248 13 -6.85521364
		 -17.56931686 13 -3.49476051 -17.91352272 13 -5.8114529e-06 -17.56932068 13 3.49474955
		 -16.54994202 13 6.85520363 -14.89455414 13 9.95221615 -12.66677856 13 12.66677094
		 -9.95222473 13 14.89455032 -6.85521269 13 16.5499382 -3.49475908 13 17.56932449 -2.8610229e-06 13 17.91352844
		 3.49475384 13 17.56932449 6.85520887 13 16.54994392 9.95222282 13 14.89455795 12.66677856 13 12.66678143
		 14.89455605 13 9.95222569 16.54994583 13 6.85521221 17.56933022 13 3.49475694 17.91353226 13 1.5795231e-06
		 17.56931305 15.66666698 -3.49474573 16.54993057 15.66666698 -6.85519695 14.89454746 15.66666698 -9.95220852
		 12.66677475 15.66666698 -12.6667614 9.95222282 15.66666698 -14.89453888 6.85521364 15.66666698 -16.54992676
		 3.49476147 15.66666698 -17.56931114 8.0168247e-06 15.66666698 -17.913517 -3.49474621 15.66666698 -17.56931496
		 -6.85519934 15.66666698 -16.54993629 -9.95221138 15.66666698 -14.89455032 -12.66676617 15.66666698 -12.66677666
		 -14.89454269 15.66666698 -9.95222473 -16.54993248 15.66666698 -6.85521364 -17.56931686 15.66666698 -3.49476051
		 -17.91352272 15.66666698 -5.8114529e-06 -17.56932068 15.66666698 3.49474955 -16.54994202 15.66666698 6.85520363
		 -14.89455414 15.66666698 9.95221615 -12.66677856 15.66666698 12.66677094 -9.95222473 15.66666698 14.89455032
		 -6.85521269 15.66666698 16.5499382 -3.49475908 15.66666698 17.56932449 -2.8610229e-06 15.66666698 17.91352844
		 3.49475384 15.66666698 17.56932449 6.85520887 15.66666698 16.54994392 9.95222282 15.66666698 14.89455795
		 12.66677856 15.66666698 12.66678143 14.89455605 15.66666698 9.95222569 16.54994583 15.66666698 6.85521221
		 17.56933022 15.66666698 3.49475694 17.91353226 15.66666698 1.5795231e-06 17.56931305 18.33333397 -3.49474573
		 16.54993057 18.33333397 -6.85519695 14.89454746 18.33333397 -9.95220852 12.66677475 18.33333397 -12.6667614
		 9.95222282 18.33333397 -14.89453888 6.85521364 18.33333397 -16.54992676 3.49476147 18.33333397 -17.56931114
		 8.0168247e-06 18.33333397 -17.913517 -3.49474621 18.33333397 -17.56931496 -6.85519934 18.33333397 -16.54993629
		 -9.95221138 18.33333397 -14.89455032 -12.66676617 18.33333397 -12.66677666 -14.89454269 18.33333397 -9.95222473
		 -16.54993248 18.33333397 -6.85521364 -17.56931686 18.33333397 -3.49476051 -17.91352272 18.33333397 -5.8114529e-06
		 -17.56932068 18.33333397 3.49474955 -16.54994202 18.33333397 6.85520363 -14.89455414 18.33333397 9.95221615
		 -12.66677856 18.33333397 12.66677094 -9.95222473 18.33333397 14.89455032 -6.85521269 18.33333397 16.5499382
		 -3.49475908 18.33333397 17.56932449 -2.8610229e-06 18.33333397 17.91352844 3.49475384 18.33333397 17.56932449
		 6.85520887 18.33333397 16.54994392 9.95222282 18.33333397 14.89455795 12.66677856 18.33333397 12.66678143
		 14.89455605 18.33333397 9.95222569 16.54994583 18.33333397 6.85521221 17.56933022 18.33333397 3.49475694
		 17.91353226 18.33333397 1.5795231e-06 17.56931305 21 -3.49474573 16.54993057 21 -6.85519695
		 14.89454746 21 -9.95220852 12.66677475 21 -12.6667614 9.95222282 21 -14.89453888
		 6.85521364 21 -16.54992676 3.49476147 21 -17.56931114 8.0168247e-06 21 -17.913517
		 -3.49474621 21 -17.56931496 -6.85519934 21 -16.54993629 -9.95221138 21 -14.89455032
		 -12.66676617 21 -12.66677666 -14.89454269 21 -9.95222473 -16.54993248 21 -6.85521364
		 -17.56931686 21 -3.49476051 -17.91352272 21 -5.8114529e-06 -17.56932068 21 3.49474955
		 -16.54994202 21 6.85520363 -14.89455414 21 9.95221615 -12.66677856 21 12.66677094
		 -9.95222473 21 14.89455032 -6.85521269 21 16.5499382 -3.49475908 21 17.56932449 -2.8610229e-06 21 17.91352844
		 3.49475384 21 17.56932449 6.85520887 21 16.54994392 9.95222282 21 14.89455795 12.66677856 21 12.66678143
		 14.89455605 21 9.95222569 16.54994583 21 6.85521221 17.56933022 21 3.49475694 17.91353226 21 1.5795231e-06
		 17.56931305 23.66666794 -3.49474573 16.54993057 23.66666794 -6.85519695 14.89454746 23.66666794 -9.95220852
		 12.66677475 23.66666794 -12.6667614 9.95222282 23.66666794 -14.89453888 6.85521364 23.66666794 -16.54992676
		 3.49476147 23.66666794 -17.56931114 8.0168247e-06 23.66666794 -17.913517 -3.49474621 23.66666794 -17.56931496
		 -6.85519934 23.66666794 -16.54993629 -9.95221138 23.66666794 -14.89455032 -12.66676617 23.66666794 -12.66677666
		 -14.89454269 23.66666794 -9.95222473 -16.54993248 23.66666794 -6.85521364 -17.56931686 23.66666794 -3.49476051
		 -17.91352272 23.66666794 -5.8114529e-06 -17.56932068 23.66666794 3.49474955 -16.54994202 23.66666794 6.85520363
		 -14.89455414 23.66666794 9.95221615 -12.66677856 23.66666794 12.66677094;
	setAttr ".vt[1494:1659]" -9.95222473 23.66666794 14.89455032 -6.85521269 23.66666794 16.5499382
		 -3.49475908 23.66666794 17.56932449 -2.8610229e-06 23.66666794 17.91352844 3.49475384 23.66666794 17.56932449
		 6.85520887 23.66666794 16.54994392 9.95222282 23.66666794 14.89455795 12.66677856 23.66666794 12.66678143
		 14.89455605 23.66666794 9.95222569 16.54994583 23.66666794 6.85521221 17.56933022 23.66666794 3.49475694
		 17.91353226 23.66666794 1.5795231e-06 17.56931305 26.33333588 -3.49474573 16.54993057 26.33333588 -6.85519695
		 14.89454746 26.33333588 -9.95220852 12.66677475 26.33333588 -12.6667614 9.95222282 26.33333588 -14.89453888
		 6.85521364 26.33333588 -16.54992676 3.49476147 26.33333588 -17.56931114 8.0168247e-06 26.33333588 -17.913517
		 -3.49474621 26.33333588 -17.56931496 -6.85519934 26.33333588 -16.54993629 -9.95221138 26.33333588 -14.89455032
		 -12.66676617 26.33333588 -12.66677666 -14.89454269 26.33333588 -9.95222473 -16.54993248 26.33333588 -6.85521364
		 -17.56931686 26.33333588 -3.49476051 -17.91352272 26.33333588 -5.8114529e-06 -17.56932068 26.33333588 3.49474955
		 -16.54994202 26.33333588 6.85520363 -14.89455414 26.33333588 9.95221615 -12.66677856 26.33333588 12.66677094
		 -9.95222473 26.33333588 14.89455032 -6.85521269 26.33333588 16.5499382 -3.49475908 26.33333588 17.56932449
		 -2.8610229e-06 26.33333588 17.91352844 3.49475384 26.33333588 17.56932449 6.85520887 26.33333588 16.54994392
		 9.95222282 26.33333588 14.89455795 12.66677856 26.33333588 12.66678143 14.89455605 26.33333588 9.95222569
		 16.54994583 26.33333588 6.85521221 17.56933022 26.33333588 3.49475694 17.91353226 26.33333588 1.5795231e-06
		 17.56931305 29.000001907349 -3.49474573 16.54993057 29.000001907349 -6.85519695 14.89454746 29.000001907349 -9.95220852
		 12.66677475 29.000001907349 -12.6667614 9.95222282 29.000001907349 -14.89453888 6.85521364 29.000001907349 -16.54992676
		 3.49476147 29.000001907349 -17.56931114 8.0168247e-06 29.000001907349 -17.913517
		 -3.49474621 29.000001907349 -17.56931496 -6.85519934 29.000001907349 -16.54993629
		 -9.95221138 29.000001907349 -14.89455032 -12.66676617 29.000001907349 -12.66677666
		 -14.89454269 29.000001907349 -9.95222473 -16.54993248 29.000001907349 -6.85521364
		 -17.56931686 29.000001907349 -3.49476051 -17.91352272 29.000001907349 -5.8114529e-06
		 -17.56932068 29.000001907349 3.49474955 -16.54994202 29.000001907349 6.85520363 -14.89455414 29.000001907349 9.95221615
		 -12.66677856 29.000001907349 12.66677094 -9.95222473 29.000001907349 14.89455032
		 -6.85521269 29.000001907349 16.5499382 -3.49475908 29.000001907349 17.56932449 -2.8610229e-06 29.000001907349 17.91352844
		 3.49475384 29.000001907349 17.56932449 6.85520887 29.000001907349 16.54994392 9.95222282 29.000001907349 14.89455795
		 12.66677856 29.000001907349 12.66678143 14.89455605 29.000001907349 9.95222569 16.54994583 29.000001907349 6.85521221
		 17.56933022 29.000001907349 3.49475694 17.91353226 29.000001907349 1.5795231e-06
		 17.56931305 31.66666794 -3.49474573 16.54993057 31.66666794 -6.85519695 14.89454746 31.66666794 -9.95220852
		 12.66677475 31.66666794 -12.6667614 9.95222282 31.66666794 -14.89453888 6.85521364 31.66666794 -16.54992676
		 3.49476147 31.66666794 -17.56931114 8.0168247e-06 31.66666794 -17.913517 -3.49474621 31.66666794 -17.56931496
		 -6.85519934 31.66666794 -16.54993629 -9.95221138 31.66666794 -14.89455032 -12.66676617 31.66666794 -12.66677666
		 -14.89454269 31.66666794 -9.95222473 -16.54993248 31.66666794 -6.85521364 -17.56931686 31.66666794 -3.49476051
		 -17.91352272 31.66666794 -5.8114529e-06 -17.56932068 31.66666794 3.49474955 -16.54994202 31.66666794 6.85520363
		 -14.89455414 31.66666794 9.95221615 -12.66677856 31.66666794 12.66677094 -9.95222473 31.66666794 14.89455032
		 -6.85521269 31.66666794 16.5499382 -3.49475908 31.66666794 17.56932449 -2.8610229e-06 31.66666794 17.91352844
		 3.49475384 31.66666794 17.56932449 6.85520887 31.66666794 16.54994392 9.95222282 31.66666794 14.89455795
		 12.66677856 31.66666794 12.66678143 14.89455605 31.66666794 9.95222569 16.54994583 31.66666794 6.85521221
		 17.56933022 31.66666794 3.49475694 17.91353226 31.66666794 1.5795231e-06 17.56931305 34.33333588 -3.49474573
		 16.54993057 34.33333588 -6.85519695 14.89454746 34.33333588 -9.95220852 12.66677475 34.33333588 -12.6667614
		 9.95222282 34.33333588 -14.89453888 6.85521364 34.33333588 -16.54992676 3.49476147 34.33333588 -17.56931114
		 8.0168247e-06 34.33333588 -17.913517 -3.49474621 34.33333588 -17.56931496 -6.85519934 34.33333588 -16.54993629
		 -9.95221138 34.33333588 -14.89455032 -12.66676617 34.33333588 -12.66677666 -14.89454269 34.33333588 -9.95222473
		 -16.54993248 34.33333588 -6.85521364 -17.56931686 34.33333588 -3.49476051 -17.91352272 34.33333588 -5.8114529e-06
		 -17.56932068 34.33333588 3.49474955 -16.54994202 34.33333588 6.85520363 -14.89455414 34.33333588 9.95221615
		 -12.66677856 34.33333588 12.66677094 -9.95222473 34.33333588 14.89455032 -6.85521269 34.33333588 16.5499382
		 -3.49475908 34.33333588 17.56932449 -2.8610229e-06 34.33333588 17.91352844 3.49475384 34.33333588 17.56932449
		 6.85520887 34.33333588 16.54994392 9.95222282 34.33333588 14.89455795 12.66677856 34.33333588 12.66678143
		 14.89455605 34.33333588 9.95222569 16.54994583 34.33333588 6.85521221 17.56933022 34.33333588 3.49475694
		 17.91353226 34.33333588 1.5795231e-06 17.56931305 37 -3.49474573 16.54993057 37 -6.85519695
		 14.89454746 37 -9.95220852 12.66677475 37 -12.6667614 9.95222282 37 -14.89453888
		 6.85521364 37 -16.54992676 3.49476147 37 -17.56931114 8.0168247e-06 37 -17.913517
		 -3.49474621 37 -17.56931496 -6.85519934 37 -16.54993629 -9.95221138 37 -14.89455032
		 -12.66676617 37 -12.66677666 -14.89454269 37 -9.95222473 -16.54993248 37 -6.85521364
		 -17.56931686 37 -3.49476051 -17.91352272 37 -5.8114529e-06 -17.56932068 37 3.49474955
		 -16.54994202 37 6.85520363 -14.89455414 37 9.95221615 -12.66677856 37 12.66677094
		 -9.95222473 37 14.89455032 -6.85521269 37 16.5499382 -3.49475908 37 17.56932449 -2.8610229e-06 37 17.91352844
		 3.49475384 37 17.56932449 6.85520887 37 16.54994392;
	setAttr ".vt[1660:1825]" 9.95222282 37 14.89455795 12.66677856 37 12.66678143
		 14.89455605 37 9.95222569 16.54994583 37 6.85521221 17.56933022 37 3.49475694 17.91353226 37 1.5795231e-06
		 17.56931305 39.66666794 -3.49474573 16.54993057 39.66666794 -6.85519695 14.89454746 39.66666794 -9.95220852
		 12.66677475 39.66666794 -12.6667614 9.95222282 39.66666794 -14.89453888 6.85521364 39.66666794 -16.54992676
		 3.49476147 39.66666794 -17.56931114 8.0168247e-06 39.66666794 -17.913517 -3.49474621 39.66666794 -17.56931496
		 -6.85519934 39.66666794 -16.54993629 -9.95221138 39.66666794 -14.89455032 -12.66676617 39.66666794 -12.66677666
		 -14.89454269 39.66666794 -9.95222473 -16.54993248 39.66666794 -6.85521364 -17.56931686 39.66666794 -3.49476051
		 -17.91352272 39.66666794 -5.8114529e-06 -17.56932068 39.66666794 3.49474955 -16.54994202 39.66666794 6.85520363
		 -14.89455414 39.66666794 9.95221615 -12.66677856 39.66666794 12.66677094 -9.95222473 39.66666794 14.89455032
		 -6.85521269 39.66666794 16.5499382 -3.49475908 39.66666794 17.56932449 -2.8610229e-06 39.66666794 17.91352844
		 3.49475384 39.66666794 17.56932449 6.85520887 39.66666794 16.54994392 9.95222282 39.66666794 14.89455795
		 12.66677856 39.66666794 12.66678143 14.89455605 39.66666794 9.95222569 16.54994583 39.66666794 6.85521221
		 17.56933022 39.66666794 3.49475694 17.91353226 39.66666794 1.5795231e-06 16.90062904 44.44415283 -3.36173987
		 15.92004395 44.44415283 -6.59429359 14.32766247 44.44415283 -9.57343292 12.18467712 44.44415283 -12.1846714
		 9.57344055 44.44415283 -14.32765865 6.59430218 44.44415283 -15.92004204 3.36174798 44.44415283 -16.90062714
		 4.0531158e-06 44.44415283 -17.23173141 -3.36174011 44.44415283 -16.90062904 -6.59429502 44.44415283 -15.92004585
		 -9.57343483 44.44415283 -14.32766438 -12.18467236 44.44415283 -12.18467712 -14.32766056 44.44415283 -9.57344151
		 -15.9200449 44.44415283 -6.59430218 -16.90063095 44.44415283 -3.3617475 -17.23173523 44.44415283 -2.8908253e-06
		 -16.90063095 44.44415283 3.36174202 -15.92004871 44.44415283 6.59429741 -14.32766533 44.44415283 9.57343674
		 -12.18467903 44.44415283 12.18467522 -9.57344151 44.44415283 14.32766438 -6.5943017 44.44415283 15.92004776
		 -3.36174679 44.44415283 16.90063477 -1.4305115e-06 44.44415283 17.23173714 3.36174417 44.44415283 16.90063477
		 6.59429932 44.44415283 15.92005157 9.57344055 44.44415283 14.32766819 12.18467903 44.44415283 12.18467999
		 14.32766724 44.44415283 9.57344151 15.92005157 44.44415283 6.59430122 16.90063667 44.44415283 3.3617456
		 17.23173904 44.44415283 8.046627e-07 14.32766914 50.80810928 -2.84995031 13.49636841 50.80810928 -5.59037876
		 12.14641094 50.80810928 -8.11597252 10.32967186 50.80810928 -10.32967186 8.11597252 50.80810928 -12.14640999
		 5.59037876 50.80810928 -13.49636841 2.84995031 50.80810928 -14.32766724 0 50.80810928 -14.60836411
		 -2.84995031 50.80810928 -14.32766914 -5.59037876 50.80810928 -13.49636841 -8.11597252 50.80810928 -12.14641094
		 -10.32967186 50.80810928 -10.32967186 -12.14640999 50.80810928 -8.11597252 -13.49636841 50.80810928 -5.59037876
		 -14.32766724 50.80810928 -2.84995031 -14.60836411 50.80810928 0 -14.32766914 50.80810928 2.84995031
		 -13.49636841 50.80810928 5.59037876 -12.14641094 50.80810928 8.11597252 -10.32967186 50.80810928 10.32967186
		 -8.11597252 50.80810928 12.14640999 -5.59037876 50.80810928 13.49636841 -2.84995031 50.80810928 14.32766724
		 0 50.80810928 14.60836411 2.84995031 50.80810928 14.32766914 5.59037876 50.80810928 13.49636841
		 8.11597252 50.80810928 12.14641094 10.32967186 50.80810928 10.32967186 12.14640999 50.80810928 8.11597252
		 13.49636841 50.80810928 5.59037876 14.32766724 50.80810928 2.84995031 14.60836411 50.80810928 0
		 9.57344246 55.67887115 -1.90427589 9.01798439 55.67887115 -3.73537159 8.11597157 55.67887115 -5.4229188
		 6.90206623 55.67887115 -6.90206623 5.4229188 55.67887115 -8.11597157 3.73537159 55.67887115 -9.017985344
		 1.90427589 55.67887115 -9.57344246 0 55.67887115 -9.76099682 -1.90427589 55.67887115 -9.57344246
		 -3.73537159 55.67887115 -9.01798439 -5.4229188 55.67887115 -8.11597157 -6.90206623 55.67887115 -6.90206623
		 -8.11597157 55.67887115 -5.4229188 -9.017985344 55.67887115 -3.73537159 -9.57344246 55.67887115 -1.90427589
		 -9.76099682 55.67887115 0 -9.57344246 55.67887115 1.90427589 -9.01798439 55.67887115 3.73537159
		 -8.11597157 55.67887115 5.4229188 -6.90206623 55.67887115 6.90206623 -5.4229188 55.67887115 8.11597157
		 -3.73537159 55.67887115 9.017985344 -1.90427589 55.67887115 9.57344246 0 55.67887115 9.76099682
		 1.90427589 55.67887115 9.57344246 3.73537159 55.67887115 9.01798439 5.4229188 55.67887115 8.11597157
		 6.90206623 55.67887115 6.90206623 8.11597157 55.67887115 5.4229188 9.017985344 55.67887115 3.73537159
		 9.57344246 55.67887115 1.90427589 9.76099682 55.67887115 0 3.9193325 -8.20073414 -0.77960366
		 3.69193029 -8.20073414 -1.52924764 3.32264948 -8.20073414 -2.22012353 2.82568121 -8.20073414 -2.82568121
		 2.22012329 -8.20073414 -3.32264948 1.52924776 -8.20073414 -3.69193029 0.77960366 -8.20073414 -3.91933227
		 0 -8.20073414 -3.99611664 -0.77960366 -8.20073414 -3.9193325 -1.52924764 -8.20073414 -3.69193029
		 -2.22012353 -8.20073414 -3.32264948 -2.82568121 -8.20073414 -2.82568121 -3.32264948 -8.20073414 -2.22012329
		 -3.69193029 -8.20073414 -1.52924776 -3.91933227 -8.20073414 -0.77960366 -3.99611664 -8.20073414 0
		 -3.9193325 -8.20073414 0.77960366 -3.69193029 -8.20073414 1.52924764 -3.32264948 -8.20073414 2.22012353
		 -2.82568121 -8.20073414 2.82568121 -2.22012329 -8.20073414 3.32264948 -1.52924776 -8.20073414 3.69193029
		 -0.77960366 -8.20073414 3.91933227 0 -8.20073414 3.99611664 0.77960366 -8.20073414 3.9193325
		 1.52924764 -8.20073414 3.69193029 2.22012353 -8.20073414 3.32264948 2.82568121 -8.20073414 2.82568121
		 3.32264948 -8.20073414 2.22012329 3.69193029 -8.20073414 1.52924776 3.91933227 -8.20073414 0.77960366
		 3.99611664 -8.20073414 0;
	setAttr ".vt[1826:1991]" 3.9193325 58.200737 -0.77960366 3.69193029 58.200737 -1.52924764
		 3.32264948 58.200737 -2.22012353 2.82568121 58.200737 -2.82568121 2.22012329 58.200737 -3.32264948
		 1.52924776 58.200737 -3.69193029 0.77960366 58.200737 -3.91933227 0 58.200737 -3.99611664
		 -0.77960366 58.200737 -3.9193325 -1.52924764 58.200737 -3.69193029 -2.22012353 58.200737 -3.32264948
		 -2.82568121 58.200737 -2.82568121 -3.32264948 58.200737 -2.22012329 -3.69193029 58.200737 -1.52924776
		 -3.91933227 58.200737 -0.77960366 -3.99611664 58.200737 0 -3.9193325 58.200737 0.77960366
		 -3.69193029 58.200737 1.52924764 -3.32264948 58.200737 2.22012353 -2.82568121 58.200737 2.82568121
		 -2.22012329 58.200737 3.32264948 -1.52924776 58.200737 3.69193029 -0.77960366 58.200737 3.91933227
		 0 58.200737 3.99611664 0.77960366 58.200737 3.9193325 1.52924764 58.200737 3.69193029
		 2.22012353 58.200737 3.32264948 2.82568121 58.200737 2.82568121 3.32264948 58.200737 2.22012329
		 3.69193029 58.200737 1.52924776 3.91933227 58.200737 0.77960366 3.99611664 58.200737 0
		 9.34058189 -5.67887592 -2.83343482 8.60832977 -5.67887592 -4.60124874 7.54526424 -5.67887592 -6.19223881
		 6.19223881 -5.67887592 -7.54526424 4.60124826 -5.67887592 -8.60832977 2.83343482 -5.67887592 -9.34058285
		 0.95673382 -5.67887592 -9.71388245 -0.95673382 -5.67887592 -9.71388149 -2.83343482 -5.67887592 -9.34058189
		 -4.60124874 -5.67887592 -8.60832977 -6.19223881 -5.67887592 -7.54526424 -7.54526424 -5.67887592 -6.19223881
		 -8.60832977 -5.67887592 -4.60124826 -9.34058285 -5.67887592 -2.83343482 -9.71388245 -5.67887592 -0.95673382
		 -9.71388149 -5.67887592 0.95673382 -9.34058189 -5.67887592 2.83343482 -8.60832977 -5.67887592 4.60124874
		 -7.54526424 -5.67887592 6.19223881 -6.19223881 -5.67887592 7.54526424 -4.60124826 -5.67887592 8.60832977
		 -2.83343482 -5.67887592 9.34058285 -0.95673382 -5.67887592 9.71388245 0.95673382 -5.67887592 9.71388149
		 2.83343482 -5.67887592 9.34058189 4.60124874 -5.67887592 8.60832977 6.19223881 -5.67887592 7.54526424
		 7.54526424 -5.67887592 6.19223881 8.60832977 -5.67887592 4.60124826 9.34058285 -5.67887592 2.83343482
		 9.71388245 -5.67887592 0.95673382 9.71388149 -5.67887592 -0.95673382 13.97916985 -0.80811214 -4.24053478
		 12.88327599 -0.80811214 -6.88625431 11.29228592 -0.80811214 -9.26733971 9.26733971 -0.80811214 -11.29228592
		 6.88625431 -0.80811214 -12.88327599 4.24053478 -0.80811214 -13.97916985 1.43185329 -0.80811214 -14.53785133
		 -1.43185329 -0.80811214 -14.53785133 -4.24053478 -0.80811214 -13.97916985 -6.88625431 -0.80811214 -12.88327599
		 -9.26733971 -0.80811214 -11.29228592 -11.29228592 -0.80811214 -9.26733971 -12.88327599 -0.80811214 -6.88625431
		 -13.97916985 -0.80811214 -4.24053478 -14.53785133 -0.80811214 -1.43185329 -14.53785133 -0.80811214 1.43185329
		 -13.97916985 -0.80811214 4.24053478 -12.88327599 -0.80811214 6.88625431 -11.29228592 -0.80811214 9.26733971
		 -9.26733971 -0.80811214 11.29228592 -6.88625431 -0.80811214 12.88327599 -4.24053478 -0.80811214 13.97916985
		 -1.43185329 -0.80811214 14.53785133 1.43185329 -0.80811214 14.53785133 4.24053478 -0.80811214 13.97916985
		 6.88625431 -0.80811214 12.88327599 9.26733971 -0.80811214 11.29228592 11.29228592 -0.80811214 9.26733971
		 12.88327599 -0.80811214 6.88625431 13.97916985 -0.80811214 4.24053478 14.53785133 -0.80811214 1.43185329
		 14.53785133 -0.80811214 -1.43185329 16.48954582 5.55584908 -5.0020451546 15.19685364 5.55584908 -8.12288284
		 13.32015514 5.55584908 -10.93156242 10.93157005 5.55584908 -13.32014942 8.12289047 5.55584908 -15.19684982
		 5.0020532608 5.55584908 -16.48954582 1.6889894 5.55584908 -17.14855576 -1.68898141 5.55584908 -17.14855766
		 -5.0020456314 5.55584908 -16.48954773 -8.12288475 5.55584908 -15.19685555 -10.93156624 5.55584908 -13.3201561
		 -13.32015228 5.55584908 -10.93157101 -15.19685364 5.55584908 -8.12289143 -16.48954773 5.55584908 -5.0020532608
		 -17.14855957 5.55584908 -1.68898857 -17.14855957 5.55584908 1.68898296 -16.48955154 5.55584908 5.0020480156
		 -15.19685841 5.55584908 8.12288761 -13.32015896 5.55584908 10.93156815 -10.93157196 5.55584908 13.3201561
		 -8.12289143 5.55584908 15.19685745 -5.0020523071 5.55584908 16.48955154 -1.68898737 5.55584908 17.14856148
		 1.68898463 5.55584908 17.14856148 5.0020503998 5.55584908 16.48955345 8.12288952 5.55584908 15.19685936
		 10.93157005 5.55584908 13.32015991 13.320158 5.55584908 10.93157196 15.19685936 5.55584908 8.12289143
		 16.48955536 5.55584908 5.0020518303 17.14856529 5.55584908 1.68898618 17.14855957 5.55584908 -1.68898296
		 17.14196396 10.33333397 -5.19994974 15.79812813 10.33333397 -8.44426632 13.84717846 10.33333397 -11.36407471
		 11.36408806 10.33333397 -13.84716702 8.44428253 10.33333397 -15.79812241 5.19996643 10.33333397 -17.14196396
		 1.7558192 10.33333397 -17.82704926 -1.75580323 10.33333397 -17.82705116 -5.19995165 10.33333397 -17.14196968
		 -8.44426918 10.33333397 -15.79813194 -11.36407852 10.33333397 -13.84718132 -13.84717178 10.33333397 -11.36408997
		 -15.79812813 10.33333397 -8.44428253 -17.14196968 10.33333397 -5.19996595 -17.82705498 10.33333397 -1.75581765
		 -17.82705688 10.33333397 1.75580621 -17.1419754 10.33333397 5.19995546 -15.79813766 10.33333397 8.44427395
		 -13.84718418 10.33333397 11.36408329 -11.36409187 10.33333397 13.84717751 -8.44428253 10.33333397 15.79813385
		 -5.199965 10.33333397 17.1419754 -1.75581527 10.33333397 17.8270607 1.75580978 10.33333397 17.82706261
		 5.19996071 10.33333397 17.14197922 8.44427872 10.33333397 15.79814053 11.36408997 10.33333397 13.84718704
		 13.84718513 10.33333397 11.36409283 15.79813957 10.33333397 8.44428253 17.14198303 10.33333397 5.19996357
		 17.82706833 10.33333397 1.75581288 17.82705688 10.33333397 -1.75580657 17.14196396 13 -5.19994974
		 15.79812813 13 -8.44426632 13.84717846 13 -11.36407471 11.36408806 13 -13.84716702
		 8.44428253 13 -15.79812241 5.19996643 13 -17.14196396;
	setAttr ".vt[1992:2157]" 1.7558192 13 -17.82704926 -1.75580323 13 -17.82705116
		 -5.19995165 13 -17.14196968 -8.44426918 13 -15.79813194 -11.36407852 13 -13.84718132
		 -13.84717178 13 -11.36408997 -15.79812813 13 -8.44428253 -17.14196968 13 -5.19996595
		 -17.82705498 13 -1.75581765 -17.82705688 13 1.75580621 -17.1419754 13 5.19995546
		 -15.79813766 13 8.44427395 -13.84718418 13 11.36408329 -11.36409187 13 13.84717751
		 -8.44428253 13 15.79813385 -5.199965 13 17.1419754 -1.75581527 13 17.8270607 1.75580978 13 17.82706261
		 5.19996071 13 17.14197922 8.44427872 13 15.79814053 11.36408997 13 13.84718704 13.84718513 13 11.36409283
		 15.79813957 13 8.44428253 17.14198303 13 5.19996357 17.82706833 13 1.75581288 17.82705688 13 -1.75580657
		 17.14196396 15.66666698 -5.19994974 15.79812813 15.66666698 -8.44426632 13.84717846 15.66666698 -11.36407471
		 11.36408806 15.66666698 -13.84716702 8.44428253 15.66666698 -15.79812241 5.19996643 15.66666698 -17.14196396
		 1.7558192 15.66666698 -17.82704926 -1.75580323 15.66666698 -17.82705116 -5.19995165 15.66666698 -17.14196968
		 -8.44426918 15.66666698 -15.79813194 -11.36407852 15.66666698 -13.84718132 -13.84717178 15.66666698 -11.36408997
		 -15.79812813 15.66666698 -8.44428253 -17.14196968 15.66666698 -5.19996595 -17.82705498 15.66666698 -1.75581765
		 -17.82705688 15.66666698 1.75580621 -17.1419754 15.66666698 5.19995546 -15.79813766 15.66666698 8.44427395
		 -13.84718418 15.66666698 11.36408329 -11.36409187 15.66666698 13.84717751 -8.44428253 15.66666698 15.79813385
		 -5.199965 15.66666698 17.1419754 -1.75581527 15.66666698 17.8270607 1.75580978 15.66666698 17.82706261
		 5.19996071 15.66666698 17.14197922 8.44427872 15.66666698 15.79814053 11.36408997 15.66666698 13.84718704
		 13.84718513 15.66666698 11.36409283 15.79813957 15.66666698 8.44428253 17.14198303 15.66666698 5.19996357
		 17.82706833 15.66666698 1.75581288 17.82705688 15.66666698 -1.75580657 17.14196396 18.33333397 -5.19994974
		 15.79812813 18.33333397 -8.44426632 13.84717846 18.33333397 -11.36407471 11.36408806 18.33333397 -13.84716702
		 8.44428253 18.33333397 -15.79812241 5.19996643 18.33333397 -17.14196396 1.7558192 18.33333397 -17.82704926
		 -1.75580323 18.33333397 -17.82705116 -5.19995165 18.33333397 -17.14196968 -8.44426918 18.33333397 -15.79813194
		 -11.36407852 18.33333397 -13.84718132 -13.84717178 18.33333397 -11.36408997 -15.79812813 18.33333397 -8.44428253
		 -17.14196968 18.33333397 -5.19996595 -17.82705498 18.33333397 -1.75581765 -17.82705688 18.33333397 1.75580621
		 -17.1419754 18.33333397 5.19995546 -15.79813766 18.33333397 8.44427395 -13.84718418 18.33333397 11.36408329
		 -11.36409187 18.33333397 13.84717751 -8.44428253 18.33333397 15.79813385 -5.199965 18.33333397 17.1419754
		 -1.75581527 18.33333397 17.8270607 1.75580978 18.33333397 17.82706261 5.19996071 18.33333397 17.14197922
		 8.44427872 18.33333397 15.79814053 11.36408997 18.33333397 13.84718704 13.84718513 18.33333397 11.36409283
		 15.79813957 18.33333397 8.44428253 17.14198303 18.33333397 5.19996357 17.82706833 18.33333397 1.75581288
		 17.82705688 18.33333397 -1.75580657 17.14196396 21.000001907349 -5.19994974 15.79812813 21.000001907349 -8.44426632
		 13.84717846 21.000001907349 -11.36407471 11.36408806 21.000001907349 -13.84716702
		 8.44428253 21.000001907349 -15.79812241 5.19996643 21.000001907349 -17.14196396 1.7558192 21.000001907349 -17.82704926
		 -1.75580323 21.000001907349 -17.82705116 -5.19995165 21.000001907349 -17.14196968
		 -8.44426918 21.000001907349 -15.79813194 -11.36407852 21.000001907349 -13.84718132
		 -13.84717178 21.000001907349 -11.36408997 -15.79812813 21.000001907349 -8.44428253
		 -17.14196968 21.000001907349 -5.19996595 -17.82705498 21.000001907349 -1.75581765
		 -17.82705688 21.000001907349 1.75580621 -17.1419754 21.000001907349 5.19995546 -15.79813766 21.000001907349 8.44427395
		 -13.84718418 21.000001907349 11.36408329 -11.36409187 21.000001907349 13.84717751
		 -8.44428253 21.000001907349 15.79813385 -5.199965 21.000001907349 17.1419754 -1.75581527 21.000001907349 17.8270607
		 1.75580978 21.000001907349 17.82706261 5.19996071 21.000001907349 17.14197922 8.44427872 21.000001907349 15.79814053
		 11.36408997 21.000001907349 13.84718704 13.84718513 21.000001907349 11.36409283 15.79813957 21.000001907349 8.44428253
		 17.14198303 21.000001907349 5.19996357 17.82706833 21.000001907349 1.75581288 17.82705688 21.000001907349 -1.75580657
		 17.14196396 23.66666794 -5.19994974 15.79812813 23.66666794 -8.44426632 13.84717846 23.66666794 -11.36407471
		 11.36408806 23.66666794 -13.84716702 8.44428253 23.66666794 -15.79812241 5.19996643 23.66666794 -17.14196396
		 1.7558192 23.66666794 -17.82704926 -1.75580323 23.66666794 -17.82705116 -5.19995165 23.66666794 -17.14196968
		 -8.44426918 23.66666794 -15.79813194 -11.36407852 23.66666794 -13.84718132 -13.84717178 23.66666794 -11.36408997
		 -15.79812813 23.66666794 -8.44428253 -17.14196968 23.66666794 -5.19996595 -17.82705498 23.66666794 -1.75581765
		 -17.82705688 23.66666794 1.75580621 -17.1419754 23.66666794 5.19995546 -15.79813766 23.66666794 8.44427395
		 -13.84718418 23.66666794 11.36408329 -11.36409187 23.66666794 13.84717751 -8.44428253 23.66666794 15.79813385
		 -5.199965 23.66666794 17.1419754 -1.75581527 23.66666794 17.8270607 1.75580978 23.66666794 17.82706261
		 5.19996071 23.66666794 17.14197922 8.44427872 23.66666794 15.79814053 11.36408997 23.66666794 13.84718704
		 13.84718513 23.66666794 11.36409283 15.79813957 23.66666794 8.44428253 17.14198303 23.66666794 5.19996357
		 17.82706833 23.66666794 1.75581288 17.82705688 23.66666794 -1.75580657 17.14196396 26.33333588 -5.19994974
		 15.79812813 26.33333588 -8.44426632 13.84717846 26.33333588 -11.36407471 11.36408806 26.33333588 -13.84716702
		 8.44428253 26.33333588 -15.79812241 5.19996643 26.33333588 -17.14196396 1.7558192 26.33333588 -17.82704926
		 -1.75580323 26.33333588 -17.82705116 -5.19995165 26.33333588 -17.14196968 -8.44426918 26.33333588 -15.79813194
		 -11.36407852 26.33333588 -13.84718132 -13.84717178 26.33333588 -11.36408997;
	setAttr ".vt[2158:2323]" -15.79812813 26.33333588 -8.44428253 -17.14196968 26.33333588 -5.19996595
		 -17.82705498 26.33333588 -1.75581765 -17.82705688 26.33333588 1.75580621 -17.1419754 26.33333588 5.19995546
		 -15.79813766 26.33333588 8.44427395 -13.84718418 26.33333588 11.36408329 -11.36409187 26.33333588 13.84717751
		 -8.44428253 26.33333588 15.79813385 -5.199965 26.33333588 17.1419754 -1.75581527 26.33333588 17.8270607
		 1.75580978 26.33333588 17.82706261 5.19996071 26.33333588 17.14197922 8.44427872 26.33333588 15.79814053
		 11.36408997 26.33333588 13.84718704 13.84718513 26.33333588 11.36409283 15.79813957 26.33333588 8.44428253
		 17.14198303 26.33333588 5.19996357 17.82706833 26.33333588 1.75581288 17.82705688 26.33333588 -1.75580657
		 17.14196396 29.000001907349 -5.19994974 15.79812813 29.000001907349 -8.44426632 13.84717846 29.000001907349 -11.36407471
		 11.36408806 29.000001907349 -13.84716702 8.44428253 29.000001907349 -15.79812241
		 5.19996643 29.000001907349 -17.14196396 1.7558192 29.000001907349 -17.82704926 -1.75580323 29.000001907349 -17.82705116
		 -5.19995165 29.000001907349 -17.14196968 -8.44426918 29.000001907349 -15.79813194
		 -11.36407852 29.000001907349 -13.84718132 -13.84717178 29.000001907349 -11.36408997
		 -15.79812813 29.000001907349 -8.44428253 -17.14196968 29.000001907349 -5.19996595
		 -17.82705498 29.000001907349 -1.75581765 -17.82705688 29.000001907349 1.75580621
		 -17.1419754 29.000001907349 5.19995546 -15.79813766 29.000001907349 8.44427395 -13.84718418 29.000001907349 11.36408329
		 -11.36409187 29.000001907349 13.84717751 -8.44428253 29.000001907349 15.79813385
		 -5.199965 29.000001907349 17.1419754 -1.75581527 29.000001907349 17.8270607 1.75580978 29.000001907349 17.82706261
		 5.19996071 29.000001907349 17.14197922 8.44427872 29.000001907349 15.79814053 11.36408997 29.000001907349 13.84718704
		 13.84718513 29.000001907349 11.36409283 15.79813957 29.000001907349 8.44428253 17.14198303 29.000001907349 5.19996357
		 17.82706833 29.000001907349 1.75581288 17.82705688 29.000001907349 -1.75580657 17.14196396 31.66666794 -5.19994974
		 15.79812813 31.66666794 -8.44426632 13.84717846 31.66666794 -11.36407471 11.36408806 31.66666794 -13.84716702
		 8.44428253 31.66666794 -15.79812241 5.19996643 31.66666794 -17.14196396 1.7558192 31.66666794 -17.82704926
		 -1.75580323 31.66666794 -17.82705116 -5.19995165 31.66666794 -17.14196968 -8.44426918 31.66666794 -15.79813194
		 -11.36407852 31.66666794 -13.84718132 -13.84717178 31.66666794 -11.36408997 -15.79812813 31.66666794 -8.44428253
		 -17.14196968 31.66666794 -5.19996595 -17.82705498 31.66666794 -1.75581765 -17.82705688 31.66666794 1.75580621
		 -17.1419754 31.66666794 5.19995546 -15.79813766 31.66666794 8.44427395 -13.84718418 31.66666794 11.36408329
		 -11.36409187 31.66666794 13.84717751 -8.44428253 31.66666794 15.79813385 -5.199965 31.66666794 17.1419754
		 -1.75581527 31.66666794 17.8270607 1.75580978 31.66666794 17.82706261 5.19996071 31.66666794 17.14197922
		 8.44427872 31.66666794 15.79814053 11.36408997 31.66666794 13.84718704 13.84718513 31.66666794 11.36409283
		 15.79813957 31.66666794 8.44428253 17.14198303 31.66666794 5.19996357 17.82706833 31.66666794 1.75581288
		 17.82705688 31.66666794 -1.75580657 17.14196396 34.33333588 -5.19994974 15.79812813 34.33333588 -8.44426632
		 13.84717846 34.33333588 -11.36407471 11.36408806 34.33333588 -13.84716702 8.44428253 34.33333588 -15.79812241
		 5.19996643 34.33333588 -17.14196396 1.7558192 34.33333588 -17.82704926 -1.75580323 34.33333588 -17.82705116
		 -5.19995165 34.33333588 -17.14196968 -8.44426918 34.33333588 -15.79813194 -11.36407852 34.33333588 -13.84718132
		 -13.84717178 34.33333588 -11.36408997 -15.79812813 34.33333588 -8.44428253 -17.14196968 34.33333588 -5.19996595
		 -17.82705498 34.33333588 -1.75581765 -17.82705688 34.33333588 1.75580621 -17.1419754 34.33333588 5.19995546
		 -15.79813766 34.33333588 8.44427395 -13.84718418 34.33333588 11.36408329 -11.36409187 34.33333588 13.84717751
		 -8.44428253 34.33333588 15.79813385 -5.199965 34.33333588 17.1419754 -1.75581527 34.33333588 17.8270607
		 1.75580978 34.33333588 17.82706261 5.19996071 34.33333588 17.14197922 8.44427872 34.33333588 15.79814053
		 11.36408997 34.33333588 13.84718704 13.84718513 34.33333588 11.36409283 15.79813957 34.33333588 8.44428253
		 17.14198303 34.33333588 5.19996357 17.82706833 34.33333588 1.75581288 17.82705688 34.33333588 -1.75580657
		 17.14196396 37 -5.19994974 15.79812813 37 -8.44426632 13.84717846 37 -11.36407471
		 11.36408806 37 -13.84716702 8.44428253 37 -15.79812241 5.19996643 37 -17.14196396
		 1.7558192 37 -17.82704926 -1.75580323 37 -17.82705116 -5.19995165 37 -17.14196968
		 -8.44426918 37 -15.79813194 -11.36407852 37 -13.84718132 -13.84717178 37 -11.36408997
		 -15.79812813 37 -8.44428253 -17.14196968 37 -5.19996595 -17.82705498 37 -1.75581765
		 -17.82705688 37 1.75580621 -17.1419754 37 5.19995546 -15.79813766 37 8.44427395 -13.84718418 37 11.36408329
		 -11.36409187 37 13.84717751 -8.44428253 37 15.79813385 -5.199965 37 17.1419754 -1.75581527 37 17.8270607
		 1.75580978 37 17.82706261 5.19996071 37 17.14197922 8.44427872 37 15.79814053 11.36408997 37 13.84718704
		 13.84718513 37 11.36409283 15.79813957 37 8.44428253 17.14198303 37 5.19996357 17.82706833 37 1.75581288
		 17.82705688 37 -1.75580657 17.14196396 39.66666794 -5.19994974 15.79812813 39.66666794 -8.44426632
		 13.84717846 39.66666794 -11.36407471 11.36408806 39.66666794 -13.84716702 8.44428253 39.66666794 -15.79812241
		 5.19996643 39.66666794 -17.14196396 1.7558192 39.66666794 -17.82704926 -1.75580323 39.66666794 -17.82705116
		 -5.19995165 39.66666794 -17.14196968 -8.44426918 39.66666794 -15.79813194 -11.36407852 39.66666794 -13.84718132
		 -13.84717178 39.66666794 -11.36408997 -15.79812813 39.66666794 -8.44428253 -17.14196968 39.66666794 -5.19996595
		 -17.82705498 39.66666794 -1.75581765 -17.82705688 39.66666794 1.75580621 -17.1419754 39.66666794 5.19995546
		 -15.79813766 39.66666794 8.44427395;
	setAttr ".vt[2324:2489]" -13.84718418 39.66666794 11.36408329 -11.36409187 39.66666794 13.84717751
		 -8.44428253 39.66666794 15.79813385 -5.199965 39.66666794 17.1419754 -1.75581527 39.66666794 17.8270607
		 1.75580978 39.66666794 17.82706261 5.19996071 39.66666794 17.14197922 8.44427872 39.66666794 15.79814053
		 11.36408997 39.66666794 13.84718704 13.84718513 39.66666794 11.36409283 15.79813957 39.66666794 8.44428253
		 17.14198303 39.66666794 5.19996357 17.82706833 39.66666794 1.75581288 17.82705688 39.66666794 -1.75580657
		 16.48954582 44.44415283 -5.0020446777 15.19685364 44.44415283 -8.12288284 13.32015514 44.44415283 -10.93156338
		 10.93157005 44.44415283 -13.32015038 8.12289143 44.44415283 -15.19685078 5.0020532608 44.44415283 -16.48954582
		 1.6889894 44.44415283 -17.14855576 -1.68898129 44.44415283 -17.14855576 -5.0020456314 44.44415283 -16.48954773
		 -8.12288475 44.44415283 -15.19685555 -10.93156528 44.44415283 -13.3201561 -13.32015228 44.44415283 -10.93157196
		 -15.19685364 44.44415283 -8.12289143 -16.48954773 44.44415283 -5.002052784 -17.14855957 44.44415283 -1.68898857
		 -17.14855957 44.44415283 1.68898284 -16.48955154 44.44415283 5.0020475388 -15.19685841 44.44415283 8.12288666
		 -13.320158 44.44415283 10.93156815 -10.93157196 44.44415283 13.32015419 -8.12289143 44.44415283 15.1968565
		 -5.0020523071 44.44415283 16.48955154 -1.68898737 44.44415283 17.14856148 1.68898463 44.44415283 17.14856148
		 5.0020503998 44.44415283 16.48955345 8.12288952 44.44415283 15.19686031 10.93157101 44.44415283 13.32015896
		 13.320158 44.44415283 10.93157196 15.19685936 44.44415283 8.12289143 16.48955536 44.44415283 5.0020518303
		 17.14856529 44.44415283 1.68898618 17.14855957 44.44415283 -1.68898296 13.97916985 50.80810928 -4.24053478
		 12.88327694 50.80810928 -6.88625526 11.29228592 50.80810928 -9.26733971 9.26733971 50.80810928 -11.29228592
		 6.88625526 50.80810928 -12.88327599 4.24053478 50.80810928 -13.97916985 1.43185329 50.80810928 -14.53785133
		 -1.43185329 50.80810928 -14.53785133 -4.24053478 50.80810928 -13.97916985 -6.88625526 50.80810928 -12.88327694
		 -9.26733971 50.80810928 -11.29228592 -11.29228592 50.80810928 -9.26733971 -12.88327599 50.80810928 -6.88625526
		 -13.97916985 50.80810928 -4.24053478 -14.53785133 50.80810928 -1.43185329 -14.53785133 50.80810928 1.43185329
		 -13.97916985 50.80810928 4.24053478 -12.88327694 50.80810928 6.88625526 -11.29228592 50.80810928 9.26733971
		 -9.26733971 50.80810928 11.29228592 -6.88625526 50.80810928 12.88327599 -4.24053478 50.80810928 13.97916985
		 -1.43185329 50.80810928 14.53785133 1.43185329 50.80810928 14.53785133 4.24053478 50.80810928 13.97916985
		 6.88625526 50.80810928 12.88327694 9.26733971 50.80810928 11.29228592 11.29228592 50.80810928 9.26733971
		 12.88327599 50.80810928 6.88625526 13.97916985 50.80810928 4.24053478 14.53785133 50.80810928 1.43185329
		 14.53785133 50.80810928 -1.43185329 9.34058189 55.67887115 -2.83343458 8.60832977 55.67887115 -4.60124826
		 7.54526424 55.67887115 -6.19223785 6.19223785 55.67887115 -7.54526424 4.60124826 55.67887115 -8.60832977
		 2.83343458 55.67887115 -9.34058285 0.95673382 55.67887115 -9.71388149 -0.95673382 55.67887115 -9.71388245
		 -2.83343458 55.67887115 -9.34058189 -4.60124826 55.67887115 -8.60832977 -6.19223785 55.67887115 -7.54526424
		 -7.54526424 55.67887115 -6.19223785 -8.60832977 55.67887115 -4.60124826 -9.34058285 55.67887115 -2.83343458
		 -9.71388149 55.67887115 -0.95673382 -9.71388245 55.67887115 0.95673382 -9.34058189 55.67887115 2.83343458
		 -8.60832977 55.67887115 4.60124826 -7.54526424 55.67887115 6.19223785 -6.19223785 55.67887115 7.54526424
		 -4.60124826 55.67887115 8.60832977 -2.83343458 55.67887115 9.34058285 -0.95673382 55.67887115 9.71388149
		 0.95673382 55.67887115 9.71388245 2.83343458 55.67887115 9.34058189 4.60124826 55.67887115 8.60832977
		 6.19223785 55.67887115 7.54526424 7.54526424 55.67887115 6.19223785 8.60832977 55.67887115 4.60124826
		 9.34058285 55.67887115 2.83343458 9.71388149 55.67887115 0.95673382 9.71388245 55.67887115 -0.95673382
		 4.37330198 -8.086553574 -1.32662666 4.030457973 -8.086553574 -2.15432501 3.53272605 -8.086553574 -2.89923358
		 2.89923358 -8.086553574 -3.53272605 2.15432501 -8.086553574 -4.030457973 1.32662666 -8.086553574 -4.37330198
		 0.447947 -8.086553574 -4.54808235 -0.447947 -8.086553574 -4.54808235 -1.32662666 -8.086553574 -4.37330198
		 -2.15432501 -8.086553574 -4.030457973 -2.89923358 -8.086553574 -3.53272605 -3.53272605 -8.086553574 -2.89923358
		 -4.030457973 -8.086553574 -2.15432501 -4.37330198 -8.086553574 -1.32662666 -4.54808235 -8.086553574 -0.447947
		 -4.54808235 -8.086553574 0.447947 -4.37330198 -8.086553574 1.32662666 -4.030457973 -8.086553574 2.15432501
		 -3.53272605 -8.086553574 2.89923358 -2.89923358 -8.086553574 3.53272605 -2.15432501 -8.086553574 4.030457973
		 -1.32662666 -8.086553574 4.37330198 -0.447947 -8.086553574 4.54808235 0.447947 -8.086553574 4.54808235
		 1.32662666 -8.086553574 4.37330198 2.15432501 -8.086553574 4.030457973 2.89923358 -8.086553574 3.53272605
		 3.53272605 -8.086553574 2.89923358 4.030457973 -8.086553574 2.15432501 4.37330198 -8.086553574 1.32662666
		 4.54808235 -8.086553574 0.447947 4.54808235 -8.086553574 -0.447947 4.37330198 58.086555481 -1.32662666
		 4.030457973 58.086555481 -2.15432501 3.53272605 58.086555481 -2.89923358 2.89923358 58.086555481 -3.53272605
		 2.15432501 58.086555481 -4.030457973 1.32662666 58.086555481 -4.37330198 0.447947 58.086555481 -4.54808235
		 -0.447947 58.086555481 -4.54808235 -1.32662666 58.086555481 -4.37330198 -2.15432501 58.086555481 -4.030457973
		 -2.89923358 58.086555481 -3.53272605 -3.53272605 58.086555481 -2.89923358 -4.030457973 58.086555481 -2.15432501
		 -4.37330198 58.086555481 -1.32662666 -4.54808235 58.086555481 -0.447947 -4.54808235 58.086555481 0.447947
		 -4.37330198 58.086555481 1.32662666 -4.030457973 58.086555481 2.15432501 -3.53272605 58.086555481 2.89923358
		 -2.89923358 58.086555481 3.53272605 -2.15432501 58.086555481 4.030457973 -1.32662666 58.086555481 4.37330198
		 -0.447947 58.086555481 4.54808235 0.447947 58.086555481 4.54808235;
	setAttr ".vt[2490:2497]" 1.32662666 58.086555481 4.37330198 2.15432501 58.086555481 4.030457973
		 2.89923358 58.086555481 3.53272605 3.53272605 58.086555481 2.89923358 4.030457973 58.086555481 2.15432501
		 4.37330198 58.086555481 1.32662666 4.54808235 58.086555481 0.447947 4.54808235 58.086555481 -0.447947;
	setAttr -s 4992 ".ed";
	setAttr ".ed[0:165]"  0 610 1 610 1 1 1 611 1 611 2 1 2 612 1 612 3 1 3 613 1
		 613 4 1 4 614 1 614 5 1 5 615 1 615 6 1 6 616 1 616 7 1 7 617 1 617 8 1 8 618 1 618 9 1
		 9 619 1 619 10 1 10 620 1 620 11 1 11 621 1 621 12 1 12 622 1 622 13 1 13 623 1 623 14 1
		 14 624 1 624 15 1 15 625 1 625 16 1 16 626 1 626 17 1 17 627 1 627 18 1 18 628 1
		 628 19 1 19 629 1 629 20 1 20 630 1 630 21 1 21 631 1 631 22 1 22 632 1 632 23 1
		 23 633 1 633 24 1 24 634 1 634 25 1 25 635 1 635 26 1 26 636 1 636 27 1 27 637 1
		 637 28 1 28 638 1 638 29 1 29 639 1 639 30 1 30 640 1 640 31 1 31 641 1 641 0 1 32 642 1
		 642 33 1 33 643 1 643 34 1 34 644 1 644 35 1 35 645 1 645 36 1 36 646 1 646 37 1
		 37 647 1 647 38 1 38 648 1 648 39 1 39 649 1 649 40 1 40 650 1 650 41 1 41 651 1
		 651 42 1 42 652 1 652 43 1 43 653 1 653 44 1 44 654 1 654 45 1 45 655 1 655 46 1
		 46 656 1 656 47 1 47 657 1 657 48 1 48 658 1 658 49 1 49 659 1 659 50 1 50 660 1
		 660 51 1 51 661 1 661 52 1 52 662 1 662 53 1 53 663 1 663 54 1 54 664 1 664 55 1
		 55 665 1 665 56 1 56 666 1 666 57 1 57 667 1 667 58 1 58 668 1 668 59 1 59 669 1
		 669 60 1 60 670 1 670 61 1 61 671 1 671 62 1 62 672 1 672 63 1 63 673 1 673 32 1
		 64 674 1 674 65 1 65 675 1 675 66 1 66 676 1 676 67 1 67 677 1 677 68 1 68 678 1
		 678 69 1 69 679 1 679 70 1 70 680 1 680 71 1 71 681 1 681 72 1 72 682 1 682 73 1
		 73 683 1 683 74 1 74 684 1 684 75 1 75 685 1 685 76 1 76 686 1 686 77 1 77 687 1
		 687 78 1 78 688 1 688 79 1 79 689 1 689 80 1 80 690 1 690 81 1 81 691 1 691 82 1
		 82 692 1 692 83 1;
	setAttr ".ed[166:331]" 83 693 1 693 84 1 84 694 1 694 85 1 85 695 1 695 86 1
		 86 696 1 696 87 1 87 697 1 697 88 1 88 698 1 698 89 1 89 699 1 699 90 1 90 700 1
		 700 91 1 91 701 1 701 92 1 92 702 1 702 93 1 93 703 1 703 94 1 94 704 1 704 95 1
		 95 705 1 705 64 1 96 706 1 706 97 1 97 707 1 707 98 1 98 708 1 708 99 1 99 709 1
		 709 100 1 100 710 1 710 101 1 101 711 1 711 102 1 102 712 1 712 103 1 103 713 1 713 104 1
		 104 714 1 714 105 1 105 715 1 715 106 1 106 716 1 716 107 1 107 717 1 717 108 1 108 718 1
		 718 109 1 109 719 1 719 110 1 110 720 1 720 111 1 111 721 1 721 112 1 112 722 1 722 113 1
		 113 723 1 723 114 1 114 724 1 724 115 1 115 725 1 725 116 1 116 726 1 726 117 1 117 727 1
		 727 118 1 118 728 1 728 119 1 119 729 1 729 120 1 120 730 1 730 121 1 121 731 1 731 122 1
		 122 732 1 732 123 1 123 733 1 733 124 1 124 734 1 734 125 1 125 735 1 735 126 1 126 736 1
		 736 127 1 127 737 1 737 96 1 128 738 1 738 129 1 129 739 1 739 130 1 130 740 1 740 131 1
		 131 741 1 741 132 1 132 742 1 742 133 1 133 743 1 743 134 1 134 744 1 744 135 1 135 745 1
		 745 136 1 136 746 1 746 137 1 137 747 1 747 138 1 138 748 1 748 139 1 139 749 1 749 140 1
		 140 750 1 750 141 1 141 751 1 751 142 1 142 752 1 752 143 1 143 753 1 753 144 1 144 754 1
		 754 145 1 145 755 1 755 146 1 146 756 1 756 147 1 147 757 1 757 148 1 148 758 1 758 149 1
		 149 759 1 759 150 1 150 760 1 760 151 1 151 761 1 761 152 1 152 762 1 762 153 1 153 763 1
		 763 154 1 154 764 1 764 155 1 155 765 1 765 156 1 156 766 1 766 157 1 157 767 1 767 158 1
		 158 768 1 768 159 1 159 769 1 769 128 1 160 770 1 770 161 1 161 771 1 771 162 1 162 772 1
		 772 163 1 163 773 1 773 164 1 164 774 1 774 165 1 165 775 1 775 166 1;
	setAttr ".ed[332:497]" 166 776 1 776 167 1 167 777 1 777 168 1 168 778 1 778 169 1
		 169 779 1 779 170 1 170 780 1 780 171 1 171 781 1 781 172 1 172 782 1 782 173 1 173 783 1
		 783 174 1 174 784 1 784 175 1 175 785 1 785 176 1 176 786 1 786 177 1 177 787 1 787 178 1
		 178 788 1 788 179 1 179 789 1 789 180 1 180 790 1 790 181 1 181 791 1 791 182 1 182 792 1
		 792 183 1 183 793 1 793 184 1 184 794 1 794 185 1 185 795 1 795 186 1 186 796 1 796 187 1
		 187 797 1 797 188 1 188 798 1 798 189 1 189 799 1 799 190 1 190 800 1 800 191 1 191 801 1
		 801 160 1 192 802 1 802 193 1 193 803 1 803 194 1 194 804 1 804 195 1 195 805 1 805 196 1
		 196 806 1 806 197 1 197 807 1 807 198 1 198 808 1 808 199 1 199 809 1 809 200 1 200 810 1
		 810 201 1 201 811 1 811 202 1 202 812 1 812 203 1 203 813 1 813 204 1 204 814 1 814 205 1
		 205 815 1 815 206 1 206 816 1 816 207 1 207 817 1 817 208 1 208 818 1 818 209 1 209 819 1
		 819 210 1 210 820 1 820 211 1 211 821 1 821 212 1 212 822 1 822 213 1 213 823 1 823 214 1
		 214 824 1 824 215 1 215 825 1 825 216 1 216 826 1 826 217 1 217 827 1 827 218 1 218 828 1
		 828 219 1 219 829 1 829 220 1 220 830 1 830 221 1 221 831 1 831 222 1 222 832 1 832 223 1
		 223 833 1 833 192 1 224 834 1 834 225 1 225 835 1 835 226 1 226 836 1 836 227 1 227 837 1
		 837 228 1 228 838 1 838 229 1 229 839 1 839 230 1 230 840 1 840 231 1 231 841 1 841 232 1
		 232 842 1 842 233 1 233 843 1 843 234 1 234 844 1 844 235 1 235 845 1 845 236 1 236 846 1
		 846 237 1 237 847 1 847 238 1 238 848 1 848 239 1 239 849 1 849 240 1 240 850 1 850 241 1
		 241 851 1 851 242 1 242 852 1 852 243 1 243 853 1 853 244 1 244 854 1 854 245 1 245 855 1
		 855 246 1 246 856 1 856 247 1 247 857 1 857 248 1 248 858 1 858 249 1;
	setAttr ".ed[498:663]" 249 859 1 859 250 1 250 860 1 860 251 1 251 861 1 861 252 1
		 252 862 1 862 253 1 253 863 1 863 254 1 254 864 1 864 255 1 255 865 1 865 224 1 256 866 1
		 866 257 1 257 867 1 867 258 1 258 868 1 868 259 1 259 869 1 869 260 1 260 870 1 870 261 1
		 261 871 1 871 262 1 262 872 1 872 263 1 263 873 1 873 264 1 264 874 1 874 265 1 265 875 1
		 875 266 1 266 876 1 876 267 1 267 877 1 877 268 1 268 878 1 878 269 1 269 879 1 879 270 1
		 270 880 1 880 271 1 271 881 1 881 272 1 272 882 1 882 273 1 273 883 1 883 274 1 274 884 1
		 884 275 1 275 885 1 885 276 1 276 886 1 886 277 1 277 887 1 887 278 1 278 888 1 888 279 1
		 279 889 1 889 280 1 280 890 1 890 281 1 281 891 1 891 282 1 282 892 1 892 283 1 283 893 1
		 893 284 1 284 894 1 894 285 1 285 895 1 895 286 1 286 896 1 896 287 1 287 897 1 897 256 1
		 288 898 1 898 289 1 289 899 1 899 290 1 290 900 1 900 291 1 291 901 1 901 292 1 292 902 1
		 902 293 1 293 903 1 903 294 1 294 904 1 904 295 1 295 905 1 905 296 1 296 906 1 906 297 1
		 297 907 1 907 298 1 298 908 1 908 299 1 299 909 1 909 300 1 300 910 1 910 301 1 301 911 1
		 911 302 1 302 912 1 912 303 1 303 913 1 913 304 1 304 914 1 914 305 1 305 915 1 915 306 1
		 306 916 1 916 307 1 307 917 1 917 308 1 308 918 1 918 309 1 309 919 1 919 310 1 310 920 1
		 920 311 1 311 921 1 921 312 1 312 922 1 922 313 1 313 923 1 923 314 1 314 924 1 924 315 1
		 315 925 1 925 316 1 316 926 1 926 317 1 317 927 1 927 318 1 318 928 1 928 319 1 319 929 1
		 929 288 1 320 930 1 930 321 1 321 931 1 931 322 1 322 932 1 932 323 1 323 933 1 933 324 1
		 324 934 1 934 325 1 325 935 1 935 326 1 326 936 1 936 327 1 327 937 1 937 328 1 328 938 1
		 938 329 1 329 939 1 939 330 1 330 940 1 940 331 1 331 941 1 941 332 1;
	setAttr ".ed[664:829]" 332 942 1 942 333 1 333 943 1 943 334 1 334 944 1 944 335 1
		 335 945 1 945 336 1 336 946 1 946 337 1 337 947 1 947 338 1 338 948 1 948 339 1 339 949 1
		 949 340 1 340 950 1 950 341 1 341 951 1 951 342 1 342 952 1 952 343 1 343 953 1 953 344 1
		 344 954 1 954 345 1 345 955 1 955 346 1 346 956 1 956 347 1 347 957 1 957 348 1 348 958 1
		 958 349 1 349 959 1 959 350 1 350 960 1 960 351 1 351 961 1 961 320 1 352 962 1 962 353 1
		 353 963 1 963 354 1 354 964 1 964 355 1 355 965 1 965 356 1 356 966 1 966 357 1 357 967 1
		 967 358 1 358 968 1 968 359 1 359 969 1 969 360 1 360 970 1 970 361 1 361 971 1 971 362 1
		 362 972 1 972 363 1 363 973 1 973 364 1 364 974 1 974 365 1 365 975 1 975 366 1 366 976 1
		 976 367 1 367 977 1 977 368 1 368 978 1 978 369 1 369 979 1 979 370 1 370 980 1 980 371 1
		 371 981 1 981 372 1 372 982 1 982 373 1 373 983 1 983 374 1 374 984 1 984 375 1 375 985 1
		 985 376 1 376 986 1 986 377 1 377 987 1 987 378 1 378 988 1 988 379 1 379 989 1 989 380 1
		 380 990 1 990 381 1 381 991 1 991 382 1 382 992 1 992 383 1 383 993 1 993 352 1 384 994 1
		 994 385 1 385 995 1 995 386 1 386 996 1 996 387 1 387 997 1 997 388 1 388 998 1 998 389 1
		 389 999 1 999 390 1 390 1000 1 1000 391 1 391 1001 1 1001 392 1 392 1002 1 1002 393 1
		 393 1003 1 1003 394 1 394 1004 1 1004 395 1 395 1005 1 1005 396 1 396 1006 1 1006 397 1
		 397 1007 1 1007 398 1 398 1008 1 1008 399 1 399 1009 1 1009 400 1 400 1010 1 1010 401 1
		 401 1011 1 1011 402 1 402 1012 1 1012 403 1 403 1013 1 1013 404 1 404 1014 1 1014 405 1
		 405 1015 1 1015 406 1 406 1016 1 1016 407 1 407 1017 1 1017 408 1 408 1018 1 1018 409 1
		 409 1019 1 1019 410 1 410 1020 1 1020 411 1 411 1021 1 1021 412 1 412 1022 1 1022 413 1
		 413 1023 1 1023 414 1 414 1024 1 1024 415 1;
	setAttr ".ed[830:995]" 415 1025 1 1025 384 1 416 1026 1 1026 417 1 417 1027 1
		 1027 418 1 418 1028 1 1028 419 1 419 1029 1 1029 420 1 420 1030 1 1030 421 1 421 1031 1
		 1031 422 1 422 1032 1 1032 423 1 423 1033 1 1033 424 1 424 1034 1 1034 425 1 425 1035 1
		 1035 426 1 426 1036 1 1036 427 1 427 1037 1 1037 428 1 428 1038 1 1038 429 1 429 1039 1
		 1039 430 1 430 1040 1 1040 431 1 431 1041 1 1041 432 1 432 1042 1 1042 433 1 433 1043 1
		 1043 434 1 434 1044 1 1044 435 1 435 1045 1 1045 436 1 436 1046 1 1046 437 1 437 1047 1
		 1047 438 1 438 1048 1 1048 439 1 439 1049 1 1049 440 1 440 1050 1 1050 441 1 441 1051 1
		 1051 442 1 442 1052 1 1052 443 1 443 1053 1 1053 444 1 444 1054 1 1054 445 1 445 1055 1
		 1055 446 1 446 1056 1 1056 447 1 447 1057 1 1057 416 1 448 1058 1 1058 449 1 449 1059 1
		 1059 450 1 450 1060 1 1060 451 1 451 1061 1 1061 452 1 452 1062 1 1062 453 1 453 1063 1
		 1063 454 1 454 1064 1 1064 455 1 455 1065 1 1065 456 1 456 1066 1 1066 457 1 457 1067 1
		 1067 458 1 458 1068 1 1068 459 1 459 1069 1 1069 460 1 460 1070 1 1070 461 1 461 1071 1
		 1071 462 1 462 1072 1 1072 463 1 463 1073 1 1073 464 1 464 1074 1 1074 465 1 465 1075 1
		 1075 466 1 466 1076 1 1076 467 1 467 1077 1 1077 468 1 468 1078 1 1078 469 1 469 1079 1
		 1079 470 1 470 1080 1 1080 471 1 471 1081 1 1081 472 1 472 1082 1 1082 473 1 473 1083 1
		 1083 474 1 474 1084 1 1084 475 1 475 1085 1 1085 476 1 476 1086 1 1086 477 1 477 1087 1
		 1087 478 1 478 1088 1 1088 479 1 479 1089 1 1089 448 1 480 1090 1 1090 481 1 481 1091 1
		 1091 482 1 482 1092 1 1092 483 1 483 1093 1 1093 484 1 484 1094 1 1094 485 1 485 1095 1
		 1095 486 1 486 1096 1 1096 487 1 487 1097 1 1097 488 1 488 1098 1 1098 489 1 489 1099 1
		 1099 490 1 490 1100 1 1100 491 1 491 1101 1 1101 492 1 492 1102 1 1102 493 1 493 1103 1
		 1103 494 1 494 1104 1 1104 495 1 495 1105 1 1105 496 1 496 1106 1 1106 497 1 497 1107 1
		 1107 498 1;
	setAttr ".ed[996:1161]" 498 1108 1 1108 499 1 499 1109 1 1109 500 1 500 1110 1
		 1110 501 1 501 1111 1 1111 502 1 502 1112 1 1112 503 1 503 1113 1 1113 504 1 504 1114 1
		 1114 505 1 505 1115 1 1115 506 1 506 1116 1 1116 507 1 507 1117 1 1117 508 1 508 1118 1
		 1118 509 1 509 1119 1 1119 510 1 510 1120 1 1120 511 1 511 1121 1 1121 480 1 512 1122 1
		 1122 513 1 513 1123 1 1123 514 1 514 1124 1 1124 515 1 515 1125 1 1125 516 1 516 1126 1
		 1126 517 1 517 1127 1 1127 518 1 518 1128 1 1128 519 1 519 1129 1 1129 520 1 520 1130 1
		 1130 521 1 521 1131 1 1131 522 1 522 1132 1 1132 523 1 523 1133 1 1133 524 1 524 1134 1
		 1134 525 1 525 1135 1 1135 526 1 526 1136 1 1136 527 1 527 1137 1 1137 528 1 528 1138 1
		 1138 529 1 529 1139 1 1139 530 1 530 1140 1 1140 531 1 531 1141 1 1141 532 1 532 1142 1
		 1142 533 1 533 1143 1 1143 534 1 534 1144 1 1144 535 1 535 1145 1 1145 536 1 536 1146 1
		 1146 537 1 537 1147 1 1147 538 1 538 1148 1 1148 539 1 539 1149 1 1149 540 1 540 1150 1
		 1150 541 1 541 1151 1 1151 542 1 542 1152 1 1152 543 1 543 1153 1 1153 512 1 544 1154 1
		 1154 545 1 545 1155 1 1155 546 1 546 1156 1 1156 547 1 547 1157 1 1157 548 1 548 1158 1
		 1158 549 1 549 1159 1 1159 550 1 550 1160 1 1160 551 1 551 1161 1 1161 552 1 552 1162 1
		 1162 553 1 553 1163 1 1163 554 1 554 1164 1 1164 555 1 555 1165 1 1165 556 1 556 1166 1
		 1166 557 1 557 1167 1 1167 558 1 558 1168 1 1168 559 1 559 1169 1 1169 560 1 560 1170 1
		 1170 561 1 561 1171 1 1171 562 1 562 1172 1 1172 563 1 563 1173 1 1173 564 1 564 1174 1
		 1174 565 1 565 1175 1 1175 566 1 566 1176 1 1176 567 1 567 1177 1 1177 568 1 568 1178 1
		 1178 569 1 569 1179 1 1179 570 1 570 1180 1 1180 571 1 571 1181 1 1181 572 1 572 1182 1
		 1182 573 1 573 1183 1 1183 574 1 574 1184 1 1184 575 1 575 1185 1 1185 544 1 576 1186 1
		 1186 577 1 577 1187 1 1187 578 1 578 1188 1 1188 579 1 579 1189 1 1189 580 1 580 1190 1
		 1190 581 1;
	setAttr ".ed[1162:1327]" 581 1191 1 1191 582 1 582 1192 1 1192 583 1 583 1193 1
		 1193 584 1 584 1194 1 1194 585 1 585 1195 1 1195 586 1 586 1196 1 1196 587 1 587 1197 1
		 1197 588 1 588 1198 1 1198 589 1 589 1199 1 1199 590 1 590 1200 1 1200 591 1 591 1201 1
		 1201 592 1 592 1202 1 1202 593 1 593 1203 1 1203 594 1 594 1204 1 1204 595 1 595 1205 1
		 1205 596 1 596 1206 1 1206 597 1 597 1207 1 1207 598 1 598 1208 1 1208 599 1 599 1209 1
		 1209 600 1 600 1210 1 1210 601 1 601 1211 1 1211 602 1 602 1212 1 1212 603 1 603 1213 1
		 1213 604 1 604 1214 1 1214 605 1 605 1215 1 1215 606 1 606 1216 1 1216 607 1 607 1217 1
		 1217 576 1 0 1218 1 1218 32 1 1 1219 1 1219 33 1 2 1220 1 1220 34 1 3 1221 1 1221 35 1
		 4 1222 1 1222 36 1 5 1223 1 1223 37 1 6 1224 1 1224 38 1 7 1225 1 1225 39 1 8 1226 1
		 1226 40 1 9 1227 1 1227 41 1 10 1228 1 1228 42 1 11 1229 1 1229 43 1 12 1230 1 1230 44 1
		 13 1231 1 1231 45 1 14 1232 1 1232 46 1 15 1233 1 1233 47 1 16 1234 1 1234 48 1 17 1235 1
		 1235 49 1 18 1236 1 1236 50 1 19 1237 1 1237 51 1 20 1238 1 1238 52 1 21 1239 1 1239 53 1
		 22 1240 1 1240 54 1 23 1241 1 1241 55 1 24 1242 1 1242 56 1 25 1243 1 1243 57 1 26 1244 1
		 1244 58 1 27 1245 1 1245 59 1 28 1246 1 1246 60 1 29 1247 1 1247 61 1 30 1248 1 1248 62 1
		 31 1249 1 1249 63 1 32 1250 1 1250 64 1 33 1251 1 1251 65 1 34 1252 1 1252 66 1 35 1253 1
		 1253 67 1 36 1254 1 1254 68 1 37 1255 1 1255 69 1 38 1256 1 1256 70 1 39 1257 1 1257 71 1
		 40 1258 1 1258 72 1 41 1259 1 1259 73 1 42 1260 1 1260 74 1 43 1261 1 1261 75 1 44 1262 1
		 1262 76 1 45 1263 1 1263 77 1 46 1264 1 1264 78 1 47 1265 1 1265 79 1 48 1266 1 1266 80 1
		 49 1267 1 1267 81 1 50 1268 1 1268 82 1 51 1269 1 1269 83 1 52 1270 1 1270 84 1 53 1271 1
		 1271 85 1 54 1272 1 1272 86 1 55 1273 1 1273 87 1;
	setAttr ".ed[1328:1493]" 56 1274 1 1274 88 1 57 1275 1 1275 89 1 58 1276 1 1276 90 1
		 59 1277 1 1277 91 1 60 1278 1 1278 92 1 61 1279 1 1279 93 1 62 1280 1 1280 94 1 63 1281 1
		 1281 95 1 64 1282 1 1282 96 1 65 1283 1 1283 97 1 66 1284 1 1284 98 1 67 1285 1 1285 99 1
		 68 1286 1 1286 100 1 69 1287 1 1287 101 1 70 1288 1 1288 102 1 71 1289 1 1289 103 1
		 72 1290 1 1290 104 1 73 1291 1 1291 105 1 74 1292 1 1292 106 1 75 1293 1 1293 107 1
		 76 1294 1 1294 108 1 77 1295 1 1295 109 1 78 1296 1 1296 110 1 79 1297 1 1297 111 1
		 80 1298 1 1298 112 1 81 1299 1 1299 113 1 82 1300 1 1300 114 1 83 1301 1 1301 115 1
		 84 1302 1 1302 116 1 85 1303 1 1303 117 1 86 1304 1 1304 118 1 87 1305 1 1305 119 1
		 88 1306 1 1306 120 1 89 1307 1 1307 121 1 90 1308 1 1308 122 1 91 1309 1 1309 123 1
		 92 1310 1 1310 124 1 93 1311 1 1311 125 1 94 1312 1 1312 126 1 95 1313 1 1313 127 1
		 96 1314 1 1314 128 1 97 1315 1 1315 129 1 98 1316 1 1316 130 1 99 1317 1 1317 131 1
		 100 1318 1 1318 132 1 101 1319 1 1319 133 1 102 1320 1 1320 134 1 103 1321 1 1321 135 1
		 104 1322 1 1322 136 1 105 1323 1 1323 137 1 106 1324 1 1324 138 1 107 1325 1 1325 139 1
		 108 1326 1 1326 140 1 109 1327 1 1327 141 1 110 1328 1 1328 142 1 111 1329 1 1329 143 1
		 112 1330 1 1330 144 1 113 1331 1 1331 145 1 114 1332 1 1332 146 1 115 1333 1 1333 147 1
		 116 1334 1 1334 148 1 117 1335 1 1335 149 1 118 1336 1 1336 150 1 119 1337 1 1337 151 1
		 120 1338 1 1338 152 1 121 1339 1 1339 153 1 122 1340 1 1340 154 1 123 1341 1 1341 155 1
		 124 1342 1 1342 156 1 125 1343 1 1343 157 1 126 1344 1 1344 158 1 127 1345 1 1345 159 1
		 128 1346 1 1346 160 1 129 1347 1 1347 161 1 130 1348 1 1348 162 1 131 1349 1 1349 163 1
		 132 1350 1 1350 164 1 133 1351 1 1351 165 1 134 1352 1 1352 166 1 135 1353 1 1353 167 1
		 136 1354 1 1354 168 1 137 1355 1 1355 169 1 138 1356 1 1356 170 1;
	setAttr ".ed[1494:1659]" 139 1357 1 1357 171 1 140 1358 1 1358 172 1 141 1359 1
		 1359 173 1 142 1360 1 1360 174 1 143 1361 1 1361 175 1 144 1362 1 1362 176 1 145 1363 1
		 1363 177 1 146 1364 1 1364 178 1 147 1365 1 1365 179 1 148 1366 1 1366 180 1 149 1367 1
		 1367 181 1 150 1368 1 1368 182 1 151 1369 1 1369 183 1 152 1370 1 1370 184 1 153 1371 1
		 1371 185 1 154 1372 1 1372 186 1 155 1373 1 1373 187 1 156 1374 1 1374 188 1 157 1375 1
		 1375 189 1 158 1376 1 1376 190 1 159 1377 1 1377 191 1 160 1378 1 1378 192 1 161 1379 1
		 1379 193 1 162 1380 1 1380 194 1 163 1381 1 1381 195 1 164 1382 1 1382 196 1 165 1383 1
		 1383 197 1 166 1384 1 1384 198 1 167 1385 1 1385 199 1 168 1386 1 1386 200 1 169 1387 1
		 1387 201 1 170 1388 1 1388 202 1 171 1389 1 1389 203 1 172 1390 1 1390 204 1 173 1391 1
		 1391 205 1 174 1392 1 1392 206 1 175 1393 1 1393 207 1 176 1394 1 1394 208 1 177 1395 1
		 1395 209 1 178 1396 1 1396 210 1 179 1397 1 1397 211 1 180 1398 1 1398 212 1 181 1399 1
		 1399 213 1 182 1400 1 1400 214 1 183 1401 1 1401 215 1 184 1402 1 1402 216 1 185 1403 1
		 1403 217 1 186 1404 1 1404 218 1 187 1405 1 1405 219 1 188 1406 1 1406 220 1 189 1407 1
		 1407 221 1 190 1408 1 1408 222 1 191 1409 1 1409 223 1 192 1410 1 1410 224 1 193 1411 1
		 1411 225 1 194 1412 1 1412 226 1 195 1413 1 1413 227 1 196 1414 1 1414 228 1 197 1415 1
		 1415 229 1 198 1416 1 1416 230 1 199 1417 1 1417 231 1 200 1418 1 1418 232 1 201 1419 1
		 1419 233 1 202 1420 1 1420 234 1 203 1421 1 1421 235 1 204 1422 1 1422 236 1 205 1423 1
		 1423 237 1 206 1424 1 1424 238 1 207 1425 1 1425 239 1 208 1426 1 1426 240 1 209 1427 1
		 1427 241 1 210 1428 1 1428 242 1 211 1429 1 1429 243 1 212 1430 1 1430 244 1 213 1431 1
		 1431 245 1 214 1432 1 1432 246 1 215 1433 1 1433 247 1 216 1434 1 1434 248 1 217 1435 1
		 1435 249 1 218 1436 1 1436 250 1 219 1437 1 1437 251 1 220 1438 1 1438 252 1 221 1439 1
		 1439 253 1;
	setAttr ".ed[1660:1825]" 222 1440 1 1440 254 1 223 1441 1 1441 255 1 224 1442 1
		 1442 256 1 225 1443 1 1443 257 1 226 1444 1 1444 258 1 227 1445 1 1445 259 1 228 1446 1
		 1446 260 1 229 1447 1 1447 261 1 230 1448 1 1448 262 1 231 1449 1 1449 263 1 232 1450 1
		 1450 264 1 233 1451 1 1451 265 1 234 1452 1 1452 266 1 235 1453 1 1453 267 1 236 1454 1
		 1454 268 1 237 1455 1 1455 269 1 238 1456 1 1456 270 1 239 1457 1 1457 271 1 240 1458 1
		 1458 272 1 241 1459 1 1459 273 1 242 1460 1 1460 274 1 243 1461 1 1461 275 1 244 1462 1
		 1462 276 1 245 1463 1 1463 277 1 246 1464 1 1464 278 1 247 1465 1 1465 279 1 248 1466 1
		 1466 280 1 249 1467 1 1467 281 1 250 1468 1 1468 282 1 251 1469 1 1469 283 1 252 1470 1
		 1470 284 1 253 1471 1 1471 285 1 254 1472 1 1472 286 1 255 1473 1 1473 287 1 256 1474 1
		 1474 288 1 257 1475 1 1475 289 1 258 1476 1 1476 290 1 259 1477 1 1477 291 1 260 1478 1
		 1478 292 1 261 1479 1 1479 293 1 262 1480 1 1480 294 1 263 1481 1 1481 295 1 264 1482 1
		 1482 296 1 265 1483 1 1483 297 1 266 1484 1 1484 298 1 267 1485 1 1485 299 1 268 1486 1
		 1486 300 1 269 1487 1 1487 301 1 270 1488 1 1488 302 1 271 1489 1 1489 303 1 272 1490 1
		 1490 304 1 273 1491 1 1491 305 1 274 1492 1 1492 306 1 275 1493 1 1493 307 1 276 1494 1
		 1494 308 1 277 1495 1 1495 309 1 278 1496 1 1496 310 1 279 1497 1 1497 311 1 280 1498 1
		 1498 312 1 281 1499 1 1499 313 1 282 1500 1 1500 314 1 283 1501 1 1501 315 1 284 1502 1
		 1502 316 1 285 1503 1 1503 317 1 286 1504 1 1504 318 1 287 1505 1 1505 319 1 288 1506 1
		 1506 320 1 289 1507 1 1507 321 1 290 1508 1 1508 322 1 291 1509 1 1509 323 1 292 1510 1
		 1510 324 1 293 1511 1 1511 325 1 294 1512 1 1512 326 1 295 1513 1 1513 327 1 296 1514 1
		 1514 328 1 297 1515 1 1515 329 1 298 1516 1 1516 330 1 299 1517 1 1517 331 1 300 1518 1
		 1518 332 1 301 1519 1 1519 333 1 302 1520 1 1520 334 1 303 1521 1 1521 335 1 304 1522 1
		 1522 336 1;
	setAttr ".ed[1826:1991]" 305 1523 1 1523 337 1 306 1524 1 1524 338 1 307 1525 1
		 1525 339 1 308 1526 1 1526 340 1 309 1527 1 1527 341 1 310 1528 1 1528 342 1 311 1529 1
		 1529 343 1 312 1530 1 1530 344 1 313 1531 1 1531 345 1 314 1532 1 1532 346 1 315 1533 1
		 1533 347 1 316 1534 1 1534 348 1 317 1535 1 1535 349 1 318 1536 1 1536 350 1 319 1537 1
		 1537 351 1 320 1538 1 1538 352 1 321 1539 1 1539 353 1 322 1540 1 1540 354 1 323 1541 1
		 1541 355 1 324 1542 1 1542 356 1 325 1543 1 1543 357 1 326 1544 1 1544 358 1 327 1545 1
		 1545 359 1 328 1546 1 1546 360 1 329 1547 1 1547 361 1 330 1548 1 1548 362 1 331 1549 1
		 1549 363 1 332 1550 1 1550 364 1 333 1551 1 1551 365 1 334 1552 1 1552 366 1 335 1553 1
		 1553 367 1 336 1554 1 1554 368 1 337 1555 1 1555 369 1 338 1556 1 1556 370 1 339 1557 1
		 1557 371 1 340 1558 1 1558 372 1 341 1559 1 1559 373 1 342 1560 1 1560 374 1 343 1561 1
		 1561 375 1 344 1562 1 1562 376 1 345 1563 1 1563 377 1 346 1564 1 1564 378 1 347 1565 1
		 1565 379 1 348 1566 1 1566 380 1 349 1567 1 1567 381 1 350 1568 1 1568 382 1 351 1569 1
		 1569 383 1 352 1570 1 1570 384 1 353 1571 1 1571 385 1 354 1572 1 1572 386 1 355 1573 1
		 1573 387 1 356 1574 1 1574 388 1 357 1575 1 1575 389 1 358 1576 1 1576 390 1 359 1577 1
		 1577 391 1 360 1578 1 1578 392 1 361 1579 1 1579 393 1 362 1580 1 1580 394 1 363 1581 1
		 1581 395 1 364 1582 1 1582 396 1 365 1583 1 1583 397 1 366 1584 1 1584 398 1 367 1585 1
		 1585 399 1 368 1586 1 1586 400 1 369 1587 1 1587 401 1 370 1588 1 1588 402 1 371 1589 1
		 1589 403 1 372 1590 1 1590 404 1 373 1591 1 1591 405 1 374 1592 1 1592 406 1 375 1593 1
		 1593 407 1 376 1594 1 1594 408 1 377 1595 1 1595 409 1 378 1596 1 1596 410 1 379 1597 1
		 1597 411 1 380 1598 1 1598 412 1 381 1599 1 1599 413 1 382 1600 1 1600 414 1 383 1601 1
		 1601 415 1 384 1602 1 1602 416 1 385 1603 1 1603 417 1 386 1604 1 1604 418 1 387 1605 1
		 1605 419 1;
	setAttr ".ed[1992:2157]" 388 1606 1 1606 420 1 389 1607 1 1607 421 1 390 1608 1
		 1608 422 1 391 1609 1 1609 423 1 392 1610 1 1610 424 1 393 1611 1 1611 425 1 394 1612 1
		 1612 426 1 395 1613 1 1613 427 1 396 1614 1 1614 428 1 397 1615 1 1615 429 1 398 1616 1
		 1616 430 1 399 1617 1 1617 431 1 400 1618 1 1618 432 1 401 1619 1 1619 433 1 402 1620 1
		 1620 434 1 403 1621 1 1621 435 1 404 1622 1 1622 436 1 405 1623 1 1623 437 1 406 1624 1
		 1624 438 1 407 1625 1 1625 439 1 408 1626 1 1626 440 1 409 1627 1 1627 441 1 410 1628 1
		 1628 442 1 411 1629 1 1629 443 1 412 1630 1 1630 444 1 413 1631 1 1631 445 1 414 1632 1
		 1632 446 1 415 1633 1 1633 447 1 416 1634 1 1634 448 1 417 1635 1 1635 449 1 418 1636 1
		 1636 450 1 419 1637 1 1637 451 1 420 1638 1 1638 452 1 421 1639 1 1639 453 1 422 1640 1
		 1640 454 1 423 1641 1 1641 455 1 424 1642 1 1642 456 1 425 1643 1 1643 457 1 426 1644 1
		 1644 458 1 427 1645 1 1645 459 1 428 1646 1 1646 460 1 429 1647 1 1647 461 1 430 1648 1
		 1648 462 1 431 1649 1 1649 463 1 432 1650 1 1650 464 1 433 1651 1 1651 465 1 434 1652 1
		 1652 466 1 435 1653 1 1653 467 1 436 1654 1 1654 468 1 437 1655 1 1655 469 1 438 1656 1
		 1656 470 1 439 1657 1 1657 471 1 440 1658 1 1658 472 1 441 1659 1 1659 473 1 442 1660 1
		 1660 474 1 443 1661 1 1661 475 1 444 1662 1 1662 476 1 445 1663 1 1663 477 1 446 1664 1
		 1664 478 1 447 1665 1 1665 479 1 448 1666 1 1666 480 1 449 1667 1 1667 481 1 450 1668 1
		 1668 482 1 451 1669 1 1669 483 1 452 1670 1 1670 484 1 453 1671 1 1671 485 1 454 1672 1
		 1672 486 1 455 1673 1 1673 487 1 456 1674 1 1674 488 1 457 1675 1 1675 489 1 458 1676 1
		 1676 490 1 459 1677 1 1677 491 1 460 1678 1 1678 492 1 461 1679 1 1679 493 1 462 1680 1
		 1680 494 1 463 1681 1 1681 495 1 464 1682 1 1682 496 1 465 1683 1 1683 497 1 466 1684 1
		 1684 498 1 467 1685 1 1685 499 1 468 1686 1 1686 500 1 469 1687 1 1687 501 1 470 1688 1
		 1688 502 1;
	setAttr ".ed[2158:2323]" 471 1689 1 1689 503 1 472 1690 1 1690 504 1 473 1691 1
		 1691 505 1 474 1692 1 1692 506 1 475 1693 1 1693 507 1 476 1694 1 1694 508 1 477 1695 1
		 1695 509 1 478 1696 1 1696 510 1 479 1697 1 1697 511 1 480 1698 1 1698 512 1 481 1699 1
		 1699 513 1 482 1700 1 1700 514 1 483 1701 1 1701 515 1 484 1702 1 1702 516 1 485 1703 1
		 1703 517 1 486 1704 1 1704 518 1 487 1705 1 1705 519 1 488 1706 1 1706 520 1 489 1707 1
		 1707 521 1 490 1708 1 1708 522 1 491 1709 1 1709 523 1 492 1710 1 1710 524 1 493 1711 1
		 1711 525 1 494 1712 1 1712 526 1 495 1713 1 1713 527 1 496 1714 1 1714 528 1 497 1715 1
		 1715 529 1 498 1716 1 1716 530 1 499 1717 1 1717 531 1 500 1718 1 1718 532 1 501 1719 1
		 1719 533 1 502 1720 1 1720 534 1 503 1721 1 1721 535 1 504 1722 1 1722 536 1 505 1723 1
		 1723 537 1 506 1724 1 1724 538 1 507 1725 1 1725 539 1 508 1726 1 1726 540 1 509 1727 1
		 1727 541 1 510 1728 1 1728 542 1 511 1729 1 1729 543 1 512 1730 1 1730 544 1 513 1731 1
		 1731 545 1 514 1732 1 1732 546 1 515 1733 1 1733 547 1 516 1734 1 1734 548 1 517 1735 1
		 1735 549 1 518 1736 1 1736 550 1 519 1737 1 1737 551 1 520 1738 1 1738 552 1 521 1739 1
		 1739 553 1 522 1740 1 1740 554 1 523 1741 1 1741 555 1 524 1742 1 1742 556 1 525 1743 1
		 1743 557 1 526 1744 1 1744 558 1 527 1745 1 1745 559 1 528 1746 1 1746 560 1 529 1747 1
		 1747 561 1 530 1748 1 1748 562 1 531 1749 1 1749 563 1 532 1750 1 1750 564 1 533 1751 1
		 1751 565 1 534 1752 1 1752 566 1 535 1753 1 1753 567 1 536 1754 1 1754 568 1 537 1755 1
		 1755 569 1 538 1756 1 1756 570 1 539 1757 1 1757 571 1 540 1758 1 1758 572 1 541 1759 1
		 1759 573 1 542 1760 1 1760 574 1 543 1761 1 1761 575 1 544 1762 1 1762 576 1 545 1763 1
		 1763 577 1 546 1764 1 1764 578 1 547 1765 1 1765 579 1 548 1766 1 1766 580 1 549 1767 1
		 1767 581 1 550 1768 1 1768 582 1 551 1769 1 1769 583 1 552 1770 1 1770 584 1 553 1771 1
		 1771 585 1;
	setAttr ".ed[2324:2489]" 554 1772 1 1772 586 1 555 1773 1 1773 587 1 556 1774 1
		 1774 588 1 557 1775 1 1775 589 1 558 1776 1 1776 590 1 559 1777 1 1777 591 1 560 1778 1
		 1778 592 1 561 1779 1 1779 593 1 562 1780 1 1780 594 1 563 1781 1 1781 595 1 564 1782 1
		 1782 596 1 565 1783 1 1783 597 1 566 1784 1 1784 598 1 567 1785 1 1785 599 1 568 1786 1
		 1786 600 1 569 1787 1 1787 601 1 570 1788 1 1788 602 1 571 1789 1 1789 603 1 572 1790 1
		 1790 604 1 573 1791 1 1791 605 1 574 1792 1 1792 606 1 575 1793 1 1793 607 1 608 1794 1
		 1794 0 1 608 1795 1 1795 1 1 608 1796 1 1796 2 1 608 1797 1 1797 3 1 608 1798 1 1798 4 1
		 608 1799 1 1799 5 1 608 1800 1 1800 6 1 608 1801 1 1801 7 1 608 1802 1 1802 8 1 608 1803 1
		 1803 9 1 608 1804 1 1804 10 1 608 1805 1 1805 11 1 608 1806 1 1806 12 1 608 1807 1
		 1807 13 1 608 1808 1 1808 14 1 608 1809 1 1809 15 1 608 1810 1 1810 16 1 608 1811 1
		 1811 17 1 608 1812 1 1812 18 1 608 1813 1 1813 19 1 608 1814 1 1814 20 1 608 1815 1
		 1815 21 1 608 1816 1 1816 22 1 608 1817 1 1817 23 1 608 1818 1 1818 24 1 608 1819 1
		 1819 25 1 608 1820 1 1820 26 1 608 1821 1 1821 27 1 608 1822 1 1822 28 1 608 1823 1
		 1823 29 1 608 1824 1 1824 30 1 608 1825 1 1825 31 1 576 1826 1 1826 609 1 577 1827 1
		 1827 609 1 578 1828 1 1828 609 1 579 1829 1 1829 609 1 580 1830 1 1830 609 1 581 1831 1
		 1831 609 1 582 1832 1 1832 609 1 583 1833 1 1833 609 1 584 1834 1 1834 609 1 585 1835 1
		 1835 609 1 586 1836 1 1836 609 1 587 1837 1 1837 609 1 588 1838 1 1838 609 1 589 1839 1
		 1839 609 1 590 1840 1 1840 609 1 591 1841 1 1841 609 1 592 1842 1 1842 609 1 593 1843 1
		 1843 609 1 594 1844 1 1844 609 1 595 1845 1 1845 609 1 596 1846 1 1846 609 1 597 1847 1
		 1847 609 1 598 1848 1 1848 609 1 599 1849 1 1849 609 1 600 1850 1 1850 609 1 601 1851 1
		 1851 609 1 602 1852 1 1852 609 1 603 1853 1 1853 609 1 604 1854 1 1854 609 1;
	setAttr ".ed[2490:2655]" 605 1855 1 1855 609 1 606 1856 1 1856 609 1 607 1857 1
		 1857 609 1 1858 610 1 1858 1219 1 1858 642 1 1858 1218 1 1859 611 1 1859 1220 1 1859 643 1
		 1859 1219 1 1860 612 1 1860 1221 1 1860 644 1 1860 1220 1 1861 613 1 1861 1222 1
		 1861 645 1 1861 1221 1 1862 614 1 1862 1223 1 1862 646 1 1862 1222 1 1863 615 1 1863 1224 1
		 1863 647 1 1863 1223 1 1864 616 1 1864 1225 1 1864 648 1 1864 1224 1 1865 617 1 1865 1226 1
		 1865 649 1 1865 1225 1 1866 618 1 1866 1227 1 1866 650 1 1866 1226 1 1867 619 1 1867 1228 1
		 1867 651 1 1867 1227 1 1868 620 1 1868 1229 1 1868 652 1 1868 1228 1 1869 621 1 1869 1230 1
		 1869 653 1 1869 1229 1 1870 622 1 1870 1231 1 1870 654 1 1870 1230 1 1871 623 1 1871 1232 1
		 1871 655 1 1871 1231 1 1872 624 1 1872 1233 1 1872 656 1 1872 1232 1 1873 625 1 1873 1234 1
		 1873 657 1 1873 1233 1 1874 626 1 1874 1235 1 1874 658 1 1874 1234 1 1875 627 1 1875 1236 1
		 1875 659 1 1875 1235 1 1876 628 1 1876 1237 1 1876 660 1 1876 1236 1 1877 629 1 1877 1238 1
		 1877 661 1 1877 1237 1 1878 630 1 1878 1239 1 1878 662 1 1878 1238 1 1879 631 1 1879 1240 1
		 1879 663 1 1879 1239 1 1880 632 1 1880 1241 1 1880 664 1 1880 1240 1 1881 633 1 1881 1242 1
		 1881 665 1 1881 1241 1 1882 634 1 1882 1243 1 1882 666 1 1882 1242 1 1883 635 1 1883 1244 1
		 1883 667 1 1883 1243 1 1884 636 1 1884 1245 1 1884 668 1 1884 1244 1 1885 637 1 1885 1246 1
		 1885 669 1 1885 1245 1 1886 638 1 1886 1247 1 1886 670 1 1886 1246 1 1887 639 1 1887 1248 1
		 1887 671 1 1887 1247 1 1888 640 1 1888 1249 1 1888 672 1 1888 1248 1 1889 641 1 1889 1218 1
		 1889 673 1 1889 1249 1 1890 642 1 1890 1251 1 1890 674 1 1890 1250 1 1891 643 1 1891 1252 1
		 1891 675 1 1891 1251 1 1892 644 1 1892 1253 1 1892 676 1 1892 1252 1 1893 645 1 1893 1254 1
		 1893 677 1 1893 1253 1 1894 646 1 1894 1255 1 1894 678 1 1894 1254 1 1895 647 1 1895 1256 1
		 1895 679 1 1895 1255 1 1896 648 1 1896 1257 1 1896 680 1 1896 1256 1 1897 649 1 1897 1258 1
		 1897 681 1 1897 1257 1;
	setAttr ".ed[2656:2821]" 1898 650 1 1898 1259 1 1898 682 1 1898 1258 1 1899 651 1
		 1899 1260 1 1899 683 1 1899 1259 1 1900 652 1 1900 1261 1 1900 684 1 1900 1260 1
		 1901 653 1 1901 1262 1 1901 685 1 1901 1261 1 1902 654 1 1902 1263 1 1902 686 1 1902 1262 1
		 1903 655 1 1903 1264 1 1903 687 1 1903 1263 1 1904 656 1 1904 1265 1 1904 688 1 1904 1264 1
		 1905 657 1 1905 1266 1 1905 689 1 1905 1265 1 1906 658 1 1906 1267 1 1906 690 1 1906 1266 1
		 1907 659 1 1907 1268 1 1907 691 1 1907 1267 1 1908 660 1 1908 1269 1 1908 692 1 1908 1268 1
		 1909 661 1 1909 1270 1 1909 693 1 1909 1269 1 1910 662 1 1910 1271 1 1910 694 1 1910 1270 1
		 1911 663 1 1911 1272 1 1911 695 1 1911 1271 1 1912 664 1 1912 1273 1 1912 696 1 1912 1272 1
		 1913 665 1 1913 1274 1 1913 697 1 1913 1273 1 1914 666 1 1914 1275 1 1914 698 1 1914 1274 1
		 1915 667 1 1915 1276 1 1915 699 1 1915 1275 1 1916 668 1 1916 1277 1 1916 700 1 1916 1276 1
		 1917 669 1 1917 1278 1 1917 701 1 1917 1277 1 1918 670 1 1918 1279 1 1918 702 1 1918 1278 1
		 1919 671 1 1919 1280 1 1919 703 1 1919 1279 1 1920 672 1 1920 1281 1 1920 704 1 1920 1280 1
		 1921 673 1 1921 1250 1 1921 705 1 1921 1281 1 1922 674 1 1922 1283 1 1922 706 1 1922 1282 1
		 1923 675 1 1923 1284 1 1923 707 1 1923 1283 1 1924 676 1 1924 1285 1 1924 708 1 1924 1284 1
		 1925 677 1 1925 1286 1 1925 709 1 1925 1285 1 1926 678 1 1926 1287 1 1926 710 1 1926 1286 1
		 1927 679 1 1927 1288 1 1927 711 1 1927 1287 1 1928 680 1 1928 1289 1 1928 712 1 1928 1288 1
		 1929 681 1 1929 1290 1 1929 713 1 1929 1289 1 1930 682 1 1930 1291 1 1930 714 1 1930 1290 1
		 1931 683 1 1931 1292 1 1931 715 1 1931 1291 1 1932 684 1 1932 1293 1 1932 716 1 1932 1292 1
		 1933 685 1 1933 1294 1 1933 717 1 1933 1293 1 1934 686 1 1934 1295 1 1934 718 1 1934 1294 1
		 1935 687 1 1935 1296 1 1935 719 1 1935 1295 1 1936 688 1 1936 1297 1 1936 720 1 1936 1296 1
		 1937 689 1 1937 1298 1 1937 721 1 1937 1297 1 1938 690 1 1938 1299 1 1938 722 1 1938 1298 1
		 1939 691 1 1939 1300 1;
	setAttr ".ed[2822:2987]" 1939 723 1 1939 1299 1 1940 692 1 1940 1301 1 1940 724 1
		 1940 1300 1 1941 693 1 1941 1302 1 1941 725 1 1941 1301 1 1942 694 1 1942 1303 1
		 1942 726 1 1942 1302 1 1943 695 1 1943 1304 1 1943 727 1 1943 1303 1 1944 696 1 1944 1305 1
		 1944 728 1 1944 1304 1 1945 697 1 1945 1306 1 1945 729 1 1945 1305 1 1946 698 1 1946 1307 1
		 1946 730 1 1946 1306 1 1947 699 1 1947 1308 1 1947 731 1 1947 1307 1 1948 700 1 1948 1309 1
		 1948 732 1 1948 1308 1 1949 701 1 1949 1310 1 1949 733 1 1949 1309 1 1950 702 1 1950 1311 1
		 1950 734 1 1950 1310 1 1951 703 1 1951 1312 1 1951 735 1 1951 1311 1 1952 704 1 1952 1313 1
		 1952 736 1 1952 1312 1 1953 705 1 1953 1282 1 1953 737 1 1953 1313 1 1954 706 1 1954 1315 1
		 1954 738 1 1954 1314 1 1955 707 1 1955 1316 1 1955 739 1 1955 1315 1 1956 708 1 1956 1317 1
		 1956 740 1 1956 1316 1 1957 709 1 1957 1318 1 1957 741 1 1957 1317 1 1958 710 1 1958 1319 1
		 1958 742 1 1958 1318 1 1959 711 1 1959 1320 1 1959 743 1 1959 1319 1 1960 712 1 1960 1321 1
		 1960 744 1 1960 1320 1 1961 713 1 1961 1322 1 1961 745 1 1961 1321 1 1962 714 1 1962 1323 1
		 1962 746 1 1962 1322 1 1963 715 1 1963 1324 1 1963 747 1 1963 1323 1 1964 716 1 1964 1325 1
		 1964 748 1 1964 1324 1 1965 717 1 1965 1326 1 1965 749 1 1965 1325 1 1966 718 1 1966 1327 1
		 1966 750 1 1966 1326 1 1967 719 1 1967 1328 1 1967 751 1 1967 1327 1 1968 720 1 1968 1329 1
		 1968 752 1 1968 1328 1 1969 721 1 1969 1330 1 1969 753 1 1969 1329 1 1970 722 1 1970 1331 1
		 1970 754 1 1970 1330 1 1971 723 1 1971 1332 1 1971 755 1 1971 1331 1 1972 724 1 1972 1333 1
		 1972 756 1 1972 1332 1 1973 725 1 1973 1334 1 1973 757 1 1973 1333 1 1974 726 1 1974 1335 1
		 1974 758 1 1974 1334 1 1975 727 1 1975 1336 1 1975 759 1 1975 1335 1 1976 728 1 1976 1337 1
		 1976 760 1 1976 1336 1 1977 729 1 1977 1338 1 1977 761 1 1977 1337 1 1978 730 1 1978 1339 1
		 1978 762 1 1978 1338 1 1979 731 1 1979 1340 1 1979 763 1 1979 1339 1 1980 732 1 1980 1341 1
		 1980 764 1 1980 1340 1;
	setAttr ".ed[2988:3153]" 1981 733 1 1981 1342 1 1981 765 1 1981 1341 1 1982 734 1
		 1982 1343 1 1982 766 1 1982 1342 1 1983 735 1 1983 1344 1 1983 767 1 1983 1343 1
		 1984 736 1 1984 1345 1 1984 768 1 1984 1344 1 1985 737 1 1985 1314 1 1985 769 1 1985 1345 1
		 1986 738 1 1986 1347 1 1986 770 1 1986 1346 1 1987 739 1 1987 1348 1 1987 771 1 1987 1347 1
		 1988 740 1 1988 1349 1 1988 772 1 1988 1348 1 1989 741 1 1989 1350 1 1989 773 1 1989 1349 1
		 1990 742 1 1990 1351 1 1990 774 1 1990 1350 1 1991 743 1 1991 1352 1 1991 775 1 1991 1351 1
		 1992 744 1 1992 1353 1 1992 776 1 1992 1352 1 1993 745 1 1993 1354 1 1993 777 1 1993 1353 1
		 1994 746 1 1994 1355 1 1994 778 1 1994 1354 1 1995 747 1 1995 1356 1 1995 779 1 1995 1355 1
		 1996 748 1 1996 1357 1 1996 780 1 1996 1356 1 1997 749 1 1997 1358 1 1997 781 1 1997 1357 1
		 1998 750 1 1998 1359 1 1998 782 1 1998 1358 1 1999 751 1 1999 1360 1 1999 783 1 1999 1359 1
		 2000 752 1 2000 1361 1 2000 784 1 2000 1360 1 2001 753 1 2001 1362 1 2001 785 1 2001 1361 1
		 2002 754 1 2002 1363 1 2002 786 1 2002 1362 1 2003 755 1 2003 1364 1 2003 787 1 2003 1363 1
		 2004 756 1 2004 1365 1 2004 788 1 2004 1364 1 2005 757 1 2005 1366 1 2005 789 1 2005 1365 1
		 2006 758 1 2006 1367 1 2006 790 1 2006 1366 1 2007 759 1 2007 1368 1 2007 791 1 2007 1367 1
		 2008 760 1 2008 1369 1 2008 792 1 2008 1368 1 2009 761 1 2009 1370 1 2009 793 1 2009 1369 1
		 2010 762 1 2010 1371 1 2010 794 1 2010 1370 1 2011 763 1 2011 1372 1 2011 795 1 2011 1371 1
		 2012 764 1 2012 1373 1 2012 796 1 2012 1372 1 2013 765 1 2013 1374 1 2013 797 1 2013 1373 1
		 2014 766 1 2014 1375 1 2014 798 1 2014 1374 1 2015 767 1 2015 1376 1 2015 799 1 2015 1375 1
		 2016 768 1 2016 1377 1 2016 800 1 2016 1376 1 2017 769 1 2017 1346 1 2017 801 1 2017 1377 1
		 2018 770 1 2018 1379 1 2018 802 1 2018 1378 1 2019 771 1 2019 1380 1 2019 803 1 2019 1379 1
		 2020 772 1 2020 1381 1 2020 804 1 2020 1380 1 2021 773 1 2021 1382 1 2021 805 1 2021 1381 1
		 2022 774 1 2022 1383 1;
	setAttr ".ed[3154:3319]" 2022 806 1 2022 1382 1 2023 775 1 2023 1384 1 2023 807 1
		 2023 1383 1 2024 776 1 2024 1385 1 2024 808 1 2024 1384 1 2025 777 1 2025 1386 1
		 2025 809 1 2025 1385 1 2026 778 1 2026 1387 1 2026 810 1 2026 1386 1 2027 779 1 2027 1388 1
		 2027 811 1 2027 1387 1 2028 780 1 2028 1389 1 2028 812 1 2028 1388 1 2029 781 1 2029 1390 1
		 2029 813 1 2029 1389 1 2030 782 1 2030 1391 1 2030 814 1 2030 1390 1 2031 783 1 2031 1392 1
		 2031 815 1 2031 1391 1 2032 784 1 2032 1393 1 2032 816 1 2032 1392 1 2033 785 1 2033 1394 1
		 2033 817 1 2033 1393 1 2034 786 1 2034 1395 1 2034 818 1 2034 1394 1 2035 787 1 2035 1396 1
		 2035 819 1 2035 1395 1 2036 788 1 2036 1397 1 2036 820 1 2036 1396 1 2037 789 1 2037 1398 1
		 2037 821 1 2037 1397 1 2038 790 1 2038 1399 1 2038 822 1 2038 1398 1 2039 791 1 2039 1400 1
		 2039 823 1 2039 1399 1 2040 792 1 2040 1401 1 2040 824 1 2040 1400 1 2041 793 1 2041 1402 1
		 2041 825 1 2041 1401 1 2042 794 1 2042 1403 1 2042 826 1 2042 1402 1 2043 795 1 2043 1404 1
		 2043 827 1 2043 1403 1 2044 796 1 2044 1405 1 2044 828 1 2044 1404 1 2045 797 1 2045 1406 1
		 2045 829 1 2045 1405 1 2046 798 1 2046 1407 1 2046 830 1 2046 1406 1 2047 799 1 2047 1408 1
		 2047 831 1 2047 1407 1 2048 800 1 2048 1409 1 2048 832 1 2048 1408 1 2049 801 1 2049 1378 1
		 2049 833 1 2049 1409 1 2050 802 1 2050 1411 1 2050 834 1 2050 1410 1 2051 803 1 2051 1412 1
		 2051 835 1 2051 1411 1 2052 804 1 2052 1413 1 2052 836 1 2052 1412 1 2053 805 1 2053 1414 1
		 2053 837 1 2053 1413 1 2054 806 1 2054 1415 1 2054 838 1 2054 1414 1 2055 807 1 2055 1416 1
		 2055 839 1 2055 1415 1 2056 808 1 2056 1417 1 2056 840 1 2056 1416 1 2057 809 1 2057 1418 1
		 2057 841 1 2057 1417 1 2058 810 1 2058 1419 1 2058 842 1 2058 1418 1 2059 811 1 2059 1420 1
		 2059 843 1 2059 1419 1 2060 812 1 2060 1421 1 2060 844 1 2060 1420 1 2061 813 1 2061 1422 1
		 2061 845 1 2061 1421 1 2062 814 1 2062 1423 1 2062 846 1 2062 1422 1 2063 815 1 2063 1424 1
		 2063 847 1 2063 1423 1;
	setAttr ".ed[3320:3485]" 2064 816 1 2064 1425 1 2064 848 1 2064 1424 1 2065 817 1
		 2065 1426 1 2065 849 1 2065 1425 1 2066 818 1 2066 1427 1 2066 850 1 2066 1426 1
		 2067 819 1 2067 1428 1 2067 851 1 2067 1427 1 2068 820 1 2068 1429 1 2068 852 1 2068 1428 1
		 2069 821 1 2069 1430 1 2069 853 1 2069 1429 1 2070 822 1 2070 1431 1 2070 854 1 2070 1430 1
		 2071 823 1 2071 1432 1 2071 855 1 2071 1431 1 2072 824 1 2072 1433 1 2072 856 1 2072 1432 1
		 2073 825 1 2073 1434 1 2073 857 1 2073 1433 1 2074 826 1 2074 1435 1 2074 858 1 2074 1434 1
		 2075 827 1 2075 1436 1 2075 859 1 2075 1435 1 2076 828 1 2076 1437 1 2076 860 1 2076 1436 1
		 2077 829 1 2077 1438 1 2077 861 1 2077 1437 1 2078 830 1 2078 1439 1 2078 862 1 2078 1438 1
		 2079 831 1 2079 1440 1 2079 863 1 2079 1439 1 2080 832 1 2080 1441 1 2080 864 1 2080 1440 1
		 2081 833 1 2081 1410 1 2081 865 1 2081 1441 1 2082 834 1 2082 1443 1 2082 866 1 2082 1442 1
		 2083 835 1 2083 1444 1 2083 867 1 2083 1443 1 2084 836 1 2084 1445 1 2084 868 1 2084 1444 1
		 2085 837 1 2085 1446 1 2085 869 1 2085 1445 1 2086 838 1 2086 1447 1 2086 870 1 2086 1446 1
		 2087 839 1 2087 1448 1 2087 871 1 2087 1447 1 2088 840 1 2088 1449 1 2088 872 1 2088 1448 1
		 2089 841 1 2089 1450 1 2089 873 1 2089 1449 1 2090 842 1 2090 1451 1 2090 874 1 2090 1450 1
		 2091 843 1 2091 1452 1 2091 875 1 2091 1451 1 2092 844 1 2092 1453 1 2092 876 1 2092 1452 1
		 2093 845 1 2093 1454 1 2093 877 1 2093 1453 1 2094 846 1 2094 1455 1 2094 878 1 2094 1454 1
		 2095 847 1 2095 1456 1 2095 879 1 2095 1455 1 2096 848 1 2096 1457 1 2096 880 1 2096 1456 1
		 2097 849 1 2097 1458 1 2097 881 1 2097 1457 1 2098 850 1 2098 1459 1 2098 882 1 2098 1458 1
		 2099 851 1 2099 1460 1 2099 883 1 2099 1459 1 2100 852 1 2100 1461 1 2100 884 1 2100 1460 1
		 2101 853 1 2101 1462 1 2101 885 1 2101 1461 1 2102 854 1 2102 1463 1 2102 886 1 2102 1462 1
		 2103 855 1 2103 1464 1 2103 887 1 2103 1463 1 2104 856 1 2104 1465 1 2104 888 1 2104 1464 1
		 2105 857 1 2105 1466 1;
	setAttr ".ed[3486:3651]" 2105 889 1 2105 1465 1 2106 858 1 2106 1467 1 2106 890 1
		 2106 1466 1 2107 859 1 2107 1468 1 2107 891 1 2107 1467 1 2108 860 1 2108 1469 1
		 2108 892 1 2108 1468 1 2109 861 1 2109 1470 1 2109 893 1 2109 1469 1 2110 862 1 2110 1471 1
		 2110 894 1 2110 1470 1 2111 863 1 2111 1472 1 2111 895 1 2111 1471 1 2112 864 1 2112 1473 1
		 2112 896 1 2112 1472 1 2113 865 1 2113 1442 1 2113 897 1 2113 1473 1 2114 866 1 2114 1475 1
		 2114 898 1 2114 1474 1 2115 867 1 2115 1476 1 2115 899 1 2115 1475 1 2116 868 1 2116 1477 1
		 2116 900 1 2116 1476 1 2117 869 1 2117 1478 1 2117 901 1 2117 1477 1 2118 870 1 2118 1479 1
		 2118 902 1 2118 1478 1 2119 871 1 2119 1480 1 2119 903 1 2119 1479 1 2120 872 1 2120 1481 1
		 2120 904 1 2120 1480 1 2121 873 1 2121 1482 1 2121 905 1 2121 1481 1 2122 874 1 2122 1483 1
		 2122 906 1 2122 1482 1 2123 875 1 2123 1484 1 2123 907 1 2123 1483 1 2124 876 1 2124 1485 1
		 2124 908 1 2124 1484 1 2125 877 1 2125 1486 1 2125 909 1 2125 1485 1 2126 878 1 2126 1487 1
		 2126 910 1 2126 1486 1 2127 879 1 2127 1488 1 2127 911 1 2127 1487 1 2128 880 1 2128 1489 1
		 2128 912 1 2128 1488 1 2129 881 1 2129 1490 1 2129 913 1 2129 1489 1 2130 882 1 2130 1491 1
		 2130 914 1 2130 1490 1 2131 883 1 2131 1492 1 2131 915 1 2131 1491 1 2132 884 1 2132 1493 1
		 2132 916 1 2132 1492 1 2133 885 1 2133 1494 1 2133 917 1 2133 1493 1 2134 886 1 2134 1495 1
		 2134 918 1 2134 1494 1 2135 887 1 2135 1496 1 2135 919 1 2135 1495 1 2136 888 1 2136 1497 1
		 2136 920 1 2136 1496 1 2137 889 1 2137 1498 1 2137 921 1 2137 1497 1 2138 890 1 2138 1499 1
		 2138 922 1 2138 1498 1 2139 891 1 2139 1500 1 2139 923 1 2139 1499 1 2140 892 1 2140 1501 1
		 2140 924 1 2140 1500 1 2141 893 1 2141 1502 1 2141 925 1 2141 1501 1 2142 894 1 2142 1503 1
		 2142 926 1 2142 1502 1 2143 895 1 2143 1504 1 2143 927 1 2143 1503 1 2144 896 1 2144 1505 1
		 2144 928 1 2144 1504 1 2145 897 1 2145 1474 1 2145 929 1 2145 1505 1 2146 898 1 2146 1507 1
		 2146 930 1 2146 1506 1;
	setAttr ".ed[3652:3817]" 2147 899 1 2147 1508 1 2147 931 1 2147 1507 1 2148 900 1
		 2148 1509 1 2148 932 1 2148 1508 1 2149 901 1 2149 1510 1 2149 933 1 2149 1509 1
		 2150 902 1 2150 1511 1 2150 934 1 2150 1510 1 2151 903 1 2151 1512 1 2151 935 1 2151 1511 1
		 2152 904 1 2152 1513 1 2152 936 1 2152 1512 1 2153 905 1 2153 1514 1 2153 937 1 2153 1513 1
		 2154 906 1 2154 1515 1 2154 938 1 2154 1514 1 2155 907 1 2155 1516 1 2155 939 1 2155 1515 1
		 2156 908 1 2156 1517 1 2156 940 1 2156 1516 1 2157 909 1 2157 1518 1 2157 941 1 2157 1517 1
		 2158 910 1 2158 1519 1 2158 942 1 2158 1518 1 2159 911 1 2159 1520 1 2159 943 1 2159 1519 1
		 2160 912 1 2160 1521 1 2160 944 1 2160 1520 1 2161 913 1 2161 1522 1 2161 945 1 2161 1521 1
		 2162 914 1 2162 1523 1 2162 946 1 2162 1522 1 2163 915 1 2163 1524 1 2163 947 1 2163 1523 1
		 2164 916 1 2164 1525 1 2164 948 1 2164 1524 1 2165 917 1 2165 1526 1 2165 949 1 2165 1525 1
		 2166 918 1 2166 1527 1 2166 950 1 2166 1526 1 2167 919 1 2167 1528 1 2167 951 1 2167 1527 1
		 2168 920 1 2168 1529 1 2168 952 1 2168 1528 1 2169 921 1 2169 1530 1 2169 953 1 2169 1529 1
		 2170 922 1 2170 1531 1 2170 954 1 2170 1530 1 2171 923 1 2171 1532 1 2171 955 1 2171 1531 1
		 2172 924 1 2172 1533 1 2172 956 1 2172 1532 1 2173 925 1 2173 1534 1 2173 957 1 2173 1533 1
		 2174 926 1 2174 1535 1 2174 958 1 2174 1534 1 2175 927 1 2175 1536 1 2175 959 1 2175 1535 1
		 2176 928 1 2176 1537 1 2176 960 1 2176 1536 1 2177 929 1 2177 1506 1 2177 961 1 2177 1537 1
		 2178 930 1 2178 1539 1 2178 962 1 2178 1538 1 2179 931 1 2179 1540 1 2179 963 1 2179 1539 1
		 2180 932 1 2180 1541 1 2180 964 1 2180 1540 1 2181 933 1 2181 1542 1 2181 965 1 2181 1541 1
		 2182 934 1 2182 1543 1 2182 966 1 2182 1542 1 2183 935 1 2183 1544 1 2183 967 1 2183 1543 1
		 2184 936 1 2184 1545 1 2184 968 1 2184 1544 1 2185 937 1 2185 1546 1 2185 969 1 2185 1545 1
		 2186 938 1 2186 1547 1 2186 970 1 2186 1546 1 2187 939 1 2187 1548 1 2187 971 1 2187 1547 1
		 2188 940 1 2188 1549 1;
	setAttr ".ed[3818:3983]" 2188 972 1 2188 1548 1 2189 941 1 2189 1550 1 2189 973 1
		 2189 1549 1 2190 942 1 2190 1551 1 2190 974 1 2190 1550 1 2191 943 1 2191 1552 1
		 2191 975 1 2191 1551 1 2192 944 1 2192 1553 1 2192 976 1 2192 1552 1 2193 945 1 2193 1554 1
		 2193 977 1 2193 1553 1 2194 946 1 2194 1555 1 2194 978 1 2194 1554 1 2195 947 1 2195 1556 1
		 2195 979 1 2195 1555 1 2196 948 1 2196 1557 1 2196 980 1 2196 1556 1 2197 949 1 2197 1558 1
		 2197 981 1 2197 1557 1 2198 950 1 2198 1559 1 2198 982 1 2198 1558 1 2199 951 1 2199 1560 1
		 2199 983 1 2199 1559 1 2200 952 1 2200 1561 1 2200 984 1 2200 1560 1 2201 953 1 2201 1562 1
		 2201 985 1 2201 1561 1 2202 954 1 2202 1563 1 2202 986 1 2202 1562 1 2203 955 1 2203 1564 1
		 2203 987 1 2203 1563 1 2204 956 1 2204 1565 1 2204 988 1 2204 1564 1 2205 957 1 2205 1566 1
		 2205 989 1 2205 1565 1 2206 958 1 2206 1567 1 2206 990 1 2206 1566 1 2207 959 1 2207 1568 1
		 2207 991 1 2207 1567 1 2208 960 1 2208 1569 1 2208 992 1 2208 1568 1 2209 961 1 2209 1538 1
		 2209 993 1 2209 1569 1 2210 962 1 2210 1571 1 2210 994 1 2210 1570 1 2211 963 1 2211 1572 1
		 2211 995 1 2211 1571 1 2212 964 1 2212 1573 1 2212 996 1 2212 1572 1 2213 965 1 2213 1574 1
		 2213 997 1 2213 1573 1 2214 966 1 2214 1575 1 2214 998 1 2214 1574 1 2215 967 1 2215 1576 1
		 2215 999 1 2215 1575 1 2216 968 1 2216 1577 1 2216 1000 1 2216 1576 1 2217 969 1
		 2217 1578 1 2217 1001 1 2217 1577 1 2218 970 1 2218 1579 1 2218 1002 1 2218 1578 1
		 2219 971 1 2219 1580 1 2219 1003 1 2219 1579 1 2220 972 1 2220 1581 1 2220 1004 1
		 2220 1580 1 2221 973 1 2221 1582 1 2221 1005 1 2221 1581 1 2222 974 1 2222 1583 1
		 2222 1006 1 2222 1582 1 2223 975 1 2223 1584 1 2223 1007 1 2223 1583 1 2224 976 1
		 2224 1585 1 2224 1008 1 2224 1584 1 2225 977 1 2225 1586 1 2225 1009 1 2225 1585 1
		 2226 978 1 2226 1587 1 2226 1010 1 2226 1586 1 2227 979 1 2227 1588 1 2227 1011 1
		 2227 1587 1 2228 980 1 2228 1589 1 2228 1012 1 2228 1588 1 2229 981 1 2229 1590 1
		 2229 1013 1 2229 1589 1;
	setAttr ".ed[3984:4149]" 2230 982 1 2230 1591 1 2230 1014 1 2230 1590 1 2231 983 1
		 2231 1592 1 2231 1015 1 2231 1591 1 2232 984 1 2232 1593 1 2232 1016 1 2232 1592 1
		 2233 985 1 2233 1594 1 2233 1017 1 2233 1593 1 2234 986 1 2234 1595 1 2234 1018 1
		 2234 1594 1 2235 987 1 2235 1596 1 2235 1019 1 2235 1595 1 2236 988 1 2236 1597 1
		 2236 1020 1 2236 1596 1 2237 989 1 2237 1598 1 2237 1021 1 2237 1597 1 2238 990 1
		 2238 1599 1 2238 1022 1 2238 1598 1 2239 991 1 2239 1600 1 2239 1023 1 2239 1599 1
		 2240 992 1 2240 1601 1 2240 1024 1 2240 1600 1 2241 993 1 2241 1570 1 2241 1025 1
		 2241 1601 1 2242 994 1 2242 1603 1 2242 1026 1 2242 1602 1 2243 995 1 2243 1604 1
		 2243 1027 1 2243 1603 1 2244 996 1 2244 1605 1 2244 1028 1 2244 1604 1 2245 997 1
		 2245 1606 1 2245 1029 1 2245 1605 1 2246 998 1 2246 1607 1 2246 1030 1 2246 1606 1
		 2247 999 1 2247 1608 1 2247 1031 1 2247 1607 1 2248 1000 1 2248 1609 1 2248 1032 1
		 2248 1608 1 2249 1001 1 2249 1610 1 2249 1033 1 2249 1609 1 2250 1002 1 2250 1611 1
		 2250 1034 1 2250 1610 1 2251 1003 1 2251 1612 1 2251 1035 1 2251 1611 1 2252 1004 1
		 2252 1613 1 2252 1036 1 2252 1612 1 2253 1005 1 2253 1614 1 2253 1037 1 2253 1613 1
		 2254 1006 1 2254 1615 1 2254 1038 1 2254 1614 1 2255 1007 1 2255 1616 1 2255 1039 1
		 2255 1615 1 2256 1008 1 2256 1617 1 2256 1040 1 2256 1616 1 2257 1009 1 2257 1618 1
		 2257 1041 1 2257 1617 1 2258 1010 1 2258 1619 1 2258 1042 1 2258 1618 1 2259 1011 1
		 2259 1620 1 2259 1043 1 2259 1619 1 2260 1012 1 2260 1621 1 2260 1044 1 2260 1620 1
		 2261 1013 1 2261 1622 1 2261 1045 1 2261 1621 1 2262 1014 1 2262 1623 1 2262 1046 1
		 2262 1622 1 2263 1015 1 2263 1624 1 2263 1047 1 2263 1623 1 2264 1016 1 2264 1625 1
		 2264 1048 1 2264 1624 1 2265 1017 1 2265 1626 1 2265 1049 1 2265 1625 1 2266 1018 1
		 2266 1627 1 2266 1050 1 2266 1626 1 2267 1019 1 2267 1628 1 2267 1051 1 2267 1627 1
		 2268 1020 1 2268 1629 1 2268 1052 1 2268 1628 1 2269 1021 1 2269 1630 1 2269 1053 1
		 2269 1629 1 2270 1022 1 2270 1631 1 2270 1054 1 2270 1630 1 2271 1023 1 2271 1632 1;
	setAttr ".ed[4150:4315]" 2271 1055 1 2271 1631 1 2272 1024 1 2272 1633 1 2272 1056 1
		 2272 1632 1 2273 1025 1 2273 1602 1 2273 1057 1 2273 1633 1 2274 1026 1 2274 1635 1
		 2274 1058 1 2274 1634 1 2275 1027 1 2275 1636 1 2275 1059 1 2275 1635 1 2276 1028 1
		 2276 1637 1 2276 1060 1 2276 1636 1 2277 1029 1 2277 1638 1 2277 1061 1 2277 1637 1
		 2278 1030 1 2278 1639 1 2278 1062 1 2278 1638 1 2279 1031 1 2279 1640 1 2279 1063 1
		 2279 1639 1 2280 1032 1 2280 1641 1 2280 1064 1 2280 1640 1 2281 1033 1 2281 1642 1
		 2281 1065 1 2281 1641 1 2282 1034 1 2282 1643 1 2282 1066 1 2282 1642 1 2283 1035 1
		 2283 1644 1 2283 1067 1 2283 1643 1 2284 1036 1 2284 1645 1 2284 1068 1 2284 1644 1
		 2285 1037 1 2285 1646 1 2285 1069 1 2285 1645 1 2286 1038 1 2286 1647 1 2286 1070 1
		 2286 1646 1 2287 1039 1 2287 1648 1 2287 1071 1 2287 1647 1 2288 1040 1 2288 1649 1
		 2288 1072 1 2288 1648 1 2289 1041 1 2289 1650 1 2289 1073 1 2289 1649 1 2290 1042 1
		 2290 1651 1 2290 1074 1 2290 1650 1 2291 1043 1 2291 1652 1 2291 1075 1 2291 1651 1
		 2292 1044 1 2292 1653 1 2292 1076 1 2292 1652 1 2293 1045 1 2293 1654 1 2293 1077 1
		 2293 1653 1 2294 1046 1 2294 1655 1 2294 1078 1 2294 1654 1 2295 1047 1 2295 1656 1
		 2295 1079 1 2295 1655 1 2296 1048 1 2296 1657 1 2296 1080 1 2296 1656 1 2297 1049 1
		 2297 1658 1 2297 1081 1 2297 1657 1 2298 1050 1 2298 1659 1 2298 1082 1 2298 1658 1
		 2299 1051 1 2299 1660 1 2299 1083 1 2299 1659 1 2300 1052 1 2300 1661 1 2300 1084 1
		 2300 1660 1 2301 1053 1 2301 1662 1 2301 1085 1 2301 1661 1 2302 1054 1 2302 1663 1
		 2302 1086 1 2302 1662 1 2303 1055 1 2303 1664 1 2303 1087 1 2303 1663 1 2304 1056 1
		 2304 1665 1 2304 1088 1 2304 1664 1 2305 1057 1 2305 1634 1 2305 1089 1 2305 1665 1
		 2306 1058 1 2306 1667 1 2306 1090 1 2306 1666 1 2307 1059 1 2307 1668 1 2307 1091 1
		 2307 1667 1 2308 1060 1 2308 1669 1 2308 1092 1 2308 1668 1 2309 1061 1 2309 1670 1
		 2309 1093 1 2309 1669 1 2310 1062 1 2310 1671 1 2310 1094 1 2310 1670 1 2311 1063 1
		 2311 1672 1 2311 1095 1 2311 1671 1 2312 1064 1 2312 1673 1 2312 1096 1 2312 1672 1;
	setAttr ".ed[4316:4481]" 2313 1065 1 2313 1674 1 2313 1097 1 2313 1673 1 2314 1066 1
		 2314 1675 1 2314 1098 1 2314 1674 1 2315 1067 1 2315 1676 1 2315 1099 1 2315 1675 1
		 2316 1068 1 2316 1677 1 2316 1100 1 2316 1676 1 2317 1069 1 2317 1678 1 2317 1101 1
		 2317 1677 1 2318 1070 1 2318 1679 1 2318 1102 1 2318 1678 1 2319 1071 1 2319 1680 1
		 2319 1103 1 2319 1679 1 2320 1072 1 2320 1681 1 2320 1104 1 2320 1680 1 2321 1073 1
		 2321 1682 1 2321 1105 1 2321 1681 1 2322 1074 1 2322 1683 1 2322 1106 1 2322 1682 1
		 2323 1075 1 2323 1684 1 2323 1107 1 2323 1683 1 2324 1076 1 2324 1685 1 2324 1108 1
		 2324 1684 1 2325 1077 1 2325 1686 1 2325 1109 1 2325 1685 1 2326 1078 1 2326 1687 1
		 2326 1110 1 2326 1686 1 2327 1079 1 2327 1688 1 2327 1111 1 2327 1687 1 2328 1080 1
		 2328 1689 1 2328 1112 1 2328 1688 1 2329 1081 1 2329 1690 1 2329 1113 1 2329 1689 1
		 2330 1082 1 2330 1691 1 2330 1114 1 2330 1690 1 2331 1083 1 2331 1692 1 2331 1115 1
		 2331 1691 1 2332 1084 1 2332 1693 1 2332 1116 1 2332 1692 1 2333 1085 1 2333 1694 1
		 2333 1117 1 2333 1693 1 2334 1086 1 2334 1695 1 2334 1118 1 2334 1694 1 2335 1087 1
		 2335 1696 1 2335 1119 1 2335 1695 1 2336 1088 1 2336 1697 1 2336 1120 1 2336 1696 1
		 2337 1089 1 2337 1666 1 2337 1121 1 2337 1697 1 2338 1090 1 2338 1699 1 2338 1122 1
		 2338 1698 1 2339 1091 1 2339 1700 1 2339 1123 1 2339 1699 1 2340 1092 1 2340 1701 1
		 2340 1124 1 2340 1700 1 2341 1093 1 2341 1702 1 2341 1125 1 2341 1701 1 2342 1094 1
		 2342 1703 1 2342 1126 1 2342 1702 1 2343 1095 1 2343 1704 1 2343 1127 1 2343 1703 1
		 2344 1096 1 2344 1705 1 2344 1128 1 2344 1704 1 2345 1097 1 2345 1706 1 2345 1129 1
		 2345 1705 1 2346 1098 1 2346 1707 1 2346 1130 1 2346 1706 1 2347 1099 1 2347 1708 1
		 2347 1131 1 2347 1707 1 2348 1100 1 2348 1709 1 2348 1132 1 2348 1708 1 2349 1101 1
		 2349 1710 1 2349 1133 1 2349 1709 1 2350 1102 1 2350 1711 1 2350 1134 1 2350 1710 1
		 2351 1103 1 2351 1712 1 2351 1135 1 2351 1711 1 2352 1104 1 2352 1713 1 2352 1136 1
		 2352 1712 1 2353 1105 1 2353 1714 1 2353 1137 1 2353 1713 1 2354 1106 1 2354 1715 1;
	setAttr ".ed[4482:4647]" 2354 1138 1 2354 1714 1 2355 1107 1 2355 1716 1 2355 1139 1
		 2355 1715 1 2356 1108 1 2356 1717 1 2356 1140 1 2356 1716 1 2357 1109 1 2357 1718 1
		 2357 1141 1 2357 1717 1 2358 1110 1 2358 1719 1 2358 1142 1 2358 1718 1 2359 1111 1
		 2359 1720 1 2359 1143 1 2359 1719 1 2360 1112 1 2360 1721 1 2360 1144 1 2360 1720 1
		 2361 1113 1 2361 1722 1 2361 1145 1 2361 1721 1 2362 1114 1 2362 1723 1 2362 1146 1
		 2362 1722 1 2363 1115 1 2363 1724 1 2363 1147 1 2363 1723 1 2364 1116 1 2364 1725 1
		 2364 1148 1 2364 1724 1 2365 1117 1 2365 1726 1 2365 1149 1 2365 1725 1 2366 1118 1
		 2366 1727 1 2366 1150 1 2366 1726 1 2367 1119 1 2367 1728 1 2367 1151 1 2367 1727 1
		 2368 1120 1 2368 1729 1 2368 1152 1 2368 1728 1 2369 1121 1 2369 1698 1 2369 1153 1
		 2369 1729 1 2370 1122 1 2370 1731 1 2370 1154 1 2370 1730 1 2371 1123 1 2371 1732 1
		 2371 1155 1 2371 1731 1 2372 1124 1 2372 1733 1 2372 1156 1 2372 1732 1 2373 1125 1
		 2373 1734 1 2373 1157 1 2373 1733 1 2374 1126 1 2374 1735 1 2374 1158 1 2374 1734 1
		 2375 1127 1 2375 1736 1 2375 1159 1 2375 1735 1 2376 1128 1 2376 1737 1 2376 1160 1
		 2376 1736 1 2377 1129 1 2377 1738 1 2377 1161 1 2377 1737 1 2378 1130 1 2378 1739 1
		 2378 1162 1 2378 1738 1 2379 1131 1 2379 1740 1 2379 1163 1 2379 1739 1 2380 1132 1
		 2380 1741 1 2380 1164 1 2380 1740 1 2381 1133 1 2381 1742 1 2381 1165 1 2381 1741 1
		 2382 1134 1 2382 1743 1 2382 1166 1 2382 1742 1 2383 1135 1 2383 1744 1 2383 1167 1
		 2383 1743 1 2384 1136 1 2384 1745 1 2384 1168 1 2384 1744 1 2385 1137 1 2385 1746 1
		 2385 1169 1 2385 1745 1 2386 1138 1 2386 1747 1 2386 1170 1 2386 1746 1 2387 1139 1
		 2387 1748 1 2387 1171 1 2387 1747 1 2388 1140 1 2388 1749 1 2388 1172 1 2388 1748 1
		 2389 1141 1 2389 1750 1 2389 1173 1 2389 1749 1 2390 1142 1 2390 1751 1 2390 1174 1
		 2390 1750 1 2391 1143 1 2391 1752 1 2391 1175 1 2391 1751 1 2392 1144 1 2392 1753 1
		 2392 1176 1 2392 1752 1 2393 1145 1 2393 1754 1 2393 1177 1 2393 1753 1 2394 1146 1
		 2394 1755 1 2394 1178 1 2394 1754 1 2395 1147 1 2395 1756 1 2395 1179 1 2395 1755 1;
	setAttr ".ed[4648:4813]" 2396 1148 1 2396 1757 1 2396 1180 1 2396 1756 1 2397 1149 1
		 2397 1758 1 2397 1181 1 2397 1757 1 2398 1150 1 2398 1759 1 2398 1182 1 2398 1758 1
		 2399 1151 1 2399 1760 1 2399 1183 1 2399 1759 1 2400 1152 1 2400 1761 1 2400 1184 1
		 2400 1760 1 2401 1153 1 2401 1730 1 2401 1185 1 2401 1761 1 2402 1154 1 2402 1763 1
		 2402 1186 1 2402 1762 1 2403 1155 1 2403 1764 1 2403 1187 1 2403 1763 1 2404 1156 1
		 2404 1765 1 2404 1188 1 2404 1764 1 2405 1157 1 2405 1766 1 2405 1189 1 2405 1765 1
		 2406 1158 1 2406 1767 1 2406 1190 1 2406 1766 1 2407 1159 1 2407 1768 1 2407 1191 1
		 2407 1767 1 2408 1160 1 2408 1769 1 2408 1192 1 2408 1768 1 2409 1161 1 2409 1770 1
		 2409 1193 1 2409 1769 1 2410 1162 1 2410 1771 1 2410 1194 1 2410 1770 1 2411 1163 1
		 2411 1772 1 2411 1195 1 2411 1771 1 2412 1164 1 2412 1773 1 2412 1196 1 2412 1772 1
		 2413 1165 1 2413 1774 1 2413 1197 1 2413 1773 1 2414 1166 1 2414 1775 1 2414 1198 1
		 2414 1774 1 2415 1167 1 2415 1776 1 2415 1199 1 2415 1775 1 2416 1168 1 2416 1777 1
		 2416 1200 1 2416 1776 1 2417 1169 1 2417 1778 1 2417 1201 1 2417 1777 1 2418 1170 1
		 2418 1779 1 2418 1202 1 2418 1778 1 2419 1171 1 2419 1780 1 2419 1203 1 2419 1779 1
		 2420 1172 1 2420 1781 1 2420 1204 1 2420 1780 1 2421 1173 1 2421 1782 1 2421 1205 1
		 2421 1781 1 2422 1174 1 2422 1783 1 2422 1206 1 2422 1782 1 2423 1175 1 2423 1784 1
		 2423 1207 1 2423 1783 1 2424 1176 1 2424 1785 1 2424 1208 1 2424 1784 1 2425 1177 1
		 2425 1786 1 2425 1209 1 2425 1785 1 2426 1178 1 2426 1787 1 2426 1210 1 2426 1786 1
		 2427 1179 1 2427 1788 1 2427 1211 1 2427 1787 1 2428 1180 1 2428 1789 1 2428 1212 1
		 2428 1788 1 2429 1181 1 2429 1790 1 2429 1213 1 2429 1789 1 2430 1182 1 2430 1791 1
		 2430 1214 1 2430 1790 1 2431 1183 1 2431 1792 1 2431 1215 1 2431 1791 1 2432 1184 1
		 2432 1793 1 2432 1216 1 2432 1792 1 2433 1185 1 2433 1762 1 2433 1217 1 2433 1793 1
		 2434 610 1 2434 1794 1 2434 1795 1 2435 611 1 2435 1795 1 2435 1796 1 2436 612 1
		 2436 1796 1 2436 1797 1 2437 613 1 2437 1797 1 2437 1798 1 2438 614 1 2438 1798 1;
	setAttr ".ed[4814:4979]" 2438 1799 1 2439 615 1 2439 1799 1 2439 1800 1 2440 616 1
		 2440 1800 1 2440 1801 1 2441 617 1 2441 1801 1 2441 1802 1 2442 618 1 2442 1802 1
		 2442 1803 1 2443 619 1 2443 1803 1 2443 1804 1 2444 620 1 2444 1804 1 2444 1805 1
		 2445 621 1 2445 1805 1 2445 1806 1 2446 622 1 2446 1806 1 2446 1807 1 2447 623 1
		 2447 1807 1 2447 1808 1 2448 624 1 2448 1808 1 2448 1809 1 2449 625 1 2449 1809 1
		 2449 1810 1 2450 626 1 2450 1810 1 2450 1811 1 2451 627 1 2451 1811 1 2451 1812 1
		 2452 628 1 2452 1812 1 2452 1813 1 2453 629 1 2453 1813 1 2453 1814 1 2454 630 1
		 2454 1814 1 2454 1815 1 2455 631 1 2455 1815 1 2455 1816 1 2456 632 1 2456 1816 1
		 2456 1817 1 2457 633 1 2457 1817 1 2457 1818 1 2458 634 1 2458 1818 1 2458 1819 1
		 2459 635 1 2459 1819 1 2459 1820 1 2460 636 1 2460 1820 1 2460 1821 1 2461 637 1
		 2461 1821 1 2461 1822 1 2462 638 1 2462 1822 1 2462 1823 1 2463 639 1 2463 1823 1
		 2463 1824 1 2464 640 1 2464 1824 1 2464 1825 1 2465 641 1 2465 1825 1 2465 1794 1
		 2466 1186 1 2466 1827 1 2466 1826 1 2467 1187 1 2467 1828 1 2467 1827 1 2468 1188 1
		 2468 1829 1 2468 1828 1 2469 1189 1 2469 1830 1 2469 1829 1 2470 1190 1 2470 1831 1
		 2470 1830 1 2471 1191 1 2471 1832 1 2471 1831 1 2472 1192 1 2472 1833 1 2472 1832 1
		 2473 1193 1 2473 1834 1 2473 1833 1 2474 1194 1 2474 1835 1 2474 1834 1 2475 1195 1
		 2475 1836 1 2475 1835 1 2476 1196 1 2476 1837 1 2476 1836 1 2477 1197 1 2477 1838 1
		 2477 1837 1 2478 1198 1 2478 1839 1 2478 1838 1 2479 1199 1 2479 1840 1 2479 1839 1
		 2480 1200 1 2480 1841 1 2480 1840 1 2481 1201 1 2481 1842 1 2481 1841 1 2482 1202 1
		 2482 1843 1 2482 1842 1 2483 1203 1 2483 1844 1 2483 1843 1 2484 1204 1 2484 1845 1
		 2484 1844 1 2485 1205 1 2485 1846 1 2485 1845 1 2486 1206 1 2486 1847 1 2486 1846 1
		 2487 1207 1 2487 1848 1 2487 1847 1 2488 1208 1 2488 1849 1 2488 1848 1 2489 1209 1
		 2489 1850 1 2489 1849 1 2490 1210 1 2490 1851 1 2490 1850 1 2491 1211 1 2491 1852 1
		 2491 1851 1 2492 1212 1 2492 1853 1 2492 1852 1 2493 1213 1 2493 1854 1 2493 1853 1;
	setAttr ".ed[4980:4991]" 2494 1214 1 2494 1855 1 2494 1854 1 2495 1215 1 2495 1856 1
		 2495 1855 1 2496 1216 1 2496 1857 1 2496 1856 1 2497 1217 1 2497 1826 1 2497 1857 1;
	setAttr -s 2496 -ch 9984 ".fc";
	setAttr ".fc[0:499]" -type "polyFaces" 
		f 4 1 1218 -2498 2496
		mu 0 4 1327 1 1328 687
		f 4 1219 -66 -2499 2497
		mu 0 4 1328 33 1329 687
		f 4 -65 -1218 -2500 2498
		mu 0 4 1329 32 1330 687
		f 4 -1217 0 -2497 2499
		mu 0 4 1330 0 1327 687
		f 4 3 1220 -2502 2500
		mu 0 4 1331 2 1332 688
		f 4 1221 -68 -2503 2501
		mu 0 4 1332 34 1333 688
		f 4 -67 -1220 -2504 2502
		mu 0 4 1333 33 1328 688
		f 4 -1219 2 -2501 2503
		mu 0 4 1328 1 1331 688
		f 4 5 1222 -2506 2504
		mu 0 4 1334 3 1335 689
		f 4 1223 -70 -2507 2505
		mu 0 4 1335 35 1336 689
		f 4 -69 -1222 -2508 2506
		mu 0 4 1336 34 1332 689
		f 4 -1221 4 -2505 2507
		mu 0 4 1332 2 1334 689
		f 4 7 1224 -2510 2508
		mu 0 4 1337 4 1338 690
		f 4 1225 -72 -2511 2509
		mu 0 4 1338 36 1339 690
		f 4 -71 -1224 -2512 2510
		mu 0 4 1339 35 1335 690
		f 4 -1223 6 -2509 2511
		mu 0 4 1335 3 1337 690
		f 4 9 1226 -2514 2512
		mu 0 4 1340 5 1341 691
		f 4 1227 -74 -2515 2513
		mu 0 4 1341 37 1342 691
		f 4 -73 -1226 -2516 2514
		mu 0 4 1342 36 1338 691
		f 4 -1225 8 -2513 2515
		mu 0 4 1338 4 1340 691
		f 4 11 1228 -2518 2516
		mu 0 4 1343 6 1344 692
		f 4 1229 -76 -2519 2517
		mu 0 4 1344 38 1345 692
		f 4 -75 -1228 -2520 2518
		mu 0 4 1345 37 1341 692
		f 4 -1227 10 -2517 2519
		mu 0 4 1341 5 1343 692
		f 4 13 1230 -2522 2520
		mu 0 4 1346 7 1347 693
		f 4 1231 -78 -2523 2521
		mu 0 4 1347 39 1348 693
		f 4 -77 -1230 -2524 2522
		mu 0 4 1348 38 1344 693
		f 4 -1229 12 -2521 2523
		mu 0 4 1344 6 1346 693
		f 4 15 1232 -2526 2524
		mu 0 4 1349 8 1350 694
		f 4 1233 -80 -2527 2525
		mu 0 4 1350 40 1351 694
		f 4 -79 -1232 -2528 2526
		mu 0 4 1351 39 1347 694
		f 4 -1231 14 -2525 2527
		mu 0 4 1347 7 1349 694
		f 4 17 1234 -2530 2528
		mu 0 4 1352 9 1353 695
		f 4 1235 -82 -2531 2529
		mu 0 4 1353 41 1354 695
		f 4 -81 -1234 -2532 2530
		mu 0 4 1354 40 1350 695
		f 4 -1233 16 -2529 2531
		mu 0 4 1350 8 1352 695
		f 4 19 1236 -2534 2532
		mu 0 4 1355 10 1356 696
		f 4 1237 -84 -2535 2533
		mu 0 4 1356 42 1357 696
		f 4 -83 -1236 -2536 2534
		mu 0 4 1357 41 1353 696
		f 4 -1235 18 -2533 2535
		mu 0 4 1353 9 1355 696
		f 4 21 1238 -2538 2536
		mu 0 4 1358 11 1359 697
		f 4 1239 -86 -2539 2537
		mu 0 4 1359 43 1360 697
		f 4 -85 -1238 -2540 2538
		mu 0 4 1360 42 1356 697
		f 4 -1237 20 -2537 2539
		mu 0 4 1356 10 1358 697
		f 4 23 1240 -2542 2540
		mu 0 4 1361 12 1362 698
		f 4 1241 -88 -2543 2541
		mu 0 4 1362 44 1363 698
		f 4 -87 -1240 -2544 2542
		mu 0 4 1363 43 1359 698
		f 4 -1239 22 -2541 2543
		mu 0 4 1359 11 1361 698
		f 4 25 1242 -2546 2544
		mu 0 4 1364 13 1365 699
		f 4 1243 -90 -2547 2545
		mu 0 4 1365 45 1366 699
		f 4 -89 -1242 -2548 2546
		mu 0 4 1366 44 1362 699
		f 4 -1241 24 -2545 2547
		mu 0 4 1362 12 1364 699
		f 4 27 1244 -2550 2548
		mu 0 4 1367 14 1368 700
		f 4 1245 -92 -2551 2549
		mu 0 4 1368 46 1369 700
		f 4 -91 -1244 -2552 2550
		mu 0 4 1369 45 1365 700
		f 4 -1243 26 -2549 2551
		mu 0 4 1365 13 1367 700
		f 4 29 1246 -2554 2552
		mu 0 4 1370 15 1371 701
		f 4 1247 -94 -2555 2553
		mu 0 4 1371 47 1372 701
		f 4 -93 -1246 -2556 2554
		mu 0 4 1372 46 1368 701
		f 4 -1245 28 -2553 2555
		mu 0 4 1368 14 1370 701
		f 4 31 1248 -2558 2556
		mu 0 4 1373 16 1374 702
		f 4 1249 -96 -2559 2557
		mu 0 4 1374 48 1375 702
		f 4 -95 -1248 -2560 2558
		mu 0 4 1375 47 1371 702
		f 4 -1247 30 -2557 2559
		mu 0 4 1371 15 1373 702
		f 4 33 1250 -2562 2560
		mu 0 4 1376 17 1377 703
		f 4 1251 -98 -2563 2561
		mu 0 4 1377 49 1378 703
		f 4 -97 -1250 -2564 2562
		mu 0 4 1378 48 1374 703
		f 4 -1249 32 -2561 2563
		mu 0 4 1374 16 1376 703
		f 4 35 1252 -2566 2564
		mu 0 4 1379 18 1380 704
		f 4 1253 -100 -2567 2565
		mu 0 4 1380 50 1381 704
		f 4 -99 -1252 -2568 2566
		mu 0 4 1381 49 1377 704
		f 4 -1251 34 -2565 2567
		mu 0 4 1377 17 1379 704
		f 4 37 1254 -2570 2568
		mu 0 4 1382 19 1383 705
		f 4 1255 -102 -2571 2569
		mu 0 4 1383 51 1384 705
		f 4 -101 -1254 -2572 2570
		mu 0 4 1384 50 1380 705
		f 4 -1253 36 -2569 2571
		mu 0 4 1380 18 1382 705
		f 4 39 1256 -2574 2572
		mu 0 4 1385 20 1386 706
		f 4 1257 -104 -2575 2573
		mu 0 4 1386 52 1387 706
		f 4 -103 -1256 -2576 2574
		mu 0 4 1387 51 1383 706
		f 4 -1255 38 -2573 2575
		mu 0 4 1383 19 1385 706
		f 4 41 1258 -2578 2576
		mu 0 4 1388 21 1389 707
		f 4 1259 -106 -2579 2577
		mu 0 4 1389 53 1390 707
		f 4 -105 -1258 -2580 2578
		mu 0 4 1390 52 1386 707
		f 4 -1257 40 -2577 2579
		mu 0 4 1386 20 1388 707
		f 4 43 1260 -2582 2580
		mu 0 4 1391 22 1392 708
		f 4 1261 -108 -2583 2581
		mu 0 4 1392 54 1393 708
		f 4 -107 -1260 -2584 2582
		mu 0 4 1393 53 1389 708
		f 4 -1259 42 -2581 2583
		mu 0 4 1389 21 1391 708
		f 4 45 1262 -2586 2584
		mu 0 4 1394 23 1395 709
		f 4 1263 -110 -2587 2585
		mu 0 4 1395 55 1396 709
		f 4 -109 -1262 -2588 2586
		mu 0 4 1396 54 1392 709
		f 4 -1261 44 -2585 2587
		mu 0 4 1392 22 1394 709
		f 4 47 1264 -2590 2588
		mu 0 4 1397 24 1398 710
		f 4 1265 -112 -2591 2589
		mu 0 4 1398 56 1399 710
		f 4 -111 -1264 -2592 2590
		mu 0 4 1399 55 1395 710
		f 4 -1263 46 -2589 2591
		mu 0 4 1395 23 1397 710
		f 4 49 1266 -2594 2592
		mu 0 4 1400 25 1401 711
		f 4 1267 -114 -2595 2593
		mu 0 4 1401 57 1402 711
		f 4 -113 -1266 -2596 2594
		mu 0 4 1402 56 1398 711
		f 4 -1265 48 -2593 2595
		mu 0 4 1398 24 1400 711
		f 4 51 1268 -2598 2596
		mu 0 4 1403 26 1404 712
		f 4 1269 -116 -2599 2597
		mu 0 4 1404 58 1405 712
		f 4 -115 -1268 -2600 2598
		mu 0 4 1405 57 1401 712
		f 4 -1267 50 -2597 2599
		mu 0 4 1401 25 1403 712
		f 4 53 1270 -2602 2600
		mu 0 4 1406 27 1407 713
		f 4 1271 -118 -2603 2601
		mu 0 4 1407 59 1408 713
		f 4 -117 -1270 -2604 2602
		mu 0 4 1408 58 1404 713
		f 4 -1269 52 -2601 2603
		mu 0 4 1404 26 1406 713
		f 4 55 1272 -2606 2604
		mu 0 4 1409 28 1410 714
		f 4 1273 -120 -2607 2605
		mu 0 4 1410 60 1411 714
		f 4 -119 -1272 -2608 2606
		mu 0 4 1411 59 1407 714
		f 4 -1271 54 -2605 2607
		mu 0 4 1407 27 1409 714
		f 4 57 1274 -2610 2608
		mu 0 4 1412 29 1413 715
		f 4 1275 -122 -2611 2609
		mu 0 4 1413 61 1414 715
		f 4 -121 -1274 -2612 2610
		mu 0 4 1414 60 1410 715
		f 4 -1273 56 -2609 2611
		mu 0 4 1410 28 1412 715
		f 4 59 1276 -2614 2612
		mu 0 4 1415 30 1416 716
		f 4 1277 -124 -2615 2613
		mu 0 4 1416 62 1417 716
		f 4 -123 -1276 -2616 2614
		mu 0 4 1417 61 1413 716
		f 4 -1275 58 -2613 2615
		mu 0 4 1413 29 1415 716
		f 4 61 1278 -2618 2616
		mu 0 4 1418 31 1419 717
		f 4 1279 -126 -2619 2617
		mu 0 4 1419 63 1420 717
		f 4 -125 -1278 -2620 2618
		mu 0 4 1420 62 1416 717
		f 4 -1277 60 -2617 2619
		mu 0 4 1416 30 1418 717
		f 4 63 1216 -2622 2620
		mu 0 4 1421 0 1330 718
		f 4 1217 -128 -2623 2621
		mu 0 4 1330 32 1422 718
		f 4 -127 -1280 -2624 2622
		mu 0 4 1422 63 1419 718
		f 4 -1279 62 -2621 2623
		mu 0 4 1419 31 1421 718
		f 4 65 1282 -2626 2624
		mu 0 4 1329 33 1423 719
		f 4 1283 -130 -2627 2625
		mu 0 4 1423 65 1424 719
		f 4 -129 -1282 -2628 2626
		mu 0 4 1424 64 1425 719
		f 4 -1281 64 -2625 2627
		mu 0 4 1425 32 1329 719
		f 4 67 1284 -2630 2628
		mu 0 4 1333 34 1426 720
		f 4 1285 -132 -2631 2629
		mu 0 4 1426 66 1427 720
		f 4 -131 -1284 -2632 2630
		mu 0 4 1427 65 1423 720
		f 4 -1283 66 -2629 2631
		mu 0 4 1423 33 1333 720
		f 4 69 1286 -2634 2632
		mu 0 4 1336 35 1428 721
		f 4 1287 -134 -2635 2633
		mu 0 4 1428 67 1429 721
		f 4 -133 -1286 -2636 2634
		mu 0 4 1429 66 1426 721
		f 4 -1285 68 -2633 2635
		mu 0 4 1426 34 1336 721
		f 4 71 1288 -2638 2636
		mu 0 4 1339 36 1430 722
		f 4 1289 -136 -2639 2637
		mu 0 4 1430 68 1431 722
		f 4 -135 -1288 -2640 2638
		mu 0 4 1431 67 1428 722
		f 4 -1287 70 -2637 2639
		mu 0 4 1428 35 1339 722
		f 4 73 1290 -2642 2640
		mu 0 4 1342 37 1432 723
		f 4 1291 -138 -2643 2641
		mu 0 4 1432 69 1433 723
		f 4 -137 -1290 -2644 2642
		mu 0 4 1433 68 1430 723
		f 4 -1289 72 -2641 2643
		mu 0 4 1430 36 1342 723
		f 4 75 1292 -2646 2644
		mu 0 4 1345 38 1434 724
		f 4 1293 -140 -2647 2645
		mu 0 4 1434 70 1435 724
		f 4 -139 -1292 -2648 2646
		mu 0 4 1435 69 1432 724
		f 4 -1291 74 -2645 2647
		mu 0 4 1432 37 1345 724
		f 4 77 1294 -2650 2648
		mu 0 4 1348 39 1436 725
		f 4 1295 -142 -2651 2649
		mu 0 4 1436 71 1437 725
		f 4 -141 -1294 -2652 2650
		mu 0 4 1437 70 1434 725
		f 4 -1293 76 -2649 2651
		mu 0 4 1434 38 1348 725
		f 4 79 1296 -2654 2652
		mu 0 4 1351 40 1438 726
		f 4 1297 -144 -2655 2653
		mu 0 4 1438 72 1439 726
		f 4 -143 -1296 -2656 2654
		mu 0 4 1439 71 1436 726
		f 4 -1295 78 -2653 2655
		mu 0 4 1436 39 1351 726
		f 4 81 1298 -2658 2656
		mu 0 4 1354 41 1440 727
		f 4 1299 -146 -2659 2657
		mu 0 4 1440 73 1441 727
		f 4 -145 -1298 -2660 2658
		mu 0 4 1441 72 1438 727
		f 4 -1297 80 -2657 2659
		mu 0 4 1438 40 1354 727
		f 4 83 1300 -2662 2660
		mu 0 4 1357 42 1442 728
		f 4 1301 -148 -2663 2661
		mu 0 4 1442 74 1443 728
		f 4 -147 -1300 -2664 2662
		mu 0 4 1443 73 1440 728
		f 4 -1299 82 -2661 2663
		mu 0 4 1440 41 1357 728
		f 4 85 1302 -2666 2664
		mu 0 4 1360 43 1444 729
		f 4 1303 -150 -2667 2665
		mu 0 4 1444 75 1445 729
		f 4 -149 -1302 -2668 2666
		mu 0 4 1445 74 1442 729
		f 4 -1301 84 -2665 2667
		mu 0 4 1442 42 1360 729
		f 4 87 1304 -2670 2668
		mu 0 4 1363 44 1446 730
		f 4 1305 -152 -2671 2669
		mu 0 4 1446 76 1447 730
		f 4 -151 -1304 -2672 2670
		mu 0 4 1447 75 1444 730
		f 4 -1303 86 -2669 2671
		mu 0 4 1444 43 1363 730
		f 4 89 1306 -2674 2672
		mu 0 4 1366 45 1448 731
		f 4 1307 -154 -2675 2673
		mu 0 4 1448 77 1449 731
		f 4 -153 -1306 -2676 2674
		mu 0 4 1449 76 1446 731
		f 4 -1305 88 -2673 2675
		mu 0 4 1446 44 1366 731
		f 4 91 1308 -2678 2676
		mu 0 4 1369 46 1450 732
		f 4 1309 -156 -2679 2677
		mu 0 4 1450 78 1451 732
		f 4 -155 -1308 -2680 2678
		mu 0 4 1451 77 1448 732
		f 4 -1307 90 -2677 2679
		mu 0 4 1448 45 1369 732
		f 4 93 1310 -2682 2680
		mu 0 4 1372 47 1452 733
		f 4 1311 -158 -2683 2681
		mu 0 4 1452 79 1453 733
		f 4 -157 -1310 -2684 2682
		mu 0 4 1453 78 1450 733
		f 4 -1309 92 -2681 2683
		mu 0 4 1450 46 1372 733
		f 4 95 1312 -2686 2684
		mu 0 4 1375 48 1454 734
		f 4 1313 -160 -2687 2685
		mu 0 4 1454 80 1455 734
		f 4 -159 -1312 -2688 2686
		mu 0 4 1455 79 1452 734
		f 4 -1311 94 -2685 2687
		mu 0 4 1452 47 1375 734
		f 4 97 1314 -2690 2688
		mu 0 4 1378 49 1456 735
		f 4 1315 -162 -2691 2689
		mu 0 4 1456 81 1457 735
		f 4 -161 -1314 -2692 2690
		mu 0 4 1457 80 1454 735
		f 4 -1313 96 -2689 2691
		mu 0 4 1454 48 1378 735
		f 4 99 1316 -2694 2692
		mu 0 4 1381 50 1458 736
		f 4 1317 -164 -2695 2693
		mu 0 4 1458 82 1459 736
		f 4 -163 -1316 -2696 2694
		mu 0 4 1459 81 1456 736
		f 4 -1315 98 -2693 2695
		mu 0 4 1456 49 1381 736
		f 4 101 1318 -2698 2696
		mu 0 4 1384 51 1460 737
		f 4 1319 -166 -2699 2697
		mu 0 4 1460 83 1461 737
		f 4 -165 -1318 -2700 2698
		mu 0 4 1461 82 1458 737
		f 4 -1317 100 -2697 2699
		mu 0 4 1458 50 1384 737
		f 4 103 1320 -2702 2700
		mu 0 4 1387 52 1462 738
		f 4 1321 -168 -2703 2701
		mu 0 4 1462 84 1463 738
		f 4 -167 -1320 -2704 2702
		mu 0 4 1463 83 1460 738
		f 4 -1319 102 -2701 2703
		mu 0 4 1460 51 1387 738
		f 4 105 1322 -2706 2704
		mu 0 4 1390 53 1464 739
		f 4 1323 -170 -2707 2705
		mu 0 4 1464 85 1465 739
		f 4 -169 -1322 -2708 2706
		mu 0 4 1465 84 1462 739
		f 4 -1321 104 -2705 2707
		mu 0 4 1462 52 1390 739
		f 4 107 1324 -2710 2708
		mu 0 4 1393 54 1466 740
		f 4 1325 -172 -2711 2709
		mu 0 4 1466 86 1467 740
		f 4 -171 -1324 -2712 2710
		mu 0 4 1467 85 1464 740
		f 4 -1323 106 -2709 2711
		mu 0 4 1464 53 1393 740
		f 4 109 1326 -2714 2712
		mu 0 4 1396 55 1468 741
		f 4 1327 -174 -2715 2713
		mu 0 4 1468 87 1469 741
		f 4 -173 -1326 -2716 2714
		mu 0 4 1469 86 1466 741
		f 4 -1325 108 -2713 2715
		mu 0 4 1466 54 1396 741
		f 4 111 1328 -2718 2716
		mu 0 4 1399 56 1470 742
		f 4 1329 -176 -2719 2717
		mu 0 4 1470 88 1471 742
		f 4 -175 -1328 -2720 2718
		mu 0 4 1471 87 1468 742
		f 4 -1327 110 -2717 2719
		mu 0 4 1468 55 1399 742
		f 4 113 1330 -2722 2720
		mu 0 4 1402 57 1472 743
		f 4 1331 -178 -2723 2721
		mu 0 4 1472 89 1473 743
		f 4 -177 -1330 -2724 2722
		mu 0 4 1473 88 1470 743
		f 4 -1329 112 -2721 2723
		mu 0 4 1470 56 1402 743
		f 4 115 1332 -2726 2724
		mu 0 4 1405 58 1474 744
		f 4 1333 -180 -2727 2725
		mu 0 4 1474 90 1475 744
		f 4 -179 -1332 -2728 2726
		mu 0 4 1475 89 1472 744
		f 4 -1331 114 -2725 2727
		mu 0 4 1472 57 1405 744
		f 4 117 1334 -2730 2728
		mu 0 4 1408 59 1476 745
		f 4 1335 -182 -2731 2729
		mu 0 4 1476 91 1477 745
		f 4 -181 -1334 -2732 2730
		mu 0 4 1477 90 1474 745
		f 4 -1333 116 -2729 2731
		mu 0 4 1474 58 1408 745
		f 4 119 1336 -2734 2732
		mu 0 4 1411 60 1478 746
		f 4 1337 -184 -2735 2733
		mu 0 4 1478 92 1479 746
		f 4 -183 -1336 -2736 2734
		mu 0 4 1479 91 1476 746
		f 4 -1335 118 -2733 2735
		mu 0 4 1476 59 1411 746
		f 4 121 1338 -2738 2736
		mu 0 4 1414 61 1480 747
		f 4 1339 -186 -2739 2737
		mu 0 4 1480 93 1481 747
		f 4 -185 -1338 -2740 2738
		mu 0 4 1481 92 1478 747
		f 4 -1337 120 -2737 2739
		mu 0 4 1478 60 1414 747
		f 4 123 1340 -2742 2740
		mu 0 4 1417 62 1482 748
		f 4 1341 -188 -2743 2741
		mu 0 4 1482 94 1483 748
		f 4 -187 -1340 -2744 2742
		mu 0 4 1483 93 1480 748
		f 4 -1339 122 -2741 2743
		mu 0 4 1480 61 1417 748
		f 4 125 1342 -2746 2744
		mu 0 4 1420 63 1484 749
		f 4 1343 -190 -2747 2745
		mu 0 4 1484 95 1485 749
		f 4 -189 -1342 -2748 2746
		mu 0 4 1485 94 1482 749
		f 4 -1341 124 -2745 2747
		mu 0 4 1482 62 1420 749
		f 4 127 1280 -2750 2748
		mu 0 4 1422 32 1425 750
		f 4 1281 -192 -2751 2749
		mu 0 4 1425 64 1486 750
		f 4 -191 -1344 -2752 2750
		mu 0 4 1486 95 1484 750
		f 4 -1343 126 -2749 2751
		mu 0 4 1484 63 1422 750
		f 4 129 1346 -2754 2752
		mu 0 4 1424 65 1487 751
		f 4 1347 -194 -2755 2753
		mu 0 4 1487 97 1488 751
		f 4 -193 -1346 -2756 2754
		mu 0 4 1488 96 1489 751
		f 4 -1345 128 -2753 2755
		mu 0 4 1489 64 1424 751
		f 4 131 1348 -2758 2756
		mu 0 4 1427 66 1490 752
		f 4 1349 -196 -2759 2757
		mu 0 4 1490 98 1491 752
		f 4 -195 -1348 -2760 2758
		mu 0 4 1491 97 1487 752
		f 4 -1347 130 -2757 2759
		mu 0 4 1487 65 1427 752
		f 4 133 1350 -2762 2760
		mu 0 4 1429 67 1492 753
		f 4 1351 -198 -2763 2761
		mu 0 4 1492 99 1493 753
		f 4 -197 -1350 -2764 2762
		mu 0 4 1493 98 1490 753
		f 4 -1349 132 -2761 2763
		mu 0 4 1490 66 1429 753
		f 4 135 1352 -2766 2764
		mu 0 4 1431 68 1494 754
		f 4 1353 -200 -2767 2765
		mu 0 4 1494 100 1495 754
		f 4 -199 -1352 -2768 2766
		mu 0 4 1495 99 1492 754
		f 4 -1351 134 -2765 2767
		mu 0 4 1492 67 1431 754
		f 4 137 1354 -2770 2768
		mu 0 4 1433 69 1496 755
		f 4 1355 -202 -2771 2769
		mu 0 4 1496 101 1497 755
		f 4 -201 -1354 -2772 2770
		mu 0 4 1497 100 1494 755
		f 4 -1353 136 -2769 2771
		mu 0 4 1494 68 1433 755
		f 4 139 1356 -2774 2772
		mu 0 4 1435 70 1498 756
		f 4 1357 -204 -2775 2773
		mu 0 4 1498 102 1499 756
		f 4 -203 -1356 -2776 2774
		mu 0 4 1499 101 1496 756
		f 4 -1355 138 -2773 2775
		mu 0 4 1496 69 1435 756
		f 4 141 1358 -2778 2776
		mu 0 4 1437 71 1500 757
		f 4 1359 -206 -2779 2777
		mu 0 4 1500 103 1501 757
		f 4 -205 -1358 -2780 2778
		mu 0 4 1501 102 1498 757
		f 4 -1357 140 -2777 2779
		mu 0 4 1498 70 1437 757
		f 4 143 1360 -2782 2780
		mu 0 4 1439 72 1502 758
		f 4 1361 -208 -2783 2781
		mu 0 4 1502 104 1503 758
		f 4 -207 -1360 -2784 2782
		mu 0 4 1503 103 1500 758
		f 4 -1359 142 -2781 2783
		mu 0 4 1500 71 1439 758
		f 4 145 1362 -2786 2784
		mu 0 4 1441 73 1504 759
		f 4 1363 -210 -2787 2785
		mu 0 4 1504 105 1505 759
		f 4 -209 -1362 -2788 2786
		mu 0 4 1505 104 1502 759
		f 4 -1361 144 -2785 2787
		mu 0 4 1502 72 1441 759
		f 4 147 1364 -2790 2788
		mu 0 4 1443 74 1506 760
		f 4 1365 -212 -2791 2789
		mu 0 4 1506 106 1507 760
		f 4 -211 -1364 -2792 2790
		mu 0 4 1507 105 1504 760
		f 4 -1363 146 -2789 2791
		mu 0 4 1504 73 1443 760
		f 4 149 1366 -2794 2792
		mu 0 4 1445 75 1508 761
		f 4 1367 -214 -2795 2793
		mu 0 4 1508 107 1509 761
		f 4 -213 -1366 -2796 2794
		mu 0 4 1509 106 1506 761
		f 4 -1365 148 -2793 2795
		mu 0 4 1506 74 1445 761
		f 4 151 1368 -2798 2796
		mu 0 4 1447 76 1510 762
		f 4 1369 -216 -2799 2797
		mu 0 4 1510 108 1511 762
		f 4 -215 -1368 -2800 2798
		mu 0 4 1511 107 1508 762
		f 4 -1367 150 -2797 2799
		mu 0 4 1508 75 1447 762
		f 4 153 1370 -2802 2800
		mu 0 4 1449 77 1512 763
		f 4 1371 -218 -2803 2801
		mu 0 4 1512 109 1513 763
		f 4 -217 -1370 -2804 2802
		mu 0 4 1513 108 1510 763
		f 4 -1369 152 -2801 2803
		mu 0 4 1510 76 1449 763
		f 4 155 1372 -2806 2804
		mu 0 4 1451 78 1514 764
		f 4 1373 -220 -2807 2805
		mu 0 4 1514 110 1515 764
		f 4 -219 -1372 -2808 2806
		mu 0 4 1515 109 1512 764
		f 4 -1371 154 -2805 2807
		mu 0 4 1512 77 1451 764
		f 4 157 1374 -2810 2808
		mu 0 4 1453 79 1516 765
		f 4 1375 -222 -2811 2809
		mu 0 4 1516 111 1517 765
		f 4 -221 -1374 -2812 2810
		mu 0 4 1517 110 1514 765
		f 4 -1373 156 -2809 2811
		mu 0 4 1514 78 1453 765
		f 4 159 1376 -2814 2812
		mu 0 4 1455 80 1518 766
		f 4 1377 -224 -2815 2813
		mu 0 4 1518 112 1519 766
		f 4 -223 -1376 -2816 2814
		mu 0 4 1519 111 1516 766
		f 4 -1375 158 -2813 2815
		mu 0 4 1516 79 1455 766
		f 4 161 1378 -2818 2816
		mu 0 4 1457 81 1520 767
		f 4 1379 -226 -2819 2817
		mu 0 4 1520 113 1521 767
		f 4 -225 -1378 -2820 2818
		mu 0 4 1521 112 1518 767
		f 4 -1377 160 -2817 2819
		mu 0 4 1518 80 1457 767
		f 4 163 1380 -2822 2820
		mu 0 4 1459 82 1522 768
		f 4 1381 -228 -2823 2821
		mu 0 4 1522 114 1523 768
		f 4 -227 -1380 -2824 2822
		mu 0 4 1523 113 1520 768
		f 4 -1379 162 -2821 2823
		mu 0 4 1520 81 1459 768
		f 4 165 1382 -2826 2824
		mu 0 4 1461 83 1524 769
		f 4 1383 -230 -2827 2825
		mu 0 4 1524 115 1525 769
		f 4 -229 -1382 -2828 2826
		mu 0 4 1525 114 1522 769
		f 4 -1381 164 -2825 2827
		mu 0 4 1522 82 1461 769
		f 4 167 1384 -2830 2828
		mu 0 4 1463 84 1526 770
		f 4 1385 -232 -2831 2829
		mu 0 4 1526 116 1527 770
		f 4 -231 -1384 -2832 2830
		mu 0 4 1527 115 1524 770
		f 4 -1383 166 -2829 2831
		mu 0 4 1524 83 1463 770
		f 4 169 1386 -2834 2832
		mu 0 4 1465 85 1528 771
		f 4 1387 -234 -2835 2833
		mu 0 4 1528 117 1529 771
		f 4 -233 -1386 -2836 2834
		mu 0 4 1529 116 1526 771
		f 4 -1385 168 -2833 2835
		mu 0 4 1526 84 1465 771
		f 4 171 1388 -2838 2836
		mu 0 4 1467 86 1530 772
		f 4 1389 -236 -2839 2837
		mu 0 4 1530 118 1531 772
		f 4 -235 -1388 -2840 2838
		mu 0 4 1531 117 1528 772
		f 4 -1387 170 -2837 2839
		mu 0 4 1528 85 1467 772
		f 4 173 1390 -2842 2840
		mu 0 4 1469 87 1532 773
		f 4 1391 -238 -2843 2841
		mu 0 4 1532 119 1533 773
		f 4 -237 -1390 -2844 2842
		mu 0 4 1533 118 1530 773
		f 4 -1389 172 -2841 2843
		mu 0 4 1530 86 1469 773
		f 4 175 1392 -2846 2844
		mu 0 4 1471 88 1534 774
		f 4 1393 -240 -2847 2845
		mu 0 4 1534 120 1535 774
		f 4 -239 -1392 -2848 2846
		mu 0 4 1535 119 1532 774
		f 4 -1391 174 -2845 2847
		mu 0 4 1532 87 1471 774
		f 4 177 1394 -2850 2848
		mu 0 4 1473 89 1536 775
		f 4 1395 -242 -2851 2849
		mu 0 4 1536 121 1537 775
		f 4 -241 -1394 -2852 2850
		mu 0 4 1537 120 1534 775
		f 4 -1393 176 -2849 2851
		mu 0 4 1534 88 1473 775
		f 4 179 1396 -2854 2852
		mu 0 4 1475 90 1538 776
		f 4 1397 -244 -2855 2853
		mu 0 4 1538 122 1539 776
		f 4 -243 -1396 -2856 2854
		mu 0 4 1539 121 1536 776
		f 4 -1395 178 -2853 2855
		mu 0 4 1536 89 1475 776
		f 4 181 1398 -2858 2856
		mu 0 4 1477 91 1540 777
		f 4 1399 -246 -2859 2857
		mu 0 4 1540 123 1541 777
		f 4 -245 -1398 -2860 2858
		mu 0 4 1541 122 1538 777
		f 4 -1397 180 -2857 2859
		mu 0 4 1538 90 1477 777
		f 4 183 1400 -2862 2860
		mu 0 4 1479 92 1542 778
		f 4 1401 -248 -2863 2861
		mu 0 4 1542 124 1543 778
		f 4 -247 -1400 -2864 2862
		mu 0 4 1543 123 1540 778
		f 4 -1399 182 -2861 2863
		mu 0 4 1540 91 1479 778
		f 4 185 1402 -2866 2864
		mu 0 4 1481 93 1544 779
		f 4 1403 -250 -2867 2865
		mu 0 4 1544 125 1545 779
		f 4 -249 -1402 -2868 2866
		mu 0 4 1545 124 1542 779
		f 4 -1401 184 -2865 2867
		mu 0 4 1542 92 1481 779
		f 4 187 1404 -2870 2868
		mu 0 4 1483 94 1546 780
		f 4 1405 -252 -2871 2869
		mu 0 4 1546 126 1547 780
		f 4 -251 -1404 -2872 2870
		mu 0 4 1547 125 1544 780
		f 4 -1403 186 -2869 2871
		mu 0 4 1544 93 1483 780
		f 4 189 1406 -2874 2872
		mu 0 4 1485 95 1548 781
		f 4 1407 -254 -2875 2873
		mu 0 4 1548 127 1549 781
		f 4 -253 -1406 -2876 2874
		mu 0 4 1549 126 1546 781
		f 4 -1405 188 -2873 2875
		mu 0 4 1546 94 1485 781
		f 4 191 1344 -2878 2876
		mu 0 4 1486 64 1489 782
		f 4 1345 -256 -2879 2877
		mu 0 4 1489 96 1550 782
		f 4 -255 -1408 -2880 2878
		mu 0 4 1550 127 1548 782
		f 4 -1407 190 -2877 2879
		mu 0 4 1548 95 1486 782
		f 4 193 1410 -2882 2880
		mu 0 4 1551 129 1552 783
		f 4 1411 -258 -2883 2881
		mu 0 4 1552 162 1553 783
		f 4 -257 -1410 -2884 2882
		mu 0 4 1553 161 1554 783
		f 4 -1409 192 -2881 2883
		mu 0 4 1554 128 1551 783
		f 4 195 1412 -2886 2884
		mu 0 4 1555 130 1556 784
		f 4 1413 -260 -2887 2885
		mu 0 4 1556 163 1557 784
		f 4 -259 -1412 -2888 2886
		mu 0 4 1557 162 1552 784
		f 4 -1411 194 -2885 2887
		mu 0 4 1552 129 1555 784
		f 4 197 1414 -2890 2888
		mu 0 4 1558 131 1559 785
		f 4 1415 -262 -2891 2889
		mu 0 4 1559 164 1560 785
		f 4 -261 -1414 -2892 2890
		mu 0 4 1560 163 1556 785
		f 4 -1413 196 -2889 2891
		mu 0 4 1556 130 1558 785
		f 4 199 1416 -2894 2892
		mu 0 4 1561 132 1562 786
		f 4 1417 -264 -2895 2893
		mu 0 4 1562 165 1563 786
		f 4 -263 -1416 -2896 2894
		mu 0 4 1563 164 1559 786
		f 4 -1415 198 -2893 2895
		mu 0 4 1559 131 1561 786
		f 4 201 1418 -2898 2896
		mu 0 4 1564 133 1565 787
		f 4 1419 -266 -2899 2897
		mu 0 4 1565 166 1566 787
		f 4 -265 -1418 -2900 2898
		mu 0 4 1566 165 1562 787
		f 4 -1417 200 -2897 2899
		mu 0 4 1562 132 1564 787
		f 4 203 1420 -2902 2900
		mu 0 4 1567 134 1568 788
		f 4 1421 -268 -2903 2901
		mu 0 4 1568 167 1569 788
		f 4 -267 -1420 -2904 2902
		mu 0 4 1569 166 1565 788
		f 4 -1419 202 -2901 2903
		mu 0 4 1565 133 1567 788
		f 4 205 1422 -2906 2904
		mu 0 4 1570 135 1571 789
		f 4 1423 -270 -2907 2905
		mu 0 4 1571 168 1572 789
		f 4 -269 -1422 -2908 2906
		mu 0 4 1572 167 1568 789
		f 4 -1421 204 -2905 2907
		mu 0 4 1568 134 1570 789
		f 4 207 1424 -2910 2908
		mu 0 4 1573 136 1574 790
		f 4 1425 -272 -2911 2909
		mu 0 4 1574 169 1575 790
		f 4 -271 -1424 -2912 2910
		mu 0 4 1575 168 1571 790
		f 4 -1423 206 -2909 2911
		mu 0 4 1571 135 1573 790
		f 4 209 1426 -2914 2912
		mu 0 4 1576 137 1577 791
		f 4 1427 -274 -2915 2913
		mu 0 4 1577 170 1578 791
		f 4 -273 -1426 -2916 2914
		mu 0 4 1578 169 1574 791
		f 4 -1425 208 -2913 2915
		mu 0 4 1574 136 1576 791
		f 4 211 1428 -2918 2916
		mu 0 4 1579 138 1580 792
		f 4 1429 -276 -2919 2917
		mu 0 4 1580 171 1581 792
		f 4 -275 -1428 -2920 2918
		mu 0 4 1581 170 1577 792
		f 4 -1427 210 -2917 2919
		mu 0 4 1577 137 1579 792
		f 4 213 1430 -2922 2920
		mu 0 4 1582 139 1583 793
		f 4 1431 -278 -2923 2921
		mu 0 4 1583 172 1584 793
		f 4 -277 -1430 -2924 2922
		mu 0 4 1584 171 1580 793
		f 4 -1429 212 -2921 2923
		mu 0 4 1580 138 1582 793
		f 4 215 1432 -2926 2924
		mu 0 4 1585 140 1586 794
		f 4 1433 -280 -2927 2925
		mu 0 4 1586 173 1587 794
		f 4 -279 -1432 -2928 2926
		mu 0 4 1587 172 1583 794
		f 4 -1431 214 -2925 2927
		mu 0 4 1583 139 1585 794
		f 4 217 1434 -2930 2928
		mu 0 4 1588 141 1589 795
		f 4 1435 -282 -2931 2929
		mu 0 4 1589 174 1590 795
		f 4 -281 -1434 -2932 2930
		mu 0 4 1590 173 1586 795
		f 4 -1433 216 -2929 2931
		mu 0 4 1586 140 1588 795
		f 4 219 1436 -2934 2932
		mu 0 4 1591 142 1592 796
		f 4 1437 -284 -2935 2933
		mu 0 4 1592 175 1593 796
		f 4 -283 -1436 -2936 2934
		mu 0 4 1593 174 1589 796
		f 4 -1435 218 -2933 2935
		mu 0 4 1589 141 1591 796
		f 4 221 1438 -2938 2936
		mu 0 4 1594 143 1595 797
		f 4 1439 -286 -2939 2937
		mu 0 4 1595 176 1596 797
		f 4 -285 -1438 -2940 2938
		mu 0 4 1596 175 1592 797
		f 4 -1437 220 -2937 2939
		mu 0 4 1592 142 1594 797
		f 4 223 1440 -2942 2940
		mu 0 4 1597 144 1598 798
		f 4 1441 -288 -2943 2941
		mu 0 4 1598 177 1599 798
		f 4 -287 -1440 -2944 2942
		mu 0 4 1599 176 1595 798
		f 4 -1439 222 -2941 2943
		mu 0 4 1595 143 1597 798
		f 4 225 1442 -2946 2944
		mu 0 4 1600 145 1601 799
		f 4 1443 -290 -2947 2945
		mu 0 4 1601 178 1602 799
		f 4 -289 -1442 -2948 2946
		mu 0 4 1602 177 1598 799
		f 4 -1441 224 -2945 2947
		mu 0 4 1598 144 1600 799
		f 4 227 1444 -2950 2948
		mu 0 4 1603 146 1604 800
		f 4 1445 -292 -2951 2949
		mu 0 4 1604 179 1605 800
		f 4 -291 -1444 -2952 2950
		mu 0 4 1605 178 1601 800
		f 4 -1443 226 -2949 2951
		mu 0 4 1601 145 1603 800
		f 4 229 1446 -2954 2952
		mu 0 4 1606 147 1607 801
		f 4 1447 -294 -2955 2953
		mu 0 4 1607 180 1608 801
		f 4 -293 -1446 -2956 2954
		mu 0 4 1608 179 1604 801
		f 4 -1445 228 -2953 2955
		mu 0 4 1604 146 1606 801
		f 4 231 1448 -2958 2956
		mu 0 4 1609 148 1610 802
		f 4 1449 -296 -2959 2957
		mu 0 4 1610 181 1611 802
		f 4 -295 -1448 -2960 2958
		mu 0 4 1611 180 1607 802
		f 4 -1447 230 -2957 2959
		mu 0 4 1607 147 1609 802
		f 4 233 1450 -2962 2960
		mu 0 4 1612 149 1613 803
		f 4 1451 -298 -2963 2961
		mu 0 4 1613 182 1614 803
		f 4 -297 -1450 -2964 2962
		mu 0 4 1614 181 1610 803
		f 4 -1449 232 -2961 2963
		mu 0 4 1610 148 1612 803
		f 4 235 1452 -2966 2964
		mu 0 4 1615 150 1616 804
		f 4 1453 -300 -2967 2965
		mu 0 4 1616 183 1617 804
		f 4 -299 -1452 -2968 2966
		mu 0 4 1617 182 1613 804
		f 4 -1451 234 -2965 2967
		mu 0 4 1613 149 1615 804
		f 4 237 1454 -2970 2968
		mu 0 4 1618 151 1619 805
		f 4 1455 -302 -2971 2969
		mu 0 4 1619 184 1620 805
		f 4 -301 -1454 -2972 2970
		mu 0 4 1620 183 1616 805
		f 4 -1453 236 -2969 2971
		mu 0 4 1616 150 1618 805
		f 4 239 1456 -2974 2972
		mu 0 4 1621 152 1622 806
		f 4 1457 -304 -2975 2973
		mu 0 4 1622 185 1623 806
		f 4 -303 -1456 -2976 2974
		mu 0 4 1623 184 1619 806
		f 4 -1455 238 -2973 2975
		mu 0 4 1619 151 1621 806
		f 4 241 1458 -2978 2976
		mu 0 4 1624 153 1625 807
		f 4 1459 -306 -2979 2977
		mu 0 4 1625 186 1626 807
		f 4 -305 -1458 -2980 2978
		mu 0 4 1626 185 1622 807
		f 4 -1457 240 -2977 2979
		mu 0 4 1622 152 1624 807
		f 4 243 1460 -2982 2980
		mu 0 4 1627 154 1628 808
		f 4 1461 -308 -2983 2981
		mu 0 4 1628 187 1629 808
		f 4 -307 -1460 -2984 2982
		mu 0 4 1629 186 1625 808
		f 4 -1459 242 -2981 2983
		mu 0 4 1625 153 1627 808
		f 4 245 1462 -2986 2984
		mu 0 4 1630 155 1631 809
		f 4 1463 -310 -2987 2985
		mu 0 4 1631 188 1632 809
		f 4 -309 -1462 -2988 2986
		mu 0 4 1632 187 1628 809
		f 4 -1461 244 -2985 2987
		mu 0 4 1628 154 1630 809
		f 4 247 1464 -2990 2988
		mu 0 4 1633 156 1634 810
		f 4 1465 -312 -2991 2989
		mu 0 4 1634 189 1635 810
		f 4 -311 -1464 -2992 2990
		mu 0 4 1635 188 1631 810
		f 4 -1463 246 -2989 2991
		mu 0 4 1631 155 1633 810
		f 4 249 1466 -2994 2992
		mu 0 4 1636 157 1637 811
		f 4 1467 -314 -2995 2993
		mu 0 4 1637 190 1638 811
		f 4 -313 -1466 -2996 2994
		mu 0 4 1638 189 1634 811
		f 4 -1465 248 -2993 2995
		mu 0 4 1634 156 1636 811;
	setAttr ".fc[500:999]"
		f 4 251 1468 -2998 2996
		mu 0 4 1639 158 1640 812
		f 4 1469 -316 -2999 2997
		mu 0 4 1640 191 1641 812
		f 4 -315 -1468 -3000 2998
		mu 0 4 1641 190 1637 812
		f 4 -1467 250 -2997 2999
		mu 0 4 1637 157 1639 812
		f 4 253 1470 -3002 3000
		mu 0 4 1642 159 1643 813
		f 4 1471 -318 -3003 3001
		mu 0 4 1643 192 1644 813
		f 4 -317 -1470 -3004 3002
		mu 0 4 1644 191 1640 813
		f 4 -1469 252 -3001 3003
		mu 0 4 1640 158 1642 813
		f 4 255 1408 -3006 3004
		mu 0 4 1645 160 1646 814
		f 4 1409 -320 -3007 3005
		mu 0 4 1646 193 1647 814
		f 4 -319 -1472 -3008 3006
		mu 0 4 1647 192 1643 814
		f 4 -1471 254 -3005 3007
		mu 0 4 1643 159 1645 814
		f 4 257 1474 -3010 3008
		mu 0 4 1553 162 1648 815
		f 4 1475 -322 -3011 3009
		mu 0 4 1648 195 1649 815
		f 4 -321 -1474 -3012 3010
		mu 0 4 1649 194 1650 815
		f 4 -1473 256 -3009 3011
		mu 0 4 1650 161 1553 815
		f 4 259 1476 -3014 3012
		mu 0 4 1557 163 1651 816
		f 4 1477 -324 -3015 3013
		mu 0 4 1651 196 1652 816
		f 4 -323 -1476 -3016 3014
		mu 0 4 1652 195 1648 816
		f 4 -1475 258 -3013 3015
		mu 0 4 1648 162 1557 816
		f 4 261 1478 -3018 3016
		mu 0 4 1560 164 1653 817
		f 4 1479 -326 -3019 3017
		mu 0 4 1653 197 1654 817
		f 4 -325 -1478 -3020 3018
		mu 0 4 1654 196 1651 817
		f 4 -1477 260 -3017 3019
		mu 0 4 1651 163 1560 817
		f 4 263 1480 -3022 3020
		mu 0 4 1563 165 1655 818
		f 4 1481 -328 -3023 3021
		mu 0 4 1655 198 1656 818
		f 4 -327 -1480 -3024 3022
		mu 0 4 1656 197 1653 818
		f 4 -1479 262 -3021 3023
		mu 0 4 1653 164 1563 818
		f 4 265 1482 -3026 3024
		mu 0 4 1566 166 1657 819
		f 4 1483 -330 -3027 3025
		mu 0 4 1657 199 1658 819
		f 4 -329 -1482 -3028 3026
		mu 0 4 1658 198 1655 819
		f 4 -1481 264 -3025 3027
		mu 0 4 1655 165 1566 819
		f 4 267 1484 -3030 3028
		mu 0 4 1569 167 1659 820
		f 4 1485 -332 -3031 3029
		mu 0 4 1659 200 1660 820
		f 4 -331 -1484 -3032 3030
		mu 0 4 1660 199 1657 820
		f 4 -1483 266 -3029 3031
		mu 0 4 1657 166 1569 820
		f 4 269 1486 -3034 3032
		mu 0 4 1572 168 1661 821
		f 4 1487 -334 -3035 3033
		mu 0 4 1661 201 1662 821
		f 4 -333 -1486 -3036 3034
		mu 0 4 1662 200 1659 821
		f 4 -1485 268 -3033 3035
		mu 0 4 1659 167 1572 821
		f 4 271 1488 -3038 3036
		mu 0 4 1575 169 1663 822
		f 4 1489 -336 -3039 3037
		mu 0 4 1663 202 1664 822
		f 4 -335 -1488 -3040 3038
		mu 0 4 1664 201 1661 822
		f 4 -1487 270 -3037 3039
		mu 0 4 1661 168 1575 822
		f 4 273 1490 -3042 3040
		mu 0 4 1578 170 1665 823
		f 4 1491 -338 -3043 3041
		mu 0 4 1665 203 1666 823
		f 4 -337 -1490 -3044 3042
		mu 0 4 1666 202 1663 823
		f 4 -1489 272 -3041 3043
		mu 0 4 1663 169 1578 823
		f 4 275 1492 -3046 3044
		mu 0 4 1581 171 1667 824
		f 4 1493 -340 -3047 3045
		mu 0 4 1667 204 1668 824
		f 4 -339 -1492 -3048 3046
		mu 0 4 1668 203 1665 824
		f 4 -1491 274 -3045 3047
		mu 0 4 1665 170 1581 824
		f 4 277 1494 -3050 3048
		mu 0 4 1584 172 1669 825
		f 4 1495 -342 -3051 3049
		mu 0 4 1669 205 1670 825
		f 4 -341 -1494 -3052 3050
		mu 0 4 1670 204 1667 825
		f 4 -1493 276 -3049 3051
		mu 0 4 1667 171 1584 825
		f 4 279 1496 -3054 3052
		mu 0 4 1587 173 1671 826
		f 4 1497 -344 -3055 3053
		mu 0 4 1671 206 1672 826
		f 4 -343 -1496 -3056 3054
		mu 0 4 1672 205 1669 826
		f 4 -1495 278 -3053 3055
		mu 0 4 1669 172 1587 826
		f 4 281 1498 -3058 3056
		mu 0 4 1590 174 1673 827
		f 4 1499 -346 -3059 3057
		mu 0 4 1673 207 1674 827
		f 4 -345 -1498 -3060 3058
		mu 0 4 1674 206 1671 827
		f 4 -1497 280 -3057 3059
		mu 0 4 1671 173 1590 827
		f 4 283 1500 -3062 3060
		mu 0 4 1593 175 1675 828
		f 4 1501 -348 -3063 3061
		mu 0 4 1675 208 1676 828
		f 4 -347 -1500 -3064 3062
		mu 0 4 1676 207 1673 828
		f 4 -1499 282 -3061 3063
		mu 0 4 1673 174 1593 828
		f 4 285 1502 -3066 3064
		mu 0 4 1596 176 1677 829
		f 4 1503 -350 -3067 3065
		mu 0 4 1677 209 1678 829
		f 4 -349 -1502 -3068 3066
		mu 0 4 1678 208 1675 829
		f 4 -1501 284 -3065 3067
		mu 0 4 1675 175 1596 829
		f 4 287 1504 -3070 3068
		mu 0 4 1599 177 1679 830
		f 4 1505 -352 -3071 3069
		mu 0 4 1679 210 1680 830
		f 4 -351 -1504 -3072 3070
		mu 0 4 1680 209 1677 830
		f 4 -1503 286 -3069 3071
		mu 0 4 1677 176 1599 830
		f 4 289 1506 -3074 3072
		mu 0 4 1602 178 1681 831
		f 4 1507 -354 -3075 3073
		mu 0 4 1681 211 1682 831
		f 4 -353 -1506 -3076 3074
		mu 0 4 1682 210 1679 831
		f 4 -1505 288 -3073 3075
		mu 0 4 1679 177 1602 831
		f 4 291 1508 -3078 3076
		mu 0 4 1605 179 1683 832
		f 4 1509 -356 -3079 3077
		mu 0 4 1683 212 1684 832
		f 4 -355 -1508 -3080 3078
		mu 0 4 1684 211 1681 832
		f 4 -1507 290 -3077 3079
		mu 0 4 1681 178 1605 832
		f 4 293 1510 -3082 3080
		mu 0 4 1608 180 1685 833
		f 4 1511 -358 -3083 3081
		mu 0 4 1685 213 1686 833
		f 4 -357 -1510 -3084 3082
		mu 0 4 1686 212 1683 833
		f 4 -1509 292 -3081 3083
		mu 0 4 1683 179 1608 833
		f 4 295 1512 -3086 3084
		mu 0 4 1611 181 1687 834
		f 4 1513 -360 -3087 3085
		mu 0 4 1687 214 1688 834
		f 4 -359 -1512 -3088 3086
		mu 0 4 1688 213 1685 834
		f 4 -1511 294 -3085 3087
		mu 0 4 1685 180 1611 834
		f 4 297 1514 -3090 3088
		mu 0 4 1614 182 1689 835
		f 4 1515 -362 -3091 3089
		mu 0 4 1689 215 1690 835
		f 4 -361 -1514 -3092 3090
		mu 0 4 1690 214 1687 835
		f 4 -1513 296 -3089 3091
		mu 0 4 1687 181 1614 835
		f 4 299 1516 -3094 3092
		mu 0 4 1617 183 1691 836
		f 4 1517 -364 -3095 3093
		mu 0 4 1691 216 1692 836
		f 4 -363 -1516 -3096 3094
		mu 0 4 1692 215 1689 836
		f 4 -1515 298 -3093 3095
		mu 0 4 1689 182 1617 836
		f 4 301 1518 -3098 3096
		mu 0 4 1620 184 1693 837
		f 4 1519 -366 -3099 3097
		mu 0 4 1693 217 1694 837
		f 4 -365 -1518 -3100 3098
		mu 0 4 1694 216 1691 837
		f 4 -1517 300 -3097 3099
		mu 0 4 1691 183 1620 837
		f 4 303 1520 -3102 3100
		mu 0 4 1623 185 1695 838
		f 4 1521 -368 -3103 3101
		mu 0 4 1695 218 1696 838
		f 4 -367 -1520 -3104 3102
		mu 0 4 1696 217 1693 838
		f 4 -1519 302 -3101 3103
		mu 0 4 1693 184 1623 838
		f 4 305 1522 -3106 3104
		mu 0 4 1626 186 1697 839
		f 4 1523 -370 -3107 3105
		mu 0 4 1697 219 1698 839
		f 4 -369 -1522 -3108 3106
		mu 0 4 1698 218 1695 839
		f 4 -1521 304 -3105 3107
		mu 0 4 1695 185 1626 839
		f 4 307 1524 -3110 3108
		mu 0 4 1629 187 1699 840
		f 4 1525 -372 -3111 3109
		mu 0 4 1699 220 1700 840
		f 4 -371 -1524 -3112 3110
		mu 0 4 1700 219 1697 840
		f 4 -1523 306 -3109 3111
		mu 0 4 1697 186 1629 840
		f 4 309 1526 -3114 3112
		mu 0 4 1632 188 1701 841
		f 4 1527 -374 -3115 3113
		mu 0 4 1701 221 1702 841
		f 4 -373 -1526 -3116 3114
		mu 0 4 1702 220 1699 841
		f 4 -1525 308 -3113 3115
		mu 0 4 1699 187 1632 841
		f 4 311 1528 -3118 3116
		mu 0 4 1635 189 1703 842
		f 4 1529 -376 -3119 3117
		mu 0 4 1703 222 1704 842
		f 4 -375 -1528 -3120 3118
		mu 0 4 1704 221 1701 842
		f 4 -1527 310 -3117 3119
		mu 0 4 1701 188 1635 842
		f 4 313 1530 -3122 3120
		mu 0 4 1638 190 1705 843
		f 4 1531 -378 -3123 3121
		mu 0 4 1705 223 1706 843
		f 4 -377 -1530 -3124 3122
		mu 0 4 1706 222 1703 843
		f 4 -1529 312 -3121 3123
		mu 0 4 1703 189 1638 843
		f 4 315 1532 -3126 3124
		mu 0 4 1641 191 1707 844
		f 4 1533 -380 -3127 3125
		mu 0 4 1707 224 1708 844
		f 4 -379 -1532 -3128 3126
		mu 0 4 1708 223 1705 844
		f 4 -1531 314 -3125 3127
		mu 0 4 1705 190 1641 844
		f 4 317 1534 -3130 3128
		mu 0 4 1644 192 1709 845
		f 4 1535 -382 -3131 3129
		mu 0 4 1709 225 1710 845
		f 4 -381 -1534 -3132 3130
		mu 0 4 1710 224 1707 845
		f 4 -1533 316 -3129 3131
		mu 0 4 1707 191 1644 845
		f 4 319 1472 -3134 3132
		mu 0 4 1647 193 1711 846
		f 4 1473 -384 -3135 3133
		mu 0 4 1711 226 1712 846
		f 4 -383 -1536 -3136 3134
		mu 0 4 1712 225 1709 846
		f 4 -1535 318 -3133 3135
		mu 0 4 1709 192 1647 846
		f 4 321 1538 -3138 3136
		mu 0 4 1649 195 1713 847
		f 4 1539 -386 -3139 3137
		mu 0 4 1713 228 1714 847
		f 4 -385 -1538 -3140 3138
		mu 0 4 1714 227 1715 847
		f 4 -1537 320 -3137 3139
		mu 0 4 1715 194 1649 847
		f 4 323 1540 -3142 3140
		mu 0 4 1652 196 1716 848
		f 4 1541 -388 -3143 3141
		mu 0 4 1716 229 1717 848
		f 4 -387 -1540 -3144 3142
		mu 0 4 1717 228 1713 848
		f 4 -1539 322 -3141 3143
		mu 0 4 1713 195 1652 848
		f 4 325 1542 -3146 3144
		mu 0 4 1654 197 1718 849
		f 4 1543 -390 -3147 3145
		mu 0 4 1718 230 1719 849
		f 4 -389 -1542 -3148 3146
		mu 0 4 1719 229 1716 849
		f 4 -1541 324 -3145 3147
		mu 0 4 1716 196 1654 849
		f 4 327 1544 -3150 3148
		mu 0 4 1656 198 1720 850
		f 4 1545 -392 -3151 3149
		mu 0 4 1720 231 1721 850
		f 4 -391 -1544 -3152 3150
		mu 0 4 1721 230 1718 850
		f 4 -1543 326 -3149 3151
		mu 0 4 1718 197 1656 850
		f 4 329 1546 -3154 3152
		mu 0 4 1658 199 1722 851
		f 4 1547 -394 -3155 3153
		mu 0 4 1722 232 1723 851
		f 4 -393 -1546 -3156 3154
		mu 0 4 1723 231 1720 851
		f 4 -1545 328 -3153 3155
		mu 0 4 1720 198 1658 851
		f 4 331 1548 -3158 3156
		mu 0 4 1660 200 1724 852
		f 4 1549 -396 -3159 3157
		mu 0 4 1724 233 1725 852
		f 4 -395 -1548 -3160 3158
		mu 0 4 1725 232 1722 852
		f 4 -1547 330 -3157 3159
		mu 0 4 1722 199 1660 852
		f 4 333 1550 -3162 3160
		mu 0 4 1662 201 1726 853
		f 4 1551 -398 -3163 3161
		mu 0 4 1726 234 1727 853
		f 4 -397 -1550 -3164 3162
		mu 0 4 1727 233 1724 853
		f 4 -1549 332 -3161 3163
		mu 0 4 1724 200 1662 853
		f 4 335 1552 -3166 3164
		mu 0 4 1664 202 1728 854
		f 4 1553 -400 -3167 3165
		mu 0 4 1728 235 1729 854
		f 4 -399 -1552 -3168 3166
		mu 0 4 1729 234 1726 854
		f 4 -1551 334 -3165 3167
		mu 0 4 1726 201 1664 854
		f 4 337 1554 -3170 3168
		mu 0 4 1666 203 1730 855
		f 4 1555 -402 -3171 3169
		mu 0 4 1730 236 1731 855
		f 4 -401 -1554 -3172 3170
		mu 0 4 1731 235 1728 855
		f 4 -1553 336 -3169 3171
		mu 0 4 1728 202 1666 855
		f 4 339 1556 -3174 3172
		mu 0 4 1668 204 1732 856
		f 4 1557 -404 -3175 3173
		mu 0 4 1732 237 1733 856
		f 4 -403 -1556 -3176 3174
		mu 0 4 1733 236 1730 856
		f 4 -1555 338 -3173 3175
		mu 0 4 1730 203 1668 856
		f 4 341 1558 -3178 3176
		mu 0 4 1670 205 1734 857
		f 4 1559 -406 -3179 3177
		mu 0 4 1734 238 1735 857
		f 4 -405 -1558 -3180 3178
		mu 0 4 1735 237 1732 857
		f 4 -1557 340 -3177 3179
		mu 0 4 1732 204 1670 857
		f 4 343 1560 -3182 3180
		mu 0 4 1672 206 1736 858
		f 4 1561 -408 -3183 3181
		mu 0 4 1736 239 1737 858
		f 4 -407 -1560 -3184 3182
		mu 0 4 1737 238 1734 858
		f 4 -1559 342 -3181 3183
		mu 0 4 1734 205 1672 858
		f 4 345 1562 -3186 3184
		mu 0 4 1674 207 1738 859
		f 4 1563 -410 -3187 3185
		mu 0 4 1738 240 1739 859
		f 4 -409 -1562 -3188 3186
		mu 0 4 1739 239 1736 859
		f 4 -1561 344 -3185 3187
		mu 0 4 1736 206 1674 859
		f 4 347 1564 -3190 3188
		mu 0 4 1676 208 1740 860
		f 4 1565 -412 -3191 3189
		mu 0 4 1740 241 1741 860
		f 4 -411 -1564 -3192 3190
		mu 0 4 1741 240 1738 860
		f 4 -1563 346 -3189 3191
		mu 0 4 1738 207 1676 860
		f 4 349 1566 -3194 3192
		mu 0 4 1678 209 1742 861
		f 4 1567 -414 -3195 3193
		mu 0 4 1742 242 1743 861
		f 4 -413 -1566 -3196 3194
		mu 0 4 1743 241 1740 861
		f 4 -1565 348 -3193 3195
		mu 0 4 1740 208 1678 861
		f 4 351 1568 -3198 3196
		mu 0 4 1680 210 1744 862
		f 4 1569 -416 -3199 3197
		mu 0 4 1744 243 1745 862
		f 4 -415 -1568 -3200 3198
		mu 0 4 1745 242 1742 862
		f 4 -1567 350 -3197 3199
		mu 0 4 1742 209 1680 862
		f 4 353 1570 -3202 3200
		mu 0 4 1682 211 1746 863
		f 4 1571 -418 -3203 3201
		mu 0 4 1746 244 1747 863
		f 4 -417 -1570 -3204 3202
		mu 0 4 1747 243 1744 863
		f 4 -1569 352 -3201 3203
		mu 0 4 1744 210 1682 863
		f 4 355 1572 -3206 3204
		mu 0 4 1684 212 1748 864
		f 4 1573 -420 -3207 3205
		mu 0 4 1748 245 1749 864
		f 4 -419 -1572 -3208 3206
		mu 0 4 1749 244 1746 864
		f 4 -1571 354 -3205 3207
		mu 0 4 1746 211 1684 864
		f 4 357 1574 -3210 3208
		mu 0 4 1686 213 1750 865
		f 4 1575 -422 -3211 3209
		mu 0 4 1750 246 1751 865
		f 4 -421 -1574 -3212 3210
		mu 0 4 1751 245 1748 865
		f 4 -1573 356 -3209 3211
		mu 0 4 1748 212 1686 865
		f 4 359 1576 -3214 3212
		mu 0 4 1688 214 1752 866
		f 4 1577 -424 -3215 3213
		mu 0 4 1752 247 1753 866
		f 4 -423 -1576 -3216 3214
		mu 0 4 1753 246 1750 866
		f 4 -1575 358 -3213 3215
		mu 0 4 1750 213 1688 866
		f 4 361 1578 -3218 3216
		mu 0 4 1690 215 1754 867
		f 4 1579 -426 -3219 3217
		mu 0 4 1754 248 1755 867
		f 4 -425 -1578 -3220 3218
		mu 0 4 1755 247 1752 867
		f 4 -1577 360 -3217 3219
		mu 0 4 1752 214 1690 867
		f 4 363 1580 -3222 3220
		mu 0 4 1692 216 1756 868
		f 4 1581 -428 -3223 3221
		mu 0 4 1756 249 1757 868
		f 4 -427 -1580 -3224 3222
		mu 0 4 1757 248 1754 868
		f 4 -1579 362 -3221 3223
		mu 0 4 1754 215 1692 868
		f 4 365 1582 -3226 3224
		mu 0 4 1694 217 1758 869
		f 4 1583 -430 -3227 3225
		mu 0 4 1758 250 1759 869
		f 4 -429 -1582 -3228 3226
		mu 0 4 1759 249 1756 869
		f 4 -1581 364 -3225 3227
		mu 0 4 1756 216 1694 869
		f 4 367 1584 -3230 3228
		mu 0 4 1696 218 1760 870
		f 4 1585 -432 -3231 3229
		mu 0 4 1760 251 1761 870
		f 4 -431 -1584 -3232 3230
		mu 0 4 1761 250 1758 870
		f 4 -1583 366 -3229 3231
		mu 0 4 1758 217 1696 870
		f 4 369 1586 -3234 3232
		mu 0 4 1698 219 1762 871
		f 4 1587 -434 -3235 3233
		mu 0 4 1762 252 1763 871
		f 4 -433 -1586 -3236 3234
		mu 0 4 1763 251 1760 871
		f 4 -1585 368 -3233 3235
		mu 0 4 1760 218 1698 871
		f 4 371 1588 -3238 3236
		mu 0 4 1700 220 1764 872
		f 4 1589 -436 -3239 3237
		mu 0 4 1764 253 1765 872
		f 4 -435 -1588 -3240 3238
		mu 0 4 1765 252 1762 872
		f 4 -1587 370 -3237 3239
		mu 0 4 1762 219 1700 872
		f 4 373 1590 -3242 3240
		mu 0 4 1702 221 1766 873
		f 4 1591 -438 -3243 3241
		mu 0 4 1766 254 1767 873
		f 4 -437 -1590 -3244 3242
		mu 0 4 1767 253 1764 873
		f 4 -1589 372 -3241 3243
		mu 0 4 1764 220 1702 873
		f 4 375 1592 -3246 3244
		mu 0 4 1704 222 1768 874
		f 4 1593 -440 -3247 3245
		mu 0 4 1768 255 1769 874
		f 4 -439 -1592 -3248 3246
		mu 0 4 1769 254 1766 874
		f 4 -1591 374 -3245 3247
		mu 0 4 1766 221 1704 874
		f 4 377 1594 -3250 3248
		mu 0 4 1706 223 1770 875
		f 4 1595 -442 -3251 3249
		mu 0 4 1770 256 1771 875
		f 4 -441 -1594 -3252 3250
		mu 0 4 1771 255 1768 875
		f 4 -1593 376 -3249 3251
		mu 0 4 1768 222 1706 875
		f 4 379 1596 -3254 3252
		mu 0 4 1708 224 1772 876
		f 4 1597 -444 -3255 3253
		mu 0 4 1772 257 1773 876
		f 4 -443 -1596 -3256 3254
		mu 0 4 1773 256 1770 876
		f 4 -1595 378 -3253 3255
		mu 0 4 1770 223 1708 876
		f 4 381 1598 -3258 3256
		mu 0 4 1710 225 1774 877
		f 4 1599 -446 -3259 3257
		mu 0 4 1774 258 1775 877
		f 4 -445 -1598 -3260 3258
		mu 0 4 1775 257 1772 877
		f 4 -1597 380 -3257 3259
		mu 0 4 1772 224 1710 877
		f 4 383 1536 -3262 3260
		mu 0 4 1712 226 1776 878
		f 4 1537 -448 -3263 3261
		mu 0 4 1776 259 1777 878
		f 4 -447 -1600 -3264 3262
		mu 0 4 1777 258 1774 878
		f 4 -1599 382 -3261 3263
		mu 0 4 1774 225 1712 878
		f 4 385 1602 -3266 3264
		mu 0 4 1714 228 1778 879
		f 4 1603 -450 -3267 3265
		mu 0 4 1778 261 1779 879
		f 4 -449 -1602 -3268 3266
		mu 0 4 1779 260 1780 879
		f 4 -1601 384 -3265 3267
		mu 0 4 1780 227 1714 879
		f 4 387 1604 -3270 3268
		mu 0 4 1717 229 1781 880
		f 4 1605 -452 -3271 3269
		mu 0 4 1781 262 1782 880
		f 4 -451 -1604 -3272 3270
		mu 0 4 1782 261 1778 880
		f 4 -1603 386 -3269 3271
		mu 0 4 1778 228 1717 880
		f 4 389 1606 -3274 3272
		mu 0 4 1719 230 1783 881
		f 4 1607 -454 -3275 3273
		mu 0 4 1783 263 1784 881
		f 4 -453 -1606 -3276 3274
		mu 0 4 1784 262 1781 881
		f 4 -1605 388 -3273 3275
		mu 0 4 1781 229 1719 881
		f 4 391 1608 -3278 3276
		mu 0 4 1721 231 1785 882
		f 4 1609 -456 -3279 3277
		mu 0 4 1785 264 1786 882
		f 4 -455 -1608 -3280 3278
		mu 0 4 1786 263 1783 882
		f 4 -1607 390 -3277 3279
		mu 0 4 1783 230 1721 882
		f 4 393 1610 -3282 3280
		mu 0 4 1723 232 1787 883
		f 4 1611 -458 -3283 3281
		mu 0 4 1787 265 1788 883
		f 4 -457 -1610 -3284 3282
		mu 0 4 1788 264 1785 883
		f 4 -1609 392 -3281 3283
		mu 0 4 1785 231 1723 883
		f 4 395 1612 -3286 3284
		mu 0 4 1725 233 1789 884
		f 4 1613 -460 -3287 3285
		mu 0 4 1789 266 1790 884
		f 4 -459 -1612 -3288 3286
		mu 0 4 1790 265 1787 884
		f 4 -1611 394 -3285 3287
		mu 0 4 1787 232 1725 884
		f 4 397 1614 -3290 3288
		mu 0 4 1727 234 1791 885
		f 4 1615 -462 -3291 3289
		mu 0 4 1791 267 1792 885
		f 4 -461 -1614 -3292 3290
		mu 0 4 1792 266 1789 885
		f 4 -1613 396 -3289 3291
		mu 0 4 1789 233 1727 885
		f 4 399 1616 -3294 3292
		mu 0 4 1729 235 1793 886
		f 4 1617 -464 -3295 3293
		mu 0 4 1793 268 1794 886
		f 4 -463 -1616 -3296 3294
		mu 0 4 1794 267 1791 886
		f 4 -1615 398 -3293 3295
		mu 0 4 1791 234 1729 886
		f 4 401 1618 -3298 3296
		mu 0 4 1731 236 1795 887
		f 4 1619 -466 -3299 3297
		mu 0 4 1795 269 1796 887
		f 4 -465 -1618 -3300 3298
		mu 0 4 1796 268 1793 887
		f 4 -1617 400 -3297 3299
		mu 0 4 1793 235 1731 887
		f 4 403 1620 -3302 3300
		mu 0 4 1733 237 1797 888
		f 4 1621 -468 -3303 3301
		mu 0 4 1797 270 1798 888
		f 4 -467 -1620 -3304 3302
		mu 0 4 1798 269 1795 888
		f 4 -1619 402 -3301 3303
		mu 0 4 1795 236 1733 888
		f 4 405 1622 -3306 3304
		mu 0 4 1735 238 1799 889
		f 4 1623 -470 -3307 3305
		mu 0 4 1799 271 1800 889
		f 4 -469 -1622 -3308 3306
		mu 0 4 1800 270 1797 889
		f 4 -1621 404 -3305 3307
		mu 0 4 1797 237 1735 889
		f 4 407 1624 -3310 3308
		mu 0 4 1737 239 1801 890
		f 4 1625 -472 -3311 3309
		mu 0 4 1801 272 1802 890
		f 4 -471 -1624 -3312 3310
		mu 0 4 1802 271 1799 890
		f 4 -1623 406 -3309 3311
		mu 0 4 1799 238 1737 890
		f 4 409 1626 -3314 3312
		mu 0 4 1739 240 1803 891
		f 4 1627 -474 -3315 3313
		mu 0 4 1803 273 1804 891
		f 4 -473 -1626 -3316 3314
		mu 0 4 1804 272 1801 891
		f 4 -1625 408 -3313 3315
		mu 0 4 1801 239 1739 891
		f 4 411 1628 -3318 3316
		mu 0 4 1741 241 1805 892
		f 4 1629 -476 -3319 3317
		mu 0 4 1805 274 1806 892
		f 4 -475 -1628 -3320 3318
		mu 0 4 1806 273 1803 892
		f 4 -1627 410 -3317 3319
		mu 0 4 1803 240 1741 892
		f 4 413 1630 -3322 3320
		mu 0 4 1743 242 1807 893
		f 4 1631 -478 -3323 3321
		mu 0 4 1807 275 1808 893
		f 4 -477 -1630 -3324 3322
		mu 0 4 1808 274 1805 893
		f 4 -1629 412 -3321 3323
		mu 0 4 1805 241 1743 893
		f 4 415 1632 -3326 3324
		mu 0 4 1745 243 1809 894
		f 4 1633 -480 -3327 3325
		mu 0 4 1809 276 1810 894
		f 4 -479 -1632 -3328 3326
		mu 0 4 1810 275 1807 894
		f 4 -1631 414 -3325 3327
		mu 0 4 1807 242 1745 894
		f 4 417 1634 -3330 3328
		mu 0 4 1747 244 1811 895
		f 4 1635 -482 -3331 3329
		mu 0 4 1811 277 1812 895
		f 4 -481 -1634 -3332 3330
		mu 0 4 1812 276 1809 895
		f 4 -1633 416 -3329 3331
		mu 0 4 1809 243 1747 895
		f 4 419 1636 -3334 3332
		mu 0 4 1749 245 1813 896
		f 4 1637 -484 -3335 3333
		mu 0 4 1813 278 1814 896
		f 4 -483 -1636 -3336 3334
		mu 0 4 1814 277 1811 896
		f 4 -1635 418 -3333 3335
		mu 0 4 1811 244 1749 896
		f 4 421 1638 -3338 3336
		mu 0 4 1751 246 1815 897
		f 4 1639 -486 -3339 3337
		mu 0 4 1815 279 1816 897
		f 4 -485 -1638 -3340 3338
		mu 0 4 1816 278 1813 897
		f 4 -1637 420 -3337 3339
		mu 0 4 1813 245 1751 897
		f 4 423 1640 -3342 3340
		mu 0 4 1753 247 1817 898
		f 4 1641 -488 -3343 3341
		mu 0 4 1817 280 1818 898
		f 4 -487 -1640 -3344 3342
		mu 0 4 1818 279 1815 898
		f 4 -1639 422 -3341 3343
		mu 0 4 1815 246 1753 898
		f 4 425 1642 -3346 3344
		mu 0 4 1755 248 1819 899
		f 4 1643 -490 -3347 3345
		mu 0 4 1819 281 1820 899
		f 4 -489 -1642 -3348 3346
		mu 0 4 1820 280 1817 899
		f 4 -1641 424 -3345 3347
		mu 0 4 1817 247 1755 899
		f 4 427 1644 -3350 3348
		mu 0 4 1757 249 1821 900
		f 4 1645 -492 -3351 3349
		mu 0 4 1821 282 1822 900
		f 4 -491 -1644 -3352 3350
		mu 0 4 1822 281 1819 900
		f 4 -1643 426 -3349 3351
		mu 0 4 1819 248 1757 900
		f 4 429 1646 -3354 3352
		mu 0 4 1759 250 1823 901
		f 4 1647 -494 -3355 3353
		mu 0 4 1823 283 1824 901
		f 4 -493 -1646 -3356 3354
		mu 0 4 1824 282 1821 901
		f 4 -1645 428 -3353 3355
		mu 0 4 1821 249 1759 901
		f 4 431 1648 -3358 3356
		mu 0 4 1761 251 1825 902
		f 4 1649 -496 -3359 3357
		mu 0 4 1825 284 1826 902
		f 4 -495 -1648 -3360 3358
		mu 0 4 1826 283 1823 902
		f 4 -1647 430 -3357 3359
		mu 0 4 1823 250 1761 902
		f 4 433 1650 -3362 3360
		mu 0 4 1763 252 1827 903
		f 4 1651 -498 -3363 3361
		mu 0 4 1827 285 1828 903
		f 4 -497 -1650 -3364 3362
		mu 0 4 1828 284 1825 903
		f 4 -1649 432 -3361 3363
		mu 0 4 1825 251 1763 903
		f 4 435 1652 -3366 3364
		mu 0 4 1765 253 1829 904
		f 4 1653 -500 -3367 3365
		mu 0 4 1829 286 1830 904
		f 4 -499 -1652 -3368 3366
		mu 0 4 1830 285 1827 904
		f 4 -1651 434 -3365 3367
		mu 0 4 1827 252 1765 904
		f 4 437 1654 -3370 3368
		mu 0 4 1767 254 1831 905
		f 4 1655 -502 -3371 3369
		mu 0 4 1831 287 1832 905
		f 4 -501 -1654 -3372 3370
		mu 0 4 1832 286 1829 905
		f 4 -1653 436 -3369 3371
		mu 0 4 1829 253 1767 905
		f 4 439 1656 -3374 3372
		mu 0 4 1769 255 1833 906
		f 4 1657 -504 -3375 3373
		mu 0 4 1833 288 1834 906
		f 4 -503 -1656 -3376 3374
		mu 0 4 1834 287 1831 906
		f 4 -1655 438 -3373 3375
		mu 0 4 1831 254 1769 906
		f 4 441 1658 -3378 3376
		mu 0 4 1771 256 1835 907
		f 4 1659 -506 -3379 3377
		mu 0 4 1835 289 1836 907
		f 4 -505 -1658 -3380 3378
		mu 0 4 1836 288 1833 907
		f 4 -1657 440 -3377 3379
		mu 0 4 1833 255 1771 907
		f 4 443 1660 -3382 3380
		mu 0 4 1773 257 1837 908
		f 4 1661 -508 -3383 3381
		mu 0 4 1837 290 1838 908
		f 4 -507 -1660 -3384 3382
		mu 0 4 1838 289 1835 908
		f 4 -1659 442 -3381 3383
		mu 0 4 1835 256 1773 908
		f 4 445 1662 -3386 3384
		mu 0 4 1775 258 1839 909
		f 4 1663 -510 -3387 3385
		mu 0 4 1839 291 1840 909
		f 4 -509 -1662 -3388 3386
		mu 0 4 1840 290 1837 909
		f 4 -1661 444 -3385 3387
		mu 0 4 1837 257 1775 909
		f 4 447 1600 -3390 3388
		mu 0 4 1777 259 1841 910
		f 4 1601 -512 -3391 3389
		mu 0 4 1841 292 1842 910
		f 4 -511 -1664 -3392 3390
		mu 0 4 1842 291 1839 910
		f 4 -1663 446 -3389 3391
		mu 0 4 1839 258 1777 910
		f 4 449 1666 -3394 3392
		mu 0 4 1779 261 1843 911
		f 4 1667 -514 -3395 3393
		mu 0 4 1843 294 1844 911
		f 4 -513 -1666 -3396 3394
		mu 0 4 1844 293 1845 911
		f 4 -1665 448 -3393 3395
		mu 0 4 1845 260 1779 911
		f 4 451 1668 -3398 3396
		mu 0 4 1782 262 1846 912
		f 4 1669 -516 -3399 3397
		mu 0 4 1846 295 1847 912
		f 4 -515 -1668 -3400 3398
		mu 0 4 1847 294 1843 912
		f 4 -1667 450 -3397 3399
		mu 0 4 1843 261 1782 912
		f 4 453 1670 -3402 3400
		mu 0 4 1784 263 1848 913
		f 4 1671 -518 -3403 3401
		mu 0 4 1848 296 1849 913
		f 4 -517 -1670 -3404 3402
		mu 0 4 1849 295 1846 913
		f 4 -1669 452 -3401 3403
		mu 0 4 1846 262 1784 913
		f 4 455 1672 -3406 3404
		mu 0 4 1786 264 1850 914
		f 4 1673 -520 -3407 3405
		mu 0 4 1850 297 1851 914
		f 4 -519 -1672 -3408 3406
		mu 0 4 1851 296 1848 914
		f 4 -1671 454 -3405 3407
		mu 0 4 1848 263 1786 914
		f 4 457 1674 -3410 3408
		mu 0 4 1788 265 1852 915
		f 4 1675 -522 -3411 3409
		mu 0 4 1852 298 1853 915
		f 4 -521 -1674 -3412 3410
		mu 0 4 1853 297 1850 915
		f 4 -1673 456 -3409 3411
		mu 0 4 1850 264 1788 915
		f 4 459 1676 -3414 3412
		mu 0 4 1790 266 1854 916
		f 4 1677 -524 -3415 3413
		mu 0 4 1854 299 1855 916
		f 4 -523 -1676 -3416 3414
		mu 0 4 1855 298 1852 916
		f 4 -1675 458 -3413 3415
		mu 0 4 1852 265 1790 916
		f 4 461 1678 -3418 3416
		mu 0 4 1792 267 1856 917
		f 4 1679 -526 -3419 3417
		mu 0 4 1856 300 1857 917
		f 4 -525 -1678 -3420 3418
		mu 0 4 1857 299 1854 917
		f 4 -1677 460 -3417 3419
		mu 0 4 1854 266 1792 917
		f 4 463 1680 -3422 3420
		mu 0 4 1794 268 1858 918
		f 4 1681 -528 -3423 3421
		mu 0 4 1858 301 1859 918
		f 4 -527 -1680 -3424 3422
		mu 0 4 1859 300 1856 918
		f 4 -1679 462 -3421 3423
		mu 0 4 1856 267 1794 918
		f 4 465 1682 -3426 3424
		mu 0 4 1796 269 1860 919
		f 4 1683 -530 -3427 3425
		mu 0 4 1860 302 1861 919
		f 4 -529 -1682 -3428 3426
		mu 0 4 1861 301 1858 919
		f 4 -1681 464 -3425 3427
		mu 0 4 1858 268 1796 919
		f 4 467 1684 -3430 3428
		mu 0 4 1798 270 1862 920
		f 4 1685 -532 -3431 3429
		mu 0 4 1862 303 1863 920
		f 4 -531 -1684 -3432 3430
		mu 0 4 1863 302 1860 920
		f 4 -1683 466 -3429 3431
		mu 0 4 1860 269 1798 920
		f 4 469 1686 -3434 3432
		mu 0 4 1800 271 1864 921
		f 4 1687 -534 -3435 3433
		mu 0 4 1864 304 1865 921
		f 4 -533 -1686 -3436 3434
		mu 0 4 1865 303 1862 921
		f 4 -1685 468 -3433 3435
		mu 0 4 1862 270 1800 921
		f 4 471 1688 -3438 3436
		mu 0 4 1802 272 1866 922
		f 4 1689 -536 -3439 3437
		mu 0 4 1866 305 1867 922
		f 4 -535 -1688 -3440 3438
		mu 0 4 1867 304 1864 922
		f 4 -1687 470 -3437 3439
		mu 0 4 1864 271 1802 922
		f 4 473 1690 -3442 3440
		mu 0 4 1804 273 1868 923
		f 4 1691 -538 -3443 3441
		mu 0 4 1868 306 1869 923
		f 4 -537 -1690 -3444 3442
		mu 0 4 1869 305 1866 923
		f 4 -1689 472 -3441 3443
		mu 0 4 1866 272 1804 923
		f 4 475 1692 -3446 3444
		mu 0 4 1806 274 1870 924
		f 4 1693 -540 -3447 3445
		mu 0 4 1870 307 1871 924
		f 4 -539 -1692 -3448 3446
		mu 0 4 1871 306 1868 924
		f 4 -1691 474 -3445 3447
		mu 0 4 1868 273 1806 924
		f 4 477 1694 -3450 3448
		mu 0 4 1808 275 1872 925
		f 4 1695 -542 -3451 3449
		mu 0 4 1872 308 1873 925
		f 4 -541 -1694 -3452 3450
		mu 0 4 1873 307 1870 925
		f 4 -1693 476 -3449 3451
		mu 0 4 1870 274 1808 925
		f 4 479 1696 -3454 3452
		mu 0 4 1810 276 1874 926
		f 4 1697 -544 -3455 3453
		mu 0 4 1874 309 1875 926
		f 4 -543 -1696 -3456 3454
		mu 0 4 1875 308 1872 926
		f 4 -1695 478 -3453 3455
		mu 0 4 1872 275 1810 926
		f 4 481 1698 -3458 3456
		mu 0 4 1812 277 1876 927
		f 4 1699 -546 -3459 3457
		mu 0 4 1876 310 1877 927
		f 4 -545 -1698 -3460 3458
		mu 0 4 1877 309 1874 927
		f 4 -1697 480 -3457 3459
		mu 0 4 1874 276 1812 927
		f 4 483 1700 -3462 3460
		mu 0 4 1814 278 1878 928
		f 4 1701 -548 -3463 3461
		mu 0 4 1878 311 1879 928
		f 4 -547 -1700 -3464 3462
		mu 0 4 1879 310 1876 928
		f 4 -1699 482 -3461 3463
		mu 0 4 1876 277 1814 928
		f 4 485 1702 -3466 3464
		mu 0 4 1816 279 1880 929
		f 4 1703 -550 -3467 3465
		mu 0 4 1880 312 1881 929
		f 4 -549 -1702 -3468 3466
		mu 0 4 1881 311 1878 929
		f 4 -1701 484 -3465 3467
		mu 0 4 1878 278 1816 929
		f 4 487 1704 -3470 3468
		mu 0 4 1818 280 1882 930
		f 4 1705 -552 -3471 3469
		mu 0 4 1882 313 1883 930
		f 4 -551 -1704 -3472 3470
		mu 0 4 1883 312 1880 930
		f 4 -1703 486 -3469 3471
		mu 0 4 1880 279 1818 930
		f 4 489 1706 -3474 3472
		mu 0 4 1820 281 1884 931
		f 4 1707 -554 -3475 3473
		mu 0 4 1884 314 1885 931
		f 4 -553 -1706 -3476 3474
		mu 0 4 1885 313 1882 931
		f 4 -1705 488 -3473 3475
		mu 0 4 1882 280 1820 931
		f 4 491 1708 -3478 3476
		mu 0 4 1822 282 1886 932
		f 4 1709 -556 -3479 3477
		mu 0 4 1886 315 1887 932
		f 4 -555 -1708 -3480 3478
		mu 0 4 1887 314 1884 932
		f 4 -1707 490 -3477 3479
		mu 0 4 1884 281 1822 932
		f 4 493 1710 -3482 3480
		mu 0 4 1824 283 1888 933
		f 4 1711 -558 -3483 3481
		mu 0 4 1888 316 1889 933
		f 4 -557 -1710 -3484 3482
		mu 0 4 1889 315 1886 933
		f 4 -1709 492 -3481 3483
		mu 0 4 1886 282 1824 933
		f 4 495 1712 -3486 3484
		mu 0 4 1826 284 1890 934
		f 4 1713 -560 -3487 3485
		mu 0 4 1890 317 1891 934
		f 4 -559 -1712 -3488 3486
		mu 0 4 1891 316 1888 934
		f 4 -1711 494 -3485 3487
		mu 0 4 1888 283 1826 934
		f 4 497 1714 -3490 3488
		mu 0 4 1828 285 1892 935
		f 4 1715 -562 -3491 3489
		mu 0 4 1892 318 1893 935
		f 4 -561 -1714 -3492 3490
		mu 0 4 1893 317 1890 935
		f 4 -1713 496 -3489 3491
		mu 0 4 1890 284 1828 935
		f 4 499 1716 -3494 3492
		mu 0 4 1830 286 1894 936
		f 4 1717 -564 -3495 3493
		mu 0 4 1894 319 1895 936
		f 4 -563 -1716 -3496 3494
		mu 0 4 1895 318 1892 936
		f 4 -1715 498 -3493 3495
		mu 0 4 1892 285 1830 936;
	setAttr ".fc[1000:1499]"
		f 4 501 1718 -3498 3496
		mu 0 4 1832 287 1896 937
		f 4 1719 -566 -3499 3497
		mu 0 4 1896 320 1897 937
		f 4 -565 -1718 -3500 3498
		mu 0 4 1897 319 1894 937
		f 4 -1717 500 -3497 3499
		mu 0 4 1894 286 1832 937
		f 4 503 1720 -3502 3500
		mu 0 4 1834 288 1898 938
		f 4 1721 -568 -3503 3501
		mu 0 4 1898 321 1899 938
		f 4 -567 -1720 -3504 3502
		mu 0 4 1899 320 1896 938
		f 4 -1719 502 -3501 3503
		mu 0 4 1896 287 1834 938
		f 4 505 1722 -3506 3504
		mu 0 4 1836 289 1900 939
		f 4 1723 -570 -3507 3505
		mu 0 4 1900 322 1901 939
		f 4 -569 -1722 -3508 3506
		mu 0 4 1901 321 1898 939
		f 4 -1721 504 -3505 3507
		mu 0 4 1898 288 1836 939
		f 4 507 1724 -3510 3508
		mu 0 4 1838 290 1902 940
		f 4 1725 -572 -3511 3509
		mu 0 4 1902 323 1903 940
		f 4 -571 -1724 -3512 3510
		mu 0 4 1903 322 1900 940
		f 4 -1723 506 -3509 3511
		mu 0 4 1900 289 1838 940
		f 4 509 1726 -3514 3512
		mu 0 4 1840 291 1904 941
		f 4 1727 -574 -3515 3513
		mu 0 4 1904 324 1905 941
		f 4 -573 -1726 -3516 3514
		mu 0 4 1905 323 1902 941
		f 4 -1725 508 -3513 3515
		mu 0 4 1902 290 1840 941
		f 4 511 1664 -3518 3516
		mu 0 4 1842 292 1906 942
		f 4 1665 -576 -3519 3517
		mu 0 4 1906 325 1907 942
		f 4 -575 -1728 -3520 3518
		mu 0 4 1907 324 1904 942
		f 4 -1727 510 -3517 3519
		mu 0 4 1904 291 1842 942
		f 4 513 1730 -3522 3520
		mu 0 4 1844 294 1908 943
		f 4 1731 -578 -3523 3521
		mu 0 4 1908 327 1909 943
		f 4 -577 -1730 -3524 3522
		mu 0 4 1909 326 1910 943
		f 4 -1729 512 -3521 3523
		mu 0 4 1910 293 1844 943
		f 4 515 1732 -3526 3524
		mu 0 4 1847 295 1911 944
		f 4 1733 -580 -3527 3525
		mu 0 4 1911 328 1912 944
		f 4 -579 -1732 -3528 3526
		mu 0 4 1912 327 1908 944
		f 4 -1731 514 -3525 3527
		mu 0 4 1908 294 1847 944
		f 4 517 1734 -3530 3528
		mu 0 4 1849 296 1913 945
		f 4 1735 -582 -3531 3529
		mu 0 4 1913 329 1914 945
		f 4 -581 -1734 -3532 3530
		mu 0 4 1914 328 1911 945
		f 4 -1733 516 -3529 3531
		mu 0 4 1911 295 1849 945
		f 4 519 1736 -3534 3532
		mu 0 4 1851 297 1915 946
		f 4 1737 -584 -3535 3533
		mu 0 4 1915 330 1916 946
		f 4 -583 -1736 -3536 3534
		mu 0 4 1916 329 1913 946
		f 4 -1735 518 -3533 3535
		mu 0 4 1913 296 1851 946
		f 4 521 1738 -3538 3536
		mu 0 4 1853 298 1917 947
		f 4 1739 -586 -3539 3537
		mu 0 4 1917 331 1918 947
		f 4 -585 -1738 -3540 3538
		mu 0 4 1918 330 1915 947
		f 4 -1737 520 -3537 3539
		mu 0 4 1915 297 1853 947
		f 4 523 1740 -3542 3540
		mu 0 4 1855 299 1919 948
		f 4 1741 -588 -3543 3541
		mu 0 4 1919 332 1920 948
		f 4 -587 -1740 -3544 3542
		mu 0 4 1920 331 1917 948
		f 4 -1739 522 -3541 3543
		mu 0 4 1917 298 1855 948
		f 4 525 1742 -3546 3544
		mu 0 4 1857 300 1921 949
		f 4 1743 -590 -3547 3545
		mu 0 4 1921 333 1922 949
		f 4 -589 -1742 -3548 3546
		mu 0 4 1922 332 1919 949
		f 4 -1741 524 -3545 3547
		mu 0 4 1919 299 1857 949
		f 4 527 1744 -3550 3548
		mu 0 4 1859 301 1923 950
		f 4 1745 -592 -3551 3549
		mu 0 4 1923 334 1924 950
		f 4 -591 -1744 -3552 3550
		mu 0 4 1924 333 1921 950
		f 4 -1743 526 -3549 3551
		mu 0 4 1921 300 1859 950
		f 4 529 1746 -3554 3552
		mu 0 4 1861 302 1925 951
		f 4 1747 -594 -3555 3553
		mu 0 4 1925 335 1926 951
		f 4 -593 -1746 -3556 3554
		mu 0 4 1926 334 1923 951
		f 4 -1745 528 -3553 3555
		mu 0 4 1923 301 1861 951
		f 4 531 1748 -3558 3556
		mu 0 4 1863 303 1927 952
		f 4 1749 -596 -3559 3557
		mu 0 4 1927 336 1928 952
		f 4 -595 -1748 -3560 3558
		mu 0 4 1928 335 1925 952
		f 4 -1747 530 -3557 3559
		mu 0 4 1925 302 1863 952
		f 4 533 1750 -3562 3560
		mu 0 4 1865 304 1929 953
		f 4 1751 -598 -3563 3561
		mu 0 4 1929 337 1930 953
		f 4 -597 -1750 -3564 3562
		mu 0 4 1930 336 1927 953
		f 4 -1749 532 -3561 3563
		mu 0 4 1927 303 1865 953
		f 4 535 1752 -3566 3564
		mu 0 4 1867 305 1931 954
		f 4 1753 -600 -3567 3565
		mu 0 4 1931 338 1932 954
		f 4 -599 -1752 -3568 3566
		mu 0 4 1932 337 1929 954
		f 4 -1751 534 -3565 3567
		mu 0 4 1929 304 1867 954
		f 4 537 1754 -3570 3568
		mu 0 4 1869 306 1933 955
		f 4 1755 -602 -3571 3569
		mu 0 4 1933 339 1934 955
		f 4 -601 -1754 -3572 3570
		mu 0 4 1934 338 1931 955
		f 4 -1753 536 -3569 3571
		mu 0 4 1931 305 1869 955
		f 4 539 1756 -3574 3572
		mu 0 4 1871 307 1935 956
		f 4 1757 -604 -3575 3573
		mu 0 4 1935 340 1936 956
		f 4 -603 -1756 -3576 3574
		mu 0 4 1936 339 1933 956
		f 4 -1755 538 -3573 3575
		mu 0 4 1933 306 1871 956
		f 4 541 1758 -3578 3576
		mu 0 4 1873 308 1937 957
		f 4 1759 -606 -3579 3577
		mu 0 4 1937 341 1938 957
		f 4 -605 -1758 -3580 3578
		mu 0 4 1938 340 1935 957
		f 4 -1757 540 -3577 3579
		mu 0 4 1935 307 1873 957
		f 4 543 1760 -3582 3580
		mu 0 4 1875 309 1939 958
		f 4 1761 -608 -3583 3581
		mu 0 4 1939 342 1940 958
		f 4 -607 -1760 -3584 3582
		mu 0 4 1940 341 1937 958
		f 4 -1759 542 -3581 3583
		mu 0 4 1937 308 1875 958
		f 4 545 1762 -3586 3584
		mu 0 4 1877 310 1941 959
		f 4 1763 -610 -3587 3585
		mu 0 4 1941 343 1942 959
		f 4 -609 -1762 -3588 3586
		mu 0 4 1942 342 1939 959
		f 4 -1761 544 -3585 3587
		mu 0 4 1939 309 1877 959
		f 4 547 1764 -3590 3588
		mu 0 4 1879 311 1943 960
		f 4 1765 -612 -3591 3589
		mu 0 4 1943 344 1944 960
		f 4 -611 -1764 -3592 3590
		mu 0 4 1944 343 1941 960
		f 4 -1763 546 -3589 3591
		mu 0 4 1941 310 1879 960
		f 4 549 1766 -3594 3592
		mu 0 4 1881 312 1945 961
		f 4 1767 -614 -3595 3593
		mu 0 4 1945 345 1946 961
		f 4 -613 -1766 -3596 3594
		mu 0 4 1946 344 1943 961
		f 4 -1765 548 -3593 3595
		mu 0 4 1943 311 1881 961
		f 4 551 1768 -3598 3596
		mu 0 4 1883 313 1947 962
		f 4 1769 -616 -3599 3597
		mu 0 4 1947 346 1948 962
		f 4 -615 -1768 -3600 3598
		mu 0 4 1948 345 1945 962
		f 4 -1767 550 -3597 3599
		mu 0 4 1945 312 1883 962
		f 4 553 1770 -3602 3600
		mu 0 4 1885 314 1949 963
		f 4 1771 -618 -3603 3601
		mu 0 4 1949 347 1950 963
		f 4 -617 -1770 -3604 3602
		mu 0 4 1950 346 1947 963
		f 4 -1769 552 -3601 3603
		mu 0 4 1947 313 1885 963
		f 4 555 1772 -3606 3604
		mu 0 4 1887 315 1951 964
		f 4 1773 -620 -3607 3605
		mu 0 4 1951 348 1952 964
		f 4 -619 -1772 -3608 3606
		mu 0 4 1952 347 1949 964
		f 4 -1771 554 -3605 3607
		mu 0 4 1949 314 1887 964
		f 4 557 1774 -3610 3608
		mu 0 4 1889 316 1953 965
		f 4 1775 -622 -3611 3609
		mu 0 4 1953 349 1954 965
		f 4 -621 -1774 -3612 3610
		mu 0 4 1954 348 1951 965
		f 4 -1773 556 -3609 3611
		mu 0 4 1951 315 1889 965
		f 4 559 1776 -3614 3612
		mu 0 4 1891 317 1955 966
		f 4 1777 -624 -3615 3613
		mu 0 4 1955 350 1956 966
		f 4 -623 -1776 -3616 3614
		mu 0 4 1956 349 1953 966
		f 4 -1775 558 -3613 3615
		mu 0 4 1953 316 1891 966
		f 4 561 1778 -3618 3616
		mu 0 4 1893 318 1957 967
		f 4 1779 -626 -3619 3617
		mu 0 4 1957 351 1958 967
		f 4 -625 -1778 -3620 3618
		mu 0 4 1958 350 1955 967
		f 4 -1777 560 -3617 3619
		mu 0 4 1955 317 1893 967
		f 4 563 1780 -3622 3620
		mu 0 4 1895 319 1959 968
		f 4 1781 -628 -3623 3621
		mu 0 4 1959 352 1960 968
		f 4 -627 -1780 -3624 3622
		mu 0 4 1960 351 1957 968
		f 4 -1779 562 -3621 3623
		mu 0 4 1957 318 1895 968
		f 4 565 1782 -3626 3624
		mu 0 4 1897 320 1961 969
		f 4 1783 -630 -3627 3625
		mu 0 4 1961 353 1962 969
		f 4 -629 -1782 -3628 3626
		mu 0 4 1962 352 1959 969
		f 4 -1781 564 -3625 3627
		mu 0 4 1959 319 1897 969
		f 4 567 1784 -3630 3628
		mu 0 4 1899 321 1963 970
		f 4 1785 -632 -3631 3629
		mu 0 4 1963 354 1964 970
		f 4 -631 -1784 -3632 3630
		mu 0 4 1964 353 1961 970
		f 4 -1783 566 -3629 3631
		mu 0 4 1961 320 1899 970
		f 4 569 1786 -3634 3632
		mu 0 4 1901 322 1965 971
		f 4 1787 -634 -3635 3633
		mu 0 4 1965 355 1966 971
		f 4 -633 -1786 -3636 3634
		mu 0 4 1966 354 1963 971
		f 4 -1785 568 -3633 3635
		mu 0 4 1963 321 1901 971
		f 4 571 1788 -3638 3636
		mu 0 4 1903 323 1967 972
		f 4 1789 -636 -3639 3637
		mu 0 4 1967 356 1968 972
		f 4 -635 -1788 -3640 3638
		mu 0 4 1968 355 1965 972
		f 4 -1787 570 -3637 3639
		mu 0 4 1965 322 1903 972
		f 4 573 1790 -3642 3640
		mu 0 4 1905 324 1969 973
		f 4 1791 -638 -3643 3641
		mu 0 4 1969 357 1970 973
		f 4 -637 -1790 -3644 3642
		mu 0 4 1970 356 1967 973
		f 4 -1789 572 -3641 3643
		mu 0 4 1967 323 1905 973
		f 4 575 1728 -3646 3644
		mu 0 4 1907 325 1971 974
		f 4 1729 -640 -3647 3645
		mu 0 4 1971 358 1972 974
		f 4 -639 -1792 -3648 3646
		mu 0 4 1972 357 1969 974
		f 4 -1791 574 -3645 3647
		mu 0 4 1969 324 1907 974
		f 4 577 1794 -3650 3648
		mu 0 4 1909 327 1973 975
		f 4 1795 -642 -3651 3649
		mu 0 4 1973 360 1974 975
		f 4 -641 -1794 -3652 3650
		mu 0 4 1974 359 1975 975
		f 4 -1793 576 -3649 3651
		mu 0 4 1975 326 1909 975
		f 4 579 1796 -3654 3652
		mu 0 4 1912 328 1976 976
		f 4 1797 -644 -3655 3653
		mu 0 4 1976 361 1977 976
		f 4 -643 -1796 -3656 3654
		mu 0 4 1977 360 1973 976
		f 4 -1795 578 -3653 3655
		mu 0 4 1973 327 1912 976
		f 4 581 1798 -3658 3656
		mu 0 4 1914 329 1978 977
		f 4 1799 -646 -3659 3657
		mu 0 4 1978 362 1979 977
		f 4 -645 -1798 -3660 3658
		mu 0 4 1979 361 1976 977
		f 4 -1797 580 -3657 3659
		mu 0 4 1976 328 1914 977
		f 4 583 1800 -3662 3660
		mu 0 4 1916 330 1980 978
		f 4 1801 -648 -3663 3661
		mu 0 4 1980 363 1981 978
		f 4 -647 -1800 -3664 3662
		mu 0 4 1981 362 1978 978
		f 4 -1799 582 -3661 3663
		mu 0 4 1978 329 1916 978
		f 4 585 1802 -3666 3664
		mu 0 4 1918 331 1982 979
		f 4 1803 -650 -3667 3665
		mu 0 4 1982 364 1983 979
		f 4 -649 -1802 -3668 3666
		mu 0 4 1983 363 1980 979
		f 4 -1801 584 -3665 3667
		mu 0 4 1980 330 1918 979
		f 4 587 1804 -3670 3668
		mu 0 4 1920 332 1984 980
		f 4 1805 -652 -3671 3669
		mu 0 4 1984 365 1985 980
		f 4 -651 -1804 -3672 3670
		mu 0 4 1985 364 1982 980
		f 4 -1803 586 -3669 3671
		mu 0 4 1982 331 1920 980
		f 4 589 1806 -3674 3672
		mu 0 4 1922 333 1986 981
		f 4 1807 -654 -3675 3673
		mu 0 4 1986 366 1987 981
		f 4 -653 -1806 -3676 3674
		mu 0 4 1987 365 1984 981
		f 4 -1805 588 -3673 3675
		mu 0 4 1984 332 1922 981
		f 4 591 1808 -3678 3676
		mu 0 4 1924 334 1988 982
		f 4 1809 -656 -3679 3677
		mu 0 4 1988 367 1989 982
		f 4 -655 -1808 -3680 3678
		mu 0 4 1989 366 1986 982
		f 4 -1807 590 -3677 3679
		mu 0 4 1986 333 1924 982
		f 4 593 1810 -3682 3680
		mu 0 4 1926 335 1990 983
		f 4 1811 -658 -3683 3681
		mu 0 4 1990 368 1991 983
		f 4 -657 -1810 -3684 3682
		mu 0 4 1991 367 1988 983
		f 4 -1809 592 -3681 3683
		mu 0 4 1988 334 1926 983
		f 4 595 1812 -3686 3684
		mu 0 4 1928 336 1992 984
		f 4 1813 -660 -3687 3685
		mu 0 4 1992 369 1993 984
		f 4 -659 -1812 -3688 3686
		mu 0 4 1993 368 1990 984
		f 4 -1811 594 -3685 3687
		mu 0 4 1990 335 1928 984
		f 4 597 1814 -3690 3688
		mu 0 4 1930 337 1994 985
		f 4 1815 -662 -3691 3689
		mu 0 4 1994 370 1995 985
		f 4 -661 -1814 -3692 3690
		mu 0 4 1995 369 1992 985
		f 4 -1813 596 -3689 3691
		mu 0 4 1992 336 1930 985
		f 4 599 1816 -3694 3692
		mu 0 4 1932 338 1996 986
		f 4 1817 -664 -3695 3693
		mu 0 4 1996 371 1997 986
		f 4 -663 -1816 -3696 3694
		mu 0 4 1997 370 1994 986
		f 4 -1815 598 -3693 3695
		mu 0 4 1994 337 1932 986
		f 4 601 1818 -3698 3696
		mu 0 4 1934 339 1998 987
		f 4 1819 -666 -3699 3697
		mu 0 4 1998 372 1999 987
		f 4 -665 -1818 -3700 3698
		mu 0 4 1999 371 1996 987
		f 4 -1817 600 -3697 3699
		mu 0 4 1996 338 1934 987
		f 4 603 1820 -3702 3700
		mu 0 4 1936 340 2000 988
		f 4 1821 -668 -3703 3701
		mu 0 4 2000 373 2001 988
		f 4 -667 -1820 -3704 3702
		mu 0 4 2001 372 1998 988
		f 4 -1819 602 -3701 3703
		mu 0 4 1998 339 1936 988
		f 4 605 1822 -3706 3704
		mu 0 4 1938 341 2002 989
		f 4 1823 -670 -3707 3705
		mu 0 4 2002 374 2003 989
		f 4 -669 -1822 -3708 3706
		mu 0 4 2003 373 2000 989
		f 4 -1821 604 -3705 3707
		mu 0 4 2000 340 1938 989
		f 4 607 1824 -3710 3708
		mu 0 4 1940 342 2004 990
		f 4 1825 -672 -3711 3709
		mu 0 4 2004 375 2005 990
		f 4 -671 -1824 -3712 3710
		mu 0 4 2005 374 2002 990
		f 4 -1823 606 -3709 3711
		mu 0 4 2002 341 1940 990
		f 4 609 1826 -3714 3712
		mu 0 4 1942 343 2006 991
		f 4 1827 -674 -3715 3713
		mu 0 4 2006 376 2007 991
		f 4 -673 -1826 -3716 3714
		mu 0 4 2007 375 2004 991
		f 4 -1825 608 -3713 3715
		mu 0 4 2004 342 1942 991
		f 4 611 1828 -3718 3716
		mu 0 4 1944 344 2008 992
		f 4 1829 -676 -3719 3717
		mu 0 4 2008 377 2009 992
		f 4 -675 -1828 -3720 3718
		mu 0 4 2009 376 2006 992
		f 4 -1827 610 -3717 3719
		mu 0 4 2006 343 1944 992
		f 4 613 1830 -3722 3720
		mu 0 4 1946 345 2010 993
		f 4 1831 -678 -3723 3721
		mu 0 4 2010 378 2011 993
		f 4 -677 -1830 -3724 3722
		mu 0 4 2011 377 2008 993
		f 4 -1829 612 -3721 3723
		mu 0 4 2008 344 1946 993
		f 4 615 1832 -3726 3724
		mu 0 4 1948 346 2012 994
		f 4 1833 -680 -3727 3725
		mu 0 4 2012 379 2013 994
		f 4 -679 -1832 -3728 3726
		mu 0 4 2013 378 2010 994
		f 4 -1831 614 -3725 3727
		mu 0 4 2010 345 1948 994
		f 4 617 1834 -3730 3728
		mu 0 4 1950 347 2014 995
		f 4 1835 -682 -3731 3729
		mu 0 4 2014 380 2015 995
		f 4 -681 -1834 -3732 3730
		mu 0 4 2015 379 2012 995
		f 4 -1833 616 -3729 3731
		mu 0 4 2012 346 1950 995
		f 4 619 1836 -3734 3732
		mu 0 4 1952 348 2016 996
		f 4 1837 -684 -3735 3733
		mu 0 4 2016 381 2017 996
		f 4 -683 -1836 -3736 3734
		mu 0 4 2017 380 2014 996
		f 4 -1835 618 -3733 3735
		mu 0 4 2014 347 1952 996
		f 4 621 1838 -3738 3736
		mu 0 4 1954 349 2018 997
		f 4 1839 -686 -3739 3737
		mu 0 4 2018 382 2019 997
		f 4 -685 -1838 -3740 3738
		mu 0 4 2019 381 2016 997
		f 4 -1837 620 -3737 3739
		mu 0 4 2016 348 1954 997
		f 4 623 1840 -3742 3740
		mu 0 4 1956 350 2020 998
		f 4 1841 -688 -3743 3741
		mu 0 4 2020 383 2021 998
		f 4 -687 -1840 -3744 3742
		mu 0 4 2021 382 2018 998
		f 4 -1839 622 -3741 3743
		mu 0 4 2018 349 1956 998
		f 4 625 1842 -3746 3744
		mu 0 4 1958 351 2022 999
		f 4 1843 -690 -3747 3745
		mu 0 4 2022 384 2023 999
		f 4 -689 -1842 -3748 3746
		mu 0 4 2023 383 2020 999
		f 4 -1841 624 -3745 3747
		mu 0 4 2020 350 1958 999
		f 4 627 1844 -3750 3748
		mu 0 4 1960 352 2024 1000
		f 4 1845 -692 -3751 3749
		mu 0 4 2024 385 2025 1000
		f 4 -691 -1844 -3752 3750
		mu 0 4 2025 384 2022 1000
		f 4 -1843 626 -3749 3751
		mu 0 4 2022 351 1960 1000
		f 4 629 1846 -3754 3752
		mu 0 4 1962 353 2026 1001
		f 4 1847 -694 -3755 3753
		mu 0 4 2026 386 2027 1001
		f 4 -693 -1846 -3756 3754
		mu 0 4 2027 385 2024 1001
		f 4 -1845 628 -3753 3755
		mu 0 4 2024 352 1962 1001
		f 4 631 1848 -3758 3756
		mu 0 4 1964 354 2028 1002
		f 4 1849 -696 -3759 3757
		mu 0 4 2028 387 2029 1002
		f 4 -695 -1848 -3760 3758
		mu 0 4 2029 386 2026 1002
		f 4 -1847 630 -3757 3759
		mu 0 4 2026 353 1964 1002
		f 4 633 1850 -3762 3760
		mu 0 4 1966 355 2030 1003
		f 4 1851 -698 -3763 3761
		mu 0 4 2030 388 2031 1003
		f 4 -697 -1850 -3764 3762
		mu 0 4 2031 387 2028 1003
		f 4 -1849 632 -3761 3763
		mu 0 4 2028 354 1966 1003
		f 4 635 1852 -3766 3764
		mu 0 4 1968 356 2032 1004
		f 4 1853 -700 -3767 3765
		mu 0 4 2032 389 2033 1004
		f 4 -699 -1852 -3768 3766
		mu 0 4 2033 388 2030 1004
		f 4 -1851 634 -3765 3767
		mu 0 4 2030 355 1968 1004
		f 4 637 1854 -3770 3768
		mu 0 4 1970 357 2034 1005
		f 4 1855 -702 -3771 3769
		mu 0 4 2034 390 2035 1005
		f 4 -701 -1854 -3772 3770
		mu 0 4 2035 389 2032 1005
		f 4 -1853 636 -3769 3771
		mu 0 4 2032 356 1970 1005
		f 4 639 1792 -3774 3772
		mu 0 4 1972 358 2036 1006
		f 4 1793 -704 -3775 3773
		mu 0 4 2036 391 2037 1006
		f 4 -703 -1856 -3776 3774
		mu 0 4 2037 390 2034 1006
		f 4 -1855 638 -3773 3775
		mu 0 4 2034 357 1972 1006
		f 4 641 1858 -3778 3776
		mu 0 4 1974 360 2038 1007
		f 4 1859 -706 -3779 3777
		mu 0 4 2038 393 2039 1007
		f 4 -705 -1858 -3780 3778
		mu 0 4 2039 392 2040 1007
		f 4 -1857 640 -3777 3779
		mu 0 4 2040 359 1974 1007
		f 4 643 1860 -3782 3780
		mu 0 4 1977 361 2041 1008
		f 4 1861 -708 -3783 3781
		mu 0 4 2041 394 2042 1008
		f 4 -707 -1860 -3784 3782
		mu 0 4 2042 393 2038 1008
		f 4 -1859 642 -3781 3783
		mu 0 4 2038 360 1977 1008
		f 4 645 1862 -3786 3784
		mu 0 4 1979 362 2043 1009
		f 4 1863 -710 -3787 3785
		mu 0 4 2043 395 2044 1009
		f 4 -709 -1862 -3788 3786
		mu 0 4 2044 394 2041 1009
		f 4 -1861 644 -3785 3787
		mu 0 4 2041 361 1979 1009
		f 4 647 1864 -3790 3788
		mu 0 4 1981 363 2045 1010
		f 4 1865 -712 -3791 3789
		mu 0 4 2045 396 2046 1010
		f 4 -711 -1864 -3792 3790
		mu 0 4 2046 395 2043 1010
		f 4 -1863 646 -3789 3791
		mu 0 4 2043 362 1981 1010
		f 4 649 1866 -3794 3792
		mu 0 4 1983 364 2047 1011
		f 4 1867 -714 -3795 3793
		mu 0 4 2047 397 2048 1011
		f 4 -713 -1866 -3796 3794
		mu 0 4 2048 396 2045 1011
		f 4 -1865 648 -3793 3795
		mu 0 4 2045 363 1983 1011
		f 4 651 1868 -3798 3796
		mu 0 4 1985 365 2049 1012
		f 4 1869 -716 -3799 3797
		mu 0 4 2049 398 2050 1012
		f 4 -715 -1868 -3800 3798
		mu 0 4 2050 397 2047 1012
		f 4 -1867 650 -3797 3799
		mu 0 4 2047 364 1985 1012
		f 4 653 1870 -3802 3800
		mu 0 4 1987 366 2051 1013
		f 4 1871 -718 -3803 3801
		mu 0 4 2051 399 2052 1013
		f 4 -717 -1870 -3804 3802
		mu 0 4 2052 398 2049 1013
		f 4 -1869 652 -3801 3803
		mu 0 4 2049 365 1987 1013
		f 4 655 1872 -3806 3804
		mu 0 4 1989 367 2053 1014
		f 4 1873 -720 -3807 3805
		mu 0 4 2053 400 2054 1014
		f 4 -719 -1872 -3808 3806
		mu 0 4 2054 399 2051 1014
		f 4 -1871 654 -3805 3807
		mu 0 4 2051 366 1989 1014
		f 4 657 1874 -3810 3808
		mu 0 4 1991 368 2055 1015
		f 4 1875 -722 -3811 3809
		mu 0 4 2055 401 2056 1015
		f 4 -721 -1874 -3812 3810
		mu 0 4 2056 400 2053 1015
		f 4 -1873 656 -3809 3811
		mu 0 4 2053 367 1991 1015
		f 4 659 1876 -3814 3812
		mu 0 4 1993 369 2057 1016
		f 4 1877 -724 -3815 3813
		mu 0 4 2057 402 2058 1016
		f 4 -723 -1876 -3816 3814
		mu 0 4 2058 401 2055 1016
		f 4 -1875 658 -3813 3815
		mu 0 4 2055 368 1993 1016
		f 4 661 1878 -3818 3816
		mu 0 4 1995 370 2059 1017
		f 4 1879 -726 -3819 3817
		mu 0 4 2059 403 2060 1017
		f 4 -725 -1878 -3820 3818
		mu 0 4 2060 402 2057 1017
		f 4 -1877 660 -3817 3819
		mu 0 4 2057 369 1995 1017
		f 4 663 1880 -3822 3820
		mu 0 4 1997 371 2061 1018
		f 4 1881 -728 -3823 3821
		mu 0 4 2061 404 2062 1018
		f 4 -727 -1880 -3824 3822
		mu 0 4 2062 403 2059 1018
		f 4 -1879 662 -3821 3823
		mu 0 4 2059 370 1997 1018
		f 4 665 1882 -3826 3824
		mu 0 4 1999 372 2063 1019
		f 4 1883 -730 -3827 3825
		mu 0 4 2063 405 2064 1019
		f 4 -729 -1882 -3828 3826
		mu 0 4 2064 404 2061 1019
		f 4 -1881 664 -3825 3827
		mu 0 4 2061 371 1999 1019
		f 4 667 1884 -3830 3828
		mu 0 4 2001 373 2065 1020
		f 4 1885 -732 -3831 3829
		mu 0 4 2065 406 2066 1020
		f 4 -731 -1884 -3832 3830
		mu 0 4 2066 405 2063 1020
		f 4 -1883 666 -3829 3831
		mu 0 4 2063 372 2001 1020
		f 4 669 1886 -3834 3832
		mu 0 4 2003 374 2067 1021
		f 4 1887 -734 -3835 3833
		mu 0 4 2067 407 2068 1021
		f 4 -733 -1886 -3836 3834
		mu 0 4 2068 406 2065 1021
		f 4 -1885 668 -3833 3835
		mu 0 4 2065 373 2003 1021
		f 4 671 1888 -3838 3836
		mu 0 4 2005 375 2069 1022
		f 4 1889 -736 -3839 3837
		mu 0 4 2069 408 2070 1022
		f 4 -735 -1888 -3840 3838
		mu 0 4 2070 407 2067 1022
		f 4 -1887 670 -3837 3839
		mu 0 4 2067 374 2005 1022
		f 4 673 1890 -3842 3840
		mu 0 4 2007 376 2071 1023
		f 4 1891 -738 -3843 3841
		mu 0 4 2071 409 2072 1023
		f 4 -737 -1890 -3844 3842
		mu 0 4 2072 408 2069 1023
		f 4 -1889 672 -3841 3843
		mu 0 4 2069 375 2007 1023
		f 4 675 1892 -3846 3844
		mu 0 4 2009 377 2073 1024
		f 4 1893 -740 -3847 3845
		mu 0 4 2073 410 2074 1024
		f 4 -739 -1892 -3848 3846
		mu 0 4 2074 409 2071 1024
		f 4 -1891 674 -3845 3847
		mu 0 4 2071 376 2009 1024
		f 4 677 1894 -3850 3848
		mu 0 4 2011 378 2075 1025
		f 4 1895 -742 -3851 3849
		mu 0 4 2075 411 2076 1025
		f 4 -741 -1894 -3852 3850
		mu 0 4 2076 410 2073 1025
		f 4 -1893 676 -3849 3851
		mu 0 4 2073 377 2011 1025
		f 4 679 1896 -3854 3852
		mu 0 4 2013 379 2077 1026
		f 4 1897 -744 -3855 3853
		mu 0 4 2077 412 2078 1026
		f 4 -743 -1896 -3856 3854
		mu 0 4 2078 411 2075 1026
		f 4 -1895 678 -3853 3855
		mu 0 4 2075 378 2013 1026
		f 4 681 1898 -3858 3856
		mu 0 4 2015 380 2079 1027
		f 4 1899 -746 -3859 3857
		mu 0 4 2079 413 2080 1027
		f 4 -745 -1898 -3860 3858
		mu 0 4 2080 412 2077 1027
		f 4 -1897 680 -3857 3859
		mu 0 4 2077 379 2015 1027
		f 4 683 1900 -3862 3860
		mu 0 4 2017 381 2081 1028
		f 4 1901 -748 -3863 3861
		mu 0 4 2081 414 2082 1028
		f 4 -747 -1900 -3864 3862
		mu 0 4 2082 413 2079 1028
		f 4 -1899 682 -3861 3863
		mu 0 4 2079 380 2017 1028
		f 4 685 1902 -3866 3864
		mu 0 4 2019 382 2083 1029
		f 4 1903 -750 -3867 3865
		mu 0 4 2083 415 2084 1029
		f 4 -749 -1902 -3868 3866
		mu 0 4 2084 414 2081 1029
		f 4 -1901 684 -3865 3867
		mu 0 4 2081 381 2019 1029
		f 4 687 1904 -3870 3868
		mu 0 4 2021 383 2085 1030
		f 4 1905 -752 -3871 3869
		mu 0 4 2085 416 2086 1030
		f 4 -751 -1904 -3872 3870
		mu 0 4 2086 415 2083 1030
		f 4 -1903 686 -3869 3871
		mu 0 4 2083 382 2021 1030
		f 4 689 1906 -3874 3872
		mu 0 4 2023 384 2087 1031
		f 4 1907 -754 -3875 3873
		mu 0 4 2087 417 2088 1031
		f 4 -753 -1906 -3876 3874
		mu 0 4 2088 416 2085 1031
		f 4 -1905 688 -3873 3875
		mu 0 4 2085 383 2023 1031
		f 4 691 1908 -3878 3876
		mu 0 4 2025 385 2089 1032
		f 4 1909 -756 -3879 3877
		mu 0 4 2089 418 2090 1032
		f 4 -755 -1908 -3880 3878
		mu 0 4 2090 417 2087 1032
		f 4 -1907 690 -3877 3879
		mu 0 4 2087 384 2025 1032
		f 4 693 1910 -3882 3880
		mu 0 4 2027 386 2091 1033
		f 4 1911 -758 -3883 3881
		mu 0 4 2091 419 2092 1033
		f 4 -757 -1910 -3884 3882
		mu 0 4 2092 418 2089 1033
		f 4 -1909 692 -3881 3883
		mu 0 4 2089 385 2027 1033
		f 4 695 1912 -3886 3884
		mu 0 4 2029 387 2093 1034
		f 4 1913 -760 -3887 3885
		mu 0 4 2093 420 2094 1034
		f 4 -759 -1912 -3888 3886
		mu 0 4 2094 419 2091 1034
		f 4 -1911 694 -3885 3887
		mu 0 4 2091 386 2029 1034
		f 4 697 1914 -3890 3888
		mu 0 4 2031 388 2095 1035
		f 4 1915 -762 -3891 3889
		mu 0 4 2095 421 2096 1035
		f 4 -761 -1914 -3892 3890
		mu 0 4 2096 420 2093 1035
		f 4 -1913 696 -3889 3891
		mu 0 4 2093 387 2031 1035
		f 4 699 1916 -3894 3892
		mu 0 4 2033 389 2097 1036
		f 4 1917 -764 -3895 3893
		mu 0 4 2097 422 2098 1036
		f 4 -763 -1916 -3896 3894
		mu 0 4 2098 421 2095 1036
		f 4 -1915 698 -3893 3895
		mu 0 4 2095 388 2033 1036
		f 4 701 1918 -3898 3896
		mu 0 4 2035 390 2099 1037
		f 4 1919 -766 -3899 3897
		mu 0 4 2099 423 2100 1037
		f 4 -765 -1918 -3900 3898
		mu 0 4 2100 422 2097 1037
		f 4 -1917 700 -3897 3899
		mu 0 4 2097 389 2035 1037
		f 4 703 1856 -3902 3900
		mu 0 4 2037 391 2101 1038
		f 4 1857 -768 -3903 3901
		mu 0 4 2101 424 2102 1038
		f 4 -767 -1920 -3904 3902
		mu 0 4 2102 423 2099 1038
		f 4 -1919 702 -3901 3903
		mu 0 4 2099 390 2037 1038
		f 4 705 1922 -3906 3904
		mu 0 4 2039 393 2103 1039
		f 4 1923 -770 -3907 3905
		mu 0 4 2103 426 2104 1039
		f 4 -769 -1922 -3908 3906
		mu 0 4 2104 425 2105 1039
		f 4 -1921 704 -3905 3907
		mu 0 4 2105 392 2039 1039
		f 4 707 1924 -3910 3908
		mu 0 4 2042 394 2106 1040
		f 4 1925 -772 -3911 3909
		mu 0 4 2106 427 2107 1040
		f 4 -771 -1924 -3912 3910
		mu 0 4 2107 426 2103 1040
		f 4 -1923 706 -3909 3911
		mu 0 4 2103 393 2042 1040
		f 4 709 1926 -3914 3912
		mu 0 4 2044 395 2108 1041
		f 4 1927 -774 -3915 3913
		mu 0 4 2108 428 2109 1041
		f 4 -773 -1926 -3916 3914
		mu 0 4 2109 427 2106 1041
		f 4 -1925 708 -3913 3915
		mu 0 4 2106 394 2044 1041
		f 4 711 1928 -3918 3916
		mu 0 4 2046 396 2110 1042
		f 4 1929 -776 -3919 3917
		mu 0 4 2110 429 2111 1042
		f 4 -775 -1928 -3920 3918
		mu 0 4 2111 428 2108 1042
		f 4 -1927 710 -3917 3919
		mu 0 4 2108 395 2046 1042
		f 4 713 1930 -3922 3920
		mu 0 4 2048 397 2112 1043
		f 4 1931 -778 -3923 3921
		mu 0 4 2112 430 2113 1043
		f 4 -777 -1930 -3924 3922
		mu 0 4 2113 429 2110 1043
		f 4 -1929 712 -3921 3923
		mu 0 4 2110 396 2048 1043
		f 4 715 1932 -3926 3924
		mu 0 4 2050 398 2114 1044
		f 4 1933 -780 -3927 3925
		mu 0 4 2114 431 2115 1044
		f 4 -779 -1932 -3928 3926
		mu 0 4 2115 430 2112 1044
		f 4 -1931 714 -3925 3927
		mu 0 4 2112 397 2050 1044
		f 4 717 1934 -3930 3928
		mu 0 4 2052 399 2116 1045
		f 4 1935 -782 -3931 3929
		mu 0 4 2116 432 2117 1045
		f 4 -781 -1934 -3932 3930
		mu 0 4 2117 431 2114 1045
		f 4 -1933 716 -3929 3931
		mu 0 4 2114 398 2052 1045
		f 4 719 1936 -3934 3932
		mu 0 4 2054 400 2118 1046
		f 4 1937 -784 -3935 3933
		mu 0 4 2118 433 2119 1046
		f 4 -783 -1936 -3936 3934
		mu 0 4 2119 432 2116 1046
		f 4 -1935 718 -3933 3935
		mu 0 4 2116 399 2054 1046
		f 4 721 1938 -3938 3936
		mu 0 4 2056 401 2120 1047
		f 4 1939 -786 -3939 3937
		mu 0 4 2120 434 2121 1047
		f 4 -785 -1938 -3940 3938
		mu 0 4 2121 433 2118 1047
		f 4 -1937 720 -3937 3939
		mu 0 4 2118 400 2056 1047
		f 4 723 1940 -3942 3940
		mu 0 4 2058 402 2122 1048
		f 4 1941 -788 -3943 3941
		mu 0 4 2122 435 2123 1048
		f 4 -787 -1940 -3944 3942
		mu 0 4 2123 434 2120 1048
		f 4 -1939 722 -3941 3943
		mu 0 4 2120 401 2058 1048
		f 4 725 1942 -3946 3944
		mu 0 4 2060 403 2124 1049
		f 4 1943 -790 -3947 3945
		mu 0 4 2124 436 2125 1049
		f 4 -789 -1942 -3948 3946
		mu 0 4 2125 435 2122 1049
		f 4 -1941 724 -3945 3947
		mu 0 4 2122 402 2060 1049
		f 4 727 1944 -3950 3948
		mu 0 4 2062 404 2126 1050
		f 4 1945 -792 -3951 3949
		mu 0 4 2126 437 2127 1050
		f 4 -791 -1944 -3952 3950
		mu 0 4 2127 436 2124 1050
		f 4 -1943 726 -3949 3951
		mu 0 4 2124 403 2062 1050
		f 4 729 1946 -3954 3952
		mu 0 4 2064 405 2128 1051
		f 4 1947 -794 -3955 3953
		mu 0 4 2128 438 2129 1051
		f 4 -793 -1946 -3956 3954
		mu 0 4 2129 437 2126 1051
		f 4 -1945 728 -3953 3955
		mu 0 4 2126 404 2064 1051
		f 4 731 1948 -3958 3956
		mu 0 4 2066 406 2130 1052
		f 4 1949 -796 -3959 3957
		mu 0 4 2130 439 2131 1052
		f 4 -795 -1948 -3960 3958
		mu 0 4 2131 438 2128 1052
		f 4 -1947 730 -3957 3959
		mu 0 4 2128 405 2066 1052
		f 4 733 1950 -3962 3960
		mu 0 4 2068 407 2132 1053
		f 4 1951 -798 -3963 3961
		mu 0 4 2132 440 2133 1053
		f 4 -797 -1950 -3964 3962
		mu 0 4 2133 439 2130 1053
		f 4 -1949 732 -3961 3963
		mu 0 4 2130 406 2068 1053
		f 4 735 1952 -3966 3964
		mu 0 4 2070 408 2134 1054
		f 4 1953 -800 -3967 3965
		mu 0 4 2134 441 2135 1054
		f 4 -799 -1952 -3968 3966
		mu 0 4 2135 440 2132 1054
		f 4 -1951 734 -3965 3967
		mu 0 4 2132 407 2070 1054
		f 4 737 1954 -3970 3968
		mu 0 4 2072 409 2136 1055
		f 4 1955 -802 -3971 3969
		mu 0 4 2136 442 2137 1055
		f 4 -801 -1954 -3972 3970
		mu 0 4 2137 441 2134 1055
		f 4 -1953 736 -3969 3971
		mu 0 4 2134 408 2072 1055
		f 4 739 1956 -3974 3972
		mu 0 4 2074 410 2138 1056
		f 4 1957 -804 -3975 3973
		mu 0 4 2138 443 2139 1056
		f 4 -803 -1956 -3976 3974
		mu 0 4 2139 442 2136 1056
		f 4 -1955 738 -3973 3975
		mu 0 4 2136 409 2074 1056
		f 4 741 1958 -3978 3976
		mu 0 4 2076 411 2140 1057
		f 4 1959 -806 -3979 3977
		mu 0 4 2140 444 2141 1057
		f 4 -805 -1958 -3980 3978
		mu 0 4 2141 443 2138 1057
		f 4 -1957 740 -3977 3979
		mu 0 4 2138 410 2076 1057
		f 4 743 1960 -3982 3980
		mu 0 4 2078 412 2142 1058
		f 4 1961 -808 -3983 3981
		mu 0 4 2142 445 2143 1058
		f 4 -807 -1960 -3984 3982
		mu 0 4 2143 444 2140 1058
		f 4 -1959 742 -3981 3983
		mu 0 4 2140 411 2078 1058
		f 4 745 1962 -3986 3984
		mu 0 4 2080 413 2144 1059
		f 4 1963 -810 -3987 3985
		mu 0 4 2144 446 2145 1059
		f 4 -809 -1962 -3988 3986
		mu 0 4 2145 445 2142 1059
		f 4 -1961 744 -3985 3987
		mu 0 4 2142 412 2080 1059
		f 4 747 1964 -3990 3988
		mu 0 4 2082 414 2146 1060
		f 4 1965 -812 -3991 3989
		mu 0 4 2146 447 2147 1060
		f 4 -811 -1964 -3992 3990
		mu 0 4 2147 446 2144 1060
		f 4 -1963 746 -3989 3991
		mu 0 4 2144 413 2082 1060
		f 4 749 1966 -3994 3992
		mu 0 4 2084 415 2148 1061
		f 4 1967 -814 -3995 3993
		mu 0 4 2148 448 2149 1061
		f 4 -813 -1966 -3996 3994
		mu 0 4 2149 447 2146 1061
		f 4 -1965 748 -3993 3995
		mu 0 4 2146 414 2084 1061;
	setAttr ".fc[1500:1999]"
		f 4 751 1968 -3998 3996
		mu 0 4 2086 416 2150 1062
		f 4 1969 -816 -3999 3997
		mu 0 4 2150 449 2151 1062
		f 4 -815 -1968 -4000 3998
		mu 0 4 2151 448 2148 1062
		f 4 -1967 750 -3997 3999
		mu 0 4 2148 415 2086 1062
		f 4 753 1970 -4002 4000
		mu 0 4 2088 417 2152 1063
		f 4 1971 -818 -4003 4001
		mu 0 4 2152 450 2153 1063
		f 4 -817 -1970 -4004 4002
		mu 0 4 2153 449 2150 1063
		f 4 -1969 752 -4001 4003
		mu 0 4 2150 416 2088 1063
		f 4 755 1972 -4006 4004
		mu 0 4 2090 418 2154 1064
		f 4 1973 -820 -4007 4005
		mu 0 4 2154 451 2155 1064
		f 4 -819 -1972 -4008 4006
		mu 0 4 2155 450 2152 1064
		f 4 -1971 754 -4005 4007
		mu 0 4 2152 417 2090 1064
		f 4 757 1974 -4010 4008
		mu 0 4 2092 419 2156 1065
		f 4 1975 -822 -4011 4009
		mu 0 4 2156 452 2157 1065
		f 4 -821 -1974 -4012 4010
		mu 0 4 2157 451 2154 1065
		f 4 -1973 756 -4009 4011
		mu 0 4 2154 418 2092 1065
		f 4 759 1976 -4014 4012
		mu 0 4 2094 420 2158 1066
		f 4 1977 -824 -4015 4013
		mu 0 4 2158 453 2159 1066
		f 4 -823 -1976 -4016 4014
		mu 0 4 2159 452 2156 1066
		f 4 -1975 758 -4013 4015
		mu 0 4 2156 419 2094 1066
		f 4 761 1978 -4018 4016
		mu 0 4 2096 421 2160 1067
		f 4 1979 -826 -4019 4017
		mu 0 4 2160 454 2161 1067
		f 4 -825 -1978 -4020 4018
		mu 0 4 2161 453 2158 1067
		f 4 -1977 760 -4017 4019
		mu 0 4 2158 420 2096 1067
		f 4 763 1980 -4022 4020
		mu 0 4 2098 422 2162 1068
		f 4 1981 -828 -4023 4021
		mu 0 4 2162 455 2163 1068
		f 4 -827 -1980 -4024 4022
		mu 0 4 2163 454 2160 1068
		f 4 -1979 762 -4021 4023
		mu 0 4 2160 421 2098 1068
		f 4 765 1982 -4026 4024
		mu 0 4 2100 423 2164 1069
		f 4 1983 -830 -4027 4025
		mu 0 4 2164 456 2165 1069
		f 4 -829 -1982 -4028 4026
		mu 0 4 2165 455 2162 1069
		f 4 -1981 764 -4025 4027
		mu 0 4 2162 422 2100 1069
		f 4 767 1920 -4030 4028
		mu 0 4 2102 424 2166 1070
		f 4 1921 -832 -4031 4029
		mu 0 4 2166 457 2167 1070
		f 4 -831 -1984 -4032 4030
		mu 0 4 2167 456 2164 1070
		f 4 -1983 766 -4029 4031
		mu 0 4 2164 423 2102 1070
		f 4 769 1986 -4034 4032
		mu 0 4 2104 426 2168 1071
		f 4 1987 -834 -4035 4033
		mu 0 4 2168 459 2169 1071
		f 4 -833 -1986 -4036 4034
		mu 0 4 2169 458 2170 1071
		f 4 -1985 768 -4033 4035
		mu 0 4 2170 425 2104 1071
		f 4 771 1988 -4038 4036
		mu 0 4 2107 427 2171 1072
		f 4 1989 -836 -4039 4037
		mu 0 4 2171 460 2172 1072
		f 4 -835 -1988 -4040 4038
		mu 0 4 2172 459 2168 1072
		f 4 -1987 770 -4037 4039
		mu 0 4 2168 426 2107 1072
		f 4 773 1990 -4042 4040
		mu 0 4 2109 428 2173 1073
		f 4 1991 -838 -4043 4041
		mu 0 4 2173 461 2174 1073
		f 4 -837 -1990 -4044 4042
		mu 0 4 2174 460 2171 1073
		f 4 -1989 772 -4041 4043
		mu 0 4 2171 427 2109 1073
		f 4 775 1992 -4046 4044
		mu 0 4 2111 429 2175 1074
		f 4 1993 -840 -4047 4045
		mu 0 4 2175 462 2176 1074
		f 4 -839 -1992 -4048 4046
		mu 0 4 2176 461 2173 1074
		f 4 -1991 774 -4045 4047
		mu 0 4 2173 428 2111 1074
		f 4 777 1994 -4050 4048
		mu 0 4 2113 430 2177 1075
		f 4 1995 -842 -4051 4049
		mu 0 4 2177 463 2178 1075
		f 4 -841 -1994 -4052 4050
		mu 0 4 2178 462 2175 1075
		f 4 -1993 776 -4049 4051
		mu 0 4 2175 429 2113 1075
		f 4 779 1996 -4054 4052
		mu 0 4 2115 431 2179 1076
		f 4 1997 -844 -4055 4053
		mu 0 4 2179 464 2180 1076
		f 4 -843 -1996 -4056 4054
		mu 0 4 2180 463 2177 1076
		f 4 -1995 778 -4053 4055
		mu 0 4 2177 430 2115 1076
		f 4 781 1998 -4058 4056
		mu 0 4 2117 432 2181 1077
		f 4 1999 -846 -4059 4057
		mu 0 4 2181 465 2182 1077
		f 4 -845 -1998 -4060 4058
		mu 0 4 2182 464 2179 1077
		f 4 -1997 780 -4057 4059
		mu 0 4 2179 431 2117 1077
		f 4 783 2000 -4062 4060
		mu 0 4 2119 433 2183 1078
		f 4 2001 -848 -4063 4061
		mu 0 4 2183 466 2184 1078
		f 4 -847 -2000 -4064 4062
		mu 0 4 2184 465 2181 1078
		f 4 -1999 782 -4061 4063
		mu 0 4 2181 432 2119 1078
		f 4 785 2002 -4066 4064
		mu 0 4 2121 434 2185 1079
		f 4 2003 -850 -4067 4065
		mu 0 4 2185 467 2186 1079
		f 4 -849 -2002 -4068 4066
		mu 0 4 2186 466 2183 1079
		f 4 -2001 784 -4065 4067
		mu 0 4 2183 433 2121 1079
		f 4 787 2004 -4070 4068
		mu 0 4 2123 435 2187 1080
		f 4 2005 -852 -4071 4069
		mu 0 4 2187 468 2188 1080
		f 4 -851 -2004 -4072 4070
		mu 0 4 2188 467 2185 1080
		f 4 -2003 786 -4069 4071
		mu 0 4 2185 434 2123 1080
		f 4 789 2006 -4074 4072
		mu 0 4 2125 436 2189 1081
		f 4 2007 -854 -4075 4073
		mu 0 4 2189 469 2190 1081
		f 4 -853 -2006 -4076 4074
		mu 0 4 2190 468 2187 1081
		f 4 -2005 788 -4073 4075
		mu 0 4 2187 435 2125 1081
		f 4 791 2008 -4078 4076
		mu 0 4 2127 437 2191 1082
		f 4 2009 -856 -4079 4077
		mu 0 4 2191 470 2192 1082
		f 4 -855 -2008 -4080 4078
		mu 0 4 2192 469 2189 1082
		f 4 -2007 790 -4077 4079
		mu 0 4 2189 436 2127 1082
		f 4 793 2010 -4082 4080
		mu 0 4 2129 438 2193 1083
		f 4 2011 -858 -4083 4081
		mu 0 4 2193 471 2194 1083
		f 4 -857 -2010 -4084 4082
		mu 0 4 2194 470 2191 1083
		f 4 -2009 792 -4081 4083
		mu 0 4 2191 437 2129 1083
		f 4 795 2012 -4086 4084
		mu 0 4 2131 439 2195 1084
		f 4 2013 -860 -4087 4085
		mu 0 4 2195 472 2196 1084
		f 4 -859 -2012 -4088 4086
		mu 0 4 2196 471 2193 1084
		f 4 -2011 794 -4085 4087
		mu 0 4 2193 438 2131 1084
		f 4 797 2014 -4090 4088
		mu 0 4 2133 440 2197 1085
		f 4 2015 -862 -4091 4089
		mu 0 4 2197 473 2198 1085
		f 4 -861 -2014 -4092 4090
		mu 0 4 2198 472 2195 1085
		f 4 -2013 796 -4089 4091
		mu 0 4 2195 439 2133 1085
		f 4 799 2016 -4094 4092
		mu 0 4 2135 441 2199 1086
		f 4 2017 -864 -4095 4093
		mu 0 4 2199 474 2200 1086
		f 4 -863 -2016 -4096 4094
		mu 0 4 2200 473 2197 1086
		f 4 -2015 798 -4093 4095
		mu 0 4 2197 440 2135 1086
		f 4 801 2018 -4098 4096
		mu 0 4 2137 442 2201 1087
		f 4 2019 -866 -4099 4097
		mu 0 4 2201 475 2202 1087
		f 4 -865 -2018 -4100 4098
		mu 0 4 2202 474 2199 1087
		f 4 -2017 800 -4097 4099
		mu 0 4 2199 441 2137 1087
		f 4 803 2020 -4102 4100
		mu 0 4 2139 443 2203 1088
		f 4 2021 -868 -4103 4101
		mu 0 4 2203 476 2204 1088
		f 4 -867 -2020 -4104 4102
		mu 0 4 2204 475 2201 1088
		f 4 -2019 802 -4101 4103
		mu 0 4 2201 442 2139 1088
		f 4 805 2022 -4106 4104
		mu 0 4 2141 444 2205 1089
		f 4 2023 -870 -4107 4105
		mu 0 4 2205 477 2206 1089
		f 4 -869 -2022 -4108 4106
		mu 0 4 2206 476 2203 1089
		f 4 -2021 804 -4105 4107
		mu 0 4 2203 443 2141 1089
		f 4 807 2024 -4110 4108
		mu 0 4 2143 445 2207 1090
		f 4 2025 -872 -4111 4109
		mu 0 4 2207 478 2208 1090
		f 4 -871 -2024 -4112 4110
		mu 0 4 2208 477 2205 1090
		f 4 -2023 806 -4109 4111
		mu 0 4 2205 444 2143 1090
		f 4 809 2026 -4114 4112
		mu 0 4 2145 446 2209 1091
		f 4 2027 -874 -4115 4113
		mu 0 4 2209 479 2210 1091
		f 4 -873 -2026 -4116 4114
		mu 0 4 2210 478 2207 1091
		f 4 -2025 808 -4113 4115
		mu 0 4 2207 445 2145 1091
		f 4 811 2028 -4118 4116
		mu 0 4 2147 447 2211 1092
		f 4 2029 -876 -4119 4117
		mu 0 4 2211 480 2212 1092
		f 4 -875 -2028 -4120 4118
		mu 0 4 2212 479 2209 1092
		f 4 -2027 810 -4117 4119
		mu 0 4 2209 446 2147 1092
		f 4 813 2030 -4122 4120
		mu 0 4 2149 448 2213 1093
		f 4 2031 -878 -4123 4121
		mu 0 4 2213 481 2214 1093
		f 4 -877 -2030 -4124 4122
		mu 0 4 2214 480 2211 1093
		f 4 -2029 812 -4121 4123
		mu 0 4 2211 447 2149 1093
		f 4 815 2032 -4126 4124
		mu 0 4 2151 449 2215 1094
		f 4 2033 -880 -4127 4125
		mu 0 4 2215 482 2216 1094
		f 4 -879 -2032 -4128 4126
		mu 0 4 2216 481 2213 1094
		f 4 -2031 814 -4125 4127
		mu 0 4 2213 448 2151 1094
		f 4 817 2034 -4130 4128
		mu 0 4 2153 450 2217 1095
		f 4 2035 -882 -4131 4129
		mu 0 4 2217 483 2218 1095
		f 4 -881 -2034 -4132 4130
		mu 0 4 2218 482 2215 1095
		f 4 -2033 816 -4129 4131
		mu 0 4 2215 449 2153 1095
		f 4 819 2036 -4134 4132
		mu 0 4 2155 451 2219 1096
		f 4 2037 -884 -4135 4133
		mu 0 4 2219 484 2220 1096
		f 4 -883 -2036 -4136 4134
		mu 0 4 2220 483 2217 1096
		f 4 -2035 818 -4133 4135
		mu 0 4 2217 450 2155 1096
		f 4 821 2038 -4138 4136
		mu 0 4 2157 452 2221 1097
		f 4 2039 -886 -4139 4137
		mu 0 4 2221 485 2222 1097
		f 4 -885 -2038 -4140 4138
		mu 0 4 2222 484 2219 1097
		f 4 -2037 820 -4137 4139
		mu 0 4 2219 451 2157 1097
		f 4 823 2040 -4142 4140
		mu 0 4 2159 453 2223 1098
		f 4 2041 -888 -4143 4141
		mu 0 4 2223 486 2224 1098
		f 4 -887 -2040 -4144 4142
		mu 0 4 2224 485 2221 1098
		f 4 -2039 822 -4141 4143
		mu 0 4 2221 452 2159 1098
		f 4 825 2042 -4146 4144
		mu 0 4 2161 454 2225 1099
		f 4 2043 -890 -4147 4145
		mu 0 4 2225 487 2226 1099
		f 4 -889 -2042 -4148 4146
		mu 0 4 2226 486 2223 1099
		f 4 -2041 824 -4145 4147
		mu 0 4 2223 453 2161 1099
		f 4 827 2044 -4150 4148
		mu 0 4 2163 455 2227 1100
		f 4 2045 -892 -4151 4149
		mu 0 4 2227 488 2228 1100
		f 4 -891 -2044 -4152 4150
		mu 0 4 2228 487 2225 1100
		f 4 -2043 826 -4149 4151
		mu 0 4 2225 454 2163 1100
		f 4 829 2046 -4154 4152
		mu 0 4 2165 456 2229 1101
		f 4 2047 -894 -4155 4153
		mu 0 4 2229 489 2230 1101
		f 4 -893 -2046 -4156 4154
		mu 0 4 2230 488 2227 1101
		f 4 -2045 828 -4153 4155
		mu 0 4 2227 455 2165 1101
		f 4 831 1984 -4158 4156
		mu 0 4 2167 457 2231 1102
		f 4 1985 -896 -4159 4157
		mu 0 4 2231 490 2232 1102
		f 4 -895 -2048 -4160 4158
		mu 0 4 2232 489 2229 1102
		f 4 -2047 830 -4157 4159
		mu 0 4 2229 456 2167 1102
		f 4 833 2050 -4162 4160
		mu 0 4 2169 459 2233 1103
		f 4 2051 -898 -4163 4161
		mu 0 4 2233 492 2234 1103
		f 4 -897 -2050 -4164 4162
		mu 0 4 2234 491 2235 1103
		f 4 -2049 832 -4161 4163
		mu 0 4 2235 458 2169 1103
		f 4 835 2052 -4166 4164
		mu 0 4 2172 460 2236 1104
		f 4 2053 -900 -4167 4165
		mu 0 4 2236 493 2237 1104
		f 4 -899 -2052 -4168 4166
		mu 0 4 2237 492 2233 1104
		f 4 -2051 834 -4165 4167
		mu 0 4 2233 459 2172 1104
		f 4 837 2054 -4170 4168
		mu 0 4 2174 461 2238 1105
		f 4 2055 -902 -4171 4169
		mu 0 4 2238 494 2239 1105
		f 4 -901 -2054 -4172 4170
		mu 0 4 2239 493 2236 1105
		f 4 -2053 836 -4169 4171
		mu 0 4 2236 460 2174 1105
		f 4 839 2056 -4174 4172
		mu 0 4 2176 462 2240 1106
		f 4 2057 -904 -4175 4173
		mu 0 4 2240 495 2241 1106
		f 4 -903 -2056 -4176 4174
		mu 0 4 2241 494 2238 1106
		f 4 -2055 838 -4173 4175
		mu 0 4 2238 461 2176 1106
		f 4 841 2058 -4178 4176
		mu 0 4 2178 463 2242 1107
		f 4 2059 -906 -4179 4177
		mu 0 4 2242 496 2243 1107
		f 4 -905 -2058 -4180 4178
		mu 0 4 2243 495 2240 1107
		f 4 -2057 840 -4177 4179
		mu 0 4 2240 462 2178 1107
		f 4 843 2060 -4182 4180
		mu 0 4 2180 464 2244 1108
		f 4 2061 -908 -4183 4181
		mu 0 4 2244 497 2245 1108
		f 4 -907 -2060 -4184 4182
		mu 0 4 2245 496 2242 1108
		f 4 -2059 842 -4181 4183
		mu 0 4 2242 463 2180 1108
		f 4 845 2062 -4186 4184
		mu 0 4 2182 465 2246 1109
		f 4 2063 -910 -4187 4185
		mu 0 4 2246 498 2247 1109
		f 4 -909 -2062 -4188 4186
		mu 0 4 2247 497 2244 1109
		f 4 -2061 844 -4185 4187
		mu 0 4 2244 464 2182 1109
		f 4 847 2064 -4190 4188
		mu 0 4 2184 466 2248 1110
		f 4 2065 -912 -4191 4189
		mu 0 4 2248 499 2249 1110
		f 4 -911 -2064 -4192 4190
		mu 0 4 2249 498 2246 1110
		f 4 -2063 846 -4189 4191
		mu 0 4 2246 465 2184 1110
		f 4 849 2066 -4194 4192
		mu 0 4 2186 467 2250 1111
		f 4 2067 -914 -4195 4193
		mu 0 4 2250 500 2251 1111
		f 4 -913 -2066 -4196 4194
		mu 0 4 2251 499 2248 1111
		f 4 -2065 848 -4193 4195
		mu 0 4 2248 466 2186 1111
		f 4 851 2068 -4198 4196
		mu 0 4 2188 468 2252 1112
		f 4 2069 -916 -4199 4197
		mu 0 4 2252 501 2253 1112
		f 4 -915 -2068 -4200 4198
		mu 0 4 2253 500 2250 1112
		f 4 -2067 850 -4197 4199
		mu 0 4 2250 467 2188 1112
		f 4 853 2070 -4202 4200
		mu 0 4 2190 469 2254 1113
		f 4 2071 -918 -4203 4201
		mu 0 4 2254 502 2255 1113
		f 4 -917 -2070 -4204 4202
		mu 0 4 2255 501 2252 1113
		f 4 -2069 852 -4201 4203
		mu 0 4 2252 468 2190 1113
		f 4 855 2072 -4206 4204
		mu 0 4 2192 470 2256 1114
		f 4 2073 -920 -4207 4205
		mu 0 4 2256 503 2257 1114
		f 4 -919 -2072 -4208 4206
		mu 0 4 2257 502 2254 1114
		f 4 -2071 854 -4205 4207
		mu 0 4 2254 469 2192 1114
		f 4 857 2074 -4210 4208
		mu 0 4 2194 471 2258 1115
		f 4 2075 -922 -4211 4209
		mu 0 4 2258 504 2259 1115
		f 4 -921 -2074 -4212 4210
		mu 0 4 2259 503 2256 1115
		f 4 -2073 856 -4209 4211
		mu 0 4 2256 470 2194 1115
		f 4 859 2076 -4214 4212
		mu 0 4 2196 472 2260 1116
		f 4 2077 -924 -4215 4213
		mu 0 4 2260 505 2261 1116
		f 4 -923 -2076 -4216 4214
		mu 0 4 2261 504 2258 1116
		f 4 -2075 858 -4213 4215
		mu 0 4 2258 471 2196 1116
		f 4 861 2078 -4218 4216
		mu 0 4 2198 473 2262 1117
		f 4 2079 -926 -4219 4217
		mu 0 4 2262 506 2263 1117
		f 4 -925 -2078 -4220 4218
		mu 0 4 2263 505 2260 1117
		f 4 -2077 860 -4217 4219
		mu 0 4 2260 472 2198 1117
		f 4 863 2080 -4222 4220
		mu 0 4 2200 474 2264 1118
		f 4 2081 -928 -4223 4221
		mu 0 4 2264 507 2265 1118
		f 4 -927 -2080 -4224 4222
		mu 0 4 2265 506 2262 1118
		f 4 -2079 862 -4221 4223
		mu 0 4 2262 473 2200 1118
		f 4 865 2082 -4226 4224
		mu 0 4 2202 475 2266 1119
		f 4 2083 -930 -4227 4225
		mu 0 4 2266 508 2267 1119
		f 4 -929 -2082 -4228 4226
		mu 0 4 2267 507 2264 1119
		f 4 -2081 864 -4225 4227
		mu 0 4 2264 474 2202 1119
		f 4 867 2084 -4230 4228
		mu 0 4 2204 476 2268 1120
		f 4 2085 -932 -4231 4229
		mu 0 4 2268 509 2269 1120
		f 4 -931 -2084 -4232 4230
		mu 0 4 2269 508 2266 1120
		f 4 -2083 866 -4229 4231
		mu 0 4 2266 475 2204 1120
		f 4 869 2086 -4234 4232
		mu 0 4 2206 477 2270 1121
		f 4 2087 -934 -4235 4233
		mu 0 4 2270 510 2271 1121
		f 4 -933 -2086 -4236 4234
		mu 0 4 2271 509 2268 1121
		f 4 -2085 868 -4233 4235
		mu 0 4 2268 476 2206 1121
		f 4 871 2088 -4238 4236
		mu 0 4 2208 478 2272 1122
		f 4 2089 -936 -4239 4237
		mu 0 4 2272 511 2273 1122
		f 4 -935 -2088 -4240 4238
		mu 0 4 2273 510 2270 1122
		f 4 -2087 870 -4237 4239
		mu 0 4 2270 477 2208 1122
		f 4 873 2090 -4242 4240
		mu 0 4 2210 479 2274 1123
		f 4 2091 -938 -4243 4241
		mu 0 4 2274 512 2275 1123
		f 4 -937 -2090 -4244 4242
		mu 0 4 2275 511 2272 1123
		f 4 -2089 872 -4241 4243
		mu 0 4 2272 478 2210 1123
		f 4 875 2092 -4246 4244
		mu 0 4 2212 480 2276 1124
		f 4 2093 -940 -4247 4245
		mu 0 4 2276 513 2277 1124
		f 4 -939 -2092 -4248 4246
		mu 0 4 2277 512 2274 1124
		f 4 -2091 874 -4245 4247
		mu 0 4 2274 479 2212 1124
		f 4 877 2094 -4250 4248
		mu 0 4 2214 481 2278 1125
		f 4 2095 -942 -4251 4249
		mu 0 4 2278 514 2279 1125
		f 4 -941 -2094 -4252 4250
		mu 0 4 2279 513 2276 1125
		f 4 -2093 876 -4249 4251
		mu 0 4 2276 480 2214 1125
		f 4 879 2096 -4254 4252
		mu 0 4 2216 482 2280 1126
		f 4 2097 -944 -4255 4253
		mu 0 4 2280 515 2281 1126
		f 4 -943 -2096 -4256 4254
		mu 0 4 2281 514 2278 1126
		f 4 -2095 878 -4253 4255
		mu 0 4 2278 481 2216 1126
		f 4 881 2098 -4258 4256
		mu 0 4 2218 483 2282 1127
		f 4 2099 -946 -4259 4257
		mu 0 4 2282 516 2283 1127
		f 4 -945 -2098 -4260 4258
		mu 0 4 2283 515 2280 1127
		f 4 -2097 880 -4257 4259
		mu 0 4 2280 482 2218 1127
		f 4 883 2100 -4262 4260
		mu 0 4 2220 484 2284 1128
		f 4 2101 -948 -4263 4261
		mu 0 4 2284 517 2285 1128
		f 4 -947 -2100 -4264 4262
		mu 0 4 2285 516 2282 1128
		f 4 -2099 882 -4261 4263
		mu 0 4 2282 483 2220 1128
		f 4 885 2102 -4266 4264
		mu 0 4 2222 485 2286 1129
		f 4 2103 -950 -4267 4265
		mu 0 4 2286 518 2287 1129
		f 4 -949 -2102 -4268 4266
		mu 0 4 2287 517 2284 1129
		f 4 -2101 884 -4265 4267
		mu 0 4 2284 484 2222 1129
		f 4 887 2104 -4270 4268
		mu 0 4 2224 486 2288 1130
		f 4 2105 -952 -4271 4269
		mu 0 4 2288 519 2289 1130
		f 4 -951 -2104 -4272 4270
		mu 0 4 2289 518 2286 1130
		f 4 -2103 886 -4269 4271
		mu 0 4 2286 485 2224 1130
		f 4 889 2106 -4274 4272
		mu 0 4 2226 487 2290 1131
		f 4 2107 -954 -4275 4273
		mu 0 4 2290 520 2291 1131
		f 4 -953 -2106 -4276 4274
		mu 0 4 2291 519 2288 1131
		f 4 -2105 888 -4273 4275
		mu 0 4 2288 486 2226 1131
		f 4 891 2108 -4278 4276
		mu 0 4 2228 488 2292 1132
		f 4 2109 -956 -4279 4277
		mu 0 4 2292 521 2293 1132
		f 4 -955 -2108 -4280 4278
		mu 0 4 2293 520 2290 1132
		f 4 -2107 890 -4277 4279
		mu 0 4 2290 487 2228 1132
		f 4 893 2110 -4282 4280
		mu 0 4 2230 489 2294 1133
		f 4 2111 -958 -4283 4281
		mu 0 4 2294 522 2295 1133
		f 4 -957 -2110 -4284 4282
		mu 0 4 2295 521 2292 1133
		f 4 -2109 892 -4281 4283
		mu 0 4 2292 488 2230 1133
		f 4 895 2048 -4286 4284
		mu 0 4 2232 490 2296 1134
		f 4 2049 -960 -4287 4285
		mu 0 4 2296 523 2297 1134
		f 4 -959 -2112 -4288 4286
		mu 0 4 2297 522 2294 1134
		f 4 -2111 894 -4285 4287
		mu 0 4 2294 489 2232 1134
		f 4 897 2114 -4290 4288
		mu 0 4 2234 492 2298 1135
		f 4 2115 -962 -4291 4289
		mu 0 4 2298 525 2299 1135
		f 4 -961 -2114 -4292 4290
		mu 0 4 2299 524 2300 1135
		f 4 -2113 896 -4289 4291
		mu 0 4 2300 491 2234 1135
		f 4 899 2116 -4294 4292
		mu 0 4 2237 493 2301 1136
		f 4 2117 -964 -4295 4293
		mu 0 4 2301 526 2302 1136
		f 4 -963 -2116 -4296 4294
		mu 0 4 2302 525 2298 1136
		f 4 -2115 898 -4293 4295
		mu 0 4 2298 492 2237 1136
		f 4 901 2118 -4298 4296
		mu 0 4 2239 494 2303 1137
		f 4 2119 -966 -4299 4297
		mu 0 4 2303 527 2304 1137
		f 4 -965 -2118 -4300 4298
		mu 0 4 2304 526 2301 1137
		f 4 -2117 900 -4297 4299
		mu 0 4 2301 493 2239 1137
		f 4 903 2120 -4302 4300
		mu 0 4 2241 495 2305 1138
		f 4 2121 -968 -4303 4301
		mu 0 4 2305 528 2306 1138
		f 4 -967 -2120 -4304 4302
		mu 0 4 2306 527 2303 1138
		f 4 -2119 902 -4301 4303
		mu 0 4 2303 494 2241 1138
		f 4 905 2122 -4306 4304
		mu 0 4 2243 496 2307 1139
		f 4 2123 -970 -4307 4305
		mu 0 4 2307 529 2308 1139
		f 4 -969 -2122 -4308 4306
		mu 0 4 2308 528 2305 1139
		f 4 -2121 904 -4305 4307
		mu 0 4 2305 495 2243 1139
		f 4 907 2124 -4310 4308
		mu 0 4 2245 497 2309 1140
		f 4 2125 -972 -4311 4309
		mu 0 4 2309 530 2310 1140
		f 4 -971 -2124 -4312 4310
		mu 0 4 2310 529 2307 1140
		f 4 -2123 906 -4309 4311
		mu 0 4 2307 496 2245 1140
		f 4 909 2126 -4314 4312
		mu 0 4 2247 498 2311 1141
		f 4 2127 -974 -4315 4313
		mu 0 4 2311 531 2312 1141
		f 4 -973 -2126 -4316 4314
		mu 0 4 2312 530 2309 1141
		f 4 -2125 908 -4313 4315
		mu 0 4 2309 497 2247 1141
		f 4 911 2128 -4318 4316
		mu 0 4 2249 499 2313 1142
		f 4 2129 -976 -4319 4317
		mu 0 4 2313 532 2314 1142
		f 4 -975 -2128 -4320 4318
		mu 0 4 2314 531 2311 1142
		f 4 -2127 910 -4317 4319
		mu 0 4 2311 498 2249 1142
		f 4 913 2130 -4322 4320
		mu 0 4 2251 500 2315 1143
		f 4 2131 -978 -4323 4321
		mu 0 4 2315 533 2316 1143
		f 4 -977 -2130 -4324 4322
		mu 0 4 2316 532 2313 1143
		f 4 -2129 912 -4321 4323
		mu 0 4 2313 499 2251 1143
		f 4 915 2132 -4326 4324
		mu 0 4 2253 501 2317 1144
		f 4 2133 -980 -4327 4325
		mu 0 4 2317 534 2318 1144
		f 4 -979 -2132 -4328 4326
		mu 0 4 2318 533 2315 1144
		f 4 -2131 914 -4325 4327
		mu 0 4 2315 500 2253 1144
		f 4 917 2134 -4330 4328
		mu 0 4 2255 502 2319 1145
		f 4 2135 -982 -4331 4329
		mu 0 4 2319 535 2320 1145
		f 4 -981 -2134 -4332 4330
		mu 0 4 2320 534 2317 1145
		f 4 -2133 916 -4329 4331
		mu 0 4 2317 501 2255 1145
		f 4 919 2136 -4334 4332
		mu 0 4 2257 503 2321 1146
		f 4 2137 -984 -4335 4333
		mu 0 4 2321 536 2322 1146
		f 4 -983 -2136 -4336 4334
		mu 0 4 2322 535 2319 1146
		f 4 -2135 918 -4333 4335
		mu 0 4 2319 502 2257 1146
		f 4 921 2138 -4338 4336
		mu 0 4 2259 504 2323 1147
		f 4 2139 -986 -4339 4337
		mu 0 4 2323 537 2324 1147
		f 4 -985 -2138 -4340 4338
		mu 0 4 2324 536 2321 1147
		f 4 -2137 920 -4337 4339
		mu 0 4 2321 503 2259 1147
		f 4 923 2140 -4342 4340
		mu 0 4 2261 505 2325 1148
		f 4 2141 -988 -4343 4341
		mu 0 4 2325 538 2326 1148
		f 4 -987 -2140 -4344 4342
		mu 0 4 2326 537 2323 1148
		f 4 -2139 922 -4341 4343
		mu 0 4 2323 504 2261 1148
		f 4 925 2142 -4346 4344
		mu 0 4 2263 506 2327 1149
		f 4 2143 -990 -4347 4345
		mu 0 4 2327 539 2328 1149
		f 4 -989 -2142 -4348 4346
		mu 0 4 2328 538 2325 1149
		f 4 -2141 924 -4345 4347
		mu 0 4 2325 505 2263 1149
		f 4 927 2144 -4350 4348
		mu 0 4 2265 507 2329 1150
		f 4 2145 -992 -4351 4349
		mu 0 4 2329 540 2330 1150
		f 4 -991 -2144 -4352 4350
		mu 0 4 2330 539 2327 1150
		f 4 -2143 926 -4349 4351
		mu 0 4 2327 506 2265 1150
		f 4 929 2146 -4354 4352
		mu 0 4 2267 508 2331 1151
		f 4 2147 -994 -4355 4353
		mu 0 4 2331 541 2332 1151
		f 4 -993 -2146 -4356 4354
		mu 0 4 2332 540 2329 1151
		f 4 -2145 928 -4353 4355
		mu 0 4 2329 507 2267 1151
		f 4 931 2148 -4358 4356
		mu 0 4 2269 509 2333 1152
		f 4 2149 -996 -4359 4357
		mu 0 4 2333 542 2334 1152
		f 4 -995 -2148 -4360 4358
		mu 0 4 2334 541 2331 1152
		f 4 -2147 930 -4357 4359
		mu 0 4 2331 508 2269 1152
		f 4 933 2150 -4362 4360
		mu 0 4 2271 510 2335 1153
		f 4 2151 -998 -4363 4361
		mu 0 4 2335 543 2336 1153
		f 4 -997 -2150 -4364 4362
		mu 0 4 2336 542 2333 1153
		f 4 -2149 932 -4361 4363
		mu 0 4 2333 509 2271 1153
		f 4 935 2152 -4366 4364
		mu 0 4 2273 511 2337 1154
		f 4 2153 -1000 -4367 4365
		mu 0 4 2337 544 2338 1154
		f 4 -999 -2152 -4368 4366
		mu 0 4 2338 543 2335 1154
		f 4 -2151 934 -4365 4367
		mu 0 4 2335 510 2273 1154
		f 4 937 2154 -4370 4368
		mu 0 4 2275 512 2339 1155
		f 4 2155 -1002 -4371 4369
		mu 0 4 2339 545 2340 1155
		f 4 -1001 -2154 -4372 4370
		mu 0 4 2340 544 2337 1155
		f 4 -2153 936 -4369 4371
		mu 0 4 2337 511 2275 1155
		f 4 939 2156 -4374 4372
		mu 0 4 2277 513 2341 1156
		f 4 2157 -1004 -4375 4373
		mu 0 4 2341 546 2342 1156
		f 4 -1003 -2156 -4376 4374
		mu 0 4 2342 545 2339 1156
		f 4 -2155 938 -4373 4375
		mu 0 4 2339 512 2277 1156
		f 4 941 2158 -4378 4376
		mu 0 4 2279 514 2343 1157
		f 4 2159 -1006 -4379 4377
		mu 0 4 2343 547 2344 1157
		f 4 -1005 -2158 -4380 4378
		mu 0 4 2344 546 2341 1157
		f 4 -2157 940 -4377 4379
		mu 0 4 2341 513 2279 1157
		f 4 943 2160 -4382 4380
		mu 0 4 2281 515 2345 1158
		f 4 2161 -1008 -4383 4381
		mu 0 4 2345 548 2346 1158
		f 4 -1007 -2160 -4384 4382
		mu 0 4 2346 547 2343 1158
		f 4 -2159 942 -4381 4383
		mu 0 4 2343 514 2281 1158
		f 4 945 2162 -4386 4384
		mu 0 4 2283 516 2347 1159
		f 4 2163 -1010 -4387 4385
		mu 0 4 2347 549 2348 1159
		f 4 -1009 -2162 -4388 4386
		mu 0 4 2348 548 2345 1159
		f 4 -2161 944 -4385 4387
		mu 0 4 2345 515 2283 1159
		f 4 947 2164 -4390 4388
		mu 0 4 2285 517 2349 1160
		f 4 2165 -1012 -4391 4389
		mu 0 4 2349 550 2350 1160
		f 4 -1011 -2164 -4392 4390
		mu 0 4 2350 549 2347 1160
		f 4 -2163 946 -4389 4391
		mu 0 4 2347 516 2285 1160
		f 4 949 2166 -4394 4392
		mu 0 4 2287 518 2351 1161
		f 4 2167 -1014 -4395 4393
		mu 0 4 2351 551 2352 1161
		f 4 -1013 -2166 -4396 4394
		mu 0 4 2352 550 2349 1161
		f 4 -2165 948 -4393 4395
		mu 0 4 2349 517 2287 1161
		f 4 951 2168 -4398 4396
		mu 0 4 2289 519 2353 1162
		f 4 2169 -1016 -4399 4397
		mu 0 4 2353 552 2354 1162
		f 4 -1015 -2168 -4400 4398
		mu 0 4 2354 551 2351 1162
		f 4 -2167 950 -4397 4399
		mu 0 4 2351 518 2289 1162
		f 4 953 2170 -4402 4400
		mu 0 4 2291 520 2355 1163
		f 4 2171 -1018 -4403 4401
		mu 0 4 2355 553 2356 1163
		f 4 -1017 -2170 -4404 4402
		mu 0 4 2356 552 2353 1163
		f 4 -2169 952 -4401 4403
		mu 0 4 2353 519 2291 1163
		f 4 955 2172 -4406 4404
		mu 0 4 2293 521 2357 1164
		f 4 2173 -1020 -4407 4405
		mu 0 4 2357 554 2358 1164
		f 4 -1019 -2172 -4408 4406
		mu 0 4 2358 553 2355 1164
		f 4 -2171 954 -4405 4407
		mu 0 4 2355 520 2293 1164
		f 4 957 2174 -4410 4408
		mu 0 4 2295 522 2359 1165
		f 4 2175 -1022 -4411 4409
		mu 0 4 2359 555 2360 1165
		f 4 -1021 -2174 -4412 4410
		mu 0 4 2360 554 2357 1165
		f 4 -2173 956 -4409 4411
		mu 0 4 2357 521 2295 1165
		f 4 959 2112 -4414 4412
		mu 0 4 2297 523 2361 1166
		f 4 2113 -1024 -4415 4413
		mu 0 4 2361 556 2362 1166
		f 4 -1023 -2176 -4416 4414
		mu 0 4 2362 555 2359 1166
		f 4 -2175 958 -4413 4415
		mu 0 4 2359 522 2297 1166
		f 4 961 2178 -4418 4416
		mu 0 4 2363 586 2364 1167
		f 4 2179 -1026 -4419 4417
		mu 0 4 2364 618 2365 1167
		f 4 -1025 -2178 -4420 4418
		mu 0 4 2365 619 2366 1167
		f 4 -2177 960 -4417 4419
		mu 0 4 2366 587 2363 1167
		f 4 963 2180 -4422 4420
		mu 0 4 2367 585 2368 1168
		f 4 2181 -1028 -4423 4421
		mu 0 4 2368 617 2369 1168
		f 4 -1027 -2180 -4424 4422
		mu 0 4 2369 618 2364 1168
		f 4 -2179 962 -4421 4423
		mu 0 4 2364 586 2367 1168
		f 4 965 2182 -4426 4424
		mu 0 4 2370 584 2371 1169
		f 4 2183 -1030 -4427 4425
		mu 0 4 2371 616 2372 1169
		f 4 -1029 -2182 -4428 4426
		mu 0 4 2372 617 2368 1169
		f 4 -2181 964 -4425 4427
		mu 0 4 2368 585 2370 1169
		f 4 967 2184 -4430 4428
		mu 0 4 2373 583 2374 1170
		f 4 2185 -1032 -4431 4429
		mu 0 4 2374 615 2375 1170
		f 4 -1031 -2184 -4432 4430
		mu 0 4 2375 616 2371 1170
		f 4 -2183 966 -4429 4431
		mu 0 4 2371 584 2373 1170
		f 4 969 2186 -4434 4432
		mu 0 4 2376 582 2377 1171
		f 4 2187 -1034 -4435 4433
		mu 0 4 2377 614 2378 1171
		f 4 -1033 -2186 -4436 4434
		mu 0 4 2378 615 2374 1171
		f 4 -2185 968 -4433 4435
		mu 0 4 2374 583 2376 1171
		f 4 971 2188 -4438 4436
		mu 0 4 2379 581 2380 1172
		f 4 2189 -1036 -4439 4437
		mu 0 4 2380 613 2381 1172
		f 4 -1035 -2188 -4440 4438
		mu 0 4 2381 614 2377 1172
		f 4 -2187 970 -4437 4439
		mu 0 4 2377 582 2379 1172
		f 4 973 2190 -4442 4440
		mu 0 4 2382 580 2383 1173
		f 4 2191 -1038 -4443 4441
		mu 0 4 2383 612 2384 1173
		f 4 -1037 -2190 -4444 4442
		mu 0 4 2384 613 2380 1173
		f 4 -2189 972 -4441 4443
		mu 0 4 2380 581 2382 1173
		f 4 975 2192 -4446 4444
		mu 0 4 2385 579 2386 1174
		f 4 2193 -1040 -4447 4445
		mu 0 4 2386 611 2387 1174
		f 4 -1039 -2192 -4448 4446
		mu 0 4 2387 612 2383 1174
		f 4 -2191 974 -4445 4447
		mu 0 4 2383 580 2385 1174
		f 4 977 2194 -4450 4448
		mu 0 4 2388 578 2389 1175
		f 4 2195 -1042 -4451 4449
		mu 0 4 2389 610 2390 1175
		f 4 -1041 -2194 -4452 4450
		mu 0 4 2390 611 2386 1175
		f 4 -2193 976 -4449 4451
		mu 0 4 2386 579 2388 1175
		f 4 979 2196 -4454 4452
		mu 0 4 2391 577 2392 1176
		f 4 2197 -1044 -4455 4453
		mu 0 4 2392 609 2393 1176
		f 4 -1043 -2196 -4456 4454
		mu 0 4 2393 610 2389 1176
		f 4 -2195 978 -4453 4455
		mu 0 4 2389 578 2391 1176
		f 4 981 2198 -4458 4456
		mu 0 4 2394 576 2395 1177
		f 4 2199 -1046 -4459 4457
		mu 0 4 2395 608 2396 1177
		f 4 -1045 -2198 -4460 4458
		mu 0 4 2396 609 2392 1177
		f 4 -2197 980 -4457 4459
		mu 0 4 2392 577 2394 1177
		f 4 983 2200 -4462 4460
		mu 0 4 2397 575 2398 1178
		f 4 2201 -1048 -4463 4461
		mu 0 4 2398 607 2399 1178
		f 4 -1047 -2200 -4464 4462
		mu 0 4 2399 608 2395 1178
		f 4 -2199 982 -4461 4463
		mu 0 4 2395 576 2397 1178
		f 4 985 2202 -4466 4464
		mu 0 4 2400 574 2401 1179
		f 4 2203 -1050 -4467 4465
		mu 0 4 2401 606 2402 1179
		f 4 -1049 -2202 -4468 4466
		mu 0 4 2402 607 2398 1179
		f 4 -2201 984 -4465 4467
		mu 0 4 2398 575 2400 1179
		f 4 987 2204 -4470 4468
		mu 0 4 2403 573 2404 1180
		f 4 2205 -1052 -4471 4469
		mu 0 4 2404 605 2405 1180
		f 4 -1051 -2204 -4472 4470
		mu 0 4 2405 606 2401 1180
		f 4 -2203 986 -4469 4471
		mu 0 4 2401 574 2403 1180
		f 4 989 2206 -4474 4472
		mu 0 4 2406 572 2407 1181
		f 4 2207 -1054 -4475 4473
		mu 0 4 2407 604 2408 1181
		f 4 -1053 -2206 -4476 4474
		mu 0 4 2408 605 2404 1181
		f 4 -2205 988 -4473 4475
		mu 0 4 2404 573 2406 1181
		f 4 991 2208 -4478 4476
		mu 0 4 2409 571 2410 1182
		f 4 2209 -1056 -4479 4477
		mu 0 4 2410 603 2411 1182
		f 4 -1055 -2208 -4480 4478
		mu 0 4 2411 604 2407 1182
		f 4 -2207 990 -4477 4479
		mu 0 4 2407 572 2409 1182
		f 4 993 2210 -4482 4480
		mu 0 4 2412 570 2413 1183
		f 4 2211 -1058 -4483 4481
		mu 0 4 2413 602 2414 1183
		f 4 -1057 -2210 -4484 4482
		mu 0 4 2414 603 2410 1183
		f 4 -2209 992 -4481 4483
		mu 0 4 2410 571 2412 1183
		f 4 995 2212 -4486 4484
		mu 0 4 2415 569 2416 1184
		f 4 2213 -1060 -4487 4485
		mu 0 4 2416 601 2417 1184
		f 4 -1059 -2212 -4488 4486
		mu 0 4 2417 602 2413 1184
		f 4 -2211 994 -4485 4487
		mu 0 4 2413 570 2415 1184
		f 4 997 2214 -4490 4488
		mu 0 4 2418 568 2419 1185
		f 4 2215 -1062 -4491 4489
		mu 0 4 2419 600 2420 1185
		f 4 -1061 -2214 -4492 4490
		mu 0 4 2420 601 2416 1185
		f 4 -2213 996 -4489 4491
		mu 0 4 2416 569 2418 1185
		f 4 999 2216 -4494 4492
		mu 0 4 2421 567 2422 1186
		f 4 2217 -1064 -4495 4493
		mu 0 4 2422 599 2423 1186
		f 4 -1063 -2216 -4496 4494
		mu 0 4 2423 600 2419 1186
		f 4 -2215 998 -4493 4495
		mu 0 4 2419 568 2421 1186;
	setAttr ".fc[2000:2495]"
		f 4 1001 2218 -4498 4496
		mu 0 4 2424 566 2425 1187
		f 4 2219 -1066 -4499 4497
		mu 0 4 2425 598 2426 1187
		f 4 -1065 -2218 -4500 4498
		mu 0 4 2426 599 2422 1187
		f 4 -2217 1000 -4497 4499
		mu 0 4 2422 567 2424 1187
		f 4 1003 2220 -4502 4500
		mu 0 4 2427 565 2428 1188
		f 4 2221 -1068 -4503 4501
		mu 0 4 2428 597 2429 1188
		f 4 -1067 -2220 -4504 4502
		mu 0 4 2429 598 2425 1188
		f 4 -2219 1002 -4501 4503
		mu 0 4 2425 566 2427 1188
		f 4 1005 2222 -4506 4504
		mu 0 4 2430 564 2431 1189
		f 4 2223 -1070 -4507 4505
		mu 0 4 2431 596 2432 1189
		f 4 -1069 -2222 -4508 4506
		mu 0 4 2432 597 2428 1189
		f 4 -2221 1004 -4505 4507
		mu 0 4 2428 565 2430 1189
		f 4 1007 2224 -4510 4508
		mu 0 4 2433 563 2434 1190
		f 4 2225 -1072 -4511 4509
		mu 0 4 2434 595 2435 1190
		f 4 -1071 -2224 -4512 4510
		mu 0 4 2435 596 2431 1190
		f 4 -2223 1006 -4509 4511
		mu 0 4 2431 564 2433 1190
		f 4 1009 2226 -4514 4512
		mu 0 4 2436 562 2437 1191
		f 4 2227 -1074 -4515 4513
		mu 0 4 2437 594 2438 1191
		f 4 -1073 -2226 -4516 4514
		mu 0 4 2438 595 2434 1191
		f 4 -2225 1008 -4513 4515
		mu 0 4 2434 563 2436 1191
		f 4 1011 2228 -4518 4516
		mu 0 4 2439 561 2440 1192
		f 4 2229 -1076 -4519 4517
		mu 0 4 2440 593 2441 1192
		f 4 -1075 -2228 -4520 4518
		mu 0 4 2441 594 2437 1192
		f 4 -2227 1010 -4517 4519
		mu 0 4 2437 562 2439 1192
		f 4 1013 2230 -4522 4520
		mu 0 4 2442 560 2443 1193
		f 4 2231 -1078 -4523 4521
		mu 0 4 2443 592 2444 1193
		f 4 -1077 -2230 -4524 4522
		mu 0 4 2444 593 2440 1193
		f 4 -2229 1012 -4521 4523
		mu 0 4 2440 561 2442 1193
		f 4 1015 2232 -4526 4524
		mu 0 4 2445 559 2446 1194
		f 4 2233 -1080 -4527 4525
		mu 0 4 2446 591 2447 1194
		f 4 -1079 -2232 -4528 4526
		mu 0 4 2447 592 2443 1194
		f 4 -2231 1014 -4525 4527
		mu 0 4 2443 560 2445 1194
		f 4 1017 2234 -4530 4528
		mu 0 4 2448 558 2449 1195
		f 4 2235 -1082 -4531 4529
		mu 0 4 2449 590 2450 1195
		f 4 -1081 -2234 -4532 4530
		mu 0 4 2450 591 2446 1195
		f 4 -2233 1016 -4529 4531
		mu 0 4 2446 559 2448 1195
		f 4 1019 2236 -4534 4532
		mu 0 4 2451 557 2452 1196
		f 4 2237 -1084 -4535 4533
		mu 0 4 2452 589 2453 1196
		f 4 -1083 -2236 -4536 4534
		mu 0 4 2453 590 2449 1196
		f 4 -2235 1018 -4533 4535
		mu 0 4 2449 558 2451 1196
		f 4 1021 2238 -4538 4536
		mu 0 4 2454 588 2455 1197
		f 4 2239 -1086 -4539 4537
		mu 0 4 2455 620 2456 1197
		f 4 -1085 -2238 -4540 4538
		mu 0 4 2456 589 2452 1197
		f 4 -2237 1020 -4537 4539
		mu 0 4 2452 557 2454 1197
		f 4 1023 2176 -4542 4540
		mu 0 4 2457 587 2366 1198
		f 4 2177 -1088 -4543 4541
		mu 0 4 2366 619 2458 1198
		f 4 -1087 -2240 -4544 4542
		mu 0 4 2458 620 2455 1198
		f 4 -2239 1022 -4541 4543
		mu 0 4 2455 588 2457 1198
		f 4 1025 2242 -4546 4544
		mu 0 4 2365 618 2459 1199
		f 4 2243 -1090 -4547 4545
		mu 0 4 2459 650 2460 1199
		f 4 -1089 -2242 -4548 4546
		mu 0 4 2460 651 2461 1199
		f 4 -2241 1024 -4545 4547
		mu 0 4 2461 619 2365 1199
		f 4 1027 2244 -4550 4548
		mu 0 4 2369 617 2462 1200
		f 4 2245 -1092 -4551 4549
		mu 0 4 2462 649 2463 1200
		f 4 -1091 -2244 -4552 4550
		mu 0 4 2463 650 2459 1200
		f 4 -2243 1026 -4549 4551
		mu 0 4 2459 618 2369 1200
		f 4 1029 2246 -4554 4552
		mu 0 4 2372 616 2464 1201
		f 4 2247 -1094 -4555 4553
		mu 0 4 2464 648 2465 1201
		f 4 -1093 -2246 -4556 4554
		mu 0 4 2465 649 2462 1201
		f 4 -2245 1028 -4553 4555
		mu 0 4 2462 617 2372 1201
		f 4 1031 2248 -4558 4556
		mu 0 4 2375 615 2466 1202
		f 4 2249 -1096 -4559 4557
		mu 0 4 2466 647 2467 1202
		f 4 -1095 -2248 -4560 4558
		mu 0 4 2467 648 2464 1202
		f 4 -2247 1030 -4557 4559
		mu 0 4 2464 616 2375 1202
		f 4 1033 2250 -4562 4560
		mu 0 4 2378 614 2468 1203
		f 4 2251 -1098 -4563 4561
		mu 0 4 2468 646 2469 1203
		f 4 -1097 -2250 -4564 4562
		mu 0 4 2469 647 2466 1203
		f 4 -2249 1032 -4561 4563
		mu 0 4 2466 615 2378 1203
		f 4 1035 2252 -4566 4564
		mu 0 4 2381 613 2470 1204
		f 4 2253 -1100 -4567 4565
		mu 0 4 2470 645 2471 1204
		f 4 -1099 -2252 -4568 4566
		mu 0 4 2471 646 2468 1204
		f 4 -2251 1034 -4565 4567
		mu 0 4 2468 614 2381 1204
		f 4 1037 2254 -4570 4568
		mu 0 4 2384 612 2472 1205
		f 4 2255 -1102 -4571 4569
		mu 0 4 2472 644 2473 1205
		f 4 -1101 -2254 -4572 4570
		mu 0 4 2473 645 2470 1205
		f 4 -2253 1036 -4569 4571
		mu 0 4 2470 613 2384 1205
		f 4 1039 2256 -4574 4572
		mu 0 4 2387 611 2474 1206
		f 4 2257 -1104 -4575 4573
		mu 0 4 2474 643 2475 1206
		f 4 -1103 -2256 -4576 4574
		mu 0 4 2475 644 2472 1206
		f 4 -2255 1038 -4573 4575
		mu 0 4 2472 612 2387 1206
		f 4 1041 2258 -4578 4576
		mu 0 4 2390 610 2476 1207
		f 4 2259 -1106 -4579 4577
		mu 0 4 2476 642 2477 1207
		f 4 -1105 -2258 -4580 4578
		mu 0 4 2477 643 2474 1207
		f 4 -2257 1040 -4577 4579
		mu 0 4 2474 611 2390 1207
		f 4 1043 2260 -4582 4580
		mu 0 4 2393 609 2478 1208
		f 4 2261 -1108 -4583 4581
		mu 0 4 2478 641 2479 1208
		f 4 -1107 -2260 -4584 4582
		mu 0 4 2479 642 2476 1208
		f 4 -2259 1042 -4581 4583
		mu 0 4 2476 610 2393 1208
		f 4 1045 2262 -4586 4584
		mu 0 4 2396 608 2480 1209
		f 4 2263 -1110 -4587 4585
		mu 0 4 2480 640 2481 1209
		f 4 -1109 -2262 -4588 4586
		mu 0 4 2481 641 2478 1209
		f 4 -2261 1044 -4585 4587
		mu 0 4 2478 609 2396 1209
		f 4 1047 2264 -4590 4588
		mu 0 4 2399 607 2482 1210
		f 4 2265 -1112 -4591 4589
		mu 0 4 2482 639 2483 1210
		f 4 -1111 -2264 -4592 4590
		mu 0 4 2483 640 2480 1210
		f 4 -2263 1046 -4589 4591
		mu 0 4 2480 608 2399 1210
		f 4 1049 2266 -4594 4592
		mu 0 4 2402 606 2484 1211
		f 4 2267 -1114 -4595 4593
		mu 0 4 2484 638 2485 1211
		f 4 -1113 -2266 -4596 4594
		mu 0 4 2485 639 2482 1211
		f 4 -2265 1048 -4593 4595
		mu 0 4 2482 607 2402 1211
		f 4 1051 2268 -4598 4596
		mu 0 4 2405 605 2486 1212
		f 4 2269 -1116 -4599 4597
		mu 0 4 2486 637 2487 1212
		f 4 -1115 -2268 -4600 4598
		mu 0 4 2487 638 2484 1212
		f 4 -2267 1050 -4597 4599
		mu 0 4 2484 606 2405 1212
		f 4 1053 2270 -4602 4600
		mu 0 4 2408 604 2488 1213
		f 4 2271 -1118 -4603 4601
		mu 0 4 2488 636 2489 1213
		f 4 -1117 -2270 -4604 4602
		mu 0 4 2489 637 2486 1213
		f 4 -2269 1052 -4601 4603
		mu 0 4 2486 605 2408 1213
		f 4 1055 2272 -4606 4604
		mu 0 4 2411 603 2490 1214
		f 4 2273 -1120 -4607 4605
		mu 0 4 2490 635 2491 1214
		f 4 -1119 -2272 -4608 4606
		mu 0 4 2491 636 2488 1214
		f 4 -2271 1054 -4605 4607
		mu 0 4 2488 604 2411 1214
		f 4 1057 2274 -4610 4608
		mu 0 4 2414 602 2492 1215
		f 4 2275 -1122 -4611 4609
		mu 0 4 2492 634 2493 1215
		f 4 -1121 -2274 -4612 4610
		mu 0 4 2493 635 2490 1215
		f 4 -2273 1056 -4609 4611
		mu 0 4 2490 603 2414 1215
		f 4 1059 2276 -4614 4612
		mu 0 4 2417 601 2494 1216
		f 4 2277 -1124 -4615 4613
		mu 0 4 2494 633 2495 1216
		f 4 -1123 -2276 -4616 4614
		mu 0 4 2495 634 2492 1216
		f 4 -2275 1058 -4613 4615
		mu 0 4 2492 602 2417 1216
		f 4 1061 2278 -4618 4616
		mu 0 4 2420 600 2496 1217
		f 4 2279 -1126 -4619 4617
		mu 0 4 2496 632 2497 1217
		f 4 -1125 -2278 -4620 4618
		mu 0 4 2497 633 2494 1217
		f 4 -2277 1060 -4617 4619
		mu 0 4 2494 601 2420 1217
		f 4 1063 2280 -4622 4620
		mu 0 4 2423 599 2498 1218
		f 4 2281 -1128 -4623 4621
		mu 0 4 2498 631 2499 1218
		f 4 -1127 -2280 -4624 4622
		mu 0 4 2499 632 2496 1218
		f 4 -2279 1062 -4621 4623
		mu 0 4 2496 600 2423 1218
		f 4 1065 2282 -4626 4624
		mu 0 4 2426 598 2500 1219
		f 4 2283 -1130 -4627 4625
		mu 0 4 2500 630 2501 1219
		f 4 -1129 -2282 -4628 4626
		mu 0 4 2501 631 2498 1219
		f 4 -2281 1064 -4625 4627
		mu 0 4 2498 599 2426 1219
		f 4 1067 2284 -4630 4628
		mu 0 4 2429 597 2502 1220
		f 4 2285 -1132 -4631 4629
		mu 0 4 2502 629 2503 1220
		f 4 -1131 -2284 -4632 4630
		mu 0 4 2503 630 2500 1220
		f 4 -2283 1066 -4629 4631
		mu 0 4 2500 598 2429 1220
		f 4 1069 2286 -4634 4632
		mu 0 4 2432 596 2504 1221
		f 4 2287 -1134 -4635 4633
		mu 0 4 2504 628 2505 1221
		f 4 -1133 -2286 -4636 4634
		mu 0 4 2505 629 2502 1221
		f 4 -2285 1068 -4633 4635
		mu 0 4 2502 597 2432 1221
		f 4 1071 2288 -4638 4636
		mu 0 4 2435 595 2506 1222
		f 4 2289 -1136 -4639 4637
		mu 0 4 2506 627 2507 1222
		f 4 -1135 -2288 -4640 4638
		mu 0 4 2507 628 2504 1222
		f 4 -2287 1070 -4637 4639
		mu 0 4 2504 596 2435 1222
		f 4 1073 2290 -4642 4640
		mu 0 4 2438 594 2508 1223
		f 4 2291 -1138 -4643 4641
		mu 0 4 2508 626 2509 1223
		f 4 -1137 -2290 -4644 4642
		mu 0 4 2509 627 2506 1223
		f 4 -2289 1072 -4641 4643
		mu 0 4 2506 595 2438 1223
		f 4 1075 2292 -4646 4644
		mu 0 4 2441 593 2510 1224
		f 4 2293 -1140 -4647 4645
		mu 0 4 2510 625 2511 1224
		f 4 -1139 -2292 -4648 4646
		mu 0 4 2511 626 2508 1224
		f 4 -2291 1074 -4645 4647
		mu 0 4 2508 594 2441 1224
		f 4 1077 2294 -4650 4648
		mu 0 4 2444 592 2512 1225
		f 4 2295 -1142 -4651 4649
		mu 0 4 2512 624 2513 1225
		f 4 -1141 -2294 -4652 4650
		mu 0 4 2513 625 2510 1225
		f 4 -2293 1076 -4649 4651
		mu 0 4 2510 593 2444 1225
		f 4 1079 2296 -4654 4652
		mu 0 4 2447 591 2514 1226
		f 4 2297 -1144 -4655 4653
		mu 0 4 2514 623 2515 1226
		f 4 -1143 -2296 -4656 4654
		mu 0 4 2515 624 2512 1226
		f 4 -2295 1078 -4653 4655
		mu 0 4 2512 592 2447 1226
		f 4 1081 2298 -4658 4656
		mu 0 4 2450 590 2516 1227
		f 4 2299 -1146 -4659 4657
		mu 0 4 2516 622 2517 1227
		f 4 -1145 -2298 -4660 4658
		mu 0 4 2517 623 2514 1227
		f 4 -2297 1080 -4657 4659
		mu 0 4 2514 591 2450 1227
		f 4 1083 2300 -4662 4660
		mu 0 4 2453 589 2518 1228
		f 4 2301 -1148 -4663 4661
		mu 0 4 2518 621 2519 1228
		f 4 -1147 -2300 -4664 4662
		mu 0 4 2519 622 2516 1228
		f 4 -2299 1082 -4661 4663
		mu 0 4 2516 590 2453 1228
		f 4 1085 2302 -4666 4664
		mu 0 4 2456 620 2520 1229
		f 4 2303 -1150 -4667 4665
		mu 0 4 2520 652 2521 1229
		f 4 -1149 -2302 -4668 4666
		mu 0 4 2521 621 2518 1229
		f 4 -2301 1084 -4665 4667
		mu 0 4 2518 589 2456 1229
		f 4 1087 2240 -4670 4668
		mu 0 4 2458 619 2461 1230
		f 4 2241 -1152 -4671 4669
		mu 0 4 2461 651 2522 1230
		f 4 -1151 -2304 -4672 4670
		mu 0 4 2522 652 2520 1230
		f 4 -2303 1086 -4669 4671
		mu 0 4 2520 620 2458 1230
		f 4 1089 2306 -4674 4672
		mu 0 4 2460 650 2523 1231
		f 4 2307 -1154 -4675 4673
		mu 0 4 2523 682 2524 1231
		f 4 -1153 -2306 -4676 4674
		mu 0 4 2524 683 2525 1231
		f 4 -2305 1088 -4673 4675
		mu 0 4 2525 651 2460 1231
		f 4 1091 2308 -4678 4676
		mu 0 4 2463 649 2526 1232
		f 4 2309 -1156 -4679 4677
		mu 0 4 2526 681 2527 1232
		f 4 -1155 -2308 -4680 4678
		mu 0 4 2527 682 2523 1232
		f 4 -2307 1090 -4677 4679
		mu 0 4 2523 650 2463 1232
		f 4 1093 2310 -4682 4680
		mu 0 4 2465 648 2528 1233
		f 4 2311 -1158 -4683 4681
		mu 0 4 2528 680 2529 1233
		f 4 -1157 -2310 -4684 4682
		mu 0 4 2529 681 2526 1233
		f 4 -2309 1092 -4681 4683
		mu 0 4 2526 649 2465 1233
		f 4 1095 2312 -4686 4684
		mu 0 4 2467 647 2530 1234
		f 4 2313 -1160 -4687 4685
		mu 0 4 2530 679 2531 1234
		f 4 -1159 -2312 -4688 4686
		mu 0 4 2531 680 2528 1234
		f 4 -2311 1094 -4685 4687
		mu 0 4 2528 648 2467 1234
		f 4 1097 2314 -4690 4688
		mu 0 4 2469 646 2532 1235
		f 4 2315 -1162 -4691 4689
		mu 0 4 2532 678 2533 1235
		f 4 -1161 -2314 -4692 4690
		mu 0 4 2533 679 2530 1235
		f 4 -2313 1096 -4689 4691
		mu 0 4 2530 647 2469 1235
		f 4 1099 2316 -4694 4692
		mu 0 4 2471 645 2534 1236
		f 4 2317 -1164 -4695 4693
		mu 0 4 2534 677 2535 1236
		f 4 -1163 -2316 -4696 4694
		mu 0 4 2535 678 2532 1236
		f 4 -2315 1098 -4693 4695
		mu 0 4 2532 646 2471 1236
		f 4 1101 2318 -4698 4696
		mu 0 4 2473 644 2536 1237
		f 4 2319 -1166 -4699 4697
		mu 0 4 2536 676 2537 1237
		f 4 -1165 -2318 -4700 4698
		mu 0 4 2537 677 2534 1237
		f 4 -2317 1100 -4697 4699
		mu 0 4 2534 645 2473 1237
		f 4 1103 2320 -4702 4700
		mu 0 4 2475 643 2538 1238
		f 4 2321 -1168 -4703 4701
		mu 0 4 2538 675 2539 1238
		f 4 -1167 -2320 -4704 4702
		mu 0 4 2539 676 2536 1238
		f 4 -2319 1102 -4701 4703
		mu 0 4 2536 644 2475 1238
		f 4 1105 2322 -4706 4704
		mu 0 4 2477 642 2540 1239
		f 4 2323 -1170 -4707 4705
		mu 0 4 2540 674 2541 1239
		f 4 -1169 -2322 -4708 4706
		mu 0 4 2541 675 2538 1239
		f 4 -2321 1104 -4705 4707
		mu 0 4 2538 643 2477 1239
		f 4 1107 2324 -4710 4708
		mu 0 4 2479 641 2542 1240
		f 4 2325 -1172 -4711 4709
		mu 0 4 2542 673 2543 1240
		f 4 -1171 -2324 -4712 4710
		mu 0 4 2543 674 2540 1240
		f 4 -2323 1106 -4709 4711
		mu 0 4 2540 642 2479 1240
		f 4 1109 2326 -4714 4712
		mu 0 4 2481 640 2544 1241
		f 4 2327 -1174 -4715 4713
		mu 0 4 2544 672 2545 1241
		f 4 -1173 -2326 -4716 4714
		mu 0 4 2545 673 2542 1241
		f 4 -2325 1108 -4713 4715
		mu 0 4 2542 641 2481 1241
		f 4 1111 2328 -4718 4716
		mu 0 4 2483 639 2546 1242
		f 4 2329 -1176 -4719 4717
		mu 0 4 2546 671 2547 1242
		f 4 -1175 -2328 -4720 4718
		mu 0 4 2547 672 2544 1242
		f 4 -2327 1110 -4717 4719
		mu 0 4 2544 640 2483 1242
		f 4 1113 2330 -4722 4720
		mu 0 4 2485 638 2548 1243
		f 4 2331 -1178 -4723 4721
		mu 0 4 2548 670 2549 1243
		f 4 -1177 -2330 -4724 4722
		mu 0 4 2549 671 2546 1243
		f 4 -2329 1112 -4721 4723
		mu 0 4 2546 639 2485 1243
		f 4 1115 2332 -4726 4724
		mu 0 4 2487 637 2550 1244
		f 4 2333 -1180 -4727 4725
		mu 0 4 2550 669 2551 1244
		f 4 -1179 -2332 -4728 4726
		mu 0 4 2551 670 2548 1244
		f 4 -2331 1114 -4725 4727
		mu 0 4 2548 638 2487 1244
		f 4 1117 2334 -4730 4728
		mu 0 4 2489 636 2552 1245
		f 4 2335 -1182 -4731 4729
		mu 0 4 2552 668 2553 1245
		f 4 -1181 -2334 -4732 4730
		mu 0 4 2553 669 2550 1245
		f 4 -2333 1116 -4729 4731
		mu 0 4 2550 637 2489 1245
		f 4 1119 2336 -4734 4732
		mu 0 4 2491 635 2554 1246
		f 4 2337 -1184 -4735 4733
		mu 0 4 2554 667 2555 1246
		f 4 -1183 -2336 -4736 4734
		mu 0 4 2555 668 2552 1246
		f 4 -2335 1118 -4733 4735
		mu 0 4 2552 636 2491 1246
		f 4 1121 2338 -4738 4736
		mu 0 4 2493 634 2556 1247
		f 4 2339 -1186 -4739 4737
		mu 0 4 2556 666 2557 1247
		f 4 -1185 -2338 -4740 4738
		mu 0 4 2557 667 2554 1247
		f 4 -2337 1120 -4737 4739
		mu 0 4 2554 635 2493 1247
		f 4 1123 2340 -4742 4740
		mu 0 4 2495 633 2558 1248
		f 4 2341 -1188 -4743 4741
		mu 0 4 2558 665 2559 1248
		f 4 -1187 -2340 -4744 4742
		mu 0 4 2559 666 2556 1248
		f 4 -2339 1122 -4741 4743
		mu 0 4 2556 634 2495 1248
		f 4 1125 2342 -4746 4744
		mu 0 4 2497 632 2560 1249
		f 4 2343 -1190 -4747 4745
		mu 0 4 2560 664 2561 1249
		f 4 -1189 -2342 -4748 4746
		mu 0 4 2561 665 2558 1249
		f 4 -2341 1124 -4745 4747
		mu 0 4 2558 633 2497 1249
		f 4 1127 2344 -4750 4748
		mu 0 4 2499 631 2562 1250
		f 4 2345 -1192 -4751 4749
		mu 0 4 2562 663 2563 1250
		f 4 -1191 -2344 -4752 4750
		mu 0 4 2563 664 2560 1250
		f 4 -2343 1126 -4749 4751
		mu 0 4 2560 632 2499 1250
		f 4 1129 2346 -4754 4752
		mu 0 4 2501 630 2564 1251
		f 4 2347 -1194 -4755 4753
		mu 0 4 2564 662 2565 1251
		f 4 -1193 -2346 -4756 4754
		mu 0 4 2565 663 2562 1251
		f 4 -2345 1128 -4753 4755
		mu 0 4 2562 631 2501 1251
		f 4 1131 2348 -4758 4756
		mu 0 4 2503 629 2566 1252
		f 4 2349 -1196 -4759 4757
		mu 0 4 2566 661 2567 1252
		f 4 -1195 -2348 -4760 4758
		mu 0 4 2567 662 2564 1252
		f 4 -2347 1130 -4757 4759
		mu 0 4 2564 630 2503 1252
		f 4 1133 2350 -4762 4760
		mu 0 4 2505 628 2568 1253
		f 4 2351 -1198 -4763 4761
		mu 0 4 2568 660 2569 1253
		f 4 -1197 -2350 -4764 4762
		mu 0 4 2569 661 2566 1253
		f 4 -2349 1132 -4761 4763
		mu 0 4 2566 629 2505 1253
		f 4 1135 2352 -4766 4764
		mu 0 4 2507 627 2570 1254
		f 4 2353 -1200 -4767 4765
		mu 0 4 2570 659 2571 1254
		f 4 -1199 -2352 -4768 4766
		mu 0 4 2571 660 2568 1254
		f 4 -2351 1134 -4765 4767
		mu 0 4 2568 628 2507 1254
		f 4 1137 2354 -4770 4768
		mu 0 4 2509 626 2572 1255
		f 4 2355 -1202 -4771 4769
		mu 0 4 2572 658 2573 1255
		f 4 -1201 -2354 -4772 4770
		mu 0 4 2573 659 2570 1255
		f 4 -2353 1136 -4769 4771
		mu 0 4 2570 627 2509 1255
		f 4 1139 2356 -4774 4772
		mu 0 4 2511 625 2574 1256
		f 4 2357 -1204 -4775 4773
		mu 0 4 2574 657 2575 1256
		f 4 -1203 -2356 -4776 4774
		mu 0 4 2575 658 2572 1256
		f 4 -2355 1138 -4773 4775
		mu 0 4 2572 626 2511 1256
		f 4 1141 2358 -4778 4776
		mu 0 4 2513 624 2576 1257
		f 4 2359 -1206 -4779 4777
		mu 0 4 2576 656 2577 1257
		f 4 -1205 -2358 -4780 4778
		mu 0 4 2577 657 2574 1257
		f 4 -2357 1140 -4777 4779
		mu 0 4 2574 625 2513 1257
		f 4 1143 2360 -4782 4780
		mu 0 4 2515 623 2578 1258
		f 4 2361 -1208 -4783 4781
		mu 0 4 2578 655 2579 1258
		f 4 -1207 -2360 -4784 4782
		mu 0 4 2579 656 2576 1258
		f 4 -2359 1142 -4781 4783
		mu 0 4 2576 624 2515 1258
		f 4 1145 2362 -4786 4784
		mu 0 4 2517 622 2580 1259
		f 4 2363 -1210 -4787 4785
		mu 0 4 2580 654 2581 1259
		f 4 -1209 -2362 -4788 4786
		mu 0 4 2581 655 2578 1259
		f 4 -2361 1144 -4785 4787
		mu 0 4 2578 623 2517 1259
		f 4 1147 2364 -4790 4788
		mu 0 4 2519 621 2582 1260
		f 4 2365 -1212 -4791 4789
		mu 0 4 2582 653 2583 1260
		f 4 -1211 -2364 -4792 4790
		mu 0 4 2583 654 2580 1260
		f 4 -2363 1146 -4789 4791
		mu 0 4 2580 622 2519 1260
		f 4 1149 2366 -4794 4792
		mu 0 4 2521 652 2584 1261
		f 4 2367 -1214 -4795 4793
		mu 0 4 2584 684 2585 1261
		f 4 -1213 -2366 -4796 4794
		mu 0 4 2585 653 2582 1261
		f 4 -2365 1148 -4793 4795
		mu 0 4 2582 621 2521 1261
		f 4 1151 2304 -4798 4796
		mu 0 4 2522 651 2525 1262
		f 4 2305 -1216 -4799 4797
		mu 0 4 2525 683 2586 1262
		f 4 -1215 -2368 -4800 4798
		mu 0 4 2586 684 2584 1262
		f 4 -2367 1150 -4797 4799
		mu 0 4 2584 652 2522 1262
		f 4 -1 -2370 -4802 4800
		mu 0 4 1327 0 2587 1263
		f 4 -2369 2370 -4803 4801
		mu 0 4 2587 685 2588 1263
		f 4 2371 -2 -4801 4802
		mu 0 4 2588 1 1327 1263
		f 4 -3 -2372 -4805 4803
		mu 0 4 1331 1 2588 1264
		f 4 -2371 2372 -4806 4804
		mu 0 4 2588 685 2589 1264
		f 4 2373 -4 -4804 4805
		mu 0 4 2589 2 1331 1264
		f 4 -5 -2374 -4808 4806
		mu 0 4 1334 2 2589 1265
		f 4 -2373 2374 -4809 4807
		mu 0 4 2589 685 2590 1265
		f 4 2375 -6 -4807 4808
		mu 0 4 2590 3 1334 1265
		f 4 -7 -2376 -4811 4809
		mu 0 4 1337 3 2590 1266
		f 4 -2375 2376 -4812 4810
		mu 0 4 2590 685 2591 1266
		f 4 2377 -8 -4810 4811
		mu 0 4 2591 4 1337 1266
		f 4 -9 -2378 -4814 4812
		mu 0 4 1340 4 2591 1267
		f 4 -2377 2378 -4815 4813
		mu 0 4 2591 685 2592 1267
		f 4 2379 -10 -4813 4814
		mu 0 4 2592 5 1340 1267
		f 4 -11 -2380 -4817 4815
		mu 0 4 1343 5 2592 1268
		f 4 -2379 2380 -4818 4816
		mu 0 4 2592 685 2593 1268
		f 4 2381 -12 -4816 4817
		mu 0 4 2593 6 1343 1268
		f 4 -13 -2382 -4820 4818
		mu 0 4 1346 6 2593 1269
		f 4 -2381 2382 -4821 4819
		mu 0 4 2593 685 2594 1269
		f 4 2383 -14 -4819 4820
		mu 0 4 2594 7 1346 1269
		f 4 -15 -2384 -4823 4821
		mu 0 4 1349 7 2594 1270
		f 4 -2383 2384 -4824 4822
		mu 0 4 2594 685 2595 1270
		f 4 2385 -16 -4822 4823
		mu 0 4 2595 8 1349 1270
		f 4 -17 -2386 -4826 4824
		mu 0 4 1352 8 2595 1271
		f 4 -2385 2386 -4827 4825
		mu 0 4 2595 685 2596 1271
		f 4 2387 -18 -4825 4826
		mu 0 4 2596 9 1352 1271
		f 4 -19 -2388 -4829 4827
		mu 0 4 1355 9 2596 1272
		f 4 -2387 2388 -4830 4828
		mu 0 4 2596 685 2597 1272
		f 4 2389 -20 -4828 4829
		mu 0 4 2597 10 1355 1272
		f 4 -21 -2390 -4832 4830
		mu 0 4 1358 10 2597 1273
		f 4 -2389 2390 -4833 4831
		mu 0 4 2597 685 2598 1273
		f 4 2391 -22 -4831 4832
		mu 0 4 2598 11 1358 1273
		f 4 -23 -2392 -4835 4833
		mu 0 4 1361 11 2598 1274
		f 4 -2391 2392 -4836 4834
		mu 0 4 2598 685 2599 1274
		f 4 2393 -24 -4834 4835
		mu 0 4 2599 12 1361 1274
		f 4 -25 -2394 -4838 4836
		mu 0 4 1364 12 2599 1275
		f 4 -2393 2394 -4839 4837
		mu 0 4 2599 685 2600 1275
		f 4 2395 -26 -4837 4838
		mu 0 4 2600 13 1364 1275
		f 4 -27 -2396 -4841 4839
		mu 0 4 1367 13 2600 1276
		f 4 -2395 2396 -4842 4840
		mu 0 4 2600 685 2601 1276
		f 4 2397 -28 -4840 4841
		mu 0 4 2601 14 1367 1276
		f 4 -29 -2398 -4844 4842
		mu 0 4 1370 14 2601 1277
		f 4 -2397 2398 -4845 4843
		mu 0 4 2601 685 2602 1277
		f 4 2399 -30 -4843 4844
		mu 0 4 2602 15 1370 1277
		f 4 -31 -2400 -4847 4845
		mu 0 4 1373 15 2602 1278
		f 4 -2399 2400 -4848 4846
		mu 0 4 2602 685 2603 1278
		f 4 2401 -32 -4846 4847
		mu 0 4 2603 16 1373 1278
		f 4 -33 -2402 -4850 4848
		mu 0 4 1376 16 2603 1279
		f 4 -2401 2402 -4851 4849
		mu 0 4 2603 685 2604 1279
		f 4 2403 -34 -4849 4850
		mu 0 4 2604 17 1376 1279
		f 4 -35 -2404 -4853 4851
		mu 0 4 1379 17 2604 1280
		f 4 -2403 2404 -4854 4852
		mu 0 4 2604 685 2605 1280
		f 4 2405 -36 -4852 4853
		mu 0 4 2605 18 1379 1280
		f 4 -37 -2406 -4856 4854
		mu 0 4 1382 18 2605 1281
		f 4 -2405 2406 -4857 4855
		mu 0 4 2605 685 2606 1281
		f 4 2407 -38 -4855 4856
		mu 0 4 2606 19 1382 1281
		f 4 -39 -2408 -4859 4857
		mu 0 4 1385 19 2606 1282
		f 4 -2407 2408 -4860 4858
		mu 0 4 2606 685 2607 1282
		f 4 2409 -40 -4858 4859
		mu 0 4 2607 20 1385 1282
		f 4 -41 -2410 -4862 4860
		mu 0 4 1388 20 2607 1283
		f 4 -2409 2410 -4863 4861
		mu 0 4 2607 685 2608 1283
		f 4 2411 -42 -4861 4862
		mu 0 4 2608 21 1388 1283
		f 4 -43 -2412 -4865 4863
		mu 0 4 1391 21 2608 1284
		f 4 -2411 2412 -4866 4864
		mu 0 4 2608 685 2609 1284
		f 4 2413 -44 -4864 4865
		mu 0 4 2609 22 1391 1284
		f 4 -45 -2414 -4868 4866
		mu 0 4 1394 22 2609 1285
		f 4 -2413 2414 -4869 4867
		mu 0 4 2609 685 2610 1285
		f 4 2415 -46 -4867 4868
		mu 0 4 2610 23 1394 1285
		f 4 -47 -2416 -4871 4869
		mu 0 4 1397 23 2610 1286
		f 4 -2415 2416 -4872 4870
		mu 0 4 2610 685 2611 1286
		f 4 2417 -48 -4870 4871
		mu 0 4 2611 24 1397 1286
		f 4 -49 -2418 -4874 4872
		mu 0 4 1400 24 2611 1287
		f 4 -2417 2418 -4875 4873
		mu 0 4 2611 685 2612 1287
		f 4 2419 -50 -4873 4874
		mu 0 4 2612 25 1400 1287
		f 4 -51 -2420 -4877 4875
		mu 0 4 1403 25 2612 1288
		f 4 -2419 2420 -4878 4876
		mu 0 4 2612 685 2613 1288
		f 4 2421 -52 -4876 4877
		mu 0 4 2613 26 1403 1288
		f 4 -53 -2422 -4880 4878
		mu 0 4 1406 26 2613 1289
		f 4 -2421 2422 -4881 4879
		mu 0 4 2613 685 2614 1289
		f 4 2423 -54 -4879 4880
		mu 0 4 2614 27 1406 1289
		f 4 -55 -2424 -4883 4881
		mu 0 4 1409 27 2614 1290
		f 4 -2423 2424 -4884 4882
		mu 0 4 2614 685 2615 1290
		f 4 2425 -56 -4882 4883
		mu 0 4 2615 28 1409 1290
		f 4 -57 -2426 -4886 4884
		mu 0 4 1412 28 2615 1291
		f 4 -2425 2426 -4887 4885
		mu 0 4 2615 685 2616 1291
		f 4 2427 -58 -4885 4886
		mu 0 4 2616 29 1412 1291
		f 4 -59 -2428 -4889 4887
		mu 0 4 1415 29 2616 1292
		f 4 -2427 2428 -4890 4888
		mu 0 4 2616 685 2617 1292
		f 4 2429 -60 -4888 4889
		mu 0 4 2617 30 1415 1292
		f 4 -61 -2430 -4892 4890
		mu 0 4 1418 30 2617 1293
		f 4 -2429 2430 -4893 4891
		mu 0 4 2617 685 2618 1293
		f 4 2431 -62 -4891 4892
		mu 0 4 2618 31 1418 1293
		f 4 -63 -2432 -4895 4893
		mu 0 4 1421 31 2618 1294
		f 4 -2431 2368 -4896 4894
		mu 0 4 2618 685 2587 1294
		f 4 2369 -64 -4894 4895
		mu 0 4 2587 0 1421 1294
		f 4 1153 2434 -4898 4896
		mu 0 4 2524 682 2619 1295
		f 4 2435 -2434 -4899 4897
		mu 0 4 2619 686 2620 1295
		f 4 -2433 1152 -4897 4898
		mu 0 4 2620 683 2524 1295
		f 4 1155 2436 -4901 4899
		mu 0 4 2527 681 2621 1296
		f 4 2437 -2436 -4902 4900
		mu 0 4 2621 686 2619 1296
		f 4 -2435 1154 -4900 4901
		mu 0 4 2619 682 2527 1296
		f 4 1157 2438 -4904 4902
		mu 0 4 2529 680 2622 1297
		f 4 2439 -2438 -4905 4903
		mu 0 4 2622 686 2621 1297
		f 4 -2437 1156 -4903 4904
		mu 0 4 2621 681 2529 1297
		f 4 1159 2440 -4907 4905
		mu 0 4 2531 679 2623 1298
		f 4 2441 -2440 -4908 4906
		mu 0 4 2623 686 2622 1298
		f 4 -2439 1158 -4906 4907
		mu 0 4 2622 680 2531 1298
		f 4 1161 2442 -4910 4908
		mu 0 4 2533 678 2624 1299
		f 4 2443 -2442 -4911 4909
		mu 0 4 2624 686 2623 1299
		f 4 -2441 1160 -4909 4910
		mu 0 4 2623 679 2533 1299
		f 4 1163 2444 -4913 4911
		mu 0 4 2535 677 2625 1300
		f 4 2445 -2444 -4914 4912
		mu 0 4 2625 686 2624 1300
		f 4 -2443 1162 -4912 4913
		mu 0 4 2624 678 2535 1300
		f 4 1165 2446 -4916 4914
		mu 0 4 2537 676 2626 1301
		f 4 2447 -2446 -4917 4915
		mu 0 4 2626 686 2625 1301
		f 4 -2445 1164 -4915 4916
		mu 0 4 2625 677 2537 1301
		f 4 1167 2448 -4919 4917
		mu 0 4 2539 675 2627 1302
		f 4 2449 -2448 -4920 4918
		mu 0 4 2627 686 2626 1302
		f 4 -2447 1166 -4918 4919
		mu 0 4 2626 676 2539 1302
		f 4 1169 2450 -4922 4920
		mu 0 4 2541 674 2628 1303
		f 4 2451 -2450 -4923 4921
		mu 0 4 2628 686 2627 1303
		f 4 -2449 1168 -4921 4922
		mu 0 4 2627 675 2541 1303
		f 4 1171 2452 -4925 4923
		mu 0 4 2543 673 2629 1304
		f 4 2453 -2452 -4926 4924
		mu 0 4 2629 686 2628 1304
		f 4 -2451 1170 -4924 4925
		mu 0 4 2628 674 2543 1304
		f 4 1173 2454 -4928 4926
		mu 0 4 2545 672 2630 1305
		f 4 2455 -2454 -4929 4927
		mu 0 4 2630 686 2629 1305
		f 4 -2453 1172 -4927 4928
		mu 0 4 2629 673 2545 1305
		f 4 1175 2456 -4931 4929
		mu 0 4 2547 671 2631 1306
		f 4 2457 -2456 -4932 4930
		mu 0 4 2631 686 2630 1306
		f 4 -2455 1174 -4930 4931
		mu 0 4 2630 672 2547 1306
		f 4 1177 2458 -4934 4932
		mu 0 4 2549 670 2632 1307
		f 4 2459 -2458 -4935 4933
		mu 0 4 2632 686 2631 1307
		f 4 -2457 1176 -4933 4934
		mu 0 4 2631 671 2549 1307
		f 4 1179 2460 -4937 4935
		mu 0 4 2551 669 2633 1308
		f 4 2461 -2460 -4938 4936
		mu 0 4 2633 686 2632 1308
		f 4 -2459 1178 -4936 4937
		mu 0 4 2632 670 2551 1308
		f 4 1181 2462 -4940 4938
		mu 0 4 2553 668 2634 1309
		f 4 2463 -2462 -4941 4939
		mu 0 4 2634 686 2633 1309
		f 4 -2461 1180 -4939 4940
		mu 0 4 2633 669 2553 1309
		f 4 1183 2464 -4943 4941
		mu 0 4 2555 667 2635 1310
		f 4 2465 -2464 -4944 4942
		mu 0 4 2635 686 2634 1310
		f 4 -2463 1182 -4942 4943
		mu 0 4 2634 668 2555 1310
		f 4 1185 2466 -4946 4944
		mu 0 4 2557 666 2636 1311
		f 4 2467 -2466 -4947 4945
		mu 0 4 2636 686 2635 1311
		f 4 -2465 1184 -4945 4946
		mu 0 4 2635 667 2557 1311
		f 4 1187 2468 -4949 4947
		mu 0 4 2559 665 2637 1312
		f 4 2469 -2468 -4950 4948
		mu 0 4 2637 686 2636 1312
		f 4 -2467 1186 -4948 4949
		mu 0 4 2636 666 2559 1312
		f 4 1189 2470 -4952 4950
		mu 0 4 2561 664 2638 1313
		f 4 2471 -2470 -4953 4951
		mu 0 4 2638 686 2637 1313
		f 4 -2469 1188 -4951 4952
		mu 0 4 2637 665 2561 1313
		f 4 1191 2472 -4955 4953
		mu 0 4 2563 663 2639 1314
		f 4 2473 -2472 -4956 4954
		mu 0 4 2639 686 2638 1314
		f 4 -2471 1190 -4954 4955
		mu 0 4 2638 664 2563 1314
		f 4 1193 2474 -4958 4956
		mu 0 4 2565 662 2640 1315
		f 4 2475 -2474 -4959 4957
		mu 0 4 2640 686 2639 1315
		f 4 -2473 1192 -4957 4958
		mu 0 4 2639 663 2565 1315
		f 4 1195 2476 -4961 4959
		mu 0 4 2567 661 2641 1316
		f 4 2477 -2476 -4962 4960
		mu 0 4 2641 686 2640 1316
		f 4 -2475 1194 -4960 4961
		mu 0 4 2640 662 2567 1316
		f 4 1197 2478 -4964 4962
		mu 0 4 2569 660 2642 1317
		f 4 2479 -2478 -4965 4963
		mu 0 4 2642 686 2641 1317
		f 4 -2477 1196 -4963 4964
		mu 0 4 2641 661 2569 1317
		f 4 1199 2480 -4967 4965
		mu 0 4 2571 659 2643 1318
		f 4 2481 -2480 -4968 4966
		mu 0 4 2643 686 2642 1318
		f 4 -2479 1198 -4966 4967
		mu 0 4 2642 660 2571 1318
		f 4 1201 2482 -4970 4968
		mu 0 4 2573 658 2644 1319
		f 4 2483 -2482 -4971 4969
		mu 0 4 2644 686 2643 1319
		f 4 -2481 1200 -4969 4970
		mu 0 4 2643 659 2573 1319
		f 4 1203 2484 -4973 4971
		mu 0 4 2575 657 2645 1320
		f 4 2485 -2484 -4974 4972
		mu 0 4 2645 686 2644 1320
		f 4 -2483 1202 -4972 4973
		mu 0 4 2644 658 2575 1320
		f 4 1205 2486 -4976 4974
		mu 0 4 2577 656 2646 1321
		f 4 2487 -2486 -4977 4975
		mu 0 4 2646 686 2645 1321
		f 4 -2485 1204 -4975 4976
		mu 0 4 2645 657 2577 1321
		f 4 1207 2488 -4979 4977
		mu 0 4 2579 655 2647 1322
		f 4 2489 -2488 -4980 4978
		mu 0 4 2647 686 2646 1322
		f 4 -2487 1206 -4978 4979
		mu 0 4 2646 656 2579 1322
		f 4 1209 2490 -4982 4980
		mu 0 4 2581 654 2648 1323
		f 4 2491 -2490 -4983 4981
		mu 0 4 2648 686 2647 1323
		f 4 -2489 1208 -4981 4982
		mu 0 4 2647 655 2581 1323
		f 4 1211 2492 -4985 4983
		mu 0 4 2583 653 2649 1324
		f 4 2493 -2492 -4986 4984
		mu 0 4 2649 686 2648 1324
		f 4 -2491 1210 -4984 4985
		mu 0 4 2648 654 2583 1324
		f 4 1213 2494 -4988 4986
		mu 0 4 2585 684 2650 1325
		f 4 2495 -2494 -4989 4987
		mu 0 4 2650 686 2649 1325
		f 4 -2493 1212 -4987 4988
		mu 0 4 2649 653 2585 1325
		f 4 1215 2432 -4991 4989
		mu 0 4 2586 683 2620 1326
		f 4 2433 -2496 -4992 4990
		mu 0 4 2620 686 2650 1326
		f 4 -2495 1214 -4990 4991
		mu 0 4 2650 684 2586 1326;
	setAttr ".cd" -type "dataPolyComponent" Index_Data Edge 0 ;
	setAttr ".cvd" -type "dataPolyComponent" Index_Data Vertex 0 ;
	setAttr ".pd[0]" -type "dataPolyComponent" Index_Data UV 0 ;
	setAttr ".hfd" -type "dataPolyComponent" Index_Data Face 0 ;
	setAttr ".ndt" 0;
createNode transform -n "camTarget";
	rename -uid "3B61FC08-D144-2A3D-75C2-D0BC0D098411";
	setAttr ".v" no;
createNode locator -n "camTargetShape" -p "camTarget";
	rename -uid "765E59F3-7748-2BEE-98F8-39B116F59F06";
	setAttr -k off ".v";
createNode pointConstraint -n "camTarget_pointConstraint1" -p "camTarget";
	rename -uid "AF40E446-1240-A91D-1A04-A6BBE2F75ADC";
	addAttr -dcb 0 -ci true -k true -sn "w0" -ln "bean_root_jntW0" -dv 1 -min 0 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".o" -type "double3" 0 55 0 ;
	setAttr ".rst" -type "double3" -420 63 0 ;
	setAttr -k on ".w0";
createNode transform -n "shotCam";
	rename -uid "892CF62E-6A45-15CF-B10E-E7BF8A73772A";
createNode camera -n "shotCamShape" -p "shotCam";
	rename -uid "CE4CDF75-BB43-A59F-CDEA-EABB06EDD92A";
	setAttr -k off ".v";
	setAttr ".cap" -type "double2" 1.417 0.945 ;
	setAttr ".fcp" 100000;
	setAttr ".imn" -type "string" "shotCam1";
	setAttr ".den" -type "string" "shotCam1_depth";
	setAttr ".man" -type "string" "shotCam1_mask";
createNode aimConstraint -n "shotCam_aimConstraint1" -p "shotCam";
	rename -uid "69C6C647-DA4B-3FD8-BCFD-BDA930FC351B";
	addAttr -dcb 0 -ci true -sn "w0" -ln "camTargetW0" -dv 1 -at "double";
	setAttr -k on ".nds";
	setAttr -k off ".v";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -k off ".rx";
	setAttr -k off ".ry";
	setAttr -k off ".rz";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr ".erp" yes;
	setAttr ".a" -type "double3" 0 0 -1 ;
	setAttr ".wut" 0;
	setAttr ".rsrr" -type "double3" 2.2518124592418016 3.4682292589170451 2.6302036037666682e-12 ;
	setAttr -k on ".w0";
createNode transform -n "duskSun";
	rename -uid "F947A8A7-6943-E6D0-5336-99A394E232D2";
	setAttr ".ro" 2;
createNode directionalLight -n "duskSunShape" -p "duskSun";
	rename -uid "CAF282FD-D449-08D5-3D03-9D8AA1426848";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 1 0.86000001 0.72000003 ;
	setAttr ".in" 1.1000000238418579;
createNode transform -n "skyFill";
	rename -uid "95094028-434E-E1B8-6D2E-48838BF87CAA";
createNode ambientLight -n "skyFillShape" -p "skyFill";
	rename -uid "5F3BE8A3-8746-CE8D-53D6-2D8608C9EA60";
	setAttr -k off ".v";
	setAttr ".cl" -type "float3" 0.60000008 0.5 0.94999999 ;
	setAttr ".in" 0.079999998211860657;
createNode lightLinker -s -n "lightLinker1";
	rename -uid "C1DF0D77-6744-4C22-F0D1-57B56E7B5201";
	setAttr -s 18 ".lnk";
	setAttr -s 18 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "C33A5CE4-BF40-4EC2-0AF4-799BB84B5DEE";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "FD42EB50-CD43-6C3B-FEC2-8DA6C86C5F0A";
createNode displayLayerManager -n "layerManager";
	rename -uid "14811BF6-9540-9721-B6ED-FAA37B9CB963";
createNode displayLayer -n "defaultLayer";
	rename -uid "8F832904-8846-869B-7098-D0BCEF15FBA0";
	setAttr ".ufem" -type "stringArray" 0  ;
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "39ED3DFD-864F-1DBA-9C5E-DEA2129D824B";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "DE636175-4C4B-EB85-776F-53BA858B1C4C";
	setAttr ".g" yes;
createNode lambert -n "wall_violet";
	rename -uid "588EC1E2-D946-7805-CA24-BFAA847983FD";
createNode file -n "wall_violet_file";
	rename -uid "25EA2C4C-E74E-0724-3E3D-679A922549D9";
	setAttr ".ftn" -type "string" "/Users/jerry/Claude/Maya-Pipeline-Research-Project/demo/textures/windows_violet.png";
	setAttr ".cs" -type "string" "sRGB";
createNode shadingEngine -n "wall_violetSG";
	rename -uid "9C2F977D-DD4A-C383-0F74-E68B45FFF4F2";
	setAttr ".ihi" 0;
	setAttr -s 4 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo1";
	rename -uid "5A980E09-CA41-BFAB-80C0-D49F92995800";
createNode lambert -n "wall_teal";
	rename -uid "CA0511AD-E64E-4D20-2733-BBBCE89CFDBF";
createNode file -n "wall_teal_file";
	rename -uid "F16C1844-6341-8F0C-27ED-C884C1D46E94";
	setAttr ".ftn" -type "string" "/Users/jerry/Claude/Maya-Pipeline-Research-Project/demo/textures/windows_teal.png";
	setAttr ".cs" -type "string" "sRGB";
createNode shadingEngine -n "wall_tealSG";
	rename -uid "F6B7D0F4-954E-1048-9CCB-7D8EF1C2F336";
	setAttr ".ihi" 0;
	setAttr -s 4 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo2";
	rename -uid "5D8B6213-E940-66A7-44CD-31B1E8E70CBA";
createNode lambert -n "wall_brick";
	rename -uid "ED191768-D049-36A9-820F-5D96D30E659F";
createNode file -n "wall_brick_file";
	rename -uid "53A8E55D-6A4B-1519-C7A8-80892542450F";
	setAttr ".ftn" -type "string" "/Users/jerry/Claude/Maya-Pipeline-Research-Project/demo/textures/windows_brick.png";
	setAttr ".cs" -type "string" "sRGB";
createNode shadingEngine -n "wall_brickSG";
	rename -uid "C302C9E2-F64C-2382-4A76-76A3BE6DEF12";
	setAttr ".ihi" 0;
	setAttr -s 4 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo3";
	rename -uid "4B34B121-3940-63B7-29B4-9E9B224BD37F";
createNode lambert -n "roof_mat";
	rename -uid "BDF56876-9044-437E-0B0E-9C9C48C7E2B0";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.62 0.57999998 0.69999999 ;
createNode shadingEngine -n "roof_matSG";
	rename -uid "16DEAD6C-0241-8042-3982-24881CBC170C";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo4";
	rename -uid "5C8721B0-394E-23E6-2FEB-2A9B388CEB52";
createNode polyCube -n "polyCube1";
	rename -uid "A0DF7FAF-7F49-1A3A-CCF7-47A67B9E42BE";
	setAttr ".w" 620;
	setAttr ".h" 8;
	setAttr ".d" 500;
createNode polyCube -n "polyCube2";
	rename -uid "365F8DED-DA46-4B66-16B9-DB99D49A5C07";
	setAttr ".w" 670;
	setAttr ".h" 8;
	setAttr ".d" 520;
createNode lambert -n "tank_mat";
	rename -uid "8BEAD02A-3243-C675-092D-84AFE382BD05";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.44999999 0.75 0.94999999 ;
createNode shadingEngine -n "tank_matSG";
	rename -uid "BCD5E665-2A40-9FC5-63BC-D6AB715754BC";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo5";
	rename -uid "058B8D78-5348-967F-9667-3681ED729365";
createNode polyCylinder -n "polyCylinder1";
	rename -uid "8DBDF568-5C4F-1E64-7D4D-29A2F5E2BDAE";
	setAttr ".r" 60;
	setAttr ".h" 110;
	setAttr ".sa" 32;
createNode polyCube -n "polyCube3";
	rename -uid "0528A23F-EC47-F44A-8255-12BB01EE3B9A";
	setAttr ".w" 110;
	setAttr ".h" 60;
	setAttr ".d" 110;
createNode polyCone -n "polyCone1";
	rename -uid "02EE2C79-3744-FE39-31E5-B6BC105E7AC2";
	setAttr ".r" 66;
	setAttr ".h" 40;
	setAttr ".sa" 32;
createNode lambert -n "stand_mat";
	rename -uid "EBED4449-364B-F951-E0E5-B0BFA0E27121";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.34999999 0.30000001 0.40000001 ;
createNode shadingEngine -n "stand_matSG";
	rename -uid "E6E91F3B-7449-F66C-1082-95A232270228";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo6";
	rename -uid "35A3A53D-7F41-49D6-2F95-0898F05A33E3";
createNode polyCylinder -n "polyCylinder2";
	rename -uid "13DB3939-5546-9BD3-F0DB-E59D1A27D79B";
	setAttr ".r" 3;
	setAttr ".h" 260;
	setAttr ".sa" 8;
createNode lambert -n "antenna_mat";
	rename -uid "68376C50-804C-39E9-ABB4-D0BDBFD96BAF";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.89999998 0.89999998 0.94999999 ;
createNode shadingEngine -n "antenna_matSG";
	rename -uid "728C1B4E-3F4B-D376-8879-6393050EE840";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo7";
	rename -uid "40C6DAF0-944A-D3EE-8585-6383EE5D88A1";
createNode lambert -n "ac_mat";
	rename -uid "46F33F26-EC43-F866-FF28-4FA78AE93FB3";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.81999999 0.83999997 0.88 ;
createNode shadingEngine -n "ac_matSG";
	rename -uid "428335B9-304D-138A-5BB7-8797CE12D853";
	setAttr ".ihi" 0;
	setAttr -s 3 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo8";
	rename -uid "DA3B6E64-3746-27D7-E271-8BBC2AFADBCC";
createNode polyCube -n "polyCube4";
	rename -uid "DE5A5C14-1043-824D-05FB-7DB98224EEBF";
	setAttr ".w" 56;
	setAttr ".h" 44;
	setAttr ".d" 56;
createNode polyCube -n "polyCube5";
	rename -uid "4939762F-6A4A-FCAD-FBBA-99AF9F849041";
	setAttr ".w" 56;
	setAttr ".h" 44;
	setAttr ".d" 56;
createNode polyCube -n "polyCube6";
	rename -uid "520A18CE-4C44-774B-0BF9-6897BE61DD41";
	setAttr ".w" 56;
	setAttr ".h" 44;
	setAttr ".d" 56;
createNode skinCluster -n "bean_skin";
	rename -uid "A4D66691-3B4D-E61F-85F7-29A7F2460A3E";
	setAttr -s 2498 ".wl";
	setAttr ".wl[0:249].w"
		2 0 0.98871755529699901 1 0.011282444703001052
		2 0 0.98871755280307949 1 0.011282447196920568
		2 0 0.98871755534181194 1 0.011282444658188104
		2 0 0.9887175563192836 1 0.011282443680716469
		2 0 0.98871755687411811 1 0.011282443125881864
		2 0 0.98871755280307949 1 0.011282447196920568
		2 0 0.98871755258270289 1 0.011282447417297163
		2 0 0.98871755614242163 1 0.011282443857578386
		2 0 0.98871755529699901 1 0.011282444703001052
		2 0 0.98871755280307949 1 0.011282447196920568
		2 0 0.98871755534181194 1 0.011282444658188104
		2 0 0.9887175563192836 1 0.011282443680716469
		2 0 0.98871755687411811 1 0.011282443125881864
		2 0 0.98871755280307949 1 0.011282447196920568
		2 0 0.98871755258270289 1 0.011282447417297163
		2 0 0.98871755614242163 1 0.011282443857578386
		2 0 0.98871755529699901 1 0.011282444703001052
		2 0 0.98871755280307949 1 0.011282447196920568
		2 0 0.98871755534181194 1 0.011282444658188104
		2 0 0.9887175563192836 1 0.011282443680716469
		2 0 0.98871755687411811 1 0.011282443125881864
		2 0 0.98871755280307949 1 0.011282447196920568
		2 0 0.98871755258270289 1 0.011282447417297163
		2 0 0.98871755614242163 1 0.011282443857578386
		2 0 0.98871755529699901 1 0.011282444703001052
		2 0 0.98871755280307949 1 0.011282447196920568
		2 0 0.98871755534181194 1 0.011282444658188104
		2 0 0.9887175563192836 1 0.011282443680716469
		2 0 0.98871755687411811 1 0.011282443125881864
		2 0 0.98871755280307949 1 0.011282447196920568
		2 0 0.98871755258270289 1 0.011282447417297163
		2 0 0.98871755614242163 1 0.011282443857578386
		2 0 0.87697353577229686 1 0.12302646422770316
		2 0 0.87697352954522478 1 0.12302647045477529
		2 0 0.87697353483756724 1 0.12302646516243278
		2 0 0.87697355116527753 1 0.12302644883472251
		2 0 0.87697353483756724 1 0.12302646516243278
		2 0 0.87697352954522478 1 0.12302647045477529
		2 0 0.87697353577229686 1 0.12302646422770316
		2 0 0.8769735321929919 1 0.12302646780700807
		2 0 0.87697353577229686 1 0.12302646422770316
		2 0 0.87697352954522478 1 0.12302647045477529
		2 0 0.87697353483756724 1 0.12302646516243278
		2 0 0.87697355116527753 1 0.12302644883472251
		2 0 0.87697353483756724 1 0.12302646516243278
		2 0 0.87697352954522478 1 0.12302647045477529
		2 0 0.87697353577229686 1 0.12302646422770316
		2 0 0.8769735321929919 1 0.12302646780700807
		2 0 0.87697353577229686 1 0.12302646422770316
		2 0 0.87697352954522478 1 0.12302647045477529
		2 0 0.87697353483756724 1 0.12302646516243278
		2 0 0.87697355116527753 1 0.12302644883472251
		2 0 0.87697353483756724 1 0.12302646516243278
		2 0 0.87697352954522478 1 0.12302647045477529
		2 0 0.87697353577229686 1 0.12302646422770316
		2 0 0.8769735321929919 1 0.12302646780700807
		2 0 0.87697353577229686 1 0.12302646422770316
		2 0 0.87697352954522478 1 0.12302647045477529
		2 0 0.87697353483756724 1 0.12302646516243278
		2 0 0.87697355116527753 1 0.12302644883472251
		2 0 0.87697353483756724 1 0.12302646516243278
		2 0 0.87697352954522478 1 0.12302647045477529
		2 0 0.87697353577229686 1 0.12302646422770316
		2 0 0.8769735321929919 1 0.12302646780700807
		2 0 0.66367293636184954 1 0.33632706363815051
		2 0 0.66367294859681059 1 0.33632705140318941
		2 0 0.66367293705512642 1 0.33632706294487352
		2 0 0.66367293245620629 1 0.33632706754379371
		2 0 0.66367293282891071 1 0.33632706717108934
		2 0 0.66367293703105124 1 0.33632706296894871
		2 0 0.66367293046567732 1 0.33632706953432262
		2 0 0.66367293674751027 1 0.33632706325248968
		2 0 0.66367293636184954 1 0.33632706363815051
		2 0 0.66367293463570476 1 0.33632706536429535
		2 0 0.66367293705512642 1 0.33632706294487352
		2 0 0.66367293245620629 1 0.33632706754379371
		2 0 0.66367293282891071 1 0.33632706717108934
		2 0 0.66367293703105124 1 0.33632706296894871
		2 0 0.66367293046567732 1 0.33632706953432262
		2 0 0.66367290652473121 1 0.33632709347526885
		2 0 0.66367292006677725 1 0.33632707993322275
		2 0 0.66367291778316084 1 0.33632708221683916
		2 0 0.66367291609502621 1 0.33632708390497384
		2 0 0.66367293245620629 1 0.33632706754379371
		2 0 0.66367290769958875 1 0.33632709230041125
		2 0 0.66367290910884391 1 0.3363270908911562
		2 0 0.6636729171186917 1 0.33632708288130825
		2 0 0.66367290652473121 1 0.33632709347526873
		2 0 0.66367291859273458 1 0.33632708140726542
		2 0 0.66367289803918128 1 0.33632710196081883
		2 0 0.66367290769958875 1 0.33632709230041125
		2 0 0.66367291108547488 1 0.33632708891452517
		2 0 0.66367290769958875 1 0.33632709230041125
		2 0 0.66367289514774241 1 0.33632710485225753
		2 0 0.66367290229766451 1 0.33632709770233549
		2 0 0.66367290652473143 1 0.33632709347526857
		2 0 0.52597477566994277 1 0.47402522433005717
		2 0 0.52597478231204553 1 0.47402521768795453
		2 0 0.52597477610434806 1 0.47402522389565205
		2 0 0.5259747765866174 1 0.47402522341338266
		2 0 0.52597477304552687 1 0.47402522695447308
		2 0 0.52597477174005947 1 0.47402522825994053
		2 0 0.52597476785445041 1 0.47402523214554954
		2 0 0.52597476903717955 1 0.4740252309628204
		2 0 0.5259747700773989 1 0.47402522992260115
		2 0 0.52597477019631045 1 0.4740252298036895
		2 0 0.52597476555212097 1 0.47402523444787903
		2 0 0.52597476314314229 1 0.47402523685685782
		2 0 0.52597476099461904 1 0.47402523900538096
		2 0 0.52597476170306312 1 0.47402523829693693
		2 0 0.52597475772909774 1 0.47402524227090231
		2 0 0.52597475274123429 1 0.47402524725876566
		2 0 0.52597475224005319 1 0.47402524775994687
		2 0 0.52597475098336088 1 0.47402524901663917
		2 0 0.52597474897445007 1 0.47402525102554999
		2 0 0.52597474969967672 1 0.47402525030032328
		2 0 0.52597474593611859 1 0.47402525406388141
		2 0 0.52597474214876838 1 0.47402525785123162
		2 0 0.52597474240861297 1 0.47402525759138703
		2 0 0.52597474187727944 1 0.47402525812272051
		2 0 0.52597473959786012 1 0.47402526040213983
		2 0 0.525974735749559 1 0.474025264250441
		2 0 0.52597473691331631 1 0.47402526308668369
		2 0 0.52597473433572828 1 0.47402526566427178
		2 0 0.52597473238655157 1 0.47402526761344838
		2 0 0.52597473263146943 1 0.47402526736853057
		2 0 0.52597472748553753 1 0.47402527251446241
		2 0 0.52597473101333037 1 0.47402526898666958
		2 0 0.50127368163440567 1 0.49872631836559445
		2 0 0.50127368195761779 1 0.49872631804238221
		2 0 0.50127368167497732 1 0.49872631832502262
		2 0 0.5012736816583041 1 0.49872631834169595
		2 0 0.50127368159717534 1 0.49872631840282466
		2 0 0.50127368155109453 1 0.49872631844890553
		2 0 0.50127368146409734 1 0.49872631853590266
		2 0 0.50127368130738159 1 0.49872631869261846
		2 0 0.50127368136211947 1 0.49872631863788047
		2 0 0.50127368130159244 1 0.4987263186984075
		2 0 0.50127368103613712 1 0.49872631896386294
		2 0 0.50127368089212554 1 0.49872631910787446
		2 0 0.50127368095884584 1 0.49872631904115422
		2 0 0.50127368080029922 1 0.49872631919970078
		2 0 0.50127368069348088 1 0.49872631930651917
		2 0 0.50127368049472687 1 0.49872631950527307
		2 0 0.50127368046599163 1 0.49872631953400842
		2 0 0.50127368031755515 1 0.49872631968244485
		2 0 0.50127368020943308 1 0.49872631979056686
		2 0 0.50127368022171981 1 0.49872631977828025
		2 0 0.50127368017053209 1 0.49872631982946791
		2 0 0.50127368007542028 1 0.49872631992457972
		2 0 0.5012736796770032 1 0.49872632032299674
		2 0 0.50127367968207293 1 0.49872632031792707
		2 0 0.50127367955004698 1 0.49872632044995308
		2 0 0.50127367928168776 1 0.4987263207183123
		2 0 0.50127367942009837 1 0.49872632057990168
		2 0 0.50127367935977041 1 0.49872632064022959
		2 0 0.50127367923172395 1 0.49872632076827605
		2 0 0.50127367912619325 1 0.49872632087380686
		2 0 0.50127367893281161 1 0.49872632106718839
		2 0 0.50127367914030407 1 0.49872632085969593
		2 1 0.83823578616628291 2 0.16176421383371711
		2 1 0.83823582480238679 2 0.16176417519761324
		2 1 0.83823579101615608 2 0.16176420898384386
		2 1 0.83823578902306284 2 0.16176421097693711
		2 1 0.83823578171585988 2 0.16176421828414017
		2 1 0.83823577620746414 2 0.16176422379253586
		2 1 0.83823576580799708 2 0.16176423419200286
		2 1 0.83823574707453197 2 0.16176425292546801
		2 1 0.83823575361777469 2 0.16176424638222534
		2 1 0.83823574638248699 2 0.16176425361751298
		2 1 0.83823571465049418 2 0.16176428534950582
		2 1 0.83823569743564663 2 0.16176430256435342
		2 1 0.83823570541126513 2 0.16176429458873484
		2 1 0.83823568645892654 2 0.16176431354107346
		2 1 0.83823567369007013 2 0.16176432630992985
		2 1 0.83823564993141608 2 0.16176435006858389
		2 1 0.83823564649643434 2 0.16176435350356561
		2 1 0.83823562875264879 2 0.16176437124735124
		2 1 0.83823561582794115 2 0.16176438417205896
		2 1 0.83823561729666884 2 0.16176438270333124
		2 1 0.83823561117780299 2 0.16176438882219707
		2 1 0.83823559980831774 2 0.16176440019168226
		2 1 0.83823555218226697 2 0.16176444781773308
		2 1 0.83823555278830897 2 0.16176444721169106
		2 1 0.83823553700614395 2 0.16176446299385602
		2 1 0.83823550492698329 2 0.16176449507301666
		2 1 0.83823552147235314 2 0.16176447852764689
		2 1 0.8382355142608473 2 0.16176448573915267
		2 1 0.83823549895439664 2 0.16176450104560336
		2 1 0.83823548633945744 2 0.16176451366054262
		2 1 0.8382354632229666 2 0.16176453677703334
		2 1 0.83823548802623826 2 0.16176451197376168
		2 1 0.7938182336415549 2 0.20618176635844507
		2 1 0.79381827442622543 2 0.20618172557377454
		2 1 0.79381823876113122 2 0.20618176123886878
		2 1 0.79381823665720141 2 0.20618176334279864
		2 1 0.79381822894364262 2 0.20618177105635735
		2 1 0.79381822312892347 2 0.20618177687107653
		2 1 0.79381821215113935 2 0.20618178784886071
		2 1 0.79381819237590168 2 0.2061818076240983
		2 1 0.79381819928301545 2 0.2061818007169845
		2 1 0.79381819164537193 2 0.20618180835462813
		2 1 0.79381815814875656 2 0.20618184185124347
		2 1 0.79381813997658845 2 0.20618186002341149
		2 1 0.7938181483957325 2 0.20618185160426747
		2 1 0.79381812838945176 2 0.20618187161054824
		2 1 0.79381811491051757 2 0.2061818850894824
		2 1 0.79381808983064295 2 0.20618191016935702
		2 1 0.79381808620464189 2 0.20618191379535816
		2 1 0.79381806747412353 2 0.20618193252587641
		2 1 0.79381805383067272 2 0.20618194616932725
		2 1 0.79381805538107642 2 0.20618194461892367
		2 1 0.79381804892194052 2 0.20618195107805945
		2 1 0.79381803692019837 2 0.20618196307980158
		2 1 0.79381798664566627 2 0.2061820133543337
		2 1 0.7938179872854102 2 0.20618201271458977
		2 1 0.79381797062560111 2 0.20618202937439892
		2 1 0.79381793676252377 2 0.20618206323747632
		2 1 0.79381795422797841 2 0.20618204577202157
		2 1 0.79381794661544225 2 0.20618205338455786
		2 1 0.79381793045780269 2 0.20618206954219737
		2 1 0.79381791714134931 2 0.20618208285865072
		2 1 0.79381789273935632 2 0.20618210726064368
		2 1 0.79381791892193176 2 0.20618208107806826
		2 1 0.74118922906558493 2 0.25881077093441507
		2 1 0.74118926894368109 2 0.25881073105631891
		2 1 0.74118923407136139 2 0.25881076592863861
		2 1 0.74118923201419862 2 0.25881076798580138
		2 1 0.74118922447209945 2 0.25881077552790055
		2 1 0.74118921878663191 2 0.25881078121336809
		2 1 0.74118920805286592 2 0.25881079194713402
		2 1 0.74118918871720008 2 0.25881081128279992
		2 1 0.74118919547077988 2 0.25881080452922017
		2 1 0.74118918800290889 2 0.25881081199709111
		2 1 0.74118915525087103 2 0.25881084474912902
		2 1 0.7411891374826427 2 0.25881086251735741
		2 1 0.74118914571464178 2 0.25881085428535822
		2 1 0.74118912615307064 2 0.25881087384692936
		2 1 0.74118911297375334 2 0.25881088702624661
		2 1 0.74118908845136811 2 0.25881091154863195
		2 1 0.74118908490596769 2 0.25881091509403231
		2 1 0.74118906659180273 2 0.25881093340819733
		2 1 0.74118905325162687 2 0.25881094674837307
		2 1 0.74118905476756713 2 0.25881094523243287
		2 1 0.74118904845200906 2 0.25881095154799094
		2 1 0.7411890367170495 2 0.2588109632829505
		2 1 0.74118898756005502 2 0.25881101243994503
		2 1 0.7411889881855781 2 0.2588110118144219
		2 1 0.74118897189609578 2 0.25881102810390422
		2 1 0.74118893878575376 2 0.25881106121424624;
	setAttr ".wl[250:499].w"
		2 1 0.74118895586297229 2 0.25881104413702771
		2 1 0.74118894841965333 2 0.25881105158034662
		2 1 0.74118893262117924 2 0.2588110673788207
		2 1 0.7411889196007353 2 0.25881108039926476
		2 1 0.74118889574117097 2 0.25881110425882897
		2 1 0.74118892134173742 2 0.25881107865826269
		2 1 0.68266895464031818 2 0.31733104535968182
		2 1 0.68266898967087608 2 0.31733101032912392
		2 1 0.68266895903759783 2 0.31733104096240217
		2 1 0.68266895723050147 2 0.31733104276949853
		2 1 0.68266895060521204 2 0.31733104939478801
		2 1 0.682668945610864 2 0.31733105438913606
		2 1 0.68266893618188362 2 0.31733106381811643
		2 1 0.68266891919664163 2 0.31733108080335837
		2 1 0.68266892512926303 2 0.31733107487073692
		2 1 0.682668918569179 2 0.317331081430821
		2 1 0.68266888979844698 2 0.31733111020155297
		2 1 0.6826688741901078 2 0.31733112580989226
		2 1 0.68266888142143278 2 0.31733111857856716
		2 1 0.68266886423774809 2 0.31733113576225191
		2 1 0.68266885266049693 2 0.31733114733950313
		2 1 0.68266883111903132 2 0.31733116888096868
		2 1 0.68266882800460682 2 0.31733117199539324
		2 1 0.68266881191669637 2 0.31733118808330363
		2 1 0.68266880019814158 2 0.31733119980185848
		2 1 0.68266880152980525 2 0.31733119847019475
		2 1 0.6826687959819614 2 0.3173312040180386
		2 1 0.68266878567349421 2 0.31733121432650579
		2 1 0.68266874249198717 2 0.31733125750801283
		2 1 0.68266874304147229 2 0.31733125695852771
		2 1 0.68266872873212792 2 0.31733127126787203
		2 1 0.68266869964665711 2 0.31733130035334289
		2 1 0.68266871464798007 2 0.31733128535201999
		2 1 0.68266870810946623 2 0.31733129189053383
		2 1 0.68266869423144427 2 0.31733130576855573
		2 1 0.68266868279375736 2 0.31733131720624275
		2 1 0.68266866183454733 2 0.31733133816545267
		2 1 0.68266868432312422 2 0.31733131567687572
		2 1 0.62299375803113755 2 0.37700624196886245
		2 1 0.62299378453824006 2 0.37700621546176
		2 1 0.6229937613584936 2 0.3770062386415064
		2 1 0.62299375999109052 2 0.37700624000890942
		2 1 0.62299375497783271 2 0.37700624502216723
		2 1 0.62299375119868405 2 0.377006248801316
		2 1 0.62299374406391494 2 0.377006255936085
		2 1 0.62299373121143586 2 0.37700626878856419
		2 1 0.62299373570056182 2 0.37700626429943818
		2 1 0.62299373073664421 2 0.37700626926335584
		2 1 0.62299370896626138 2 0.37700629103373862
		2 1 0.62299369715566488 2 0.37700630284433517
		2 1 0.62299370262749998 2 0.37700629737250008
		2 1 0.62299368962486323 2 0.37700631037513671
		2 1 0.622993680864531 2 0.37700631913546906
		2 1 0.62299366456442762 2 0.37700633543557244
		2 1 0.62299366220778929 2 0.37700633779221077
		2 1 0.62299365003430962 2 0.37700634996569049
		2 1 0.62299364116705569 2 0.37700635883294442
		2 1 0.62299364217470554 2 0.37700635782529446
		2 1 0.62299363797673557 2 0.37700636202326443
		2 1 0.62299363017647413 2 0.37700636982352592
		2 1 0.62299359750168026 2 0.37700640249831968
		2 1 0.62299359791746722 2 0.37700640208253278
		2 1 0.62299358708980324 2 0.37700641291019682
		2 1 0.6229935650812688 2 0.37700643491873115
		2 1 0.62299357643254205 2 0.37700642356745795
		2 1 0.62299357148494794 2 0.37700642851505212
		2 1 0.62299356098365966 2 0.37700643901634034
		2 1 0.62299355232893583 2 0.37700644767106428
		2 1 0.62299353646942068 2 0.37700646353057926
		2 1 0.62299355348618446 2 0.37700644651381565
		2 1 0.56881868755343379 2 0.43118131244656621
		2 1 0.56881870367531862 2 0.43118129632468138
		2 1 0.56881868957716486 2 0.4311813104228352
		2 1 0.5688186887454969 2 0.43118131125450321
		2 1 0.56881868569638316 2 0.43118131430361684
		2 1 0.56881868339786723 2 0.43118131660213288
		2 1 0.56881867905842964 2 0.43118132094157036
		2 1 0.56881867124142371 2 0.43118132875857634
		2 1 0.5688186739717549 2 0.43118132602824522
		2 1 0.56881867095265082 2 0.43118132904734918
		2 1 0.56881865771168727 2 0.43118134228831267
		2 1 0.56881865052836522 2 0.43118134947163489
		2 1 0.56881865385638986 2 0.43118134614361014
		2 1 0.56881864594805709 2 0.43118135405194291
		2 1 0.56881864061993614 2 0.43118135938006397
		2 1 0.56881863070605188 2 0.43118136929394818
		2 1 0.56881862927272098 2 0.43118137072727897
		2 1 0.56881862186869037 2 0.43118137813130958
		2 1 0.56881861647553889 2 0.43118138352446111
		2 1 0.56881861708840176 2 0.43118138291159835
		2 1 0.56881861453515503 2 0.43118138546484508
		2 1 0.56881860979095888 2 0.43118139020904112
		2 1 0.56881858991782774 2 0.43118141008217231
		2 1 0.56881859017071335 2 0.43118140982928665
		2 1 0.56881858358522186 2 0.43118141641477814
		2 1 0.56881857019941529 2 0.43118142980058471
		2 1 0.56881857710337103 2 0.43118142289662897
		2 1 0.56881857409419545 2 0.43118142590580449
		2 1 0.56881856770720929 2 0.43118143229279077
		2 1 0.56881856244332141 2 0.43118143755667854
		2 1 0.56881855279740923 2 0.43118144720259077
		2 1 0.56881856314717139 2 0.43118143685282867
		2 1 0.52720367087840869 2 0.47279632912159125
		2 1 0.52720367759236464 2 0.47279632240763531
		2 1 0.52720367172119098 2 0.47279632827880896
		2 1 0.52720367137484325 2 0.47279632862515686
		2 1 0.52720367010504054 2 0.47279632989495946
		2 1 0.52720366914782391 2 0.47279633085217604
		2 1 0.52720366734066604 2 0.47279633265933391
		2 1 0.52720366408527564 2 0.47279633591472436
		2 1 0.52720366522232132 2 0.47279633477767868
		2 1 0.52720366396501617 2 0.47279633603498389
		2 1 0.52720365845081973 2 0.47279634154918032
		2 1 0.52720365545932679 2 0.47279634454067315
		2 1 0.52720365684528214 2 0.47279634315471797
		2 1 0.5272036535518585 2 0.4727963464481415
		2 1 0.52720365133296387 2 0.47279634866703607
		2 1 0.52720364720432922 2 0.47279635279567084
		2 1 0.52720364660741892 2 0.47279635339258114
		2 1 0.52720364352401206 2 0.47279635647598794
		2 1 0.52720364127803543 2 0.47279635872196457
		2 1 0.52720364153326194 2 0.47279635846673812
		2 1 0.52720364046996304 2 0.47279635953003707
		2 1 0.52720363849424379 2 0.47279636150575616
		2 1 0.52720363021808347 2 0.47279636978191647
		2 1 0.52720363032339757 2 0.47279636967660243
		2 1 0.52720362758087147 2 0.47279637241912853
		2 1 0.52720362200635629 2 0.47279637799364382
		2 1 0.52720362488150652 2 0.47279637511849348
		2 1 0.52720362362833628 2 0.47279637637166372
		2 1 0.52720362096847773 2 0.47279637903152222
		2 1 0.52720361877633293 2 0.47279638122366707
		2 1 0.52720361475929567 2 0.47279638524070433
		2 1 0.52720361906945101 2 0.47279638093054899
		2 1 0.50383255753910439 2 0.49616744246089567
		2 1 0.5038325585091451 2 0.49616744149085484
		2 1 0.50383255766087054 2 0.49616744233912957
		2 1 0.50383255761082968 2 0.49616744238917027
		2 1 0.5038325574273671 2 0.49616744257263301
		2 1 0.50383255728906706 2 0.49616744271093294
		2 1 0.5038325570279667 2 0.49616744297203325
		2 1 0.50383255655762382 2 0.49616744344237618
		2 1 0.50383255672190563 2 0.49616744327809437
		2 1 0.50383255654024872 2 0.49616744345975139
		2 1 0.50383255574355057 2 0.49616744425644954
		2 1 0.50383255531133575 2 0.49616744468866425
		2 1 0.50383255551158035 2 0.49616744448841971
		2 1 0.5038325550357422 2 0.49616744496425774
		2 1 0.50383255471515376 2 0.49616744528484635
		2 1 0.50383255411864325 2 0.49616744588135675
		2 1 0.5038325540324009 2 0.49616744596759915
		2 1 0.50383255358690637 2 0.49616744641309374
		2 1 0.50383255326240473 2 0.49616744673759527
		2 1 0.50383255329928034 2 0.49616744670071961
		2 1 0.50383255314565345 2 0.49616744685434661
		2 1 0.5038325528601989 2 0.49616744713980104
		2 1 0.50383255166444907 2 0.49616744833555093
		2 1 0.50383255167966479 2 0.49616744832033516
		2 1 0.50383255128342141 2 0.49616744871657853
		2 1 0.50383255047800823 2 0.49616744952199171
		2 1 0.50383255089341361 2 0.4961674491065865
		2 1 0.503832550712354 2 0.49616744928764606
		2 1 0.50383255032805452 2 0.49616744967194548
		2 1 0.50383255001133054 2 0.49616744998866952
		2 1 0.50383254943094391 2 0.49616745056905609
		2 1 0.50383255005368066 2 0.49616744994631934
		2 2 0.78137958012747555 3 0.21862041987252442
		2 2 0.78137962101886238 3 0.21862037898113756
		2 2 0.78137958526044748 3 0.21862041473955246
		2 2 0.78137958315101275 3 0.21862041684898731
		2 2 0.78137957541727077 3 0.21862042458272921
		2 2 0.78137956958733701 3 0.21862043041266299
		2 2 0.78137955858082875 3 0.21862044141917131
		2 2 0.78137953875384802 3 0.218620461246152
		2 2 0.78137954567903467 3 0.21862045432096533
		2 2 0.78137953802140681 3 0.21862046197859322
		2 2 0.78137950443714588 3 0.21862049556285415
		2 2 0.78137948621742959 3 0.21862051378257041
		2 2 0.78137949465860257 3 0.21862050534139746
		2 2 0.7813794745999747 3 0.21862052540002536
		2 2 0.78137946108577261 3 0.21862053891422745
		2 2 0.78137943594027592 3 0.21862056405972408
		2 2 0.78137943230478724 3 0.21862056769521279
		2 2 0.78137941352526041 3 0.21862058647473953
		2 2 0.78137939984611149 3 0.21862060015388848
		2 2 0.78137940140057172 3 0.21862059859942826
		2 2 0.78137939492453556 3 0.21862060507546446
		2 2 0.78137938289139108 3 0.21862061710860903
		2 2 0.78137933248531632 3 0.21862066751468362
		2 2 0.78137933312673424 3 0.21862066687326578
		2 2 0.78137931642333525 3 0.21862068357666484
		2 2 0.78137928247165644 3 0.21862071752834358
		2 2 0.78137929998280875 3 0.21862070001719122
		2 2 0.78137929235035453 3 0.21862070764964547
		2 2 0.78137927615043934 3 0.21862072384956061
		2 2 0.78137926279914416 3 0.21862073720085579
		2 2 0.7813792383333048 3 0.21862076166669514
		2 2 0.78137926458438545 3 0.21862073541561455
		2 2 0.72696800630586389 3 0.27303199369413611
		2 2 0.72696804535647808 3 0.27303195464352198
		2 2 0.7269680112077691 3 0.2730319887922309
		2 2 0.72696800919329307 3 0.27303199080670704
		2 2 0.72696800180769461 3 0.27303199819230539
		2 2 0.72696799624020225 3 0.2730320037597978
		2 2 0.7269679857291651 3 0.2730320142708349
		2 2 0.72696796679472031 3 0.27303203320527969
		2 2 0.72696797340816122 3 0.27303202659183878
		2 2 0.72696796609525083 3 0.27303203390474912
		2 2 0.72696793402282822 3 0.27303206597717178
		2 2 0.72696791662329641 3 0.27303208337670359
		2 2 0.72696792468447879 3 0.27303207531552115
		2 2 0.72696790552881674 3 0.27303209447118326
		2 2 0.7269678926229749 3 0.27303210737702521
		2 2 0.72696786860943752 3 0.27303213139056243
		2 2 0.72696786513760558 3 0.27303213486239442
		2 2 0.72696784720346586 3 0.27303215279653409
		2 2 0.72696783414010369 3 0.27303216585989631
		2 2 0.72696783562458767 3 0.27303216437541239
		2 2 0.72696782944007976 3 0.27303217055992024
		2 2 0.72696781794862486 3 0.27303218205137508
		2 2 0.72696776981165678 3 0.27303223018834316
		2 2 0.72696777042420013 3 0.27303222957579992
		2 2 0.7269677544727311 3 0.27303224552726896
		2 2 0.72696772204944216 3 0.27303227795055784
		2 2 0.72696773877230136 3 0.27303226122769864
		2 2 0.72696773148343441 3 0.2730322685165657
		2 2 0.72696771601278509 3 0.27303228398721485
		2 2 0.72696770326252069 3 0.27303229673747925
		2 2 0.72696767989805244 3 0.27303232010194756
		2 2 0.72696770496739627 3 0.27303229503260379
		2 2 0.65810798346060229 3 0.34189201653939766
		2 2 0.65810801907898198 3 0.34189198092101808
		2 2 0.65810797811659649 3 0.34189202188340351
		2 2 0.6581079880195867 3 0.34189201198041336
		2 2 0.65810797040834668 3 0.34189202959165343
		2 2 0.65810796391574222 3 0.34189203608425778
		2 2 0.6581079445910738 3 0.3418920554089262
		2 2 0.65810795047325366 3 0.34189204952674634
		2 2 0.6581079556466749 3 0.34189204435332504
		2 2 0.65810793127908718 3 0.34189206872091277
		2 2 0.65810793314068017 3 0.34189206685931989
		2 2 0.6581079211598776 3 0.3418920788401224
		2 2 0.65810791047442108 3 0.34189208952557892
		2 2 0.65810791399779378 3 0.34189208600220627
		2 2 0.65810789423369198 3 0.34189210576630802
		2 2 0.65810786942707278 3 0.34189213057292722
		2 2 0.65810786693449963 3 0.34189213306550031
		2 2 0.65810786068447169 3 0.34189213931552842
		2 2 0.65810785069336175 3 0.34189214930663819
		2 2 0.65810785430020224 3 0.3418921456997977;
	setAttr ".wl[500:750].w"
		2 2 0.65810783558253438 3 0.34189216441746567
		2 2 0.65810781674653906 3 0.34189218325346088
		2 2 0.65810781803884932 3 0.34189218196115073
		2 2 0.65810781539631735 3 0.3418921846036827
		2 2 0.65810780405985947 3 0.34189219594014048
		2 2 0.65810778492072819 3 0.34189221507927181
		2 2 0.65810779070855652 3 0.34189220929144348
		2 2 0.65810777788918684 3 0.34189222211081316
		2 2 0.65810776819515637 3 0.34189223180484374
		2 2 0.65810776941322957 3 0.34189223058677054
		2 2 0.65810774382046389 3 0.34189225617953617
		2 2 0.65810776136558025 3 0.3418922386344197
		2 2 0.54203868053278237 3 0.45796131946721769
		2 2 0.54203868434957692 3 0.45796131565042308
		2 2 0.5420386807490557 3 0.45796131925094435
		2 2 0.54203867931438543 3 0.45796132068561451
		2 2 0.54203867943065354 3 0.45796132056934646
		2 2 0.54203867983953702 3 0.45796132016046298
		2 2 0.54203867869342393 3 0.45796132130657607
		2 2 0.54203868065309235 3 0.45796131934690765
		2 2 0.54203868053278237 3 0.45796131946721769
		2 2 0.54203867909228987 3 0.45796132090771019
		2 2 0.5420386807490557 3 0.45796131925094435
		2 2 0.54203867931438543 3 0.45796132068561451
		2 2 0.54203867943065354 3 0.45796132056934646
		2 2 0.54203867548425833 3 0.45796132451574167
		2 2 0.54203867869342393 3 0.45796132130657607
		2 2 0.54203868065309246 3 0.45796131934690759
		2 2 0.54203867544940343 3 0.45796132455059663
		2 2 0.54203867473701073 3 0.45796132526298927
		2 2 0.54203867421038376 3 0.45796132578961618
		2 2 0.54203867931438543 3 0.45796132068561451
		2 2 0.54203867551100626 3 0.45796132448899374
		2 2 0.54203867548425833 3 0.45796132451574167
		2 2 0.54203867452972465 3 0.45796132547027535
		2 2 0.5420386712248535 3 0.4579613287751465
		2 2 0.54203867498956382 3 0.45796132501043613
		2 2 0.54203867293299568 3 0.45796132706700432
		2 2 0.54203867159135954 3 0.45796132840864046
		2 2 0.54203867264761396 3 0.45796132735238598
		2 2 0.54203867159135954 3 0.45796132840864046
		2 2 0.54203866767571041 3 0.45796133232428959
		2 2 0.54203866990618599 3 0.45796133009381407
		2 2 0.5420386712248535 3 0.45796132877514656
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		1 0 1
		2 2 0.5 3 0.5
		2 0 0.9878037700982446 1 0.012196229901755416
		2 0 0.98780377055641999 1 0.012196229443580025
		2 0 0.98780376902389611 1 0.012196230976103955
		2 0 0.98780376902389611 1 0.012196230976103955
		2 0 0.98780377055641999 1 0.012196229443580025
		2 0 0.9878037700982446 1 0.012196229901755416
		2 0 0.98780376702824657 1 0.01219623297175349
		2 0 0.98780376992784547 1 0.012196230072154616
		2 0 0.9878037700982446 1 0.012196229901755416
		2 0 0.98780377055641999 1 0.012196229443580025
		2 0 0.98780376902389611 1 0.012196230976103955
		2 0 0.98780376902389611 1 0.012196230976103955
		2 0 0.98780377055641999 1 0.012196229443580025
		2 0 0.9878037700982446 1 0.012196229901755416
		2 0 0.98780376702824657 1 0.01219623297175349
		2 0 0.98780376992784547 1 0.012196230072154616
		2 0 0.9878037700982446 1 0.012196229901755416
		2 0 0.98780377055641999 1 0.012196229443580025
		2 0 0.98780376902389611 1 0.012196230976103955
		2 0 0.98780376902389611 1 0.012196230976103955
		2 0 0.98780377055641999 1 0.012196229443580025
		2 0 0.9878037700982446 1 0.012196229901755416
		2 0 0.98780376702824657 1 0.01219623297175349
		2 0 0.98780376992784547 1 0.012196230072154616
		2 0 0.9878037700982446 1 0.012196229901755416
		2 0 0.98780377055641999 1 0.012196229443580025
		2 0 0.98780376902389611 1 0.012196230976103955
		2 0 0.98780376902389611 1 0.012196230976103955
		2 0 0.98780377055641999 1 0.012196229443580025
		2 0 0.9878037700982446 1 0.012196229901755416
		2 0 0.98780376702824657 1 0.01219623297175349
		2 0 0.98780376992784547 1 0.012196230072154616
		2 0 0.87697666635048488 1 0.12302333364951515
		2 0 0.87697669568302994 1 0.12302330431697001
		2 0 0.87697669485299234 1 0.1230233051470076
		2 0 0.87697669485299234 1 0.1230233051470076
		2 0 0.87697670056588628 1 0.12302329943411375
		2 0 0.87697666635048488 1 0.12302333364951515
		2 0 0.87697668061962142 1 0.12302331938037858
		2 0 0.87697668061962142 1 0.12302331938037858
		2 0 0.87697666635048488 1 0.12302333364951515
		2 0 0.87697669568302994 1 0.12302330431697001
		2 0 0.87697669485299234 1 0.1230233051470076
		2 0 0.87697669485299234 1 0.1230233051470076
		2 0 0.87697670056588628 1 0.12302329943411375
		2 0 0.87697666635048488 1 0.12302333364951515
		2 0 0.87697668061962142 1 0.12302331938037858
		2 0 0.87697668061962142 1 0.12302331938037858
		2 0 0.87697666635048488 1 0.12302333364951515
		2 0 0.87697669568302994 1 0.12302330431697001
		2 0 0.87697669485299234 1 0.1230233051470076
		2 0 0.87697669485299234 1 0.1230233051470076
		2 0 0.87697670056588628 1 0.12302329943411375
		2 0 0.87697666635048488 1 0.12302333364951515
		2 0 0.87697668061962142 1 0.12302331938037858
		2 0 0.87697668061962142 1 0.12302331938037858
		2 0 0.87697666635048488 1 0.12302333364951515
		2 0 0.87697669568302994 1 0.12302330431697001
		2 0 0.87697669485299234 1 0.1230233051470076
		2 0 0.87697669485299234 1 0.1230233051470076
		2 0 0.87697670056588628 1 0.12302329943411375
		2 0 0.87697666635048488 1 0.12302333364951515
		2 0 0.87697668061962142 1 0.12302331938037858
		2 0 0.87697668061962142 1 0.12302331938037858
		2 0 0.66367594456452605 1 0.33632405543547389
		2 0 0.66367595058338358 1 0.33632404941661653
		2 0 0.66367593711937367 1 0.33632406288062633
		2 0 0.66367594130887109 1 0.33632405869112897
		2 0 0.66367593633612132 1 0.33632406366387868
		2 0 0.66367593579110506 1 0.33632406420889494
		2 0 0.66367592020495469 1 0.33632407979504542
		2 0 0.6636759233525269 1 0.33632407664747316
		2 0 0.66367591564243678 1 0.33632408435756322
		2 0 0.66367591680500237 1 0.33632408319499757
		2 0 0.66367592753258065 1 0.33632407246741941
		2 0 0.66367592962732935 1 0.3363240703726707
		2 0 0.66367593633612132 1 0.33632406366387868
		2 0 0.66367590686901878 1 0.33632409313098127
		2 0 0.66367592057525726 1 0.33632407942474274
		2 0 0.6636759227970731 1 0.33632407720292695
		2 0 0.66367591125572789 1 0.33632408874427205
		2 0 0.66367591680500237 1 0.33632408319499757
		2 0 0.66367590626424744 1 0.33632409373575256
		2 0 0.66367591794578806 1 0.33632408205421194
		2 0 0.66367590968137324 1 0.33632409031862676
		2 0 0.66367590686901878 1 0.33632409313098127
		2 0 0.66367592113071139 1 0.33632407886928856
		2 0 0.66367592205646808 1 0.33632407794353192
		2 0 0.66367591125572789 1 0.33632408874427205
		2 0 0.66367590968137324 1 0.33632409031862676
		2 0 0.66367590626424744 1 0.33632409373575256
		2 0 0.66367590626424744 1 0.33632409373575256
		2 0 0.66367590968137324 1 0.33632409031862676
		2 0 0.66367587794693861 1 0.33632412205306139
		2 0 0.66367589142305128 1 0.33632410857694878
		2 0 0.6636759227970731 1 0.33632407720292695
		2 0 0.52597537296556796 1 0.47402462703443199
		2 0 0.52597536581180271 1 0.47402463418819735
		2 0 0.5259753622171871 1 0.47402463778281284
		2 0 0.52597536253601451 1 0.4740246374639856
		2 0 0.52597536097873754 1 0.47402463902126257
		2 0 0.52597536113899857 1 0.47402463886100143
		2 0 0.52597536213073526 1 0.4740246378692648
		2 0 0.52597535517894434 1 0.47402464482105561
		2 0 0.52597535579390553 1 0.47402464420609447
		2 0 0.52597535717999955 1 0.47402464282000045
		2 0 0.52597535112580596 1 0.47402464887419415
		2 0 0.52597535069164103 1 0.47402464930835903
		2 0 0.52597534660651091 1 0.47402465339348909
		2 0 0.52597534554422309 1 0.47402465445577685
		2 0 0.5259753462454877 1 0.47402465375451236
		2 0 0.52597534363481857 1 0.47402465636518137
		2 0 0.52597533743960612 1 0.47402466256039388
		2 0 0.52597533768636651 1 0.47402466231363344
		2 0 0.52597533583531253 1 0.47402466416468753
		2 0 0.52597533464815871 1 0.4740246653518414
		2 0 0.52597533462966384 1 0.47402466537033627
		2 0 0.52597533073789782 1 0.47402466926210218
		2 0 0.52597533065975466 1 0.47402466934024534
		2 0 0.52597533195758894 1 0.47402466804241106
		2 0 0.52597532869339125 1 0.47402467130660869
		2 0 0.52597532649387546 1 0.47402467350612448
		2 0 0.52597532129782387 1 0.47402467870217607
		2 0 0.52597531995125757 1 0.47402468004874254
		2 0 0.52597532265282376 1 0.47402467734717624
		2 0 0.52597531632580174 1 0.47402468367419831
		2 0 0.52597531497420091 1 0.47402468502579909
		2 0 0.52597534356826336 1 0.47402465643173664
		2 0 0.50127370641065738 1 0.49872629358934262
		2 0 0.50127370609214561 1 0.4987262939078545
		2 0 0.5012737058574378 1 0.4987262941425622
		2 0 0.50127370580618591 1 0.49872629419381409
		2 0 0.50127370572343 1 0.49872629427657006
		2 0 0.50127370572259033 1 0.49872629427740967
		2 0 0.50127370569492413 1 0.49872629430507598
		2 0 0.50127370564770979 1 0.49872629435229021
		2 0 0.50127370555433437 1 0.49872629444566557
		2 0 0.50127370542278482 1 0.49872629457721512
		2 0 0.50127370519962688 1 0.49872629480037306
		2 0 0.50127370521552617 1 0.49872629478447378
		1 0 0.50127370500671042;
	setAttr ".wl[750:1000].w"
		1 1 0.49872629499328958
		2 0 0.50127370496456336 1 0.49872629503543658
		2 0 0.50127370490773138 1 0.49872629509226873
		2 0 0.50127370479745537 1 0.49872629520254458
		2 0 0.50127370461937637 1 0.49872629538062369
		2 0 0.50127370438682017 1 0.49872629561317994
		2 0 0.50127370445589015 1 0.49872629554410985
		2 0 0.50127370441546382 1 0.49872629558453624
		2 0 0.50127370428999141 1 0.49872629571000865
		2 0 0.50127370422619577 1 0.49872629577380423
		2 0 0.50127370413215577 1 0.49872629586784434
		2 0 0.50127370393890469 1 0.49872629606109531
		2 0 0.50127370388467041 1 0.49872629611532959
		2 0 0.50127370370921598 1 0.49872629629078402
		2 0 0.50127370354030132 1 0.49872629645969863
		2 0 0.50127370349192568 1 0.49872629650807437
		2 0 0.50127370357327306 1 0.49872629642672689
		2 0 0.50127370324826015 1 0.49872629675173979
		2 0 0.50127370308699259 1 0.49872629691300741
		2 0 0.50127370479247724 1 0.49872629520752282
		2 1 0.83823938898865025 2 0.16176061101134975
		2 1 0.83823935091541846 2 0.16176064908458154
		2 1 0.83823932285969682 2 0.16176067714030318
		2 1 0.83823931673332275 2 0.16176068326667728
		2 1 0.83823930684110803 2 0.16176069315889199
		2 1 0.83823930674073455 2 0.16176069325926548
		2 1 0.83823930343366437 2 0.16176069656633571
		2 1 0.83823929778991035 2 0.16176070221008965
		2 1 0.83823928662830804 2 0.16176071337169196
		2 1 0.83823927090354122 2 0.16176072909645875
		2 1 0.83823924422840967 2 0.1617607557715903
		2 1 0.83823924612894263 2 0.16176075387105743
		2 1 0.83823922116817207 2 0.16176077883182796
		2 1 0.83823921613011543 2 0.1617607838698846
		2 1 0.83823920933671225 2 0.16176079066328772
		2 1 0.83823919615492304 2 0.16176080384507699
		2 1 0.8382391748682303 2 0.16176082513176979
		2 1 0.83823914706964597 2 0.16176085293035405
		2 1 0.83823915532593218 2 0.16176084467406784
		2 1 0.83823915049358622 2 0.16176084950641384
		2 1 0.83823913549523799 2 0.16176086450476204
		2 1 0.8382391278694431 2 0.16176087213055687
		2 1 0.83823911662835493 2 0.16176088337164507
		2 1 0.83823909352809733 2 0.16176090647190272
		2 1 0.83823908704520056 2 0.16176091295479952
		2 1 0.83823906607223797 2 0.161760933927762
		2 1 0.83823904588106624 2 0.16176095411893376
		2 1 0.83823904009845496 2 0.16176095990154507
		2 1 0.83823904982230568 2 0.16176095017769426
		2 1 0.83823901097186471 2 0.16176098902813529
		2 1 0.83823899169475313 2 0.1617610083052469
		2 1 0.83823919555981663 2 0.16176080444018331
		2 1 0.79382203682932972 2 0.2061779631706703
		2 1 0.79382199663859487 2 0.20617800336140515
		2 1 0.7938219670225114 2 0.20617803297748863
		2 1 0.79382196055540999 2 0.20617803944459009
		2 1 0.79382195011302492 2 0.20617804988697502
		2 1 0.79382195000706912 2 0.20617804999293093
		2 1 0.7938219465160713 2 0.2061780534839287
		2 1 0.79382194055843169 2 0.20617805944156836
		2 1 0.79382192877606084 2 0.20617807122393916
		2 1 0.7938219121767387 2 0.20617808782326133
		2 1 0.79382188401803278 2 0.2061781159819672
		2 1 0.79382188602426629 2 0.20617811397573371
		2 1 0.79382185967526908 2 0.20617814032473089
		2 1 0.79382185435701424 2 0.20617814564298581
		2 1 0.79382184718578708 2 0.20617815281421295
		2 1 0.79382183327087552 2 0.20617816672912445
		2 1 0.79382181080029668 2 0.20617818919970338
		2 1 0.79382178145566018 2 0.20617821854433979
		2 1 0.79382179017112964 2 0.20617820982887033
		2 1 0.79382178507002699 2 0.20617821492997301
		2 1 0.79382176923752779 2 0.20617823076247227
		2 1 0.79382176118761549 2 0.20617823881238451
		2 1 0.79382174932134131 2 0.20617825067865869
		2 1 0.79382172493633707 2 0.20617827506366296
		2 1 0.79382171809288671 2 0.20617828190711324
		2 1 0.79382169595349072 2 0.20617830404650936
		2 1 0.79382167463936604 2 0.20617832536063399
		2 1 0.79382166853514891 2 0.20617833146485112
		2 1 0.79382167879980159 2 0.20617832120019844
		2 1 0.79382163778865489 2 0.20617836221134511
		2 1 0.79382161743942858 2 0.20617838256057144
		2 1 0.7938218326426717 2 0.20617816735732827
		2 1 0.74119294772637212 2 0.25880705227362788
		2 1 0.74119290842876717 2 0.25880709157123283
		2 1 0.74119287947082235 2 0.25880712052917759
		2 1 0.74119287314743532 2 0.25880712685256468
		2 1 0.74119286293710518 2 0.25880713706289488
		2 1 0.74119286283350383 2 0.25880713716649617
		2 1 0.74119285942008439 2 0.25880714057991561
		2 1 0.74119285359483777 2 0.25880714640516223
		2 1 0.7411928420742997 2 0.2588071579257003
		2 1 0.74119282584385515 2 0.2588071741561449
		2 1 0.74119279831090523 2 0.25880720168909477
		2 1 0.74119280027255519 2 0.25880719972744476
		2 1 0.74119277450909904 2 0.25880722549090096
		2 1 0.74119276930902944 2 0.25880723069097061
		2 1 0.74119276229716535 2 0.2588072377028347
		2 1 0.74119274869147878 2 0.25880725130852128
		2 1 0.74119272672025449 2 0.25880727327974551
		2 1 0.74119269802773335 2 0.25880730197226665
		2 1 0.74119270654952196 2 0.25880729345047804
		2 1 0.7411927015617793 2 0.25880729843822076
		2 1 0.74119268608112043 2 0.25880731391887951
		2 1 0.74119267821009893 2 0.25880732178990107
		2 1 0.74119266660752536 2 0.25880733339247458
		2 1 0.74119264276442254 2 0.25880735723557746
		2 1 0.74119263607305275 2 0.25880736392694731
		2 1 0.74119261442565543 2 0.25880738557434463
		2 1 0.74119259358519074 2 0.25880740641480926
		2 1 0.74119258761662654 2 0.2588074123833734
		2 1 0.74119259765316969 2 0.25880740234683025
		2 1 0.74119255755340796 2 0.25880744244659204
		2 1 0.7411925376564007 2 0.2588074623435993
		2 1 0.74119274807723523 2 0.25880725192276482
		2 1 0.68267222127441163 2 0.31732777872558832
		2 1 0.68267218675357644 2 0.31732781324642356
		2 1 0.68267216131557873 2 0.31732783868442138
		2 1 0.68267215576082307 2 0.31732784423917693
		2 1 0.68267214679159716 2 0.31732785320840279
		2 1 0.68267214670058907 2 0.31732785329941099
		2 1 0.68267214370208362 2 0.31732785629791632
		2 1 0.68267213858491815 2 0.31732786141508185
		2 1 0.68267212846474534 2 0.3173278715352546
		2 1 0.68267211420717355 2 0.3173278857928265
		2 1 0.68267209002096052 2 0.31732790997903954
		2 1 0.68267209174416421 2 0.31732790825583573
		2 1 0.68267206911235678 2 0.31732793088764327
		2 1 0.68267206454437612 2 0.31732793545562388
		2 1 0.68267205838483158 2 0.31732794161516842
		2 1 0.68267204643297019 2 0.31732795356702986
		2 1 0.68267202713243547 2 0.31732797286756453
		2 1 0.68267200192760535 2 0.31732799807239465
		2 1 0.68267200941353634 2 0.31732799058646366
		2 1 0.68267200503207381 2 0.31732799496792619
		2 1 0.68267199143315171 2 0.3173280085668484
		2 1 0.68267198451888467 2 0.31732801548111544
		2 1 0.68267197432665128 2 0.31732802567334872
		2 1 0.68267195338177511 2 0.31732804661822483
		2 1 0.68267194750376881 2 0.31732805249623131
		2 1 0.68267192848770231 2 0.31732807151229775
		2 1 0.68267191018048279 2 0.31732808981951721
		2 1 0.68267190493742269 2 0.31732809506257736
		2 1 0.68267191375398184 2 0.3173280862460181
		2 1 0.68267187852851485 2 0.31732812147148515
		2 1 0.68267186105007338 2 0.31732813894992667
		2 1 0.68267204589339026 2 0.31732795410660974
		2 1 0.62299614669302317 2 0.37700385330697678
		2 1 0.6229961205715 2 0.37700387942850005
		2 1 0.62299610132285732 2 0.37700389867714279
		2 1 0.6229960971196371 2 0.37700390288036295
		2 1 0.62299609033272663 2 0.37700390966727332
		2 1 0.62299609026386171 2 0.37700390973613823
		2 1 0.62299608799492701 2 0.37700391200507299
		2 1 0.62299608412282659 2 0.37700391587717352
		2 1 0.62299607646500776 2 0.37700392353499235
		2 1 0.62299606567646693 2 0.37700393432353319
		2 1 0.62299604737503755 2 0.3770039526249625
		2 1 0.62299604867896596 2 0.37700395132103404
		2 1 0.62299603155373806 2 0.37700396844626199
		2 1 0.62299602809719967 2 0.37700397190280033
		2 1 0.62299602343634364 2 0.37700397656365647
		2 1 0.62299601439250807 2 0.37700398560749188
		2 1 0.62299599978801712 2 0.37700400021198288
		2 1 0.62299598071581463 2 0.37700401928418542
		2 1 0.62299598638033149 2 0.37700401361966845
		2 1 0.62299598306492976 2 0.3770040169350703
		2 1 0.62299597277478347 2 0.37700402722521659
		2 1 0.62299596754283793 2 0.37700403245716207
		2 1 0.62299595983049361 2 0.37700404016950645
		2 1 0.62299594398175029 2 0.37700405601824971
		2 1 0.62299593953393162 2 0.37700406046606849
		2 1 0.62299592514469648 2 0.37700407485530357
		2 1 0.62299591129183784 2 0.3770040887081621
		2 1 0.62299590732447585 2 0.37700409267552415
		2 1 0.62299591399586296 2 0.3770040860041371
		2 1 0.62299588734116562 2 0.37700411265883432
		2 1 0.62299587411543478 2 0.37700412588456517
		2 1 0.62299601398421445 2 0.37700398601578566
		2 1 0.56882019094188963 2 0.43117980905811043
		2 1 0.56882017505444771 2 0.43117982494555235
		2 1 0.56882016334717911 2 0.43117983665282095
		2 1 0.5688201607907275 2 0.43117983920927244
		2 1 0.56882015666284258 2 0.43117984333715742
		2 1 0.56882015662095808 2 0.43117984337904186
		2 1 0.56882015524096352 2 0.43117984475903653
		2 1 0.56882015288590282 2 0.43117984711409724
		2 1 0.56882014822832061 2 0.43117985177167939
		2 1 0.56882014166659367 2 0.43117985833340627
		2 1 0.56882013053543357 2 0.43117986946456638
		2 1 0.56882013132849918 2 0.43117986867150082
		2 1 0.56882012091271983 2 0.43117987908728012
		2 1 0.56882011881040973 2 0.43117988118959033
		2 1 0.56882011597561832 2 0.43117988402438168
		2 1 0.56882011047504388 2 0.43117988952495617
		2 1 0.5688201015924087 2 0.43117989840759124
		2 1 0.5688200899924557 2 0.43117991000754424
		2 1 0.56882009343768603 2 0.43117990656231397
		2 1 0.56882009142121703 2 0.43117990857878297
		2 1 0.56882008516262095 2 0.431179914837379
		2 1 0.56882008198048628 2 0.43117991801951383
		2 1 0.5688200772897416 2 0.43117992271025835
		2 1 0.56882006765033766 2 0.43117993234966234
		2 1 0.56882006494511872 2 0.43117993505488139
		2 1 0.56882005619340603 2 0.43117994380659397
		2 1 0.56882004776792461 2 0.43117995223207545
		2 1 0.56882004535492536 2 0.43117995464507458
		2 1 0.56882004941254649 2 0.43117995058745351
		2 1 0.56882003320082719 2 0.43117996679917275
		2 1 0.5688200251567731 2 0.43117997484322684
		2 1 0.56882011022671453 2 0.43117988977328547
		2 1 0.52720429696501725 2 0.47279570303498275
		2 1 0.52720429034867899 2 0.47279570965132112
		2 1 0.52720428547317688 2 0.47279571452682306
		2 1 0.52720428440854072 2 0.47279571559145933
		2 1 0.52720428268947961 2 0.4727957173105205
		2 1 0.52720428267203678 2 0.47279571732796322
		2 1 0.52720428209733672 2 0.47279571790266323
		2 1 0.52720428111657003 2 0.47279571888343003
		2 1 0.52720427917691604 2 0.47279572082308391
		2 1 0.52720427644427947 2 0.47279572355572058
		2 1 0.527204271808699 2 0.47279572819130106
		2 1 0.5272042721389717 2 0.47279572786102836
		2 1 0.52720426780131191 2 0.47279573219868809
		2 1 0.52720426692580336 2 0.47279573307419676
		2 1 0.52720426574525225 2 0.47279573425474775
		2 1 0.52720426345453342 2 0.47279573654546653
		2 1 0.52720425975535323 2 0.47279574024464677
		2 1 0.5272042549245437 2 0.47279574507545641
		2 1 0.52720425635931245 2 0.47279574364068755
		2 1 0.5272042555195523 2 0.4727957444804477
		2 1 0.52720425291315509 2 0.47279574708684491
		2 1 0.52720425158795281 2 0.47279574841204725
		2 1 0.52720424963448864 2 0.47279575036551136
		2 1 0.52720424562015133 2 0.47279575437984861
		2 1 0.52720424449356107 2 0.47279575550643899
		2 1 0.52720424084890372 2 0.47279575915109628
		2 1 0.52720423734010546 2 0.47279576265989448
		2 1 0.52720423633521019 2 0.47279576366478987
		2 1 0.5272042380250096 2 0.47279576197499051
		2 1 0.52720423127362703 2 0.47279576872637297
		2 1 0.52720422792367483 2 0.47279577207632517
		2 1 0.5272042633511167 2 0.4727957366488833
		2 1 0.50383264799694794 2 0.49616735200305212
		2 1 0.50383264704100994 2 0.49616735295899012
		2 1 0.50383264633659008 2 0.49616735366340992
		2 1 0.50383264618276991 2 0.49616735381723009
		2 1 0.50383264593439758 2 0.49616735406560236
		2 1 0.50383264593187771 2 0.4961673540681224
		1 1 0.50383264584884391;
	setAttr ".wl[1000:1250].w"
		1 2 0.49616735415115604
		2 1 0.50383264570714148 2 0.49616735429285852
		2 1 0.50383264542689721 2 0.49616735457310279
		2 1 0.50383264503208225 2 0.49616735496791786
		2 1 0.50383264436232678 2 0.49616735563767322
		2 1 0.50383264441004494 2 0.49616735558995517
		2 1 0.50383264378333381 2 0.49616735621666619
		2 1 0.50383264365683889 2 0.49616735634316106
		2 1 0.50383264348627133 2 0.49616735651372867
		2 1 0.50383264315530496 2 0.49616735684469515
		2 1 0.50383264262084215 2 0.49616735737915785
		2 1 0.50383264192287969 2 0.49616735807712026
		2 1 0.50383264213017742 2 0.49616735786982258
		2 1 0.50383264200884748 2 0.49616735799115247
		2 1 0.50383264163227148 2 0.49616735836772852
		2 1 0.5038326414408042 2 0.49616735855919575
		2 1 0.50383264115856508 2 0.49616735884143498
		2 1 0.50383264057856791 2 0.49616735942143214
		2 1 0.50383264041579656 2 0.49616735958420344
		2 1 0.50383263988921123 2 0.49616736011078877
		2 1 0.50383263938225498 2 0.49616736061774497
		2 1 0.50383263923706623 2 0.49616736076293388
		2 1 0.50383263948121115 2 0.49616736051878885
		2 1 0.50383263850576165 2 0.4961673614942384
		2 1 0.50383263802175571 2 0.49616736197824429
		2 1 0.50383264314036325 2 0.49616735685963675
		2 2 0.78138339326952733 3 0.21861660673047265
		2 2 0.78138335297356831 3 0.21861664702643172
		2 2 0.78138332327994686 3 0.21861667672005317
		2 2 0.78138331679591377 3 0.21861668320408625
		2 2 0.78138330632618969 3 0.21861669367381031
		2 2 0.78138330621995644 3 0.21861669378004356
		2 2 0.78138330271981893 3 0.21861669728018107
		2 2 0.78138329674658169 3 0.21861670325341834
		2 2 0.78138328493336351 3 0.21861671506663649
		2 2 0.78138326829058302 3 0.21861673170941701
		2 2 0.78138324005815563 3 0.2186167599418444
		2 2 0.78138324206964149 3 0.21861675793035854
		2 2 0.78138321565166102 3 0.21861678434833903
		2 2 0.78138321031948277 3 0.21861678968051723
		2 2 0.78138320312948084 3 0.21861679687051913
		2 2 0.78138318917813954 3 0.21861681082186046
		2 2 0.78138316664873164 3 0.2186168333512683
		2 2 0.78138313722727015 3 0.21861686277272985
		2 2 0.78138314596555691 3 0.21861685403444309
		2 2 0.78138314085109939 3 0.21861685914890067
		2 2 0.78138312497715046 3 0.21861687502284963
		2 2 0.78138311690616347 3 0.21861688309383662
		2 2 0.78138310500882302 3 0.21861689499117695
		2 2 0.78138308055997874 3 0.21861691944002132
		2 2 0.78138307369861226 3 0.21861692630138774
		2 2 0.78138305150125531 3 0.21861694849874469
		2 2 0.78138303013133059 3 0.21861696986866938
		2 2 0.78138302401113291 3 0.21861697598886712
		2 2 0.7813830343026581 3 0.21861696569734185
		2 2 0.78138299318414539 3 0.21861700681585466
		2 2 0.7813829727816457 3 0.21861702721835433
		2 2 0.78138318854829103 3 0.21861681145170891
		2 2 0.72697164780615076 3 0.27302835219384924
		2 2 0.7269716093239238 3 0.2730283906760762
		2 2 0.72697158096682191 3 0.27302841903317815
		2 2 0.72697157477463736 3 0.27302842522536258
		2 2 0.72697156477615954 3 0.2730284352238404
		2 2 0.72697156467470792 3 0.2730284353252922
		2 2 0.7269715613321126 3 0.27302843866788734
		2 2 0.7269715556277333 3 0.2730284443722667
		2 2 0.72697154434623268 3 0.27302845565376732
		2 2 0.72697152845255086 3 0.27302847154744914
		2 2 0.72697150149087786 3 0.27302849850912214
		2 2 0.72697150341182581 3 0.27302849658817419
		2 2 0.72697147818293173 3 0.27302852181706827
		2 2 0.7269714730907576 3 0.27302852690924245
		2 2 0.72697146622438158 3 0.27302853377561842
		2 2 0.72697145290099774 3 0.27302854709900232
		2 2 0.72697143138565146 3 0.27302856861434854
		2 2 0.72697140328846799 3 0.27302859671153201
		2 2 0.72697141163343892 3 0.27302858836656102
		2 2 0.72697140674918637 3 0.27302859325081363
		2 2 0.72697139158973412 3 0.27302860841026588
		2 2 0.72697138388202742 3 0.27302861611797263
		2 2 0.7269713725201945 3 0.27302862747980544
		2 2 0.72697134917180994 3 0.27302865082819
		2 2 0.72697134261927876 3 0.2730286573807213
		2 2 0.72697132142104148 3 0.27302867857895846
		2 2 0.72697130101299401 3 0.2730286989870061
		2 2 0.7269712951682713 3 0.27302870483172864
		2 2 0.7269713049965667 3 0.27302869500343324
		2 2 0.72697126572883242 3 0.27302873427116758
		2 2 0.72697124624466702 3 0.27302875375533298
		2 2 0.726971452299499 3 0.273028547700501
		2 2 0.65811095403324038 3 0.34188904596675962
		2 2 0.65811091845507885 3 0.34188908154492109
		2 2 0.65811090057780419 3 0.34188909942219586
		2 2 0.65811089172159609 3 0.34188910827840391
		2 2 0.65811089441856285 3 0.3418891055814372
		2 2 0.65811089521559696 3 0.3418891047844031
		2 2 0.65811089998234495 3 0.34188910001765499
		2 2 0.65811089262564659 3 0.34188910737435346
		2 2 0.65811087059317186 3 0.34188912940682814
		2 2 0.65811085170007222 3 0.34188914829992789
		2 2 0.65811084354404714 3 0.34188915645595297
		2 2 0.65811084325724456 3 0.34188915674275544
		2 2 0.65811082294046686 3 0.34188917705953314
		2 2 0.6581108176573377 3 0.34188918234266225
		2 2 0.65811082114497166 3 0.34188917885502834
		2 2 0.65811080816120249 3 0.34188919183879751
		2 2 0.65811077735024337 3 0.34188922264975657
		2 2 0.65811077857746902 3 0.34188922142253098
		2 2 0.65811077981337163 3 0.34188922018662837
		2 2 0.65811077390923522 3 0.34188922609076483
		2 2 0.65811076337541496 3 0.34188923662458515
		2 2 0.65811074402029901 3 0.34188925597970105
		2 2 0.65811074346616383 3 0.34188925653383623
		2 2 0.6581107232003085 3 0.34188927679969155
		2 2 0.65811070799952331 3 0.34188929200047663
		2 2 0.65811071100028184 3 0.34188928899971816
		2 2 0.65811069707149827 3 0.34188930292850173
		2 2 0.65811070268882454 3 0.34188929731117546
		2 2 0.65811070381038828 3 0.34188929618961172
		2 2 0.65811067038329985 3 0.34188932961670021
		2 2 0.65811063890147736 3 0.34188936109852264
		2 2 0.65811080799570087 3 0.34188919200429918
		2 2 0.54203961897002106 3 0.45796038102997894
		2 2 0.54203961557890268 3 0.45796038442109732
		2 2 0.54203961664742506 3 0.457960383352575
		2 2 0.54203961795438427 3 0.45796038204561584
		2 2 0.54203961833840575 3 0.4579603816615942
		2 2 0.54203961623305708 3 0.45796038376694287
		2 2 0.54203962075393719 3 0.45796037924606275
		2 2 0.54203962179361687 3 0.45796037820638313
		2 2 0.54203961445874149 3 0.45796038554125851
		2 2 0.54203961031013714 3 0.4579603896898628
		2 2 0.54203961365672126 3 0.45796038634327879
		2 2 0.54203961431020076 3 0.45796038568979919
		2 2 0.54203961418078694 3 0.45796038581921317
		2 2 0.54203961172177795 3 0.45796038827822211
		2 2 0.54203961148630875 3 0.4579603885136912
		2 2 0.54203961217942831 3 0.45796038782057163
		2 2 0.5420396092632217 3 0.45796039073677836
		2 2 0.54203960919899052 3 0.45796039080100953
		2 2 0.54203961066601758 3 0.45796038933398237
		2 2 0.54203961066601758 3 0.45796038933398237
		2 2 0.54203961002316847 3 0.45796038997683153
		2 2 0.5420396072104996 3 0.45796039278950046
		2 2 0.5420396116595888 3 0.4579603883404112
		2 2 0.54203961194838857 3 0.45796038805161138
		2 2 0.54203960857898081 3 0.4579603914210193
		2 2 0.54203960393022621 3 0.45796039606977379
		2 2 0.5420396070218344 3 0.45796039297816554
		2 2 0.54203961066601758 3 0.45796038933398237
		2 2 0.54203960586555089 3 0.45796039413444922
		2 2 0.54203960338346246 3 0.45796039661653765
		2 2 0.54203960239196314 3 0.45796039760803697
		2 2 0.54203961217942831 3 0.45796038782057163
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 0 0.95285770650578194 1 0.047142293494218092
		2 0 0.95285772266687285 1 0.047142277333127244
		2 0 0.95285772066048779 1 0.047142279339512268
		2 0 0.9528577193560005 1 0.04714228064399955
		2 0 0.9528577244523595 1 0.047142275547640528
		2 0 0.95285771136151132 1 0.047142288638488683
		2 0 0.95285770650578194 1 0.047142293494218092
		2 0 0.9528577125966835 1 0.047142287403316524
		2 0 0.95285770650578194 1 0.047142293494218092
		2 0 0.95285772266687285 1 0.047142277333127244
		2 0 0.95285772066048779 1 0.047142279339512268
		2 0 0.9528577193560005 1 0.04714228064399955
		2 0 0.9528577244523595 1 0.047142275547640528
		2 0 0.95285771136151132 1 0.047142288638488683
		2 0 0.95285770650578194 1 0.047142293494218092
		2 0 0.9528577125966835 1 0.047142287403316524
		2 0 0.95285770650578194 1 0.047142293494218092
		2 0 0.95285772266687285 1 0.047142277333127244
		2 0 0.95285772066048779 1 0.047142279339512268
		2 0 0.9528577193560005 1 0.04714228064399955
		2 0 0.9528577244523595 1 0.047142275547640528
		2 0 0.95285771136151132 1 0.047142288638488683
		2 0 0.95285770650578194 1 0.047142293494218092
		2 0 0.9528577125966835 1 0.047142287403316524
		2 0 0.95285770650578194 1 0.047142293494218092
		2 0 0.95285772266687285 1 0.047142277333127244
		2 0 0.95285772066048779 1 0.047142279339512268
		2 0 0.9528577193560005 1 0.04714228064399955
		2 0 0.9528577244523595 1 0.047142275547640528
		2 0 0.95285771136151132 1 0.047142288638488683
		2 0 0.95285770650578194 1 0.047142293494218092
		2 0 0.9528577125966835 1 0.047142287403316524
		1 0 0.77175739900332951;
	setAttr ".wl[1250:1500].w"
		1 1 0.22824260099667046
		2 0 0.77175741781196172 1 0.22824258218803828
		2 0 0.77175740742176369 1 0.22824259257823629
		2 0 0.77175745805980955 1 0.22824254194019047
		2 0 0.77175743652611251 1 0.22824256347388752
		2 0 0.77175741781196172 1 0.22824258218803828
		2 0 0.771757440163094 1 0.22824255983690597
		2 0 0.77175741259604602 1 0.22824258740395395
		2 0 0.77175739900332951 1 0.22824260099667046
		2 0 0.77175741781196172 1 0.22824258218803828
		2 0 0.77175740742176369 1 0.22824259257823629
		2 0 0.77175745805980955 1 0.22824254194019047
		2 0 0.77175743652611251 1 0.22824256347388752
		2 0 0.77175741781196172 1 0.22824258218803828
		2 0 0.771757440163094 1 0.22824255983690597
		2 0 0.77175741259604602 1 0.22824258740395395
		2 0 0.77175739900332951 1 0.22824260099667046
		2 0 0.77175741781196172 1 0.22824258218803828
		2 0 0.77175740742176369 1 0.22824259257823629
		2 0 0.77175745805980955 1 0.22824254194019047
		2 0 0.77175743652611251 1 0.22824256347388752
		2 0 0.77175741781196172 1 0.22824258218803828
		2 0 0.771757440163094 1 0.22824255983690597
		2 0 0.77175741259604602 1 0.22824258740395395
		2 0 0.77175739900332951 1 0.22824260099667046
		2 0 0.77175741781196172 1 0.22824258218803828
		2 0 0.77175740742176369 1 0.22824259257823629
		2 0 0.77175745805980955 1 0.22824254194019047
		2 0 0.77175743652611251 1 0.22824256347388752
		2 0 0.77175741781196172 1 0.22824258218803828
		2 0 0.771757440163094 1 0.22824255983690597
		2 0 0.77175741259604602 1 0.22824258740395395
		2 0 0.57608795159207893 1 0.42391204840792107
		2 0 0.5760879636186228 1 0.4239120363813772
		2 0 0.57608795835976179 1 0.42391204164023827
		2 0 0.57608795348670883 1 0.42391204651329117
		2 0 0.57608795615198072 1 0.42391204384801928
		2 0 0.57608795134733926 1 0.42391204865266069
		2 0 0.57608795429844195 1 0.4239120457015581
		2 0 0.57608794951048525 1 0.42391205048951469
		2 0 0.57608795159207893 1 0.42391204840792107
		2 0 0.5760879450026446 1 0.4239120549973554
		2 0 0.5760879370357308 1 0.4239120629642692
		2 0 0.57608793718036744 1 0.42391206281963267
		2 0 0.57608793697774996 1 0.42391206302224999
		2 0 0.57608793004207692 1 0.42391206995792302
		2 0 0.57608792489153204 1 0.4239120751084679
		2 0 0.57608791876295451 1 0.42391208123704543
		2 0 0.57608793351444165 1 0.42391206648555829
		2 0 0.57608791634327905 1 0.42391208365672089
		2 0 0.57608791144110771 1 0.42391208855889223
		2 0 0.57608791543858184 1 0.42391208456141821
		2 0 0.57608790714151592 1 0.42391209285848408
		2 0 0.57608790310589342 1 0.42391209689410664
		2 0 0.57608789585954667 1 0.42391210414045344
		2 0 0.57608790338919624 1 0.4239120966108037
		2 0 0.57608789998354437 1 0.42391210001645563
		2 0 0.57608788915474818 1 0.42391211084525177
		2 0 0.57608789223790058 1 0.42391210776209942
		2 0 0.57608788826136403 1 0.42391211173863602
		2 0 0.57608788796730082 1 0.4239121120326993
		2 0 0.57608788327146887 1 0.42391211672853113
		2 0 0.57608788265574051 1 0.42391211734425954
		2 0 0.57608788801544164 1 0.4239121119845583
		2 0 0.50774350715739602 1 0.49225649284260392
		2 0 0.50774350910944732 1 0.49225649089055279
		2 0 0.50774350740243113 1 0.49225649259756898
		2 0 0.50774350672331148 1 0.49225649327668852
		2 0 0.50774350670685509 1 0.49225649329314497
		2 0 0.50774350665423673 1 0.49225649334576338
		2 0 0.50774350612881414 1 0.49225649387118581
		2 0 0.50774350518232481 1 0.49225649481767519
		2 0 0.50774350547301927 1 0.49225649452698073
		2 0 0.50774350379239419 1 0.49225649620760581
		2 0 0.5077435039985948 1 0.4922564960014052
		2 0 0.50774350267437085 1 0.49225649732562926
		2 0 0.50774350307733085 1 0.49225649692266921
		2 0 0.50774350211978336 1 0.49225649788021664
		2 0 0.50774350147465053 1 0.49225649852534953
		2 0 0.50774350027426929 1 0.49225649972573066
		2 0 0.50774350010072056 1 0.49225649989927955
		2 0 0.50774349784927053 1 0.49225650215072947
		2 0 0.50774349900568871 1 0.49225650099431123
		2 0 0.50774349862543344 1 0.49225650137456656
		2 0 0.50774349763613491 1 0.49225650236386503
		2 0 0.5077434978983727 1 0.4922565021016273
		2 0 0.50774349529570229 1 0.49225650470429771
		2 0 0.50774349536621854 1 0.49225650463378146
		2 0 0.50774349617342296 1 0.4922565038265771
		2 0 0.50774349461607871 1 0.49225650538392124
		2 0 0.50774349310386591 1 0.49225650689613415
		2 0 0.50774349226282345 1 0.4922565077371765
		2 0 0.50774349310078082 1 0.49225650689921929
		2 0 0.50774349200896418 1 0.49225650799103587
		2 0 0.50774349084102954 1 0.49225650915897046
		2 0 0.5077434920941869 1 0.49225650790581321
		2 1 0.85720239412809496 2 0.14279760587190507
		2 1 0.85720243094339654 2 0.14279756905660343
		2 1 0.85720239874940851 2 0.14279760125059152
		2 1 0.85720238594133857 2 0.1427976140586614
		2 1 0.85720238563097628 2 0.14279761436902375
		2 1 0.85720238463860488 2 0.14279761536139507
		2 1 0.85720237472923289 2 0.14279762527076709
		2 1 0.85720235687861845 2 0.14279764312138149
		2 1 0.85720236236106029 2 0.14279763763893966
		2 1 0.85720233066477924 2 0.14279766933522087
		2 1 0.85720233455368722 2 0.14279766544631275
		2 1 0.85720230957905985 2 0.14279769042094018
		2 1 0.85720231717881246 2 0.1427976828211876
		2 1 0.85720229911963841 2 0.14279770088036156
		2 1 0.85720228695253819 2 0.14279771304746183
		2 1 0.85720226431355484 2 0.14279773568644519
		2 1 0.85720226104045305 2 0.14279773895954698
		2 1 0.85720221857847079 2 0.14279778142152924
		2 1 0.85720224038833159 2 0.14279775961166841
		2 1 0.8572022332167798 2 0.14279776678322018
		2 1 0.85720221455877088 2 0.14279778544122906
		2 1 0.85720221950452746 2 0.14279778049547262
		2 1 0.85720217041857105 2 0.14279782958142889
		2 1 0.85720217174849256 2 0.14279782825150741
		2 1 0.85720218697224426 2 0.14279781302775579
		2 1 0.85720215760096807 2 0.14279784239903201
		2 1 0.85720212908084836 2 0.14279787091915164
		2 1 0.85720211321890927 2 0.14279788678109082
		2 1 0.85720212902266524 2 0.14279787097733473
		2 1 0.85720210843115952 2 0.14279789156884048
		2 1 0.85720208640407314 2 0.14279791359592689
		2 1 0.85720211003844793 2 0.14279788996155207
		2 1 0.8171121610315073 2 0.18288783896849267
		2 1 0.8171122010451094 2 0.1828877989548906
		2 1 0.81711216605429371 2 0.18288783394570626
		2 1 0.8171121521335335 2 0.18288784786646653
		2 1 0.81711215179620855 2 0.18288784820379145
		2 1 0.81711215071762577 2 0.18288784928237423
		2 1 0.81711213994738552 2 0.18288786005261454
		2 1 0.81711212054601456 2 0.18288787945398552
		2 1 0.81711212650473863 2 0.18288787349526137
		2 1 0.81711209205487179 2 0.18288790794512821
		2 1 0.81711209628162518 2 0.18288790371837482
		2 1 0.81711206913735079 2 0.18288793086264918
		2 1 0.8171120773973245 2 0.18288792260267556
		2 1 0.81711205776927742 2 0.18288794223072258
		2 1 0.81711204454517261 2 0.18288795545482744
		2 1 0.81711201993945104 2 0.18288798006054907
		2 1 0.81711201638200193 2 0.18288798361799816
		2 1 0.81711197023118165 2 0.18288802976881835
		2 1 0.81711199393574974 2 0.18288800606425026
		2 1 0.81711198614117742 2 0.18288801385882261
		2 1 0.81711196586227508 2 0.18288803413772503
		2 1 0.81711197123768842 2 0.18288802876231156
		2 1 0.81711191788744775 2 0.18288808211255225
		2 1 0.8171119193329045 2 0.18288808066709547
		2 1 0.81711193587920117 2 0.18288806412079886
		2 1 0.81711190395633126 2 0.18288809604366876
		2 1 0.81711187295856269 2 0.18288812704143734
		2 1 0.81711185571863842 2 0.18288814428136158
		2 1 0.81711187289532494 2 0.182888127104675
		2 1 0.81711185051495938 2 0.18288814948504062
		2 1 0.8171118265742997 2 0.18288817342570027
		2 1 0.81711185226187877 2 0.1828881477381212
		2 1 0.76843994124734283 2 0.23156005875265717
		2 1 0.76843998203391572 2 0.23156001796608433
		2 1 0.76843994636715773 2 0.23156005363284224
		2 1 0.76843993217748086 2 0.23156006782251917
		2 1 0.76843993183363957 2 0.23156006816636038
		2 1 0.76843993073422123 2 0.2315600692657788
		2 1 0.76843991975592529 2 0.23156008024407473
		2 1 0.76843989997976614 2 0.23156010002023397
		2 1 0.76843990605359846 2 0.23156009394640154
		2 1 0.7684398709382434 2 0.23156012906175658
		2 1 0.76843987524664736 2 0.23156012475335261
		2 1 0.76843984757801242 2 0.23156015242198755
		2 1 0.76843985599754838 2 0.23156014400245162
		2 1 0.76843983599033627 2 0.2315601640096637
		2 1 0.76843982251077503 2 0.23156017748922497
		2 1 0.76843979742973356 2 0.23156020257026638
		2 1 0.76843979380356375 2 0.23156020619643625
		2 1 0.76843974676123039 2 0.23156025323876969
		2 1 0.76843977092370841 2 0.23156022907629167
		2 1 0.7684397629785652 2 0.23156023702143483
		2 1 0.768439742307928 2 0.23156025769207203
		2 1 0.76843974778718016 2 0.23156025221281981
		2 1 0.76843969340635665 2 0.23156030659364338
		2 1 0.76843969487973574 2 0.23156030512026429
		2 1 0.76843971174566172 2 0.2315602882543383
		2 1 0.76843967920612921 2 0.23156032079387084
		2 1 0.76843964760957029 2 0.23156035239042977
		2 1 0.76843963003661964 2 0.23156036996338039
		2 1 0.76843964754511107 2 0.23156035245488893
		2 1 0.76843962473242022 2 0.2315603752675798
		2 1 0.76843960032929581 2 0.23156039967070416
		2 1 0.76843962651308506 2 0.23156037348691488
		2 1 0.7124259802569799 2 0.28757401974302005
		2 1 0.71242601822268292 2 0.28757398177731708
		2 1 0.71242598502269938 2 0.28757401497730062
		2 1 0.71242597181440559 2 0.28757402818559435
		2 1 0.71242597149434517 2 0.28757402850565494
		2 1 0.71242597047096434 2 0.28757402952903566
		2 1 0.71242596025194704 2 0.28757403974805307
		2 1 0.71242594184354269 2 0.28757405815645737
		2 1 0.71242594749729782 2 0.28757405250270218
		2 1 0.71242591481058537 2 0.28757408518941463
		2 1 0.71242591882101214 2 0.28757408117898792
		2 1 0.71242589306599191 2 0.28757410693400814
		2 1 0.71242590090321678 2 0.28757409909678316
		2 1 0.71242588227974168 2 0.28757411772025832
		2 1 0.71242586973245281 2 0.28757413026754719
		2 1 0.71242584638606532 2 0.28757415361393462
		2 1 0.71242584301068868 2 0.28757415698931144
		2 1 0.71242579922189786 2 0.28757420077810214
		2 1 0.71242582171324964 2 0.2875741782867503
		2 1 0.71242581431760876 2 0.28757418568239124
		2 1 0.71242579507659509 2 0.28757420492340491
		2 1 0.71242580017689083 2 0.28757419982310917
		2 1 0.71242574955715909 2 0.28757425044284096
		2 1 0.71242575092863591 2 0.28757424907136403
		2 1 0.71242576662807877 2 0.28757423337192117
		2 1 0.71242573633904982 2 0.28757426366095018
		2 1 0.71242570692777785 2 0.28757429307222221
		2 1 0.71242569057021132 2 0.28757430942978868
		2 1 0.71242570686777662 2 0.28757429313222332
		2 1 0.71242568563286213 2 0.28757431436713787
		2 1 0.71242566291751308 2 0.28757433708248692
		2 1 0.71242568729037237 2 0.28757431270962758
		2 1 0.65259087539981142 2 0.34740912460018863
		2 1 0.65259090654990926 2 0.34740909345009074
		2 1 0.6525908793099886 2 0.34740912069001145
		2 1 0.65259086847284886 2 0.34740913152715125
		2 1 0.65259086821024559 2 0.34740913178975436
		2 1 0.65259086737058214 2 0.34740913262941786
		2 1 0.65259085898608404 2 0.34740914101391607
		2 1 0.65259084388235855 2 0.34740915611764145
		2 1 0.6525908485211509 2 0.3474091514788491
		2 1 0.65259082170236182 2 0.34740917829763823
		2 1 0.65259082499283605 2 0.34740917500716401
		2 1 0.65259080386136181 2 0.34740919613863813
		2 1 0.65259081029164656 2 0.34740918970835344
		2 1 0.65259079501146133 2 0.34740920498853878
		2 1 0.65259078471666454 2 0.3474092152833354
		2 1 0.65259076556142626 2 0.34740923443857374
		2 1 0.65259076279199801 2 0.34740923720800199
		2 1 0.65259072686418385 2 0.34740927313581615
		2 1 0.65259074531788119 2 0.34740925468211886
		2 1 0.65259073924990785 2 0.34740926075009215
		2 1 0.65259072346304703 2 0.34740927653695292
		2 1 0.65259072764773618 2 0.34740927235226388
		2 1 0.65259068611527637 2 0.34740931388472374
		2 1 0.65259068724054514 2 0.34740931275945486
		2 1 0.65259070012161813 2 0.34740929987838187
		2 1 0.65259067527008729 2 0.34740932472991276
		1 1 0.65259065113873926;
	setAttr ".wl[1500:1750].w"
		1 2 0.34740934886126074
		2 1 0.65259063771769044 2 0.34740936228230962
		2 1 0.65259065108950953 2 0.34740934891049052
		2 1 0.65259063366669656 2 0.34740936633330344
		2 1 0.65259061502921778 2 0.34740938497078222
		2 1 0.65259063502664971 2 0.34740936497335029
		2 1 0.59476474973465365 2 0.40523525026534629
		2 1 0.5947647711157652 2 0.40523522888423485
		2 1 0.59476475241855942 2 0.40523524758144058
		2 1 0.59476474498005671 2 0.40523525501994329
		2 1 0.59476474479980868 2 0.40523525520019138
		2 1 0.59476474422347225 2 0.40523525577652769
		2 1 0.59476473846843769 2 0.40523526153156231
		2 1 0.59476472810139425 2 0.4052352718986057
		2 1 0.59476473128541418 2 0.40523526871458593
		2 1 0.59476471287727073 2 0.40523528712272922
		2 1 0.59476471513581863 2 0.40523528486418142
		2 1 0.59476470063139053 2 0.40523529936860953
		2 1 0.59476470504507239 2 0.40523529495492761
		2 1 0.59476469455690939 2 0.40523530544309067
		2 1 0.59476468749066635 2 0.40523531250933365
		2 1 0.59476467434270719 2 0.40523532565729281
		2 1 0.59476467244180009 2 0.40523532755819991
		2 1 0.59476464778131821 2 0.40523535221868179
		2 1 0.5947646604477459 2 0.40523533955225405
		2 1 0.59476465628275166 2 0.40523534371724834
		2 1 0.59476464544681307 2 0.40523535455318704
		2 1 0.59476464831914033 2 0.40523535168085967
		2 1 0.59476461981168904 2 0.4052353801883109
		2 1 0.59476462058406221 2 0.4052353794159379
		2 1 0.59476462942549735 2 0.40523537057450271
		2 1 0.59476461236766365 2 0.4052353876323363
		2 1 0.59476459580415686 2 0.40523540419584309
		2 1 0.59476458659208864 2 0.40523541340791136
		2 1 0.594764595770366 2 0.40523540422963394
		2 1 0.59476458381152864 2 0.40523541618847136
		2 1 0.59476457101895741 2 0.40523542898104253
		2 1 0.59476458474498617 2 0.40523541525501394
		2 1 0.54603575133394766 2 0.45396424866605239
		2 1 0.54603576244399399 2 0.45396423755600596
		2 1 0.54603575272855809 2 0.45396424727144191
		2 1 0.54603574886336559 2 0.45396425113663441
		2 1 0.54603574876970518 2 0.45396425123029477
		2 1 0.5460357484702294 2 0.45396425152977055
		2 1 0.54603574547980049 2 0.45396425452019956
		2 1 0.54603574009288092 2 0.45396425990711908
		2 1 0.54603574174736025 2 0.45396425825263981
		2 1 0.5460357321821272 2 0.45396426781787291
		2 1 0.5460357333557132 2 0.4539642666442868
		2 1 0.54603572581892745 2 0.45396427418107266
		2 1 0.54603572811236323 2 0.45396427188763683
		2 1 0.54603572266250777 2 0.45396427733749223
		2 1 0.54603571899074921 2 0.45396428100925079
		2 1 0.54603571215881197 2 0.45396428784118809
		2 1 0.54603571117106331 2 0.45396428882893669
		2 1 0.54603569835699362 2 0.45396430164300638
		2 1 0.54603570493871789 2 0.45396429506128222
		2 1 0.54603570277450497 2 0.45396429722549497
		2 1 0.54603569714393885 2 0.45396430285606121
		2 1 0.54603569863645662 2 0.45396430136354338
		2 1 0.54603568382342671 2 0.45396431617657329
		2 1 0.54603568422476723 2 0.45396431577523289
		2 1 0.54603568881894982 2 0.45396431118105024
		2 1 0.54603567995536573 2 0.45396432004463438
		2 1 0.54603567134864395 2 0.45396432865135611
		2 1 0.54603566656187319 2 0.45396433343812681
		2 1 0.54603567133108544 2 0.45396432866891451
		2 1 0.54603566511703994 2 0.45396433488296012
		2 1 0.54603565846976998 2 0.45396434153022996
		2 1 0.54603566560208261 2 0.45396433439791745
		2 1 0.51297369550017557 2 0.48702630449982443
		2 1 0.51297369875274812 2 0.48702630124725188
		2 1 0.51297369590846098 2 0.48702630409153896
		2 1 0.51297369477688892 2 0.48702630522311113
		2 1 0.51297369474946897 2 0.48702630525053103
		2 1 0.51297369466179443 2 0.48702630533820551
		2 1 0.51297369378631774 2 0.48702630621368226
		2 1 0.51297369220924538 2 0.48702630779075468
		2 1 0.51297369269361004 2 0.48702630730639002
		2 1 0.5129736898932965 2 0.48702631010670355
		2 1 0.512973690236875 2 0.487026309763125
		2 1 0.51297368803040888 2 0.48702631196959112
		2 1 0.51297368870183413 2 0.48702631129816587
		2 1 0.51297368710633673 2 0.48702631289366327
		2 1 0.51297368603139437 2 0.48702631396860568
		2 1 0.51297368403127919 2 0.48702631596872087
		2 1 0.51297368374210639 2 0.48702631625789367
		2 1 0.5129736799906649 2 0.48702632000933505
		2 1 0.51297368191752768 2 0.48702631808247238
		2 1 0.51297368128393361 2 0.48702631871606644
		2 1 0.51297367963553142 2 0.48702632036446863
		2 1 0.51297368007248034 2 0.48702631992751966
		2 1 0.51297367573582409 2 0.48702632426417591
		2 1 0.51297367585332054 2 0.48702632414667951
		2 1 0.51297367719831133 2 0.48702632280168862
		2 1 0.51297367460341237 2 0.48702632539658763
		2 1 0.51297367208371236 2 0.48702632791628758
		2 1 0.51297367068233957 2 0.48702632931766043
		2 1 0.51297367207857192 2 0.48702632792142803
		2 1 0.51297367025935081 2 0.48702632974064924
		2 1 0.51297366831329916 2 0.4870263316867009
		2 1 0.51297367040135167 2 0.48702632959864828
		2 1 0.50008827374450193 2 0.49991172625549818
		2 1 0.50008827376692933 2 0.49991172623307079
		2 1 0.50008827374731724 2 0.49991172625268282
		2 1 0.5000882737395147 2 0.4999117262604853
		2 1 0.50008827373932574 2 0.49991172626067421
		2 1 0.50008827373872122 2 0.49991172626127878
		2 1 0.5000882737326845 2 0.49991172626731545
		2 1 0.50008827372181042 2 0.49991172627818958
		2 1 0.50008827372515019 2 0.49991172627484987
		2 1 0.50008827370584152 2 0.49991172629415853
		2 1 0.50008827370821041 2 0.49991172629178954
		2 1 0.50008827369299624 2 0.4999117263070037
		2 1 0.5000882736976261 2 0.49991172630237402
		2 1 0.50008827368662467 2 0.49991172631337533
		2 1 0.50008827367921271 2 0.49991172632078729
		2 1 0.50008827366542141 2 0.49991172633457853
		2 1 0.50008827366342756 2 0.49991172633657249
		2 1 0.50008827363756059 2 0.49991172636243936
		2 1 0.50008827365084685 2 0.49991172634915326
		2 1 0.50008827364647779 2 0.49991172635352221
		2 1 0.50008827363511177 2 0.49991172636488823
		2 1 0.50008827363812469 2 0.49991172636187536
		2 1 0.50008827360822239 2 0.49991172639177767
		2 1 0.50008827360903285 2 0.49991172639096726
		2 1 0.50008827361830677 2 0.49991172638169329
		2 1 0.50008827360041419 2 0.49991172639958575
		2 1 0.50008827358304042 2 0.49991172641695952
		2 1 0.5000882735733776 2 0.49991172642662246
		2 1 0.50008827358300489 2 0.49991172641699505
		2 1 0.50008827357046104 2 0.49991172642953902
		2 1 0.50008827355704255 2 0.49991172644295756
		2 1 0.50008827357144015 2 0.49991172642855991
		2 2 0.75502986953734785 3 0.24497013046265223
		2 2 0.75502990999077135 3 0.24497009000922865
		2 2 0.75502987461534343 3 0.2449701253846566
		2 2 0.7550298605415694 3 0.24497013945843063
		2 2 0.75502986020053697 3 0.24497013979946314
		2 2 0.75502985911009857 3 0.24497014088990141
		2 2 0.75502984822147468 3 0.2449701517785253
		2 2 0.75502982860684964 3 0.24497017139315036
		2 2 0.75502983463107032 3 0.24497016536892971
		2 2 0.75502979980254248 3 0.24497020019745755
		2 2 0.75502980407575482 3 0.24497019592424529
		2 2 0.75502977663312154 3 0.24497022336687849
		2 2 0.75502978498388529 3 0.24497021501611466
		2 2 0.75502976514009534 3 0.24497023485990474
		2 2 0.75502975177063725 3 0.24497024822936272
		2 2 0.75502972689446213 3 0.24497027310553784
		2 2 0.75502972329791151 3 0.24497027670208851
		2 2 0.75502967663982878 3 0.24497032336017122
		2 2 0.75502970060494301 3 0.24497029939505705
		2 2 0.75502969272469733 3 0.24497030727530275
		2 2 0.75502967222290185 3 0.24497032777709812
		2 2 0.75502967765739848 3 0.24497032234260158
		2 2 0.75502962372076887 3 0.24497037627923113
		2 2 0.75502962518211314 3 0.24497037481788697
		2 2 0.75502964191027444 3 0.24497035808972559
		2 2 0.75502960963653221 3 0.24497039036346777
		2 2 0.75502957829806139 3 0.24497042170193867
		2 2 0.7550295608686507 3 0.24497043913134936
		2 2 0.75502957823412853 3 0.24497042176587147
		2 2 0.75502955560777729 3 0.24497044439222271
		2 2 0.75502953140398377 3 0.24497046859601618
		2 2 0.75502955737389721 3 0.24497044262610276
		2 2 0.69763299158919967 3 0.30236700841080033
		2 2 0.69763302821276696 3 0.30236697178723304
		2 2 0.69763299618644492 3 0.30236700381355508
		2 2 0.69763298344508118 3 0.30236701655491893
		2 2 0.69763298313633515 3 0.30236701686366485
		2 2 0.69763298214913216 3 0.30236701785086778
		2 2 0.69763297229137022 3 0.30236702770862983
		2 2 0.69763295453372653 3 0.30236704546627347
		2 2 0.69763295998761421 3 0.3023670400123859
		2 2 0.69763292845641933 3 0.30236707154358072
		2 2 0.69763293232507217 3 0.30236706767492777
		2 2 0.69763290748052553 3 0.30236709251947441
		2 2 0.69763291504069425 3 0.30236708495930575
		2 2 0.69763289707558318 3 0.30236710292441676
		2 2 0.6976328849718576 3 0.3023671150281424
		2 2 0.69763286245079581 3 0.30236713754920419
		2 2 0.69763285919474305 3 0.30236714080525695
		2 2 0.69763281695394463 3 0.30236718304605531
		2 2 0.6976328386501971 3 0.30236716134980296
		2 2 0.69763283151600186 3 0.30236716848399814
		2 2 0.69763281295518398 3 0.30236718704481608
		2 2 0.6976328178751775 3 0.3023671821248225
		2 2 0.69763276904492166 3 0.30236723095507839
		2 2 0.69763277036791516 3 0.3023672296320849
		2 2 0.69763278551236119 3 0.30236721448763876
		2 2 0.69763275629409072 3 0.30236724370590928
		2 2 0.69763272792254771 3 0.30236727207745234
		2 2 0.69763271214324385 3 0.30236728785675621
		2 2 0.69763272786466768 3 0.30236727213533232
		2 2 0.69763270738043692 3 0.30236729261956308
		2 2 0.69763268546810708 3 0.30236731453189292
		2 2 0.6976327089793517 3 0.3023672910206483
		2 2 0.5990980094128765 3 0.40090199058712356
		2 2 0.5990980240784578 3 0.40090197592154225
		2 2 0.59909801745927915 3 0.40090198254072079
		2 2 0.59909800448426298 3 0.40090199551573702
		2 2 0.59909800663572088 3 0.40090199336427917
		2 2 0.5990980086329426 3 0.40090199136705745
		2 2 0.59909801234741156 3 0.40090198765258855
		2 2 0.59909800632094634 3 0.40090199367905366
		2 2 0.5990980089409893 3 0.40090199105901064
		2 2 0.59909800064705554 3 0.4009019993529444
		2 2 0.599097990619328 3 0.400902009380672
		2 2 0.59909799764282023 3 0.40090200235717982
		2 2 0.59909798517106005 3 0.40090201482893995
		2 2 0.59909798181661444 3 0.40090201818338556
		2 2 0.59909797533376996 3 0.40090202466623004
		2 2 0.59909796761990375 3 0.40090203238009625
		2 2 0.59909798618718146 3 0.40090201381281854
		2 2 0.59909796457432696 3 0.4009020354256731
		2 2 0.59909797182407132 3 0.40090202817592868
		2 2 0.59909796343561028 3 0.40090203656438983
		2 2 0.59909795299232904 3 0.40090204700767101
		2 2 0.59909795685157652 3 0.40090204314842348
		2 2 0.59909793879203443 3 0.40090206120796557
		2 2 0.59909794826939078 3 0.40090205173060917
		2 2 0.59909794398279326 3 0.40090205601720674
		2 2 0.59909793035289483 3 0.40090206964710517
		2 2 0.5990979261888919 3 0.40090207381110804
		2 2 0.59909792922841765 3 0.40090207077158241
		2 2 0.59909792885828839 3 0.40090207114171156
		2 2 0.59909792294777797 3 0.40090207705222203
		2 2 0.59909792217277813 3 0.40090207782722187
		2 2 0.59909792891888225 3 0.40090207108111786
		2 2 0.50723137463048007 3 0.49276862536951993
		2 2 0.50723137547059782 3 0.49276862452940218
		2 2 0.50723137500650284 3 0.49276862499349716
		2 2 0.50723137726833256 3 0.49276862273166744
		2 2 0.50723137578579136 3 0.49276862421420875
		2 2 0.50723137547059782 3 0.49276862452940218
		2 2 0.50723137646894689 3 0.49276862353105305
		2 2 0.50723137523762052 3 0.49276862476237954
		2 2 0.50723137463048007 3 0.49276862536951993
		2 2 0.50723137547059782 3 0.49276862452940218
		2 2 0.50723137500650284 3 0.49276862499349716
		2 2 0.50723137726833256 3 0.49276862273166744
		2 2 0.50723137578579136 3 0.49276862421420875
		2 2 0.50723137547059782 3 0.49276862452940218
		2 2 0.50723137646894689 3 0.49276862353105305
		2 2 0.50723137523762052 3 0.49276862476237954
		2 2 0.50723137463048007 3 0.49276862536951993
		2 2 0.50723137547059782 3 0.49276862452940218
		2 2 0.50723137500650284 3 0.49276862499349716
		2 2 0.50723137726833256 3 0.49276862273166744
		1 2 0.50723137578579136;
	setAttr ".wl[1750:2000].w"
		1 3 0.49276862421420875
		2 2 0.50723137547059782 3 0.49276862452940218
		2 2 0.50723137646894689 3 0.49276862353105305
		2 2 0.50723137523762052 3 0.49276862476237954
		2 2 0.50723137463048007 3 0.49276862536951993
		2 2 0.50723137547059782 3 0.49276862452940218
		2 2 0.50723137500650284 3 0.49276862499349716
		2 2 0.50723137726833256 3 0.49276862273166744
		2 2 0.50723137578579136 3 0.49276862421420875
		2 2 0.50723137547059782 3 0.49276862452940218
		2 2 0.50723137646894689 3 0.49276862353105305
		2 2 0.50723137523762052 3 0.49276862476237954
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 0 0.99872792473002425 1 0.0012720752699757944
		2 0 0.99872792496027896 1 0.0012720750397211078
		2 0 0.9987279248988411 1 0.0012720751011588434
		2 0 0.99872792481437322 1 0.001272075185626755
		2 0 0.99872792506127561 1 0.0012720749387244437
		2 0 0.9987279249043356 1 0.0012720750956644921
		2 0 0.99872792501678043 1 0.0012720749832194711
		2 0 0.99872792487731343 1 0.0012720751226866771
		2 0 0.99872792473002425 1 0.0012720752699757944
		2 0 0.99872792496027896 1 0.0012720750397211078
		2 0 0.9987279248988411 1 0.0012720751011588434
		2 0 0.99872792481437322 1 0.001272075185626755
		2 0 0.99872792506127561 1 0.0012720749387244437
		2 0 0.9987279249043356 1 0.0012720750956644921
		2 0 0.99872792501678043 1 0.0012720749832194711
		2 0 0.99872792487731343 1 0.0012720751226866771
		2 0 0.99872792473002425 1 0.0012720752699757944
		2 0 0.99872792496027896 1 0.0012720750397211078
		2 0 0.9987279248988411 1 0.0012720751011588434
		2 0 0.99872792481437322 1 0.001272075185626755
		2 0 0.99872792506127561 1 0.0012720749387244437
		2 0 0.9987279249043356 1 0.0012720750956644921
		2 0 0.99872792501678043 1 0.0012720749832194711
		2 0 0.99872792487731343 1 0.0012720751226866771
		2 0 0.99872792473002425 1 0.0012720752699757944
		2 0 0.99872792496027896 1 0.0012720750397211078
		2 0 0.9987279248988411 1 0.0012720751011588434
		2 0 0.99872792481437322 1 0.001272075185626755
		2 0 0.99872792506127561 1 0.0012720749387244437
		2 0 0.9987279249043356 1 0.0012720750956644921
		2 0 0.99872792501678043 1 0.0012720749832194711
		2 0 0.99872792487731343 1 0.0012720751226866771
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 0 0.95285935194326399 1 0.047140648056736054
		2 0 0.95285934574004194 1 0.047140654259958101
		2 0 0.95285934390227456 1 0.047140656097725456
		2 0 0.95285934390227456 1 0.047140656097725456
		2 0 0.95285934895736246 1 0.047140651042637573
		2 0 0.95285933888087559 1 0.047140661119124426
		2 0 0.95285933083401575 1 0.047140669165984292
		2 0 0.95285934441844722 1 0.047140655581552775
		2 0 0.95285935194326399 1 0.047140648056736054
		2 0 0.95285934574004194 1 0.047140654259958101
		2 0 0.95285934390227456 1 0.047140656097725456
		2 0 0.95285934390227456 1 0.047140656097725456
		2 0 0.95285934895736246 1 0.047140651042637573
		2 0 0.95285933888087559 1 0.047140661119124426
		2 0 0.95285933083401575 1 0.047140669165984292
		2 0 0.95285934441844722 1 0.047140655581552775
		2 0 0.95285935194326399 1 0.047140648056736054
		2 0 0.95285934574004194 1 0.047140654259958101
		2 0 0.95285934390227456 1 0.047140656097725456
		2 0 0.95285934390227456 1 0.047140656097725456
		2 0 0.95285934895736246 1 0.047140651042637573
		2 0 0.95285933888087559 1 0.047140661119124426
		2 0 0.95285933083401575 1 0.047140669165984292
		2 0 0.95285934441844722 1 0.047140655581552775
		2 0 0.95285935194326399 1 0.047140648056736054
		2 0 0.95285934574004194 1 0.047140654259958101
		2 0 0.95285934390227456 1 0.047140656097725456
		2 0 0.95285934390227456 1 0.047140656097725456
		2 0 0.95285934895736246 1 0.047140651042637573
		2 0 0.95285933888087559 1 0.047140661119124426
		2 0 0.95285933083401575 1 0.047140669165984292
		2 0 0.95285934441844722 1 0.047140655581552775
		2 0 0.77176116070165546 1 0.22823883929834463
		2 0 0.77176118047625708 1 0.22823881952374295
		2 0 0.77176117448135129 1 0.22823882551864869
		2 0 0.77176117448135129 1 0.22823882551864869
		2 0 0.77176118047625708 1 0.22823881952374295
		2 0 0.77176116070165546 1 0.22823883929834463
		2 0 0.77176116036836706 1 0.22823883963163297
		2 0 0.77176116036836706 1 0.22823883963163297
		2 0 0.77176116070165546 1 0.22823883929834463
		2 0 0.77176118047625708 1 0.22823881952374295
		2 0 0.77176117448135129 1 0.22823882551864869
		2 0 0.77176117448135129 1 0.22823882551864869
		2 0 0.77176118047625708 1 0.22823881952374295
		2 0 0.77176116070165546 1 0.22823883929834463
		2 0 0.77176116036836706 1 0.22823883963163297
		2 0 0.77176116036836706 1 0.22823883963163297
		2 0 0.77176116070165546 1 0.22823883929834463
		2 0 0.77176118047625708 1 0.22823881952374295
		2 0 0.77176117448135129 1 0.22823882551864869
		2 0 0.77176117448135129 1 0.22823882551864869
		2 0 0.77176118047625708 1 0.22823881952374295
		2 0 0.77176116070165546 1 0.22823883929834463
		2 0 0.77176116036836706 1 0.22823883963163297
		2 0 0.77176116036836706 1 0.22823883963163297
		2 0 0.77176116070165546 1 0.22823883929834463
		2 0 0.77176118047625708 1 0.22823881952374295
		2 0 0.77176117448135129 1 0.22823882551864869
		2 0 0.77176117448135129 1 0.22823882551864869
		2 0 0.77176118047625708 1 0.22823881952374295
		2 0 0.77176116070165546 1 0.22823883929834463
		2 0 0.77176116036836706 1 0.22823883963163297
		2 0 0.77176116036836706 1 0.22823883963163297
		2 0 0.57608958445446479 1 0.42391041554553527
		2 0 0.57608958234525798 1 0.42391041765474197
		2 0 0.57608958143082112 1 0.42391041856917888
		2 0 0.5760895780709071 1 0.4239104219290929
		2 0 0.57608958047352887 1 0.42391041952647113
		2 0 0.57608956548710777 1 0.42391043451289234
		2 0 0.57608956748564466 1 0.4239104325143554
		2 0 0.57608955849574295 1 0.42391044150425711
		2 0 0.57608956862650318 1 0.42391043137349677
		2 0 0.5760895615390198 1 0.4239104384609802
		2 0 0.57608955598196865 1 0.42391044401803135
		2 0 0.57608955536757744 1 0.42391044463242256
		2 0 0.57608954973210735 1 0.4239104502678927
		2 0 0.57608955077487944 1 0.42391044922512056
		2 0 0.5760895375445203 1 0.4239104624554797
		2 0 0.57608954197115192 1 0.42391045802884814
		2 0 0.57608953362341864 1 0.42391046637658142
		2 0 0.57608953032967736 1 0.4239104696703227
		2 0 0.57608952840199168 1 0.42391047159800832
		2 0 0.57608952672203739 1 0.42391047327796272
		2 0 0.5760895226143844 1 0.42391047738561566
		2 0 0.57608952358188703 1 0.42391047641811297
		2 0 0.57608952318615814 1 0.42391047681384181
		2 0 0.57608952535238167 1 0.42391047464761838
		2 0 0.57608951333257175 1 0.42391048666742825
		2 0 0.57608951630288752 1 0.42391048369711248
		2 0 0.57608951270646636 1 0.42391048729353364
		2 0 0.57608951483759896 1 0.42391048516240099
		2 0 0.5760895090555278 1 0.42391049094447231
		2 0 0.57608949527318165 1 0.4239105047268184
		2 0 0.57608949352760808 1 0.42391050647239192
		2 0 0.57608954197115192 1 0.42391045802884814
		2 0 0.50774368918921442 1 0.49225631081078558
		2 0 0.5077436872655432 1 0.4922563127344568
		2 0 0.50774368584801244 1 0.49225631415198756
		2 0 0.50774368617082621 1 0.49225631382917384
		2 0 0.50774368503866496 1 0.4922563149613351
		2 0 0.50774368503359335 1 0.49225631496640659
		2 0 0.50774368486650201 1 0.49225631513349805
		2 0 0.50774368458134833 1 0.49225631541865167
		2 0 0.50774368401740244 1 0.49225631598259756
		2 0 0.50774368322290053 1 0.49225631677709941
		2 0 0.50774368187512631 1 0.49225631812487369
		2 0 0.50774368197115149 1 0.49225631802884845
		2 0 0.50774368070999631 1 0.49225631929000369
		2 0 0.50774368045544616 1 0.49225631954455384
		2 0 0.50774368011220605 1 0.49225631988779406
		2 0 0.50774367944618959 1 0.49225632055381041
		2 0 0.50774367837066936 1 0.49225632162933058
		2 0 0.50774367696613298 1 0.49225632303386702
		2 0 0.50774367738328563 1 0.49225632261671443
		2 0 0.50774367713912905 1 0.4922563228608709
		2 0 0.50774367638133089 1 0.49225632361866917
		2 0 0.50774367599603409 1 0.49225632400396591
		2 0 0.50774367542807297 1 0.49225632457192703
		2 0 0.50774367426092237 1 0.49225632573907757
		2 0 0.50774367393337116 1 0.49225632606662878
		2 0 0.50774367287370326 1 0.4922563271262968
		2 0 0.50774367185353575 1 0.49225632814646419
		2 0 0.50774367156136702 1 0.49225632843863298
		2 0 0.50774367205266868 1 0.49225632794733126
		2 0 0.50774367008973442 1 0.49225632991026552
		2 0 0.50774366911575053 1 0.49225633088424947
		2 0 0.50774367941612175 1 0.4922563205838783
		2 1 0.85720582715563198 2 0.14279417284436799
		2 1 0.85720579087677651 2 0.14279420912322349
		2 1 0.85720576414330918 2 0.14279423585669085
		2 1 0.85720577023131017 2 0.14279422976868986
		2 1 0.85720574887966938 2 0.14279425112033059
		2 1 0.85720574878402656 2 0.1427942512159735
		2 1 0.85720574563281693 2 0.14279425436718302
		2 1 0.85720574025505059 2 0.14279425974494936
		2 1 0.85720572961948971 2 0.14279427038051035
		2 1 0.85720571463582373 2 0.14279428536417624
		2 1 0.85720568921787832 2 0.14279431078212168
		2 1 0.85720569102884003 2 0.14279430897115997
		2 1 0.85720566724445824 2 0.14279433275554179
		2 1 0.85720566244384266 2 0.14279433755615736
		1 1 0.85720565597060905;
	setAttr ".wl[2000:2250].w"
		1 2 0.14279434402939095
		2 1 0.85720564341007066 2 0.14279435658992931
		2 1 0.85720562312660842 2 0.14279437687339158
		2 1 0.8572055966381561 2 0.14279440336184399
		2 1 0.85720560450532812 2 0.14279439549467191
		2 1 0.85720559990072787 2 0.14279440009927211
		2 1 0.8572055856092432 2 0.14279441439075674
		2 1 0.85720557834284783 2 0.14279442165715214
		2 1 0.85720556763154554 2 0.14279443236845446
		2 1 0.85720554561998941 2 0.14279445438001062
		2 1 0.85720553944262756 2 0.14279446055737249
		2 1 0.85720551945810786 2 0.14279448054189212
		2 1 0.85720550021853337 2 0.14279449978146669
		2 1 0.85720549470845275 2 0.14279450529154725
		2 1 0.85720550397402473 2 0.1427944960259753
		2 1 0.85720546695457978 2 0.14279453304542031
		2 1 0.85720544858598546 2 0.14279455141401454
		2 1 0.85720564284301148 2 0.14279435715698857
		2 1 0.81711589231120174 2 0.18288410768879823
		2 1 0.81711585288042543 2 0.1828841471195746
		2 1 0.81711582382434567 2 0.18288417617565433
		2 1 0.817115830441274 2 0.182884169558726
		2 1 0.81711580723459654 2 0.18288419276540355
		2 1 0.81711580713064413 2 0.18288419286935584
		2 1 0.81711580370565662 2 0.18288419629434335
		2 1 0.81711579786066857 2 0.18288420213933143
		2 1 0.81711578630108739 2 0.18288421369891264
		2 1 0.81711577001563718 2 0.18288422998436288
		2 1 0.81711574238937579 2 0.18288425761062418
		2 1 0.81711574435767409 2 0.18288425564232588
		2 1 0.81711571850690179 2 0.18288428149309829
		2 1 0.81711571328920807 2 0.1828842867107919
		2 1 0.81711570625357921 2 0.18288429374642073
		2 1 0.81711569260177996 2 0.18288430739821998
		2 1 0.81711567055608925 2 0.1828843294439107
		2 1 0.81711564176631946 2 0.18288435823368049
		2 1 0.81711565031699163 2 0.18288434968300846
		2 1 0.81711564531234371 2 0.18288435468765638
		2 1 0.81711562977921492 2 0.18288437022078505
		2 1 0.81711562188151532 2 0.18288437811848474
		2 1 0.81711561023961554 2 0.18288438976038443
		2 1 0.81711558631569703 2 0.182884413684303
		2 1 0.81711557960164649 2 0.18288442039835348
		2 1 0.81711555788087431 2 0.18288444211912572
		2 1 0.81711553696976857 2 0.1828844630302314
		2 1 0.81711553098097323 2 0.18288446901902675
		2 1 0.8171155410515365 2 0.18288445894846353
		2 1 0.8171155008158496 2 0.18288449918415034
		2 1 0.81711548085139651 2 0.18288451914860349
		2 1 0.81711569198545464 2 0.18288430801454533
		2 1 0.76844374461836995 2 0.23155625538163013
		2 1 0.76844370442563659 2 0.23155629557436344
		2 1 0.76844367480808151 2 0.23155632519191852
		2 1 0.76844368155287424 2 0.23155631844712576
		2 1 0.76844365789775504 2 0.23155634210224496
		2 1 0.76844365779179391 2 0.23155634220820615
		2 1 0.76844365430062278 2 0.23155634569937728
		2 1 0.7684436483426873 2 0.2315563516573127
		2 1 0.76844363655973125 2 0.23155636344026873
		2 1 0.7684436199595851 2 0.23155638004041493
		2 1 0.76844359179948174 2 0.23155640820051826
		2 1 0.76844359380581484 2 0.23155640619418519
		2 1 0.76844356745551057 2 0.23155643254448946
		2 1 0.76844356213699194 2 0.23155643786300811
		2 1 0.76844355496540928 2 0.23155644503459075
		2 1 0.76844354104980783 2 0.23155645895019214
		2 1 0.76844351857811521 2 0.23155648142188476
		2 1 0.76844348923202499 2 0.23155651076797504
		2 1 0.76844349794792621 2 0.23155650205207376
		2 1 0.76844349284657076 2 0.23155650715342924
		2 1 0.76844347701328741 2 0.23155652298671253
		2 1 0.76844346896297666 2 0.23155653103702342
		2 1 0.76844345709611483 2 0.23155654290388511
		2 1 0.76844343270990367 2 0.23155656729009633
		2 1 0.7684434258661148 2 0.2315565741338852
		2 1 0.76844340372562336 2 0.23155659627437658
		2 1 0.76844338241044485 2 0.23155661758955517
		2 1 0.76844337630592585 2 0.2315566236940742
		2 1 0.76844338657108602 2 0.23155661342891395
		2 1 0.76844334555791216 2 0.23155665444208787
		2 1 0.76844332520768055 2 0.23155667479231945
		2 1 0.76844354042157281 2 0.23155645957842713
		2 1 0.71242947859107897 2 0.28757052140892103
		2 1 0.71242944117791918 2 0.28757055882208077
		2 1 0.7124294136086009 2 0.28757058639139921
		2 1 0.71242941988694952 2 0.28757058011305048
		2 1 0.71242939786772863 2 0.28757060213227137
		2 1 0.7124293977690952 2 0.28757060223090475
		2 1 0.71242939451936027 2 0.28757060548063978
		2 1 0.71242938897345331 2 0.28757061102654674
		2 1 0.71242937800536221 2 0.28757062199463773
		2 1 0.7124293625532202 2 0.28757063744677985
		2 1 0.7124293363405656 2 0.28757066365943451
		2 1 0.71242933820814802 2 0.28757066179185198
		2 1 0.71242931368013429 2 0.28757068631986571
		2 1 0.71242930872942511 2 0.28757069127057489
		2 1 0.71242930205380306 2 0.28757069794619694
		2 1 0.71242928910055436 2 0.28757071089944564
		2 1 0.71242926818292351 2 0.28757073181707643
		2 1 0.71242924086630488 2 0.28757075913369518
		2 1 0.71242924897944515 2 0.2875707510205549
		2 1 0.71242924423088128 2 0.28757075576911867
		2 1 0.71242922949257226 2 0.28757077050742774
		2 1 0.71242922199899272 2 0.28757077800100722
		2 1 0.71242921095280198 2 0.28757078904719807
		2 1 0.71242918825305679 2 0.28757081174694321
		2 1 0.71242918188256088 2 0.28757081811743918
		2 1 0.71242916127323042 2 0.28757083872676964
		2 1 0.71242914143213754 2 0.28757085856786246
		2 1 0.71242913574978672 2 0.28757086425021333
		2 1 0.71242914530504287 2 0.28757085469495713
		2 1 0.7124291071282034 2 0.28757089287179666
		2 1 0.7124290881853268 2 0.2875709118146732
		2 1 0.71242928851576581 2 0.28757071148423413
		2 1 0.65259378018109937 2 0.34740621981890069
		2 1 0.65259374948417759 2 0.34740625051582247
		2 1 0.65259372686397699 2 0.34740627313602307
		2 1 0.65259373201526505 2 0.34740626798473501
		2 1 0.65259371394883459 2 0.34740628605116547
		2 1 0.65259371386790743 2 0.34740628613209268
		2 1 0.65259371120155008 2 0.34740628879844992
		2 1 0.65259370665121919 2 0.34740629334878076
		2 1 0.65259369765207031 2 0.34740630234792963
		2 1 0.65259368497382741 2 0.34740631502617264
		2 1 0.65259366346675118 2 0.34740633653324882
		2 1 0.65259366499907356 2 0.34740633500092644
		2 1 0.65259364487422 2 0.34740635512577994
		2 1 0.65259364081224025 2 0.34740635918775981
		2 1 0.65259363533499648 2 0.34740636466500352
		2 1 0.65259362470705795 2 0.34740637529294199
		2 1 0.65259360754446849 2 0.34740639245553145
		2 1 0.65259358513161059 2 0.34740641486838952
		2 1 0.65259359178831489 2 0.34740640821168517
		2 1 0.65259358789219291 2 0.34740641210780709
		2 1 0.65259357579964128 2 0.34740642420035867
		2 1 0.65259356965127679 2 0.34740643034872321
		2 1 0.65259356058805074 2 0.34740643941194932
		2 1 0.6525935419632668 2 0.34740645803673326
		2 1 0.65259353673637521 2 0.34740646326362484
		2 1 0.65259351982674441 2 0.34740648017325565
		2 1 0.65259350354744083 2 0.34740649645255911
		2 1 0.65259349888516172 2 0.34740650111483828
		2 1 0.65259350672509864 2 0.34740649327490131
		2 1 0.65259347540160573 2 0.34740652459839427
		2 1 0.65259345985927597 2 0.34740654014072408
		2 1 0.65259362422724809 2 0.34740637577275185
		2 1 0.59476674355164927 2 0.40523325644835068
		2 1 0.59476672248149698 2 0.40523327751850308
		2 1 0.5947667069551501 2 0.4052332930448499
		2 1 0.59476671049095808 2 0.40523328950904192
		2 1 0.59476669809028759 2 0.40523330190971246
		2 1 0.59476669803473958 2 0.40523330196526036
		2 1 0.5947666962045709 2 0.4052333037954291
		2 1 0.59476669308125585 2 0.4052333069187441
		2 1 0.59476668690430357 2 0.40523331309569638
		2 1 0.59476667820204743 2 0.40523332179795252
		2 1 0.59476666343974294 2 0.40523333656025701
		2 1 0.59476666449151816 2 0.4052333355084819
		2 1 0.59476665067796197 2 0.40523334932203808
		2 1 0.59476664788984812 2 0.40523335211015188
		2 1 0.59476664413030689 2 0.40523335586969306
		2 1 0.59476663683536568 2 0.40523336316463426
		2 1 0.59476662505508748 2 0.40523337494491252
		2 1 0.59476660967106276 2 0.40523339032893724
		2 1 0.59476661424017674 2 0.40523338575982326
		2 1 0.5947666115659066 2 0.40523338843409346
		2 1 0.59476660326566622 2 0.40523339673433384
		2 1 0.59476659904547302 2 0.40523340095452692
		2 1 0.59476659282454025 2 0.4052334071754598
		2 1 0.59476658004062333 2 0.40523341995937678
		2 1 0.59476657645292264 2 0.40523342354707731
		2 1 0.59476656484627477 2 0.40523343515372534
		2 1 0.59476655367227926 2 0.40523344632772085
		2 1 0.5947665504721249 2 0.40523344952787504
		2 1 0.59476655585340044 2 0.40523344414659956
		2 1 0.59476653435318361 2 0.40523346564681639
		2 1 0.59476652368504224 2 0.40523347631495782
		2 1 0.5947666365060279 2 0.4052333634939721
		2 1 0.54603678736214978 2 0.45396321263785028
		2 1 0.54603677641364901 2 0.45396322358635099
		2 1 0.54603676834582815 2 0.45396323165417179
		2 1 0.54603677018310925 2 0.45396322981689075
		2 1 0.54603676373945664 2 0.45396323626054341
		2 1 0.54603676371059273 2 0.45396323628940738
		2 1 0.54603676275959812 2 0.45396323724040188
		2 1 0.54603676113665711 2 0.45396323886334289
		2 1 0.54603675792698103 2 0.45396324207301902
		2 1 0.54603675340510338 2 0.45396324659489673
		2 1 0.54603674573429595 2 0.45396325426570405
		2 1 0.54603674628082055 2 0.45396325371917939
		2 1 0.54603673910300299 2 0.45396326089699701
		2 1 0.54603673765423955 2 0.45396326234576045
		2 1 0.5460367357007021 2 0.45396326429929784
		2 1 0.5460367319100955 2 0.45396326808990445
		2 1 0.54603672578881268 2 0.45396327421118737
		2 1 0.54603671779494622 2 0.45396328220505372
		2 1 0.54603672016915528 2 0.45396327983084478
		2 1 0.5460367187795474 2 0.45396328122045254
		2 1 0.54603671446656654 2 0.45396328553343351
		2 1 0.54603671227366446 2 0.45396328772633554
		2 1 0.54603670904113577 2 0.45396329095886417
		2 1 0.54603670239834123 2 0.45396329760165888
		2 1 0.54603670053409603 2 0.45396329946590402
		2 1 0.54603669450303571 2 0.45396330549696434
		2 1 0.54603668869679067 2 0.45396331130320927
		2 1 0.54603668703392283 2 0.45396331296607723
		2 1 0.54603668983014764 2 0.45396331016985247
		2 1 0.54603667865817951 2 0.45396332134182049
		2 1 0.54603667311478732 2 0.45396332688521263
		2 1 0.5460367317389645 2 0.45396326826103545
		2 1 0.51297399880764583 2 0.48702600119235417
		2 1 0.51297399560236157 2 0.48702600439763855
		2 1 0.51297399324042525 2 0.48702600675957475
		2 1 0.51297399377830777 2 0.48702600622169218
		2 1 0.51297399189186332 2 0.48702600810813668
		2 1 0.51297399188341319 2 0.48702600811658675
		2 1 0.5129739916049999 2 0.48702600839500021
		2 1 0.51297399112986741 2 0.48702600887013253
		2 1 0.51297399019020229 2 0.48702600980979771
		2 1 0.51297398886637702 2 0.48702601113362298
		2 1 0.51297398662067051 2 0.48702601337932955
		2 1 0.51297398678067097 2 0.48702601321932898
		2 1 0.51297398467929245 2 0.48702601532070761
		2 1 0.51297398425515239 2 0.48702601574484761
		2 1 0.51297398368323466 2 0.48702601631676534
		2 1 0.51297398257349613 2 0.48702601742650387
		2 1 0.51297398078142886 2 0.48702601921857108
		2 1 0.51297397844114379 2 0.48702602155885633
		2 1 0.51297397913621734 2 0.48702602086378266
		2 1 0.51297397872939554 2 0.48702602127060451
		2 1 0.51297397746672679 2 0.48702602253327315
		2 1 0.51297397682473278 2 0.48702602317526728
		2 1 0.51297397587837745 2 0.4870260241216226
		2 1 0.51297397393363242 2 0.48702602606636763
		2 1 0.51297397338785578 2 0.48702602661214428
		2 1 0.51297397162220215 2 0.48702602837779785
		2 1 0.51297396992236499 2 0.48702603007763495
		2 1 0.51297396943554385 2 0.4870260305644562
		2 1 0.51297397025416702 2 0.48702602974583298
		2 1 0.51297396698346076 2 0.48702603301653918
		2 1 0.51297396536057682 2 0.48702603463942329
		2 1 0.51297398252339588 2 0.48702601747660407
		2 1 0.50008827583587367 2 0.49991172416412633
		2 1 0.50008827581377269 2 0.49991172418622726
		2 1 0.50008827579748638 2 0.49991172420251356
		2 1 0.5000882758011953 2 0.4999117241988047
		2 1 0.50008827578818782 2 0.49991172421181218
		2 1 0.50008827578812953 2 0.49991172421187041
		2 1 0.50008827578620973 2 0.49991172421379027
		2 1 0.50008827578293369 2 0.49991172421706631
		1 1 0.50008827577645443;
	setAttr ".wl[2250:2497].w"
		1 2 0.49991172422354568
		2 1 0.5000882757673264 2 0.49991172423267355
		2 1 0.50008827575184189 2 0.49991172424815816
		2 1 0.5000882757529449 2 0.49991172424705521
		2 1 0.50008827573845549 2 0.49991172426154451
		2 1 0.50008827573553116 2 0.49991172426446889
		2 1 0.50008827573158754 2 0.49991172426841241
		2 1 0.50008827572393544 2 0.49991172427606462
		2 1 0.5000882757115791 2 0.49991172428842096
		2 1 0.50008827569544201 2 0.49991172430455794
		2 1 0.50008827570023484 2 0.49991172429976516
		2 1 0.50008827569742953 2 0.49991172430257041
		2 1 0.50008827568872338 2 0.49991172431127673
		2 1 0.50008827568429659 2 0.49991172431570347
		2 1 0.50008827567777125 2 0.49991172432222869
		2 1 0.50008827566436176 2 0.49991172433563824
		2 1 0.50008827566059855 2 0.49991172433940156
		2 1 0.50008827564842406 2 0.49991172435157594
		2 1 0.50008827563670311 2 0.49991172436329689
		2 1 0.50008827563334657 2 0.49991172436665343
		2 1 0.50008827563899128 2 0.49991172436100872
		2 1 0.50008827561643898 2 0.49991172438356107
		2 1 0.50008827560524871 2 0.49991172439475129
		2 1 0.50008827572359016 2 0.49991172427640984
		2 2 0.75503364184493149 3 0.24496635815506848
		2 2 0.75503360198043534 3 0.24496639801956469
		2 2 0.75503357260475468 3 0.2449664273952453
		2 2 0.75503357929446546 3 0.24496642070553454
		2 2 0.75503355583252818 3 0.24496644416747176
		2 2 0.75503355572743236 3 0.24496644427256759
		2 2 0.7550335522647722 3 0.24496644773522777
		2 2 0.75503354635549291 3 0.2449664536445072
		2 2 0.75503353466876366 3 0.24496646533123631
		2 2 0.75503351820418463 3 0.2449664817958154
		2 2 0.75503349027405442 3 0.24496650972594566
		2 2 0.7550334922640024 3 0.2449665077359976
		2 2 0.75503346612889155 3 0.24496653387110848
		2 2 0.7550334608538074 3 0.2449665391461926
		2 2 0.75503345374079245 3 0.24496654625920758
		2 2 0.75503343993883487 3 0.24496656006116513
		2 2 0.7550334176506609 3 0.24496658234933913
		2 2 0.75503338854423041 3 0.24496661145576962
		2 2 0.75503339718895168 3 0.24496660281104826
		2 2 0.75503339212925735 3 0.24496660787074268
		2 2 0.75503337642527946 3 0.24496662357472063
		2 2 0.75503336844071289 3 0.24496663155928716
		2 2 0.75503335667076399 3 0.24496664332923607
		2 2 0.75503333248370752 3 0.24496666751629245
		2 2 0.75503332569580972 3 0.24496667430419022
		2 2 0.7550333037361332 3 0.24496669626386683
		2 2 0.75503328259502955 3 0.24496671740497047
		2 2 0.75503327654036467 3 0.24496672345963538
		2 2 0.75503328672169212 3 0.24496671327830785
		2 2 0.75503324604346156 3 0.2449667539565385
		2 2 0.75503322585942489 3 0.24496677414057513
		2 2 0.75503343931573053 3 0.24496656068426942
		2 2 0.69763640677055783 3 0.30236359322944212
		2 2 0.69763637067994422 3 0.30236362932005578
		2 2 0.69763634408519493 3 0.30236365591480518
		2 2 0.6976363501416053 3 0.30236364985839465
		2 2 0.69763632890075888 3 0.30236367109924112
		2 2 0.69763632880561233 3 0.30236367119438762
		2 2 0.69763632567075473 3 0.30236367432924521
		2 2 0.6976363203208944 3 0.3023636796791056
		2 2 0.69763630974052304 3 0.3023636902594769
		2 2 0.69763629483461098 3 0.30236370516538907
		2 2 0.6976362695485685 3 0.3023637304514315
		2 2 0.69763627135013218 3 0.30236372864986782
		2 2 0.69763624768917909 3 0.30236375231082091
		2 2 0.6976362429134767 3 0.30236375708652335
		2 2 0.69763623647383666 3 0.30236376352616334
		2 2 0.69763622397848302 3 0.30236377602151698
		2 2 0.69763620380028679 3 0.30236379619971321
		2 2 0.69763617744930628 3 0.30236382255069372
		2 2 0.6976361852756483 3 0.3023638147243517
		2 2 0.6976361806949456 3 0.30236381930505435
		2 2 0.69763616647763349 3 0.30236383352236651
		2 2 0.69763615924895084 3 0.30236384075104916
		2 2 0.6976361485932413 3 0.3023638514067587
		2 2 0.697636126695929 3 0.302363873304071
		2 2 0.6976361205506294 3 0.30236387944937071
		2 2 0.69763610066983606 3 0.30236389933016394
		2 2 0.69763608153012335 3 0.30236391846987665
		2 2 0.69763607604864297 3 0.30236392395135708
		2 2 0.69763608526612197 3 0.30236391473387797
		2 2 0.69763604843882976 3 0.30236395156117035
		2 2 0.69763603016558196 3 0.30236396983441804
		2 2 0.69763622341436682 3 0.30236377658563324
		2 2 0.59910006558109652 3 0.40089993441890354
		2 2 0.59910006152197193 3 0.40089993847802807
		2 2 0.59910005423289814 3 0.40089994576710192
		2 2 0.59910004866267974 3 0.40089995133732026
		2 2 0.59910004607199152 3 0.40089995392800848
		2 2 0.59910004030313158 3 0.40089995969686848
		2 2 0.59910004281862905 3 0.40089995718137089
		2 2 0.59910005087976814 3 0.4008999491202318
		2 2 0.59910004425459285 3 0.4008999557454071
		2 2 0.59910003533379363 3 0.40089996466620631
		2 2 0.59910003447740101 3 0.40089996552259893
		2 2 0.59910002142788621 3 0.40089997857211379
		2 2 0.59910002047279221 3 0.40089997952720779
		2 2 0.59910002318962929 3 0.40089997681037076
		2 2 0.59910000513264694 3 0.400899994867353
		2 2 0.59910001082285969 3 0.40089998917714043
		2 2 0.59910000160160559 3 0.40089999839839446
		2 2 0.59910000061255986 3 0.4008999993874402
		2 2 0.59910000110451789 3 0.40089999889548217
		2 2 0.59910000646930051 3 0.40089999353069949
		2 2 0.59909999487360099 3 0.40090000512639901
		2 2 0.59909998755830529 3 0.40090001244169465
		2 2 0.5990999870602135 3 0.4009000129397865
		2 2 0.59909998978677304 3 0.40090001021322696
		2 2 0.59909997465780374 3 0.40090002534219621
		2 2 0.59909996986338909 3 0.40090003013661096
		2 2 0.59909997521094038 3 0.40090002478905967
		2 2 0.59909997655213587 3 0.40090002344786418
		2 2 0.59909996927441833 3 0.40090003072558167
		2 2 0.59909995192699783 3 0.40090004807300222
		2 2 0.59909994972989766 3 0.40090005027010234
		2 2 0.59910001070431373 3 0.40089998929568627
		2 2 0.50723154265459103 3 0.49276845734540897
		2 2 0.507231542269444 3 0.492768457730556
		2 2 0.50723154327009679 3 0.49276845672990321
		2 2 0.50723154327009679 3 0.49276845672990321
		2 2 0.50723154309604646 3 0.49276845690395349
		2 2 0.50723154265459103 3 0.49276845734540897
		2 2 0.50723154263970394 3 0.49276845736029606
		2 2 0.50723154263970394 3 0.49276845736029606
		2 2 0.50723154265459103 3 0.49276845734540897
		2 2 0.507231542269444 3 0.492768457730556
		2 2 0.50723154327009679 3 0.49276845672990321
		2 2 0.50723154327009679 3 0.49276845672990321
		2 2 0.50723154309604646 3 0.49276845690395349
		2 2 0.50723154265459103 3 0.49276845734540897
		2 2 0.50723154263970394 3 0.49276845736029606
		2 2 0.50723154263970394 3 0.49276845736029606
		2 2 0.50723154265459103 3 0.49276845734540897
		2 2 0.507231542269444 3 0.492768457730556
		2 2 0.50723154327009679 3 0.49276845672990321
		2 2 0.50723154327009679 3 0.49276845672990321
		2 2 0.50723154309604646 3 0.49276845690395349
		2 2 0.50723154265459103 3 0.49276845734540897
		2 2 0.50723154263970394 3 0.49276845736029606
		2 2 0.50723154263970394 3 0.49276845736029606
		2 2 0.50723154265459103 3 0.49276845734540897
		2 2 0.507231542269444 3 0.492768457730556
		2 2 0.50723154327009679 3 0.49276845672990321
		2 2 0.50723154327009679 3 0.49276845672990321
		2 2 0.50723154309604646 3 0.49276845690395349
		2 2 0.50723154265459103 3 0.49276845734540897
		2 2 0.50723154263970394 3 0.49276845736029606
		2 2 0.50723154263970394 3 0.49276845736029606
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 0 0.99782777170412673 1 0.0021722282958732343
		2 0 0.99782777186372607 1 0.0021722281362739548
		2 0 0.99782777167143422 1 0.0021722283285658122
		2 0 0.99782777167143422 1 0.0021722283285658122
		2 0 0.99782777186372607 1 0.0021722281362739548
		2 0 0.99782777170412673 1 0.0021722282958732343
		2 0 0.99782777149356072 1 0.0021722285064393015
		2 0 0.99782777149356072 1 0.0021722285064393015
		2 0 0.99782777170412673 1 0.0021722282958732343
		2 0 0.99782777186372607 1 0.0021722281362739548
		2 0 0.99782777167143422 1 0.0021722283285658122
		2 0 0.99782777167143422 1 0.0021722283285658122
		2 0 0.99782777186372607 1 0.0021722281362739548
		2 0 0.99782777170412673 1 0.0021722282958732343
		2 0 0.99782777149356072 1 0.0021722285064393015
		2 0 0.99782777149356072 1 0.0021722285064393015
		2 0 0.99782777170412673 1 0.0021722282958732343
		2 0 0.99782777186372607 1 0.0021722281362739548
		2 0 0.99782777167143422 1 0.0021722283285658122
		2 0 0.99782777167143422 1 0.0021722283285658122
		2 0 0.99782777186372607 1 0.0021722281362739548
		2 0 0.99782777170412673 1 0.0021722282958732343
		2 0 0.99782777149356072 1 0.0021722285064393015
		2 0 0.99782777149356072 1 0.0021722285064393015
		2 0 0.99782777170412673 1 0.0021722282958732343
		2 0 0.99782777186372607 1 0.0021722281362739548
		2 0 0.99782777167143422 1 0.0021722283285658122
		2 0 0.99782777167143422 1 0.0021722283285658122
		2 0 0.99782777186372607 1 0.0021722281362739548
		2 0 0.99782777170412673 1 0.0021722282958732343
		2 0 0.99782777149356072 1 0.0021722285064393015
		2 0 0.99782777149356072 1 0.0021722285064393015
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5
		2 2 0.5 3 0.5;
	setAttr -s 4 ".pm";
	setAttr ".pm[0]" -type "matrix" 1 -0 0 -0 -0 1 -0 0 0 -0 1 -0 -0 0 -0 1;
	setAttr ".pm[1]" -type "matrix" 1 -0 0 -0 -0 1 -0 0 0 -0 1 -0 -0 -22 -0 1;
	setAttr ".pm[2]" -type "matrix" 1 -0 0 -0 -0 1 -0 0 0 -0 1 -0 -0 -44 -0 1;
	setAttr ".pm[3]" -type "matrix" 1 -0 0 -0 -0 1 -0 0 0 -0 1 -0 -0 -62 -0 1;
	setAttr ".gm" -type "matrix" 1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1;
	setAttr -s 4 ".ma";
	setAttr -s 4 ".dpf[0:3]"  4 4 4 4;
	setAttr -s 4 ".lw";
	setAttr -s 4 ".lw";
	setAttr ".bm" 1;
	setAttr ".ucm" yes;
	setAttr -s 4 ".ifcl";
	setAttr -s 4 ".ifcl";
createNode dagPose -n "bindPose1";
	rename -uid "D2CB3F90-CB40-35AE-6147-32BCD354B453";
	setAttr -s 4 ".wm";
	setAttr -s 4 ".xm";
	setAttr ".xm[0]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[1]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 22 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[2]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 22 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr ".xm[3]" -type "matrix" "xform" 1 1 1 0 0 0 0 0 18 0 0 0 0 0 0 0 0 0
		 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 yes;
	setAttr -s 4 ".m";
	setAttr -s 4 ".p";
	setAttr ".bp" yes;
createNode polySphere -n "polySphere1";
	rename -uid "8006F11E-5D45-1637-8898-58818C79E17F";
	setAttr ".r" 16;
	setAttr ".sa" 40;
	setAttr ".sh" 30;
createNode polySphere -n "polySphere2";
	rename -uid "E7A075A3-804A-74A9-7E09-95BF2794FF46";
	setAttr ".r" 2.6;
createNode polySphere -n "polySphere3";
	rename -uid "9CBE1911-B048-2692-8F3C-6C90BB6A1E67";
	setAttr ".r" 2.6;
createNode polyTorus -n "polyTorus1";
	rename -uid "ACAA42BD-F146-8F28-8968-8182CBE1B663";
	setAttr ".r" 17;
	setAttr ".sr" 4.2;
	setAttr ".sa" 40;
	setAttr ".sh" 16;
createNode lambert -n "bean_body_mat";
	rename -uid "E2E25A8F-EE4A-FDB7-E963-559AC6921D0D";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.94999999 0.15000001 0.25 ;
createNode shadingEngine -n "bean_body_matSG";
	rename -uid "A8E7D7B8-8F4D-B3FD-462E-23BE8757A0ED";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo9";
	rename -uid "7C67660A-C948-C79C-EAFD-4EA8E236ACEC";
createNode lambert -n "bean_head_mat";
	rename -uid "E42D28C1-CD41-6124-405A-7AA30F145F8F";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 1 0.85000002 0.72000003 ;
createNode shadingEngine -n "bean_head_matSG";
	rename -uid "8CDDB481-714C-E9CA-6D2A-179313DE12D9";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo10";
	rename -uid "295D8168-8D4C-868E-50B9-3395D7FDAE69";
createNode lambert -n "bean_eye_mat";
	rename -uid "B2D700E9-A24E-A6AF-6FB7-3FA2FC60F1C8";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.079999998 0.07 0.12 ;
createNode shadingEngine -n "bean_eye_matSG";
	rename -uid "131F6B81-6E4D-1A2F-B3F9-E0995D169608";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo11";
	rename -uid "298EF124-BC42-4941-736F-12AEFC36E4BB";
createNode lambert -n "bean_scarf_mat";
	rename -uid "A06F8953-CD41-20A3-D8BF-EBAF01EA35FE";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.15000001 0.34999999 0.94999999 ;
createNode shadingEngine -n "bean_scarf_matSG";
	rename -uid "64F59BA8-824C-0375-7C7D-FC9607D8D17A";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo12";
	rename -uid "004D1EA5-894C-74CE-F9EC-D5ADB6E0D939";
createNode lambert -n "hero_suit_mat";
	rename -uid "3D5BB727-554B-C68E-DB93-87AD9BCAB005";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.92000002 0.1 0.18000001 ;
createNode shadingEngine -n "hero_suit_matSG";
	rename -uid "CCEDFE60-6B4F-BB50-6A00-D5A1E942AE4A";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo13";
	rename -uid "A0EE17C5-9C41-A065-3F55-9383B5E01957";
createNode lambert -n "hero_scarf_mat";
	rename -uid "B092B175-0449-FB57-7773-4890E9C2D00B";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.1 0.25 0.85000002 ;
createNode shadingEngine -n "hero_scarf_matSG";
	rename -uid "62020A48-1D4B-0558-AF40-8293C1B47C99";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo14";
	rename -uid "B0097410-1C4D-BEFB-A3AE-4CB40A68B576";
createNode lambert -n "hero_mask_mat";
	rename -uid "922AF416-E24B-F2AB-9D3E-D7B7D2FBF474";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.94999999 0.12 0.2 ;
createNode shadingEngine -n "hero_mask_matSG";
	rename -uid "433883DB-8443-51D9-C27B-8DB498A36F8E";
	setAttr ".ihi" 0;
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo15";
	rename -uid "A5AF2AE4-634A-5429-7353-F089D3705574";
createNode lambert -n "hero_lens_mat";
	rename -uid "8CF78B1E-2B4A-C1ED-F206-63B56ACFB65F";
	setAttr ".dc" 1;
	setAttr ".c" -type "float3" 0.98000002 0.98000002 1 ;
createNode shadingEngine -n "hero_lens_matSG";
	rename -uid "1BC3804C-1F45-0F03-1665-6095288E4FE2";
	setAttr ".ihi" 0;
	setAttr -s 2 ".dsm";
	setAttr ".ro" yes;
createNode materialInfo -n "materialInfo16";
	rename -uid "982848F6-3343-75D6-121B-E2A413FF0820";
createNode animCurveTL -n "bean_root_jnt_translateX";
	rename -uid "251D88BD-644E-1A3E-A044-D288178FA8F4";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 6 ".ktv[0:5]"  1 -420 24 -150 30 -110 50 160 56 230 96 380;
createNode animCurveTL -n "bean_root_jnt_translateY";
	rename -uid "412117F9-FA4A-6CFC-B234-A4B9F98C0AE1";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  1 8 24 8 30 8 40 160 50 -2 56 -22 96 -22;
createNode animCurveTA -n "bean_root_jnt_rotateY";
	rename -uid "C8934F89-1D42-4CB4-ABFC-CCA910A8B54E";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 90 96 90;
createNode animCurveTA -n "bean_mid_jnt_rotateX";
	rename -uid "6D719125-844E-2FE8-BC69-4F90BDCBFDF0";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 10 ".ktv[0:9]"  1 0 12 6.0000000000000009 24 -4 28 22 36 -24.000000000000004
		 46 -10 52 26 62 -6.0000000000000009 72 0 96 0;
createNode animCurveTA -n "bean_top_jnt_rotateX";
	rename -uid "282EE5EA-554A-843C-6D39-5A9D45A781EF";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  1 0 28 16 36 -20 52 18 64 -4 72 0 96 0;
createNode animCurveTA -n "bean_top_jnt_rotateY";
	rename -uid "8C8BE116-E842-46A4-D61A-5CBA0E55AC99";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  60 0 76 -55 96 -55;
createNode animCurveTL -n "shotCam_translateX";
	rename -uid "188D84AB-1E41-6B97-D12D-5C8AD33AB069";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 4 ".ktv[0:3]"  1 -400 40 -40 70 220 96 330;
createNode animCurveTL -n "shotCam_translateY";
	rename -uid "EDD87455-DD40-0A7C-50C1-61A09F2B8EB9";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 50 40 30 96 40;
createNode animCurveTL -n "shotCam_translateZ";
	rename -uid "825B4DB4-AE43-18AF-068A-AD9E89D5C7DB";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 330 40 400 96 290;
createNode animCurveTU -n "shotCamShape_focalLength";
	rename -uid "B428848C-CE4A-C216-5086-50950D5F9D09";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 3 ".ktv[0:2]"  1 30 60 30 96 42;
createNode animCurveTA -n "duskSun_rotateX";
	rename -uid "D72425F3-C546-7E29-553D-E8A12F7CEBA8";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -29.999999999999996 96 -24.000000000000004;
createNode animCurveTA -n "duskSun_rotateY";
	rename -uid "209F792E-8944-32D6-2C5F-3D8E46E17188";
	setAttr ".tan" 18;
	setAttr ".wgt" no;
	setAttr -s 2 ".ktv[0:1]"  1 -65 96 -35;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "358A97EF-F443-7C61-BA0F-F19ABD8748F9";
	setAttr ".b" -type "string" "// Maya Mel UI Configuration File.\n// No UI generated in batch mode.\n";
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "759701A1-4542-F290-B3F5-F383290E77B3";
	setAttr ".b" -type "string" "playbackOptions -min 1 -max 96 -ast 1 -aet 96 ";
	setAttr ".st" 6;
select -ne :time1;
	setAttr ".o" 36;
	setAttr ".unw" 36;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr ".fprt" yes;
	setAttr ".rtfm" 3;
select -ne :renderPartition;
	setAttr -s 18 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 22 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :lightList1;
	setAttr -s 2 ".l";
select -ne :defaultTextureList1;
	setAttr -s 3 ".tx";
select -ne :standardSurface1;
	setAttr ".bc" -type "float3" 0.40000001 0.40000001 0.40000001 ;
	setAttr ".sr" 0.5;
select -ne :openPBR_shader1;
	setAttr ".bc" -type "float3" 0.40000001 0.40000001 0.40000001 ;
	setAttr ".sr" 0.5;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	addAttr -ci true -uac -sn "toonBackground" -ln "toonBackground" -at "float3" -nc 
		3;
	addAttr -ci true -sn "toonBackgroundR" -ln "toonBackgroundR" -at "float" -p "toonBackground";
	addAttr -ci true -sn "toonBackgroundG" -ln "toonBackgroundG" -at "float" -p "toonBackground";
	addAttr -ci true -sn "toonBackgroundB" -ln "toonBackgroundB" -at "float" -p "toonBackground";
	addAttr -ci true -h true -sn "dss" -ln "defaultSurfaceShader" -dt "string";
	setAttr ".toonBackground" -type "float3" 1 0.66000003 0.5 ;
	setAttr ".dss" -type "string" "openPBR_shader1";
select -ne :defaultResolution;
	setAttr ".w" 1280;
	setAttr ".h" 720;
	setAttr ".pa" 1;
	setAttr ".dar" 1.7777777910232544;
select -ne :defaultLightSet;
	setAttr -s 2 ".dsm";
select -ne :defaultColorMgtGlobals;
	setAttr ".cfe" yes;
	setAttr ".cfp" -type "string" "<MAYA_RESOURCES>/OCIO-configs/Maya2022-default/config.ocio";
	setAttr ".vtn" -type "string" "ACES 1.0 SDR-video (sRGB)";
	setAttr ".vn" -type "string" "ACES 1.0 SDR-video";
	setAttr ".dn" -type "string" "sRGB";
	setAttr ".wsn" -type "string" "ACEScg";
	setAttr ".otn" -type "string" "ACES 1.0 SDR-video (sRGB)";
	setAttr ".potn" -type "string" "ACES 1.0 SDR-video (sRGB)";
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
connectAttr "polyCube1.out" "roofA_topShape.i";
connectAttr "polyCube2.out" "roofB_topShape.i";
connectAttr "polyCylinder1.out" "water_tankShape.i";
connectAttr "polyCube3.out" "tank_standShape.i";
connectAttr "polyCone1.out" "tank_roofShape.i";
connectAttr "polyCylinder2.out" "antennaShape.i";
connectAttr "polyCube4.out" "ac_unit0Shape.i";
connectAttr "polyCube5.out" "ac_unit1Shape.i";
connectAttr "polyCube6.out" "ac_unit2Shape.i";
connectAttr "bean_root_jnt_translateY.o" "bean_root_jnt.ty";
connectAttr "bean_root_jnt_translateX.o" "bean_root_jnt.tx";
connectAttr "bean_root_jnt_rotateY.o" "bean_root_jnt.ry";
connectAttr "bean_root_jnt.s" "bean_mid_jnt.is";
connectAttr "bean_mid_jnt_rotateX.o" "bean_mid_jnt.rx";
connectAttr "bean_mid_jnt.s" "bean_top_jnt.is";
connectAttr "bean_top_jnt_rotateX.o" "bean_top_jnt.rx";
connectAttr "bean_top_jnt_rotateY.o" "bean_top_jnt.ry";
connectAttr "bean_top_jnt.s" "bean_end_jnt.is";
connectAttr "polySphere1.out" "bean_headShape.i";
connectAttr "polySphere2.out" "bean_eye_LShape.i";
connectAttr "polySphere3.out" "bean_eye_RShape.i";
connectAttr "polyTorus1.out" "bean_scarfShape.i";
connectAttr "bean_skin.og[0]" "bean_bodyShape.i";
connectAttr "camTarget_pointConstraint1.ctx" "camTarget.tx";
connectAttr "camTarget_pointConstraint1.cty" "camTarget.ty";
connectAttr "camTarget_pointConstraint1.ctz" "camTarget.tz";
connectAttr "camTarget.pim" "camTarget_pointConstraint1.cpim";
connectAttr "camTarget.rp" "camTarget_pointConstraint1.crp";
connectAttr "camTarget.rpt" "camTarget_pointConstraint1.crt";
connectAttr "bean_root_jnt.t" "camTarget_pointConstraint1.tg[0].tt";
connectAttr "bean_root_jnt.rp" "camTarget_pointConstraint1.tg[0].trp";
connectAttr "bean_root_jnt.rpt" "camTarget_pointConstraint1.tg[0].trt";
connectAttr "bean_root_jnt.pm" "camTarget_pointConstraint1.tg[0].tpm";
connectAttr "camTarget_pointConstraint1.w0" "camTarget_pointConstraint1.tg[0].tw"
		;
connectAttr "shotCam_translateX.o" "shotCam.tx";
connectAttr "shotCam_translateY.o" "shotCam.ty";
connectAttr "shotCam_translateZ.o" "shotCam.tz";
connectAttr "shotCam_aimConstraint1.crx" "shotCam.rx";
connectAttr "shotCam_aimConstraint1.cry" "shotCam.ry";
connectAttr "shotCam_aimConstraint1.crz" "shotCam.rz";
connectAttr "shotCamShape_focalLength.o" "shotCamShape.fl";
connectAttr "shotCam.pim" "shotCam_aimConstraint1.cpim";
connectAttr "shotCam.t" "shotCam_aimConstraint1.ct";
connectAttr "shotCam.rp" "shotCam_aimConstraint1.crp";
connectAttr "shotCam.rpt" "shotCam_aimConstraint1.crt";
connectAttr "shotCam.ro" "shotCam_aimConstraint1.cro";
connectAttr "camTarget.t" "shotCam_aimConstraint1.tg[0].tt";
connectAttr "camTarget.rp" "shotCam_aimConstraint1.tg[0].trp";
connectAttr "camTarget.rpt" "shotCam_aimConstraint1.tg[0].trt";
connectAttr "camTarget.pm" "shotCam_aimConstraint1.tg[0].tpm";
connectAttr "shotCam_aimConstraint1.w0" "shotCam_aimConstraint1.tg[0].tw";
connectAttr "duskSun_rotateX.o" "duskSun.rx";
connectAttr "duskSun_rotateY.o" "duskSun.ry";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "wall_violetSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "wall_tealSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "wall_brickSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "roof_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "tank_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "stand_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "antenna_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "ac_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "bean_body_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "bean_head_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "bean_eye_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "bean_scarf_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "hero_suit_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "hero_scarf_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "hero_mask_matSG.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" "hero_lens_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "wall_violetSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "wall_tealSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "wall_brickSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "roof_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "tank_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "stand_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "antenna_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "ac_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "bean_body_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "bean_head_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "bean_eye_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "bean_scarf_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "hero_suit_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "hero_scarf_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "hero_mask_matSG.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" "hero_lens_matSG.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "wall_violet_file.oc" "wall_violet.c";
connectAttr ":defaultColorMgtGlobals.cme" "wall_violet_file.cme";
connectAttr ":defaultColorMgtGlobals.cfe" "wall_violet_file.cmcf";
connectAttr ":defaultColorMgtGlobals.cfp" "wall_violet_file.cmcp";
connectAttr ":defaultColorMgtGlobals.wsn" "wall_violet_file.ws";
connectAttr "wall_violet.oc" "wall_violetSG.ss";
connectAttr "tower_0Shape.iog" "wall_violetSG.dsm" -na;
connectAttr "|skyline_far|tower|towerShape.iog" "wall_violetSG.dsm" -na;
connectAttr "tower_6Shape.iog" "wall_violetSG.dsm" -na;
connectAttr "tower_9Shape.iog" "wall_violetSG.dsm" -na;
connectAttr "wall_violetSG.msg" "materialInfo1.sg";
connectAttr "wall_teal_file.oc" "wall_teal.c";
connectAttr ":defaultColorMgtGlobals.cme" "wall_teal_file.cme";
connectAttr ":defaultColorMgtGlobals.cfe" "wall_teal_file.cmcf";
connectAttr ":defaultColorMgtGlobals.cfp" "wall_teal_file.cmcp";
connectAttr ":defaultColorMgtGlobals.wsn" "wall_teal_file.ws";
connectAttr "wall_teal.oc" "wall_tealSG.ss";
connectAttr "roofB_buildingShape.iog" "wall_tealSG.dsm" -na;
connectAttr "tower_1Shape.iog" "wall_tealSG.dsm" -na;
connectAttr "tower_5Shape.iog" "wall_tealSG.dsm" -na;
connectAttr "|skyline_near|tower|towerShape.iog" "wall_tealSG.dsm" -na;
connectAttr "wall_tealSG.msg" "materialInfo2.sg";
connectAttr "wall_brick_file.oc" "wall_brick.c";
connectAttr ":defaultColorMgtGlobals.cme" "wall_brick_file.cme";
connectAttr ":defaultColorMgtGlobals.cfe" "wall_brick_file.cmcf";
connectAttr ":defaultColorMgtGlobals.cfp" "wall_brick_file.cmcp";
connectAttr ":defaultColorMgtGlobals.wsn" "wall_brick_file.ws";
connectAttr "wall_brick.oc" "wall_brickSG.ss";
connectAttr "roofA_buildingShape.iog" "wall_brickSG.dsm" -na;
connectAttr "tower_2Shape.iog" "wall_brickSG.dsm" -na;
connectAttr "tower_4Shape.iog" "wall_brickSG.dsm" -na;
connectAttr "tower_7Shape.iog" "wall_brickSG.dsm" -na;
connectAttr "wall_brickSG.msg" "materialInfo3.sg";
connectAttr "roof_mat.oc" "roof_matSG.ss";
connectAttr "roofA_topShape.iog" "roof_matSG.dsm" -na;
connectAttr "roofB_topShape.iog" "roof_matSG.dsm" -na;
connectAttr "roof_matSG.msg" "materialInfo4.sg";
connectAttr "tank_mat.oc" "tank_matSG.ss";
connectAttr "tank_roofShape.iog" "tank_matSG.dsm" -na;
connectAttr "water_tankShape.iog" "tank_matSG.dsm" -na;
connectAttr "tank_matSG.msg" "materialInfo5.sg";
connectAttr "stand_mat.oc" "stand_matSG.ss";
connectAttr "tank_standShape.iog" "stand_matSG.dsm" -na;
connectAttr "stand_matSG.msg" "materialInfo6.sg";
connectAttr "antenna_mat.oc" "antenna_matSG.ss";
connectAttr "antennaShape.iog" "antenna_matSG.dsm" -na;
connectAttr "antenna_matSG.msg" "materialInfo7.sg";
connectAttr "ac_mat.oc" "ac_matSG.ss";
connectAttr "ac_unit0Shape.iog" "ac_matSG.dsm" -na;
connectAttr "ac_unit1Shape.iog" "ac_matSG.dsm" -na;
connectAttr "ac_unit2Shape.iog" "ac_matSG.dsm" -na;
connectAttr "ac_matSG.msg" "materialInfo8.sg";
connectAttr "bean_bodyShapeOrig.w" "bean_skin.ip[0].ig";
connectAttr "bean_bodyShapeOrig.o" "bean_skin.orggeom[0]";
connectAttr "bindPose1.msg" "bean_skin.bp";
connectAttr "bean_root_jnt.wm" "bean_skin.ma[0]";
connectAttr "bean_mid_jnt.wm" "bean_skin.ma[1]";
connectAttr "bean_top_jnt.wm" "bean_skin.ma[2]";
connectAttr "bean_end_jnt.wm" "bean_skin.ma[3]";
connectAttr "bean_root_jnt.liw" "bean_skin.lw[0]";
connectAttr "bean_mid_jnt.liw" "bean_skin.lw[1]";
connectAttr "bean_top_jnt.liw" "bean_skin.lw[2]";
connectAttr "bean_end_jnt.liw" "bean_skin.lw[3]";
connectAttr "bean_root_jnt.obcc" "bean_skin.ifcl[0]";
connectAttr "bean_mid_jnt.obcc" "bean_skin.ifcl[1]";
connectAttr "bean_top_jnt.obcc" "bean_skin.ifcl[2]";
connectAttr "bean_end_jnt.obcc" "bean_skin.ifcl[3]";
connectAttr "bean_root_jnt.msg" "bindPose1.m[0]";
connectAttr "bean_mid_jnt.msg" "bindPose1.m[1]";
connectAttr "bean_top_jnt.msg" "bindPose1.m[2]";
connectAttr "bean_end_jnt.msg" "bindPose1.m[3]";
connectAttr "bindPose1.w" "bindPose1.p[0]";
connectAttr "bindPose1.m[0]" "bindPose1.p[1]";
connectAttr "bindPose1.m[1]" "bindPose1.p[2]";
connectAttr "bindPose1.m[2]" "bindPose1.p[3]";
connectAttr "bean_root_jnt.bps" "bindPose1.wm[0]";
connectAttr "bean_mid_jnt.bps" "bindPose1.wm[1]";
connectAttr "bean_top_jnt.bps" "bindPose1.wm[2]";
connectAttr "bean_end_jnt.bps" "bindPose1.wm[3]";
connectAttr "bean_body_mat.oc" "bean_body_matSG.ss";
connectAttr "bean_body_matSG.msg" "materialInfo9.sg";
connectAttr "bean_head_mat.oc" "bean_head_matSG.ss";
connectAttr "bean_head_matSG.msg" "materialInfo10.sg";
connectAttr "bean_eye_mat.oc" "bean_eye_matSG.ss";
connectAttr "bean_eye_matSG.msg" "materialInfo11.sg";
connectAttr "bean_scarf_mat.oc" "bean_scarf_matSG.ss";
connectAttr "bean_scarf_matSG.msg" "materialInfo12.sg";
connectAttr "hero_suit_mat.oc" "hero_suit_matSG.ss";
connectAttr "bean_bodyShape.iog" "hero_suit_matSG.dsm" -na;
connectAttr "hero_suit_matSG.msg" "materialInfo13.sg";
connectAttr "hero_scarf_mat.oc" "hero_scarf_matSG.ss";
connectAttr "bean_scarfShape.iog" "hero_scarf_matSG.dsm" -na;
connectAttr "hero_scarf_matSG.msg" "materialInfo14.sg";
connectAttr "hero_mask_mat.oc" "hero_mask_matSG.ss";
connectAttr "bean_headShape.iog" "hero_mask_matSG.dsm" -na;
connectAttr "hero_mask_matSG.msg" "materialInfo15.sg";
connectAttr "hero_lens_mat.oc" "hero_lens_matSG.ss";
connectAttr "bean_eye_RShape.iog" "hero_lens_matSG.dsm" -na;
connectAttr "bean_eye_LShape.iog" "hero_lens_matSG.dsm" -na;
connectAttr "hero_lens_matSG.msg" "materialInfo16.sg";
connectAttr "wall_violetSG.pa" ":renderPartition.st" -na;
connectAttr "wall_tealSG.pa" ":renderPartition.st" -na;
connectAttr "wall_brickSG.pa" ":renderPartition.st" -na;
connectAttr "roof_matSG.pa" ":renderPartition.st" -na;
connectAttr "tank_matSG.pa" ":renderPartition.st" -na;
connectAttr "stand_matSG.pa" ":renderPartition.st" -na;
connectAttr "antenna_matSG.pa" ":renderPartition.st" -na;
connectAttr "ac_matSG.pa" ":renderPartition.st" -na;
connectAttr "bean_body_matSG.pa" ":renderPartition.st" -na;
connectAttr "bean_head_matSG.pa" ":renderPartition.st" -na;
connectAttr "bean_eye_matSG.pa" ":renderPartition.st" -na;
connectAttr "bean_scarf_matSG.pa" ":renderPartition.st" -na;
connectAttr "hero_suit_matSG.pa" ":renderPartition.st" -na;
connectAttr "hero_scarf_matSG.pa" ":renderPartition.st" -na;
connectAttr "hero_mask_matSG.pa" ":renderPartition.st" -na;
connectAttr "hero_lens_matSG.pa" ":renderPartition.st" -na;
connectAttr "wall_violet.msg" ":defaultShaderList1.s" -na;
connectAttr "wall_teal.msg" ":defaultShaderList1.s" -na;
connectAttr "wall_brick.msg" ":defaultShaderList1.s" -na;
connectAttr "roof_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "tank_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "stand_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "antenna_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "ac_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "bean_body_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "bean_head_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "bean_eye_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "bean_scarf_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "hero_suit_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "hero_scarf_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "hero_mask_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "hero_lens_mat.msg" ":defaultShaderList1.s" -na;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
connectAttr "duskSunShape.ltd" ":lightList1.l" -na;
connectAttr "skyFillShape.ltd" ":lightList1.l" -na;
connectAttr "wall_violet_file.msg" ":defaultTextureList1.tx" -na;
connectAttr "wall_teal_file.msg" ":defaultTextureList1.tx" -na;
connectAttr "wall_brick_file.msg" ":defaultTextureList1.tx" -na;
connectAttr "duskSun.iog" ":defaultLightSet.dsm" -na;
connectAttr "skyFill.iog" ":defaultLightSet.dsm" -na;
dataStructure -fmt "raw" -as "name=externalContentTable:string=node:string=key:string=upath:uint32=upathcrc:string=rpath:string=roles";
applyMetadata -fmt "raw" -v "channel\nname externalContentTable\nstream\nname v1.0\nindexType numeric\nstructure externalContentTable\n0\n\"|duskSun|duskSunShape\" \"dmapName\" \"深度贴图\" 1141912088 \"\" \"sourceImages\"\n1\n\"wall_violet_file\" \"fileTextureName\" \"/Users/jerry/Claude/Maya-Pipeline-Research-Project/demo/textures/windows_violet.png\" 482353926 \"/Users/jerry/Claude/Maya-Pipeline-Research-Project/demo/textures/windows_violet.png\" \"sourceImages\"\n2\n\"wall_teal_file\" \"fileTextureName\" \"/Users/jerry/Claude/Maya-Pipeline-Research-Project/demo/textures/windows_teal.png\" 474457457 \"/Users/jerry/Claude/Maya-Pipeline-Research-Project/demo/textures/windows_teal.png\" \"sourceImages\"\n3\n\"wall_brick_file\" \"fileTextureName\" \"/Users/jerry/Claude/Maya-Pipeline-Research-Project/demo/textures/windows_brick.png\" 829192345 \"/Users/jerry/Claude/Maya-Pipeline-Research-Project/demo/textures/windows_brick.png\" \"sourceImages\"\nendStream\nendChannel\nendAssociations\n" 
		-scn;
// End of presentation.ma
