/*
    * Testbench for c7552
    * Generated automatically
    * Description: Testing using grouped inputs from counters
    */

    module tb_top();
        // Testbench signals
        reg N1;
    reg N5;
    reg N9;
    reg N12;
    reg N15;
    reg N18;
    reg N23;
    reg N26;
    reg N29;
    reg N32;
    reg N35;
    reg N38;
    reg N41;
    reg N44;
    reg N47;
    reg N50;
    reg N53;
    reg N54;
    reg N55;
    reg N56;
    reg N57;
    reg N58;
    reg N59;
    reg N60;
    reg N61;
    reg N62;
    reg N63;
    reg N64;
    reg N65;
    reg N66;
    reg N69;
    reg N70;
    reg N73;
    reg N74;
    reg N75;
    reg N76;
    reg N77;
    reg N78;
    reg N79;
    reg N80;
    reg N81;
    reg N82;
    reg N83;
    reg N84;
    reg N85;
    reg N86;
    reg N87;
    reg N88;
    reg N89;
    reg N94;
    reg N97;
    reg N100;
    reg N103;
    reg N106;
    reg N109;
    reg N110;
    reg N111;
    reg N112;
    reg N113;
    reg N114;
    reg N115;
    reg N118;
    reg N121;
    reg N124;
    reg N127;
    reg N130;
    reg N133;
    reg N134;
    reg N135;
    reg N138;
    reg N141;
    reg N144;
    reg N147;
    reg N150;
    reg N151;
    reg N152;
    reg N153;
    reg N154;
    reg N155;
    reg N156;
    reg N157;
    reg N158;
    reg N159;
    reg N160;
    reg N161;
    reg N162;
    reg N163;
    reg N164;
    reg N165;
    reg N166;
    reg N167;
    reg N168;
    reg N169;
    reg N170;
    reg N171;
    reg N172;
    reg N173;
    reg N174;
    reg N175;
    reg N176;
    reg N177;
    reg N178;
    reg N179;
    reg N180;
    reg N181;
    reg N182;
    reg N183;
    reg N184;
    reg N185;
    reg N186;
    reg N187;
    reg N188;
    reg N189;
    reg N190;
    reg N191;
    reg N192;
    reg N193;
    reg N194;
    reg N195;
    reg N196;
    reg N197;
    reg N198;
    reg N199;
    reg N200;
    reg N201;
    reg N202;
    reg N203;
    reg N204;
    reg N205;
    reg N206;
    reg N207;
    reg N208;
    reg N209;
    reg N210;
    reg N211;
    reg N212;
    reg N213;
    reg N214;
    reg N215;
    reg N216;
    reg N217;
    reg N218;
    reg N219;
    reg N220;
    reg N221;
    reg N222;
    reg N223;
    reg N224;
    reg N225;
    reg N226;
    reg N227;
    reg N228;
    reg N229;
    reg N230;
    reg N231;
    reg N232;
    reg N233;
    reg N234;
    reg N235;
    reg N236;
    reg N237;
    reg N238;
    reg N239;
    reg N240;
    reg N242;
    reg N245;
    reg N248;
    reg N251;
    reg N254;
    reg N257;
    reg N260;
    reg N263;
    reg N267;
    reg N271;
    reg N274;
    reg N277;
    reg N280;
    reg N283;
    reg N286;
    reg N289;
    reg N293;
    reg N296;
    reg N299;
    reg N303;
    reg N307;
    reg N310;
    reg N313;
    reg N316;
    reg N319;
    reg N322;
    reg N325;
    reg N328;
    reg N331;
    reg N334;
    reg N337;
    reg N340;
    reg N343;
    reg N346;
    reg N349;
    reg N352;
    reg N355;
    reg N358;
    reg N361;
    reg N364;
    reg N367;
    reg N382;
    reg N241_I;
    wire N387;
    wire N388;
    wire N478;
    wire N482;
    wire N484;
    wire N486;
    wire N489;
    wire N492;
    wire N501;
    wire N505;
    wire N507;
    wire N509;
    wire N511;
    wire N513;
    wire N515;
    wire N517;
    wire N519;
    wire N535;
    wire N537;
    wire N539;
    wire N541;
    wire N543;
    wire N545;
    wire N547;
    wire N549;
    wire N551;
    wire N553;
    wire N556;
    wire N559;
    wire N561;
    wire N563;
    wire N565;
    wire N567;
    wire N569;
    wire N571;
    wire N573;
    wire N582;
    wire N643;
    wire N707;
    wire N813;
    wire N881;
    wire N882;
    wire N883;
    wire N884;
    wire N885;
    wire N889;
    wire N945;
    wire N1110;
    wire N1111;
    wire N1112;
    wire N1113;
    wire N1114;
    wire N1489;
    wire N1490;
    wire N1781;
    wire N10025;
    wire N10101;
    wire N10102;
    wire N10103;
    wire N10104;
    wire N10109;
    wire N10110;
    wire N10111;
    wire N10112;
    wire N10350;
    wire N10351;
    wire N10352;
    wire N10353;
    wire N10574;
    wire N10575;
    wire N10576;
    wire N10628;
    wire N10632;
    wire N10641;
    wire N10704;
    wire N10706;
    wire N10711;
    wire N10712;
    wire N10713;
    wire N10714;
    wire N10715;
    wire N10716;
    wire N10717;
    wire N10718;
    wire N10729;
    wire N10759;
    wire N10760;
    wire N10761;
    wire N10762;
    wire N10763;
    wire N10827;
    wire N10837;
    wire N10838;
    wire N10839;
    wire N10840;
    wire N10868;
    wire N10869;
    wire N10870;
    wire N10871;
    wire N10905;
    wire N10906;
    wire N10907;
    wire N10908;
    wire N11333;
    wire N11334;
    wire N11340;
    wire N11342;
    wire N241_O;

        // Error and test tracking
        integer errors = 0;
        integer tests_run = 0;
        
        // Group counters
        integer counter_0;
    integer counter_1;
    integer counter_2;
    integer counter_3;
    integer counter_4;
    integer counter_5;
    integer counter_6;


        // Device Under Test (DUT) instantiation
        c7552 dut(
            .N1(N1),
        .N5(N5),
        .N9(N9),
        .N12(N12),
        .N15(N15),
        .N18(N18),
        .N23(N23),
        .N26(N26),
        .N29(N29),
        .N32(N32),
        .N35(N35),
        .N38(N38),
        .N41(N41),
        .N44(N44),
        .N47(N47),
        .N50(N50),
        .N53(N53),
        .N54(N54),
        .N55(N55),
        .N56(N56),
        .N57(N57),
        .N58(N58),
        .N59(N59),
        .N60(N60),
        .N61(N61),
        .N62(N62),
        .N63(N63),
        .N64(N64),
        .N65(N65),
        .N66(N66),
        .N69(N69),
        .N70(N70),
        .N73(N73),
        .N74(N74),
        .N75(N75),
        .N76(N76),
        .N77(N77),
        .N78(N78),
        .N79(N79),
        .N80(N80),
        .N81(N81),
        .N82(N82),
        .N83(N83),
        .N84(N84),
        .N85(N85),
        .N86(N86),
        .N87(N87),
        .N88(N88),
        .N89(N89),
        .N94(N94),
        .N97(N97),
        .N100(N100),
        .N103(N103),
        .N106(N106),
        .N109(N109),
        .N110(N110),
        .N111(N111),
        .N112(N112),
        .N113(N113),
        .N114(N114),
        .N115(N115),
        .N118(N118),
        .N121(N121),
        .N124(N124),
        .N127(N127),
        .N130(N130),
        .N133(N133),
        .N134(N134),
        .N135(N135),
        .N138(N138),
        .N141(N141),
        .N144(N144),
        .N147(N147),
        .N150(N150),
        .N151(N151),
        .N152(N152),
        .N153(N153),
        .N154(N154),
        .N155(N155),
        .N156(N156),
        .N157(N157),
        .N158(N158),
        .N159(N159),
        .N160(N160),
        .N161(N161),
        .N162(N162),
        .N163(N163),
        .N164(N164),
        .N165(N165),
        .N166(N166),
        .N167(N167),
        .N168(N168),
        .N169(N169),
        .N170(N170),
        .N171(N171),
        .N172(N172),
        .N173(N173),
        .N174(N174),
        .N175(N175),
        .N176(N176),
        .N177(N177),
        .N178(N178),
        .N179(N179),
        .N180(N180),
        .N181(N181),
        .N182(N182),
        .N183(N183),
        .N184(N184),
        .N185(N185),
        .N186(N186),
        .N187(N187),
        .N188(N188),
        .N189(N189),
        .N190(N190),
        .N191(N191),
        .N192(N192),
        .N193(N193),
        .N194(N194),
        .N195(N195),
        .N196(N196),
        .N197(N197),
        .N198(N198),
        .N199(N199),
        .N200(N200),
        .N201(N201),
        .N202(N202),
        .N203(N203),
        .N204(N204),
        .N205(N205),
        .N206(N206),
        .N207(N207),
        .N208(N208),
        .N209(N209),
        .N210(N210),
        .N211(N211),
        .N212(N212),
        .N213(N213),
        .N214(N214),
        .N215(N215),
        .N216(N216),
        .N217(N217),
        .N218(N218),
        .N219(N219),
        .N220(N220),
        .N221(N221),
        .N222(N222),
        .N223(N223),
        .N224(N224),
        .N225(N225),
        .N226(N226),
        .N227(N227),
        .N228(N228),
        .N229(N229),
        .N230(N230),
        .N231(N231),
        .N232(N232),
        .N233(N233),
        .N234(N234),
        .N235(N235),
        .N236(N236),
        .N237(N237),
        .N238(N238),
        .N239(N239),
        .N240(N240),
        .N242(N242),
        .N245(N245),
        .N248(N248),
        .N251(N251),
        .N254(N254),
        .N257(N257),
        .N260(N260),
        .N263(N263),
        .N267(N267),
        .N271(N271),
        .N274(N274),
        .N277(N277),
        .N280(N280),
        .N283(N283),
        .N286(N286),
        .N289(N289),
        .N293(N293),
        .N296(N296),
        .N299(N299),
        .N303(N303),
        .N307(N307),
        .N310(N310),
        .N313(N313),
        .N316(N316),
        .N319(N319),
        .N322(N322),
        .N325(N325),
        .N328(N328),
        .N331(N331),
        .N334(N334),
        .N337(N337),
        .N340(N340),
        .N343(N343),
        .N346(N346),
        .N349(N349),
        .N352(N352),
        .N355(N355),
        .N358(N358),
        .N361(N361),
        .N364(N364),
        .N367(N367),
        .N382(N382),
        .N241_I(N241_I),
        .N387(N387),
        .N388(N388),
        .N478(N478),
        .N482(N482),
        .N484(N484),
        .N486(N486),
        .N489(N489),
        .N492(N492),
        .N501(N501),
        .N505(N505),
        .N507(N507),
        .N509(N509),
        .N511(N511),
        .N513(N513),
        .N515(N515),
        .N517(N517),
        .N519(N519),
        .N535(N535),
        .N537(N537),
        .N539(N539),
        .N541(N541),
        .N543(N543),
        .N545(N545),
        .N547(N547),
        .N549(N549),
        .N551(N551),
        .N553(N553),
        .N556(N556),
        .N559(N559),
        .N561(N561),
        .N563(N563),
        .N565(N565),
        .N567(N567),
        .N569(N569),
        .N571(N571),
        .N573(N573),
        .N582(N582),
        .N643(N643),
        .N707(N707),
        .N813(N813),
        .N881(N881),
        .N882(N882),
        .N883(N883),
        .N884(N884),
        .N885(N885),
        .N889(N889),
        .N945(N945),
        .N1110(N1110),
        .N1111(N1111),
        .N1112(N1112),
        .N1113(N1113),
        .N1114(N1114),
        .N1489(N1489),
        .N1490(N1490),
        .N1781(N1781),
        .N10025(N10025),
        .N10101(N10101),
        .N10102(N10102),
        .N10103(N10103),
        .N10104(N10104),
        .N10109(N10109),
        .N10110(N10110),
        .N10111(N10111),
        .N10112(N10112),
        .N10350(N10350),
        .N10351(N10351),
        .N10352(N10352),
        .N10353(N10353),
        .N10574(N10574),
        .N10575(N10575),
        .N10576(N10576),
        .N10628(N10628),
        .N10632(N10632),
        .N10641(N10641),
        .N10704(N10704),
        .N10706(N10706),
        .N10711(N10711),
        .N10712(N10712),
        .N10713(N10713),
        .N10714(N10714),
        .N10715(N10715),
        .N10716(N10716),
        .N10717(N10717),
        .N10718(N10718),
        .N10729(N10729),
        .N10759(N10759),
        .N10760(N10760),
        .N10761(N10761),
        .N10762(N10762),
        .N10763(N10763),
        .N10827(N10827),
        .N10837(N10837),
        .N10838(N10838),
        .N10839(N10839),
        .N10840(N10840),
        .N10868(N10868),
        .N10869(N10869),
        .N10870(N10870),
        .N10871(N10871),
        .N10905(N10905),
        .N10906(N10906),
        .N10907(N10907),
        .N10908(N10908),
        .N11333(N11333),
        .N11334(N11334),
        .N11340(N11340),
        .N11342(N11342),
        .N241_O(N241_O)
        );

        // Test stimulus and verification
        initial begin
            $display("Starting grouped input test for c7552");
            
            
                for (counter_0 = 0; counter_0 < 1073741824; counter_0 = counter_0 + 1) begin
            for (counter_1 = 0; counter_1 < 1073741824; counter_1 = counter_1 + 1) begin
            for (counter_2 = 0; counter_2 < 1073741824; counter_2 = counter_2 + 1) begin
            for (counter_3 = 0; counter_3 < 1073741824; counter_3 = counter_3 + 1) begin
            for (counter_4 = 0; counter_4 < 1073741824; counter_4 = counter_4 + 1) begin
            for (counter_5 = 0; counter_5 < 1073741824; counter_5 = counter_5 + 1) begin
            for (counter_6 = 0; counter_6 < 134217728; counter_6 = counter_6 + 1) begin
                    
                    // Assign inputs from counters
                    N1 = counter_0[0];
                N5 = counter_0[1];
                N9 = counter_0[2];
                N12 = counter_0[3];
                N15 = counter_0[4];
                N18 = counter_0[5];
                N23 = counter_0[6];
                N26 = counter_0[7];
                N29 = counter_0[8];
                N32 = counter_0[9];
                N35 = counter_0[10];
                N38 = counter_0[11];
                N41 = counter_0[12];
                N44 = counter_0[13];
                N47 = counter_0[14];
                N50 = counter_0[15];
                N53 = counter_0[16];
                N54 = counter_0[17];
                N55 = counter_0[18];
                N56 = counter_0[19];
                N57 = counter_0[20];
                N58 = counter_0[21];
                N59 = counter_0[22];
                N60 = counter_0[23];
                N61 = counter_0[24];
                N62 = counter_0[25];
                N63 = counter_0[26];
                N64 = counter_0[27];
                N65 = counter_0[28];
                N66 = counter_0[29];
                N69 = counter_1[0];
                N70 = counter_1[1];
                N73 = counter_1[2];
                N74 = counter_1[3];
                N75 = counter_1[4];
                N76 = counter_1[5];
                N77 = counter_1[6];
                N78 = counter_1[7];
                N79 = counter_1[8];
                N80 = counter_1[9];
                N81 = counter_1[10];
                N82 = counter_1[11];
                N83 = counter_1[12];
                N84 = counter_1[13];
                N85 = counter_1[14];
                N86 = counter_1[15];
                N87 = counter_1[16];
                N88 = counter_1[17];
                N89 = counter_1[18];
                N94 = counter_1[19];
                N97 = counter_1[20];
                N100 = counter_1[21];
                N103 = counter_1[22];
                N106 = counter_1[23];
                N109 = counter_1[24];
                N110 = counter_1[25];
                N111 = counter_1[26];
                N112 = counter_1[27];
                N113 = counter_1[28];
                N114 = counter_1[29];
                N115 = counter_2[0];
                N118 = counter_2[1];
                N121 = counter_2[2];
                N124 = counter_2[3];
                N127 = counter_2[4];
                N130 = counter_2[5];
                N133 = counter_2[6];
                N134 = counter_2[7];
                N135 = counter_2[8];
                N138 = counter_2[9];
                N141 = counter_2[10];
                N144 = counter_2[11];
                N147 = counter_2[12];
                N150 = counter_2[13];
                N151 = counter_2[14];
                N152 = counter_2[15];
                N153 = counter_2[16];
                N154 = counter_2[17];
                N155 = counter_2[18];
                N156 = counter_2[19];
                N157 = counter_2[20];
                N158 = counter_2[21];
                N159 = counter_2[22];
                N160 = counter_2[23];
                N161 = counter_2[24];
                N162 = counter_2[25];
                N163 = counter_2[26];
                N164 = counter_2[27];
                N165 = counter_2[28];
                N166 = counter_2[29];
                N167 = counter_3[0];
                N168 = counter_3[1];
                N169 = counter_3[2];
                N170 = counter_3[3];
                N171 = counter_3[4];
                N172 = counter_3[5];
                N173 = counter_3[6];
                N174 = counter_3[7];
                N175 = counter_3[8];
                N176 = counter_3[9];
                N177 = counter_3[10];
                N178 = counter_3[11];
                N179 = counter_3[12];
                N180 = counter_3[13];
                N181 = counter_3[14];
                N182 = counter_3[15];
                N183 = counter_3[16];
                N184 = counter_3[17];
                N185 = counter_3[18];
                N186 = counter_3[19];
                N187 = counter_3[20];
                N188 = counter_3[21];
                N189 = counter_3[22];
                N190 = counter_3[23];
                N191 = counter_3[24];
                N192 = counter_3[25];
                N193 = counter_3[26];
                N194 = counter_3[27];
                N195 = counter_3[28];
                N196 = counter_3[29];
                N197 = counter_4[0];
                N198 = counter_4[1];
                N199 = counter_4[2];
                N200 = counter_4[3];
                N201 = counter_4[4];
                N202 = counter_4[5];
                N203 = counter_4[6];
                N204 = counter_4[7];
                N205 = counter_4[8];
                N206 = counter_4[9];
                N207 = counter_4[10];
                N208 = counter_4[11];
                N209 = counter_4[12];
                N210 = counter_4[13];
                N211 = counter_4[14];
                N212 = counter_4[15];
                N213 = counter_4[16];
                N214 = counter_4[17];
                N215 = counter_4[18];
                N216 = counter_4[19];
                N217 = counter_4[20];
                N218 = counter_4[21];
                N219 = counter_4[22];
                N220 = counter_4[23];
                N221 = counter_4[24];
                N222 = counter_4[25];
                N223 = counter_4[26];
                N224 = counter_4[27];
                N225 = counter_4[28];
                N226 = counter_4[29];
                N227 = counter_5[0];
                N228 = counter_5[1];
                N229 = counter_5[2];
                N230 = counter_5[3];
                N231 = counter_5[4];
                N232 = counter_5[5];
                N233 = counter_5[6];
                N234 = counter_5[7];
                N235 = counter_5[8];
                N236 = counter_5[9];
                N237 = counter_5[10];
                N238 = counter_5[11];
                N239 = counter_5[12];
                N240 = counter_5[13];
                N242 = counter_5[14];
                N245 = counter_5[15];
                N248 = counter_5[16];
                N251 = counter_5[17];
                N254 = counter_5[18];
                N257 = counter_5[19];
                N260 = counter_5[20];
                N263 = counter_5[21];
                N267 = counter_5[22];
                N271 = counter_5[23];
                N274 = counter_5[24];
                N277 = counter_5[25];
                N280 = counter_5[26];
                N283 = counter_5[27];
                N286 = counter_5[28];
                N289 = counter_5[29];
                N293 = counter_6[0];
                N296 = counter_6[1];
                N299 = counter_6[2];
                N303 = counter_6[3];
                N307 = counter_6[4];
                N310 = counter_6[5];
                N313 = counter_6[6];
                N316 = counter_6[7];
                N319 = counter_6[8];
                N322 = counter_6[9];
                N325 = counter_6[10];
                N328 = counter_6[11];
                N331 = counter_6[12];
                N334 = counter_6[13];
                N337 = counter_6[14];
                N340 = counter_6[15];
                N343 = counter_6[16];
                N346 = counter_6[17];
                N349 = counter_6[18];
                N352 = counter_6[19];
                N355 = counter_6[20];
                N358 = counter_6[21];
                N361 = counter_6[22];
                N364 = counter_6[23];
                N367 = counter_6[24];
                N382 = counter_6[25];
                N241_I = counter_6[26];

                    
                    // Allow signals to propagate
                    #1;
                    
                    // Track test execution
                    tests_run = tests_run + 1;
                    
                    // Add verification logic here
                    // Example:
                    // if (output_doesnt_match_expected)
                    //     errors = errors + 1;
                    
                end
            end
            end
            end
            end
            end
            
            end

            // Test summary
            $display("Test Summary:");
            $display("  Total Tests: %0d", tests_run);
            $display("  Errors Found: %0d", errors);

            if (errors == 0)
                $display("PASSED: All tests successful!");
            else
                $display("FAILED: %0d errors detected", errors);

            $finish;
        end

    endmodule
    